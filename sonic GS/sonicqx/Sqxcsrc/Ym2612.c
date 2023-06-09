/*
**
** File: fm.c -- software implementation of FM sound generator
**
** Copyright (C) 1998 Tatsuyuki Satoh , MultiArcadeMachineEmurator development
**
** Version 0.36c
**
** Modified by Marp (marp@technologist.com) to better suit MSP.
*/

/*
**** change log. (hiro-shi) ****
** 08-12-98:
** rename ADPCMA -> ADPCMB, ADPCMB -> ADPCMA
** move ROM limit check.(CALC_CH? -> 2610Write1/2)
** test program (ADPCMB_TEST)
** move ADPCM A/B end check.
** ADPCMB repeat flag(no check)
** change ADPCM volume rate (8->16) (32->48).
**
** 09-12-98:
** change ADPCM volume. (8->16, 48->64)
** replace ym2610 ch0/3 (YM-2610B)
** init cur_chip (restart bug fix)
** change ADPCM_SHIFT (10->8) missing bank change 0x4000-0xffff.
** add ADPCM_SHIFT_MASK
** change ADPCMA_DECODE_MIN/MAX.
*/

/*
    no check:
                YM2608 rhythm sound
                OPN  SSG type envelope
                YM2612 DAC output mode
                YM2151 CSM speech mode

        no support:
                status BUSY flag (everytime not busy)
                YM2608 status mask (register :0x110)
                YM2608 DELTA-T-ADPCM and RYTHM
                YM2610 DELTA-T-ADPCM with PCM port
                YM2610 PCM memory data access
                YM2151 CSM speech mode with internal timer

        preliminary :
                key scale level rate (?)
                attack rate time rate , curve (?)
                decay  rate time rate , curve (?)
                self-feedback algorythm
                YM2610 ADPCM-A mixing level
                YM2151 noise mode (CH7.OP4)
                LFO contoller (YM2612/YM2610/YM2608/YM2151)

        note:
                        OPN                           OPM
                fnum          fM * 2^20 / (fM/(12*n))
                TimerOverA    ( 12*n)*(1024-NA)/fM        64*(1024-Na)/fM
                TimerOverB    (192*n)*(256-NB)/fM       1024*(256-Nb)/fM
                output bits   10bit<<3bit               16bit * 2ch (YM3012=10bit<<3bit)
                sampling rate fFM / (12*priscaler)      fM / 64
                lfo freq                                ( fM*2^(LFRQ/16) ) / (4295*10^6)
*/

/************************************************************************/
/*    comment of hiro-shi(Hiromitsu Shioya)                             */
/*    YM2610(B) = (OPN-B                                                */
/*    YM2610  : PSG:3ch FM:4ch ADPCM(18.5KHz):6ch DeltaT ADPCM:1ch      */
/*    YM2610B : PSG:3ch FM:6ch ADPCM(18.5KHz):6ch DeltaT ADPCM:1ch      */
/************************************************************************/

#include <stdlib.h>
#include <math.h>

#include "ym2612.h"

#undef PI
#define PI 3.141592653589793238462643383279502884197169399375105

// #define INLINE __inline__		(---- Doesn't work in Visual C++ ----)
#define INLINE __inline

#define INTERNAL_TIMER                  /* use internal timer */
#define LFO_SUPPORT                     /* LFO support                     */

/* -------------------- preliminary define section --------------------- */
/* attack/decay rate time rate */
#define OPM_ARRATE     399128
#define OPM_DRRATE    5514396
/* It is not checked , because I haven't YM2203 rate */
#define OPN_ARRATE  OPM_ARRATE
#define OPN_DRRATE  OPM_DRRATE

#define FREQ_BITS 24                    /* frequency turn          */

/* counter bits = 21 , octerve 7 */
#define FREQ_RATE   (1<<(FREQ_BITS-21))
#define TL_BITS    (FREQ_BITS+2)
/* OPbit = 14(13+sign) : TL_BITS+1(sign) / output = 16bit */
#define TL_SHIFT (TL_BITS+1-(14-16))

/* output final shift */
#define FM_OUTSB  (TL_SHIFT-FM_OUTPUT_BIT)
#define FM_MAXOUT ((1<<(TL_SHIFT-1))-1)
#define FM_MINOUT (-(1<<(TL_SHIFT-1)))

/* operator cut off mask (16bit ->14bit) */
#define OP_CUT_MASK (0xffffffff<<FM_OUTSB)

/* -------------------- quality selection --------------------- */

/* sinwave entries */
/* used static memory = SIN_ENT * 4 (byte) */
#define SIN_ENT 2048

/* output level entries (envelope,sinwave) */
/* envelope counter lower bits */
#define ENV_BITS 16
/* envelope output entries */
#define EG_ENT   4096
/* used dynamic memory = EG_ENT*4*4(byte)or EG_ENT*6*4(byte) */
/* used static  memory = EG_ENT*4 (byte)                     */

#ifdef SEG_SUPPORT
#define EG_OFF   ((3*EG_ENT)<<ENV_BITS)  /* OFF          */
#define EG_UED   EG_OFF
#define EG_UST   ((2*EG_ENT)<<ENV_BITS)  /* UPSISE START */
#define EG_DED   EG_UST
#else
#define EG_OFF   ((2*EG_ENT)<<ENV_BITS)  /* OFF          */
#define EG_DED   EG_OFF
#endif
#define EG_DST   (EG_ENT<<ENV_BITS)      /* DECAY  START */
#define EG_AED   EG_DST
#define EG_AST   0                       /* ATTACK START */

#define EG_STEP (96.0/EG_ENT) /* OPL is 0.1875 dB step  */

/* LFO table entries */
#define LFO_ENT 512
#define LFO_SHIFT (32-9)
#define LFO_RATE 0x10000

/* -------------------- local defines , macros --------------------- */
/* number of maximum envelope counter */
/* #define ENV_OFF ((EG_ENT<<ENV_BITS)-1) */

/* register number to channel number , slot offset */
#define OPN_CHAN(N) (N&3)
#define OPN_SLOT(N) ((N>>2)&3)
#define OPM_CHAN(N) (N&7)
#define OPM_SLOT(N) ((N>>3)&3)
/* slot number */
#define SLOT1 0
#define SLOT2 2
#define SLOT3 1
#define SLOT4 3

/* envelope phase */
#define ENV_MOD_OFF 0x00
#define ENV_MOD_RR  0x01
#define ENV_MOD_SR  0x02
#define ENV_MOD_DR  0x03
#define ENV_MOD_AR  0x04
#define ENV_SSG_SR  0x05
#define ENV_SSG_DR  0x06
#define ENV_SSG_AR  0x07

/* bit0 = Right enable , bit1 = Left enable */
#define OUTD_RIGHT  1
#define OUTD_LEFT   2
#define OUTD_CENTER 3

/* YM2608 Rhythm Number */
#define RY_BD  0
#define RY_SD  1
#define RY_TOP 2
#define RY_HH  3
#define RY_TOM 4
#define RY_RIM 5

/* FM timer model */
#define FM_TIMER_SINGLE (0)
#define FM_TIMER_INTERVAL (1)

/* ---------- OPN / OPM one channel  ---------- */
typedef struct fm_slot {
        int *DT;                                /* detune          :DT_TABLE[DT]       */
        int DT2;                                /* multiple,Detune2:(DT2<<4)|ML for OPM*/
        int TL;                                 /* total level     :TL << 8            */
        signed int TLL;                 /* adjusted now TL                     */
        unsigned char KSR;              /* key scale rate  :3-KSR              */
        int *AR;                                /* attack rate     :&AR_TABLE[AR<<1]   */
        int *DR;                                /* decay rate      :&DR_TALBE[DR<<1]   */
        int *SR;                                /* sustin rate     :&DR_TABLE[SR<<1]   */
        int  SL;                                /* sustin level    :SL_TALBE[SL]       */
        int *RR;                                /* release rate    :&DR_TABLE[RR<<2+2] */
        unsigned char SEG;              /* SSG EG type     :SSGEG              */
        unsigned char ksr;              /* key scale rate  :kcode>>(3-KSR)     */
        unsigned int mul;               /* multiple        :ML_TABLE[ML]       */
        unsigned int Cnt;               /* frequency count :                   */
        unsigned int Incr;              /* frequency step  :                   */
        /* envelope generator state */
        unsigned char evm;              /* envelope phase                      */
        signed int evc;                 /* envelope counter                    */
        signed int eve;                 /* envelope counter end point          */
        signed int evs;                 /* envelope counter step               */
        signed int evsa;                /* envelope step for AR                */
        signed int evsd;                /* envelope step for DR                */
        signed int evss;                /* envelope step for SR                */
        signed int evsr;                /* envelope step for RR                */
        /* LFO */
        unsigned char amon;
        unsigned int ams;
}FM_SLOT;


typedef struct fm_chan {
        FM_SLOT SLOT[4];
        unsigned char PAN;                      /* PAN NONE,LEFT,RIGHT or CENTER       */
        unsigned char ALGO;                     /* algorythm                           */
        unsigned char FB;                       /* feed back       :&FB_TABLE[FB<<8]   */
        int op1_out[2];                         /* op1 output foe beedback             */
        /* algorythm state */
        int *connect1;                          /* operator 1 connection pointer       */
        int *connect2;                          /* operator 2 connection pointer       */
        int *connect3;                          /* operator 3 connection pointer       */
        int *connect4;                          /* operator 4 connection pointer       */
        /* LFO */
        signed int pms;
        unsigned int ams;
        /* phase generator state */
        unsigned int  fc;                       /* fnum,blk        :calcrated          */
        unsigned char fn_h;                     /* freq latch      :                   */
        unsigned char kcode;            /* key code        :                   */
} FM_CH;

/* OPN/OPM common state */
typedef struct fm_state {
        unsigned char index;            /* chip index (number of chip) */
        int clock;                                      /* master clock  (Hz)  */
        int rate;                                       /* sampling rate (Hz)  */
        double freqbase;                        /* frequency base      */
        double TimerBase;                       /* Timer base time     */
        unsigned char address;          /* address register    */
        unsigned char irq;                      /* interrupt level     */
        unsigned char irqmask;          /* irq mask            */
        unsigned char status;           /* status flag         */
        unsigned int mode;                      /* mode  CSM / 3SLOT   */
        int TA;                                         /* timer a             */
        int TAC;                                        /* timer a counter     */
        unsigned char TB;                       /* timer b             */
        int TBC;                                        /* timer b counter     */
        /* speedup customize */
        /* time tables */
        signed int DT_TABLE[8][32];     /* detune tables       */
        signed int AR_TABLE[94];        /* atttack rate tables */
        signed int DR_TABLE[94];        /* decay rate tables   */
        /* Extention Timer and IRQ handler */
        FM_TIMERHANDLER Timer_Handler;
        FM_IRQHANDLER   IRQ_Handler;
        /* timer model single / interval */
        unsigned char timermodel;
}FM_ST;

/* OPN 3slot struct */
typedef struct opn_3slot {
        unsigned int  fc[3];            /* fnum3,blk3  :calcrated */
        unsigned char fn_h[3];          /* freq3 latch            */
        unsigned char kcode[3];         /* key code    :          */
}FM_3SLOT;

/* adpcm type A struct */
typedef struct adpcm_state {
        unsigned char flag;                     /* port state        */
        unsigned char flagMask;         /* arrived flag mask */
        unsigned char now_data;
        unsigned int now_addr;
        unsigned int now_step;
        unsigned int step;
        unsigned int start;
        unsigned int end;
        int IL;
        int volume;                                     /* calcrated mixing level */
        int *pan;                                       /* &outd[OPN_xxxx] */
        int /*adpcmm,*/ adpcmx, adpcmd;
        int adpcml;                                     /* hiro-shi!! */
}ADPCM_CH;

/* OPN/A/B common state */
typedef struct opn_f {
        unsigned char type;             /* chip type         */
        FM_ST ST;                               /* general state     */
        FM_3SLOT SL3;                   /* 3 slot mode state */
        FM_CH *P_CH;                    /* pointer of CH     */
        unsigned int FN_TABLE[2048]; /* fnumber -> increment counter */
#ifdef LFO_SUPPORT
        /* LFO */
        unsigned int LFOCnt;
        unsigned int LFOIncr;
        unsigned int LFO_FREQ[8];/* LFO FREQ table */
        int LFO_wave[LFO_ENT];
#endif
} FM_OPN;

/* here's the virtual YM2203(OPN) (Used by YM2608 / YM2612)  */
typedef struct ym2203_f {
        FM_OPN OPN;                             /* OPN state         */
        FM_CH CH[3];                    /* channel state     */
} YM2203;


/* here's the virtual YM2612 */
typedef struct ym2612_f {
        FM_OPN OPN;                                             /* OPN state       */
        FM_CH CH[6];                                    /* channel state */
        int address1;   /* address register1 */
        /* dac output (YM2612) */
        int dacen;
        int dacout;
} YM2612;

/* here's the virtual YM2151(OPM)  */
typedef struct ym2151_f {
        FM_ST ST;                                       /* general state     */
        FM_CH CH[8];                            /* channel state     */
        unsigned char ct;                       /* CT0,1             */
        int NoiseCnt;                           /* noise generator   */
        int NoiseIncr;                          /* noise mode enable & step */
#ifdef LFO_SUPPORT
        /* LFO */
        unsigned int LFOCnt;
        unsigned int LFOIncr;
        unsigned char pmd;                      /* LFO pmd level     */
        unsigned char amd;                      /* LFO amd level     */
        int *wavetype;                          /* LFO waveform      */
        int LFO_wave[LFO_ENT*4];        /* LFO wave tabel    */
        int testreg;                            /* test register (LFO reset) */
#endif
        unsigned int KC_TABLE[8*12*64+950];/* keycode,keyfunction -> count */
        void (*PortWrite)(int offset,int data);/*  callback when write CT0/CT1 */
} YM2151;

/* -------------------- tables --------------------- */

/* key scale level */
/* !!!!! preliminary !!!!! */

static const unsigned char KSL[32]=
{
 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
};

/* OPN key frequency number -> key code follow table */
/* fnum higher 4bit -> keycode lower 2bit */
static const char OPN_FKTABLE[16]={0,0,0,0,0,0,0,1,2,3,3,3,3,3,3,3};

/* sustain lebel table (3db per step) */
/* 0 - 15: 0, 3, 6, 9,12,15,18,21,24,27,30,33,36,39,42,93 (dB)*/
#define SC(db) (int)((db*((3/EG_STEP)*(1<<ENV_BITS)))+EG_DST)
static const int SL_TABLE[16]={
 SC( 0),SC( 1),SC( 2),SC(3 ),SC(4 ),SC(5 ),SC(6 ),SC( 7),
 SC( 8),SC( 9),SC(10),SC(11),SC(12),SC(13),SC(14),SC(31)
};
#undef SC

#define TL_MAX (EG_ENT*2) /* limit(tl + ksr + envelope + ams) + sinwave */

/* TotalLevel : 48 24 12  6  3 1.5 0.75 (dB) */
/* TL_TABLE[ 0      to TL_MAX          ] : plus  section */
/* TL_TABLE[ TL_MAX to TL_MAX+TL_MAX-1 ] : minus section */
static int *TL_TABLE;

/* pointers to TL_TABLE with sinwave output offset */
static signed int *SIN_TABLE[SIN_ENT];

/* envelope output curve table */
#ifdef SEG_SUPPORT
/* attack + decay + SSG upside + OFF */
static int ENV_CURVE[3*EG_ENT+1];
#else
/* attack + decay + OFF */
static int ENV_CURVE[2*EG_ENT+1];
#endif
/* envelope counter conversion table when change Decay to Attack phase */
static int DRAR_TABLE[EG_ENT];

#define OPM_DTTABLE OPN_DTTABLE
static char OPN_DTTABLE[4 * 32]={
/* this table is YM2151 and YM2612 data */
/* FD=0 */
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
/* FD=1 */
  0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2,
  2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7, 8, 8, 8, 8,
/* FD=2 */
  1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5,
  5, 6, 6, 7, 8, 8, 9,10,11,12,13,14,16,16,16,16,
/* FD=3 */
  2, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7,
  8 , 8, 9,10,11,12,13,14,16,17,19,20,22,22,22,22
};

/* multiple table */
#define ML(n) (int)(n*2)
static const int MUL_TABLE[4*16]= {
/* 1/2, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15 */
   ML(0.50),ML( 1.00),ML( 2.00),ML( 3.00),ML( 4.00),ML( 5.00),ML( 6.00),ML( 7.00),
   ML(8.00),ML( 9.00),ML(10.00),ML(11.00),ML(12.00),ML(13.00),ML(14.00),ML(15.00),
/* DT2=1 *SQL(2)   */
   ML(0.71),ML( 1.41),ML( 2.82),ML( 4.24),ML( 5.65),ML( 7.07),ML( 8.46),ML( 9.89),
   ML(11.30),ML(12.72),ML(14.10),ML(15.55),ML(16.96),ML(18.37),ML(19.78),ML(21.20),
/* DT2=2 *SQL(2.5) */
   ML( 0.78),ML( 1.57),ML( 3.14),ML( 4.71),ML( 6.28),ML( 7.85),ML( 9.42),ML(10.99),
   ML(12.56),ML(14.13),ML(15.70),ML(17.27),ML(18.84),ML(20.41),ML(21.98),ML(23.55),
/* DT2=3 *SQL(3)   */
   ML( 0.87),ML( 1.73),ML( 3.46),ML( 5.19),ML( 6.92),ML( 8.65),ML(10.38),ML(12.11),
   ML(13.84),ML(15.57),ML(17.30),ML(19.03),ML(20.76),ML(22.49),ML(24.22),ML(25.95)
};
#undef ML

#ifdef LFO_SUPPORT

#define PMS_RATE 0x400

/* LFO table */
static int *LFO_wave;

/* LFO work */
static unsigned int lfo_amd;
static signed int lfo_pmd;
#endif

/* dummy attack / decay rate ( when rate == 0 ) */
static int RATE_0[32]=
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

/* -------------------- state --------------------- */

/* some globals */
#define TYPE_SSG    0x01    /* SSG support          */
#define TYPE_OPN    0x02    /* OPN device           */
#define TYPE_LFOPAN 0x04    /* OPN type LFO and PAN */
#define TYPE_6CH    0x08    /* FM 6CH / 3CH         */
#define TYPE_DAC    0x10    /* YM2612's DAC device  */
#define TYPE_ADPCM  0x20    /* ADPCM device         */

#define TYPE_YM2203 (TYPE_SSG)
#define TYPE_YM2608 (TYPE_SSG |TYPE_LFOPAN |TYPE_6CH |TYPE_ADPCM)
#define TYPE_YM2610 (TYPE_SSG |TYPE_LFOPAN |TYPE_6CH |TYPE_ADPCM)
#define TYPE_YM2612 (TYPE_6CH |TYPE_LFOPAN |TYPE_DAC)

static int FMNumChips;          /* total # of FM emulated */

/* current chip state */
static void *cur_chip = 0;      /* pointer of current chip struct */

/* currenct chip state */
static FM_ST     *State;
static FMSAMPLE  *bufL,*bufR;
static FM_CH     *cch[8];
static signed int outd[4];

#ifdef LFO_SUPPORT
static unsigned int LFOCnt,LFOIncr;
#endif

/* operator connection work */
static int feedback2;           /* connect for operator 2 */
static int feedback3;           /* connect for operator 3 */
static int feedback4;           /* connect for operator 4 */


#define Limit(val, max,min) { \
        if ( val > max )      val = max; \
        else if ( val < min ) val = min; \
}

#define FM_BUFFERING_STEREO \
{                                                         \
        /* get left & right output with clipping */       \
        outd[OUTD_LEFT]  += outd[OUTD_CENTER];            \
        Limit( outd[OUTD_LEFT] , FM_MAXOUT, FM_MINOUT );  \
        outd[OUTD_RIGHT] += outd[OUTD_CENTER];            \
        Limit( outd[OUTD_RIGHT], FM_MAXOUT, FM_MINOUT );  \
        /* buffering */                                   \
        bufL[i] = (FMSAMPLE)(outd[OUTD_LEFT] >>FM_OUTSB); \
        bufR[i] = (FMSAMPLE)(outd[OUTD_RIGHT]>>FM_OUTSB); \
}

/* ----- internal timer mode , update timer */
#ifdef INTERNAL_TIMER
/* ---------- calcrate timer A ---------- */
#define INTERNAL_TIMER_A(ST,CSM_CH) {                                    \
        if( ST->TAC &&  (ST->Timer_Handler==0) )                         \
                if( (ST->TAC -= (int)(ST->freqbase*4096)) <= 0 ) {       \
                        TimerAOver( ST );                                \
                        /* CSM mode total level latch and auto key on */ \
                        if( ST->mode & 0x80 )                            \
                                CSMKeyControll( CSM_CH );                \
                }                                                        \
}

/* ---------- calcrate timer B ---------- */
#define INTERNAL_TIMER_B(ST,step)                                    \
{                                                                    \
        if( ST->TBC && (ST->Timer_Handler==0) )                      \
                if( (ST->TBC -= (int)(ST->freqbase*4096*step)) <= 0) \
                        TimerBOver( ST );                            \
}
#else
/* external timer mode */
#define INTERNAL_TIMER_A(ST,CSM_CH)
#define INTERNAL_TIMER_B(ST,step)
#endif

/* --------------------- subroutines  --------------------- */

/* status set and IRQ handling */
INLINE static void FM_STATUS_SET(FM_ST *ST,int flag)
{
        /* set status flag */
        ST->status |= flag;
        if ( !(ST->irq) && (ST->status & ST->irqmask) )
        {
                ST->irq = 1;
                /* callback user interrupt handler (IRQ is OFF to ON) */
                if(ST->IRQ_Handler) (ST->IRQ_Handler)(ST->index,1);
        }
}

/* status reset and IRQ handling */
INLINE static void FM_STATUS_RESET(FM_ST *ST,int flag)
{
        /* reset status flag */
        ST->status &=~flag;
        if ( (ST->irq) && !(ST->status & ST->irqmask) )
        {
                ST->irq = 0;
                /* callback user interrupt handler (IRQ is ON to OFF) */
                if(ST->IRQ_Handler) (ST->IRQ_Handler)(ST->index,0);
        }
}

/* IRQ mask set */
INLINE static void FM_IRQMASK_SET(FM_ST *ST, unsigned char flag)
{
        ST->irqmask = flag;
        /* IRQ handling check */
        FM_STATUS_SET(ST,0);
        FM_STATUS_RESET(ST,0);
}

/* ----- key on  ----- */
INLINE static void FM_KEYON(FM_CH *CH , int s )
{
        FM_SLOT *SLOT = &CH->SLOT[s];
        if( SLOT->evm<= ENV_MOD_RR)
        {
                /* set envelope counter from envleope output */

                /* sin wave restart */
                SLOT->Cnt = 0;
                if( s == SLOT1 ) CH->op1_out[0] = CH->op1_out[1] = 0;
                /* set attack */
#ifdef SEG_SUPPORT
                if( SLOT->SEG&8 ) ENV_SSG_AR;
                else
#endif
                SLOT->evm = ENV_MOD_AR;
                SLOT->evs = SLOT->evsa;
                /* reset attack counter */
                SLOT->evc = EG_AST;
                SLOT->eve = EG_AED;
        }
}
/* ----- key off ----- */
INLINE static void FM_KEYOFF(FM_CH *CH , int s )
{
        FM_SLOT *SLOT = &CH->SLOT[s];
        if( SLOT->evm > ENV_MOD_RR)
        {
                /* set envelope counter from envleope output */
                SLOT->evm = ENV_MOD_RR;
                if( !(SLOT->evc&EG_DST) )
                        SLOT->evc = (ENV_CURVE[SLOT->evc>>ENV_BITS]<<ENV_BITS) + EG_DST;
                SLOT->eve = EG_DED;
                SLOT->evs = SLOT->evsr;
        }
}

/* ---------- calcrate Envelope Generator & Phase Generator ---------- */
/* return : envelope output */
INLINE static signed int FM_CALC_SLOT( FM_SLOT *SLOT )
{
        /* calcrate envelope generator */
        if( (SLOT->evc+=SLOT->evs) >= SLOT->eve )
        {
                switch( SLOT->evm ){
                case ENV_MOD_AR: /* ATTACK -> DECAY1 */
                        /* next DR */
                        SLOT->evm = ENV_MOD_DR;
                        SLOT->evc = EG_DST;
                        SLOT->eve = SLOT->SL;
                        SLOT->evs = SLOT->evsd;
                        break;
                case ENV_MOD_DR: /* DECAY -> SUSTAIN */
                        SLOT->evm = ENV_MOD_SR;
                        SLOT->evc = SLOT->SL;
                        SLOT->eve = EG_DED;
                        SLOT->evs = SLOT->evss;
                        break;
                case ENV_MOD_RR: /* RR -> OFF & STOP */
                        SLOT->evm = ENV_MOD_OFF;
                case ENV_MOD_SR: /* SR -> OFF & STOP */
                        SLOT->evc = EG_OFF;
                        SLOT->eve = EG_OFF+1;
                        SLOT->evs = 0;
                        break;
#ifdef SEG_SUPPORT
                case ENV_SSG_AR: /* SSG ATTACK */
                        if( SLOT->SEG&4){       /* start direction */
                                /* next SSG-SR (upside start ) */
                                SLOT->evm = ENV_SSG_SR;
                                SLOT->evc = SLOT->SL + (EG_UST - EG_DST);
                                SLOT->eve = EG_UED;
                                SLOT->evs = SLOT->evss;
                        }else{
                                /* next SSG-DR (downside start ) */
                                SLOT->evm = ENV_SSG_DR;
                                SLOT->evc = EG_DST;
                                SLOT->eve = EG_DED;
                                SLOT->evs = SLOT->evsd;
                        }
                        break;
                case ENV_SSG_DR:        /* SEG down side */
                        if( SLOT->SEG&2){
                                /* reverce */
                                SLOT->evm = ENV_SSG_SR;
                                SLOT->evc = SLOT->SL + (EG_UST - EG_DST);
                                SLOT->eve = EG_UED;
                                SLOT->evs = SLOT->evss;
                        }else{
                                /* again */
                                SLOT->evc = EG_DST;
                        }
                        /* hold */
                        if( SLOT->SEG&1) SLOT->evs = 0;
                        break;
                case ENV_SSG_SR:        /* upside */
                        if( SLOT->SEG&2){
                                /* reverce  */
                                SLOT->evm = ENV_SSG_DR;
                                SLOT->evc = EG_DST;
                                SLOT->eve = EG_DED;
                                SLOT->evs = SLOT->evsd;
                        }else{
                                /* again */
                                SLOT->evc = SLOT->SL + (EG_UST - EG_DST);
                        }
                        /* hold check */
                        if( SLOT->SEG&1) SLOT->evs = 0;
                        break;
#endif
                }
        }
        /* calcrate envelope */
#ifdef LFO_SUPPORT
        if(SLOT->ams)
                return SLOT->TLL+ENV_CURVE[SLOT->evc>>ENV_BITS]
                        +(SLOT->ams*lfo_amd/LFO_RATE);
#endif
        return SLOT->TLL+ENV_CURVE[SLOT->evc>>ENV_BITS];
}

/* set algorythm connection */
static void set_algorythm( FM_CH *CH )
{
        signed int *carrier = &outd[CH->PAN];

        /* setup connect algorythm */
        switch( CH->ALGO ){
        case 0:
                /*  PG---S1---S2---S3---S4---OUT */
                CH->connect1 = &feedback2;
                CH->connect2 = &feedback3;
                CH->connect3 = &feedback4;
                break;
        case 1:
                /*  PG---S1-+-S3---S4---OUT */
                /*  PG---S2-+               */
                CH->connect1 = &feedback3;
                CH->connect2 = &feedback3;
                CH->connect3 = &feedback4;
                break;
        case 2:
                /* PG---S1------+-S4---OUT */
                /* PG---S2---S3-+          */
                CH->connect1 = &feedback4;
                CH->connect2 = &feedback3;
                CH->connect3 = &feedback4;
                break;
        case 3:
                /* PG---S1---S2-+-S4---OUT */
                /* PG---S3------+          */
                CH->connect1 = &feedback2;
                CH->connect2 = &feedback4;
                CH->connect3 = &feedback4;
                break;
        case 4:
                /* PG---S1---S2-+--OUT */
                /* PG---S3---S4-+      */
                CH->connect1 = &feedback2;
                CH->connect2 = carrier;
                CH->connect3 = &feedback4;
                break;
        case 5:
                /*         +-S2-+     */
                /* PG---S1-+-S3-+-OUT */
                /*         +-S4-+     */
                CH->connect1 = 0;       /* special mark */
                CH->connect2 = carrier;
                CH->connect3 = carrier;
                break;
        case 6:
                /* PG---S1---S2-+     */
                /* PG--------S3-+-OUT */
                /* PG--------S4-+     */
                CH->connect1 = &feedback2;
                CH->connect2 = carrier;
                CH->connect3 = carrier;
                break;
        case 7:
                /* PG---S1-+     */
                /* PG---S2-+-OUT */
                /* PG---S3-+     */
                /* PG---S4-+     */
                CH->connect1 = carrier;
                CH->connect2 = carrier;
                CH->connect3 = carrier;
        }
        CH->connect4 = carrier;
}

/* set detune & multiple */
INLINE static void set_det_mul(FM_ST *ST,FM_CH *CH,FM_SLOT *SLOT,int v)
{
        SLOT->mul = MUL_TABLE[v&0x0f];
        SLOT->DT  = ST->DT_TABLE[(v>>4)&7];
        CH->SLOT[SLOT1].Incr=(unsigned)-1;
}

/* set total level */
INLINE static void set_tl(FM_CH *CH,FM_SLOT *SLOT , int v,int csmflag)
{
        v &= 0x7f;
        v = (v<<7)|v; /* 7bit -> 14bit */
        SLOT->TL = (v*EG_ENT)>>14;
        if( !csmflag )
        {       /* not CSM latch total level */
                SLOT->TLL = SLOT->TL + KSL[CH->kcode];
        }
}

/* set attack rate & key scale  */
INLINE static void set_ar_ksr(FM_CH *CH,FM_SLOT *SLOT, int v,signed int *ar_table)
{
        SLOT->KSR  = (unsigned char)(3-(v>>6));
        SLOT->AR   = (v&=0x1f) ? &ar_table[v<<1] : RATE_0;
        SLOT->evsa = SLOT->AR[SLOT->ksr];
        if( SLOT->evm == ENV_MOD_AR ) SLOT->evs = SLOT->evsa;
        CH->SLOT[SLOT1].Incr=(unsigned)-1;
}
/* set decay rate */
INLINE static void set_dr(FM_SLOT *SLOT,int v,signed int *dr_table)
{
        SLOT->DR = (v&=0x1f) ? &dr_table[v<<1] : RATE_0;
        SLOT->evsd = SLOT->DR[SLOT->ksr];
        if( SLOT->evm == ENV_MOD_DR ) SLOT->evs = SLOT->evsd;
}
/* set sustain rate */
INLINE static void set_sr(FM_SLOT *SLOT,int v,signed int *dr_table)
{
        SLOT->SR = (v&=0x1f) ? &dr_table[v<<1] : RATE_0;
        SLOT->evss = SLOT->SR[SLOT->ksr];
        if( SLOT->evm == ENV_MOD_SR ) SLOT->evs = SLOT->evss;
}
/* set release rate */
INLINE static void set_sl_rr(FM_SLOT *SLOT,int v,signed int *dr_table)
{
        SLOT->SL = SL_TABLE[(v>>4)];
        SLOT->RR = &dr_table[((v&0x0f)<<2)|2];
        SLOT->evsr = SLOT->RR[SLOT->ksr];
        if( SLOT->evm == ENV_MOD_RR ) SLOT->evs = SLOT->evsr;
}

/* operator output calcrator */
#define OP_OUT(con)   SIN_TABLE[((SLOT->Cnt+con)/(0x1000000/SIN_ENT))&(SIN_ENT-1)][env_out]
#define OP_OUTN(con)  NOISE_TABLE[(NoiseCnt/(0x1000000/SIN_ENT))&(SIN_ENT-1)][env_out]
/* ---------- calcrate one of channel ---------- */
INLINE static void FM_CALC_CH( FM_CH *CH )
{
        FM_SLOT *SLOT;
        int env_out;
        /* phase generator */
#ifdef LFO_SUPPORT
        signed int pms = lfo_pmd * CH->pms / LFO_RATE;
        if(pms)
        {
                CH->SLOT[SLOT1].Cnt += CH->SLOT[SLOT1].Incr + (signed int)(pms * CH->SLOT[SLOT1].Incr) / PMS_RATE;
                CH->SLOT[SLOT2].Cnt += CH->SLOT[SLOT2].Incr + (signed int)(pms * CH->SLOT[SLOT2].Incr) / PMS_RATE;
                CH->SLOT[SLOT3].Cnt += CH->SLOT[SLOT3].Incr + (signed int)(pms * CH->SLOT[SLOT3].Incr) / PMS_RATE;
                CH->SLOT[SLOT4].Cnt += CH->SLOT[SLOT4].Incr + (signed int)(pms * CH->SLOT[SLOT4].Incr) / PMS_RATE;
        }
        else
#endif
        {
                CH->SLOT[SLOT1].Cnt += CH->SLOT[SLOT1].Incr;
                CH->SLOT[SLOT2].Cnt += CH->SLOT[SLOT2].Incr;
                CH->SLOT[SLOT3].Cnt += CH->SLOT[SLOT3].Incr;
                CH->SLOT[SLOT4].Cnt += CH->SLOT[SLOT4].Incr;
        }

        /* SLOT 1 */
        SLOT = &CH->SLOT[SLOT1];
        env_out=FM_CALC_SLOT(SLOT);
        if( env_out < EG_ENT-1 )
        {
                if( CH->FB ){
                        /* with self feed back */
                        int feedback1 = (CH->op1_out[0]+CH->op1_out[1])>>CH->FB;
                        CH->op1_out[1] = CH->op1_out[0];
                        CH->op1_out[0] = OP_OUT(feedback1);
                }else{
                        /* without self feed back */
                        CH->op1_out[0] = OP_OUT(0);
                }
                /* output slot1 */
                if( !CH->connect1 )
                {
                        /* algorythm 5  */
                        feedback2 = feedback3 = feedback4 = CH->op1_out[0];
                }else{
                        /* other algorythm */
                        feedback2 = feedback3 = feedback4 = 0;
                        *CH->connect1 += CH->op1_out[0];
                }
        }
        else
                feedback2 = feedback3 = feedback4 = 0;
        /* SLOT 2 */
        SLOT = &CH->SLOT[SLOT2];
        env_out=FM_CALC_SLOT(SLOT);
        if( env_out < EG_ENT-1 )
                *CH->connect2 += OP_OUT(feedback2);
        /* SLOT 3 */
        SLOT = &CH->SLOT[SLOT3];
        env_out=FM_CALC_SLOT(SLOT);
        if( env_out < EG_ENT-1 )
                *CH->connect3 += OP_OUT(feedback3);
        /* SLOT 4 */
        SLOT = &CH->SLOT[SLOT4];
        env_out=FM_CALC_SLOT(SLOT);
        if( env_out < EG_ENT-1 )
                *CH->connect4 += OP_OUT(feedback4);
        /* cut off output (higher 13bit+sign) */
        *CH->connect4 &= OP_CUT_MASK;
}
/* ---------- frequency counter for operater update ---------- */
INLINE static void CALC_FCSLOT(FM_SLOT *SLOT , int fc , int kc )
{
        int ksr;

        /* frequency step counter */
        /* SLOT->Incr= (fc+SLOT->DT[kc])*SLOT->mul; */
        SLOT->Incr= fc*SLOT->mul + SLOT->DT[kc];
        ksr = kc >> SLOT->KSR;
        if( SLOT->ksr != ksr )
        {
                SLOT->ksr = (unsigned char)ksr;
                /* attack , decay rate recalcration */
                SLOT->evsa = SLOT->AR[ksr];
                SLOT->evsd = SLOT->DR[ksr];
                SLOT->evss = SLOT->SR[ksr];
                SLOT->evsr = SLOT->RR[ksr];
        }
        SLOT->TLL = SLOT->TL + KSL[kc];
}

/* ---------- frequency counter  ---------- */
INLINE static void CALC_FCOUNT(FM_CH *CH )
{
        if( CH->SLOT[SLOT1].Incr==(unsigned)-1){
                int fc = CH->fc;
                int kc = CH->kcode;
                CALC_FCSLOT(&CH->SLOT[SLOT1] , fc , kc );
                CALC_FCSLOT(&CH->SLOT[SLOT2] , fc , kc );
                CALC_FCSLOT(&CH->SLOT[SLOT3] , fc , kc );
                CALC_FCSLOT(&CH->SLOT[SLOT4] , fc , kc );
        }
}

/* ----------- initialize time tabls ----------- */
static void init_timetables( FM_ST *ST , char *DTTABLE , int ARRATE , int DRRATE )
{
        int i,d;
        double rate;

        /* make detune table */
        for (d = 0;d <= 3;d++){
                for (i = 0;i <= 31;i++){
                        rate = (double)DTTABLE[d*32 + i] * ST->freqbase * FREQ_RATE;
                        ST->DT_TABLE[d][i]   =  (int)rate;
                        ST->DT_TABLE[d+4][i] = -(int)rate;
                }
        }
        /* make attack rate & decay rate tables */
        for (i = 0;i < 4;i++) ST->AR_TABLE[i] = ST->DR_TABLE[i] = 0;
        for (i = 4;i < 64;i++){
                rate  = ST->freqbase;                                           /* frequency rate */
                if( i < 60 ) rate *= 1.0+(i&3)*0.25;            /* b0-1 : x1 , x1.25 , x1.5 , x1.75 */
                rate *= 1<<((i>>2)-1);                                          /* b2-5 : shift bit */
                rate *= (double)(EG_ENT<<ENV_BITS);
                ST->AR_TABLE[i] = (int)(rate / ARRATE);
                ST->DR_TABLE[i] = (int)(rate / DRRATE);
        }
        ST->AR_TABLE[62] = EG_AED-1;
        ST->AR_TABLE[63] = EG_AED-1;
        for (i = 64;i < 94 ;i++){       /* make for overflow area */
                ST->AR_TABLE[i] = ST->AR_TABLE[63];
                ST->DR_TABLE[i] = ST->DR_TABLE[63];
        }
}

/* ---------- reset one of channel  ---------- */
static void reset_channel( FM_ST *ST , FM_CH *CH , int chan )
{
        int c,s;

        ST->mode   = 0; /* normal mode */
        FM_STATUS_RESET(ST,0xff);
        ST->TA     = 0;
        ST->TAC    = 0;
        ST->TB     = 0;
        ST->TBC    = 0;

        for( c = 0 ; c < chan ; c++ )
        {
                CH[c].fc = 0;
                CH[c].PAN = OUTD_CENTER;
                for(s = 0 ; s < 4 ; s++ )
                {
                        CH[c].SLOT[s].SEG = 0;
                        CH[c].SLOT[s].evm = ENV_MOD_OFF;
                        CH[c].SLOT[s].evc = EG_OFF;
                        CH[c].SLOT[s].eve = EG_OFF+1;
                        CH[c].SLOT[s].evs = 0;
                }
        }
}

/* ---------- generic table initialize ---------- */
static int FMInitTable( void )
{
        int s,t;
        double rate;
        int i,j;
        double pom;

        /* allocate total level table */
        TL_TABLE = malloc(TL_MAX*2*sizeof(int));
        if( TL_TABLE == 0 ) return 1;
        /* make total level table */
        for (t = 0;t < EG_ENT-1 ;t++){
                rate = ((1<<TL_BITS)-1)/pow(10,EG_STEP*t/20);   /* dB -> voltage */
                TL_TABLE[       t] =  (int)rate;
                TL_TABLE[TL_MAX+t] = -TL_TABLE[t];
        }
        /* fill volume off area */
        for ( t = EG_ENT-1; t < TL_MAX ;t++){
                TL_TABLE[t] = TL_TABLE[TL_MAX+t] = 0;
        }

        /* make sinwave table (total level offet) */
         /* degree 0 = degree 180                   = off */
        SIN_TABLE[0] = SIN_TABLE[SIN_ENT/2]         = &TL_TABLE[EG_ENT-1];
        for (s = 1;s <= SIN_ENT/4;s++){
                pom = sin(2*PI*s/SIN_ENT); /* sin     */
                pom = 20*log10(1/pom);     /* decibel */
                j = (int)(pom / EG_STEP);         /* TL_TABLE steps */

        /* degree 0   -  90    , degree 180 -  90 : plus section */
                SIN_TABLE[          s] = SIN_TABLE[SIN_ENT/2-s] = &TL_TABLE[j];
        /* degree 180 - 270    , degree 360 - 270 : minus section */
                SIN_TABLE[SIN_ENT/2+s] = SIN_TABLE[SIN_ENT  -s] = &TL_TABLE[TL_MAX+j];
/*              Log(LOG_INF,"sin(%3d) = %f:%f db\n",s,pom,(double)j * EG_STEP);*/
        }
        /* envelope counter -> envelope output table */
        for (i=0; i<EG_ENT; i++)
        {
                /* ATTACK curve */
                /* !!!!! preliminary !!!!! */
                pom = pow( ((double)(EG_ENT-1-i)/EG_ENT) , 8 ) * EG_ENT;
                /* if( pom >= EG_ENT ) pom = EG_ENT-1; */
                ENV_CURVE[i] = (int)pom;
                /* DECAY ,RELEASE curve */
                ENV_CURVE[(EG_DST>>ENV_BITS)+i]= i;
#ifdef SEG_SUPPORT
                /* DECAY UPSIDE (SSG ENV) */
                ENV_CURVE[(EG_UST>>ENV_BITS)+i]= EG_ENT-1-i;
#endif
        }
        /* off */
        ENV_CURVE[EG_OFF>>ENV_BITS]= EG_ENT-1;

        /* decay to reattack envelope converttable */
        j = EG_ENT-1;
        for (i=0; i<EG_ENT; i++)
        {
                while( j && (ENV_CURVE[j] < i) ) j--;
                DRAR_TABLE[i] = j<<ENV_BITS;
        }
        return 0;
}


static void FMCloseTable( void )
{
        if( TL_TABLE ) free(TL_TABLE);
        return;
}

/* OPN/OPM Mode  Register Write */
INLINE static void FMSetMode( FM_ST *ST ,int n,int v )
{
        /* b7 = CSM MODE */
        /* b6 = 3 slot mode */
        /* b5 = reset b */
        /* b4 = reset a */
        /* b3 = timer enable b */
        /* b2 = timer enable a */
        /* b1 = load b */
        /* b0 = load a */
        ST->mode = v;

        /* reset Timer b flag */
        if( v & 0x20 )
                FM_STATUS_RESET(ST,0x02);
        /* reset Timer a flag */
        if( v & 0x10 )
                FM_STATUS_RESET(ST,0x01);
        /* load b */
        if( v & 0x02 )
        {
                if( ST->TBC == 0 )
                {
                        ST->TBC = ( 256-ST->TB)<<4;
                        /* External timer handler */
                        if (ST->Timer_Handler) (ST->Timer_Handler)(n,1,ST->TBC,ST->TimerBase);
                }
        }else if (ST->timermodel == FM_TIMER_INTERVAL)
        {       /* stop interbval timer */
                if( ST->TBC != 0 )
                {
                        ST->TBC = 0;
                        if (ST->Timer_Handler) (ST->Timer_Handler)(n,1,0,ST->TimerBase);
                }
        }
        /* load a */
        if( v & 0x01 )
        {
                if( ST->TAC == 0 )
                {
                        ST->TAC = (1024-ST->TA);
                        /* External timer handler */
                        if (ST->Timer_Handler) (ST->Timer_Handler)(n,0,ST->TAC,ST->TimerBase);
                }
        }else if (ST->timermodel == FM_TIMER_INTERVAL)
        {       /* stop interbval timer */
                if( ST->TAC != 0 )
                {
                        ST->TAC = 0;
                        if (ST->Timer_Handler) (ST->Timer_Handler)(n,0,0,ST->TimerBase);
                }
        }
}

/* Timer A Overflow */
INLINE static void TimerAOver(FM_ST *ST)
{
        /* status set if enabled */
        if(ST->mode & 0x04) FM_STATUS_SET(ST,0x01);
        /* clear or reload the counter */
        if (ST->timermodel == FM_TIMER_INTERVAL)
        {
                ST->TAC = (1024-ST->TA);
                if (ST->Timer_Handler) (ST->Timer_Handler)(ST->index,0,ST->TAC,ST->TimerBase);
        }
        else ST->TAC = 0;
}
/* Timer B Overflow */
INLINE static void TimerBOver(FM_ST *ST)
{
        /* status set if enabled */
        if(ST->mode & 0x08) FM_STATUS_SET(ST,0x02);
        /* clear or reload the counter */
        if (ST->timermodel == FM_TIMER_INTERVAL)
        {
                ST->TBC = ( 256-ST->TB)<<4;
                if (ST->Timer_Handler) (ST->Timer_Handler)(ST->index,1,ST->TBC,ST->TimerBase);
        }
        else ST->TBC = 0;
}
/* CSM Key Controll */
INLINE static void CSMKeyControll(FM_CH *CH)
{
        int ksl = KSL[CH->kcode];
        /* all key off */
        FM_KEYOFF(CH,SLOT1);
        FM_KEYOFF(CH,SLOT2);
        FM_KEYOFF(CH,SLOT3);
        FM_KEYOFF(CH,SLOT4);
        /* total level latch */
        CH->SLOT[SLOT1].TLL = CH->SLOT[SLOT1].TL + ksl;
        CH->SLOT[SLOT2].TLL = CH->SLOT[SLOT2].TL + ksl;
        CH->SLOT[SLOT3].TLL = CH->SLOT[SLOT3].TL + ksl;
        CH->SLOT[SLOT4].TLL = CH->SLOT[SLOT4].TL + ksl;
        /* all key on */
        FM_KEYON(CH,SLOT1);
        FM_KEYON(CH,SLOT2);
        FM_KEYON(CH,SLOT3);
        FM_KEYON(CH,SLOT4);
}

static void OPNSetPris(FM_OPN *OPN , int pris , int TimerPris)
{
        int i;

        /* frequency base */
        OPN->ST.freqbase = (OPN->ST.rate) ? ((double)OPN->ST.clock / OPN->ST.rate) / pris : 0;
        /* Timer base time */
        OPN->ST.TimerBase = (OPN->ST.rate) ? 1.0/((double)OPN->ST.clock / (double)TimerPris) : 0;
        /* make time tables */
        init_timetables( &OPN->ST , OPN_DTTABLE , OPN_ARRATE , OPN_DRRATE );
        /* make fnumber -> increment counter table */
        for( i=0 ; i < 2048 ; i++ )
        {
                /* it is freq table for octave 7 */
                /* opn freq counter = 20bit */
                OPN->FN_TABLE[i] = (unsigned)(i * OPN->ST.freqbase * FREQ_RATE * 128 / 2);
        }
#ifdef LFO_SUPPORT
        /* LFO wave table */
        for(i=0;i<LFO_ENT;i++)
        {
                OPN->LFO_wave[i]= i<LFO_ENT/2 ? i*LFO_RATE/(LFO_ENT/2) : (LFO_ENT-i)*LFO_RATE/(LFO_ENT/2);
        }
        /* LFO freq. table */
        {
                /* 3.98Hz,5.56Hz,6.02Hz,6.37Hz,6.88Hz,9.63Hz,48.1Hz,72.2Hz @ 8MHz */
                static const double freq_table[8] = { 3.98,5.56,6.02,6.37,6.88,9.63,48.1,72.2 };
                for(i=0;i<8;i++)
                {
                        OPN->LFO_FREQ[i] = (unsigned)((OPN->ST.rate) ? ( (double)LFO_ENT*(1<<LFO_SHIFT)
                                        / (OPN->ST.rate / freq_table[i]
                                        * (OPN->ST.freqbase*OPN->ST.rate/(8000000.0/144))) ) : 0);

                }
        }
#endif
}

/* ---------- write a OPN mode register 0x20-0x2f ---------- */
static void OPNWriteMode(FM_OPN *OPN, int r, int v)
{
        unsigned char c;
        FM_CH *CH;

        switch(r){
        case 0x21:      /* Test */
                break;
#ifdef LFO_SUPPORT
        case 0x22:      /* LFO FREQ (YM2608/YM2612) */
                if( OPN->type & TYPE_LFOPAN )
                {
                        OPN->LFOIncr = (v&0x08) ? OPN->LFO_FREQ[v&7] : 0;
                        cur_chip = NULL;
                }
                break;
#endif
        case 0x24:      /* timer A High 8*/
                OPN->ST.TA = (OPN->ST.TA & 0x03)|(((int)v)<<2);
                break;
        case 0x25:      /* timer A Low 2*/
                OPN->ST.TA = (OPN->ST.TA & 0x3fc)|(v&3);
                break;
        case 0x26:      /* timer B */
                OPN->ST.TB = (unsigned char)v;
                break;
        case 0x27:      /* mode , timer controll */
                FMSetMode( &(OPN->ST),OPN->ST.index,v );
                break;
        case 0x28:      /* key on / off */
                c = (unsigned char)(v&0x03);
                if( c == 3 ) break;
                if( (v&0x04) && (OPN->type & TYPE_6CH) ) c+=3;
                CH = OPN->P_CH;
                CH = &CH[c];
                /* csm mode */
                if( c == 2 && (OPN->ST.mode & 0x80) ) break;
                if(v&0x10) FM_KEYON(CH,SLOT1); else FM_KEYOFF(CH,SLOT1);
                if(v&0x20) FM_KEYON(CH,SLOT2); else FM_KEYOFF(CH,SLOT2);
                if(v&0x40) FM_KEYON(CH,SLOT3); else FM_KEYOFF(CH,SLOT3);
                if(v&0x80) FM_KEYON(CH,SLOT4); else FM_KEYOFF(CH,SLOT4);
                break;
        }
}

/* ---------- write a OPN register (0x30-0xff) ---------- */
static void OPNWriteReg(FM_OPN *OPN, int r, int v)
{
        unsigned char c;
        FM_CH *CH;
        FM_SLOT *SLOT;

        /* 0x30 - 0xff */
        if( (c = (unsigned char)OPN_CHAN(r)) == 3 ) return; /* 0xX3,0xX7,0xXB,0xXF */
        if( (r >= 0x100) /* && (OPN->type & TYPE_6CH) */ ) c+=3;
                CH = OPN->P_CH;
                CH = &CH[c];

        SLOT = &(CH->SLOT[OPN_SLOT(r)]);
        switch( r & 0xf0 ) {
        case 0x30:      /* DET , MUL */
                set_det_mul(&OPN->ST,CH,SLOT,v);
                break;
        case 0x40:      /* TL */
                set_tl(CH,SLOT,v,(c == 2) && (OPN->ST.mode & 0x80) );
                break;
        case 0x50:      /* KS, AR */
                set_ar_ksr(CH,SLOT,v,OPN->ST.AR_TABLE);
                break;
        case 0x60:      /*     DR */
                /* bit7 = AMS_ON ENABLE(YM2612) */
                set_dr(SLOT,v,OPN->ST.DR_TABLE);
#ifdef LFO_SUPPORT
                if( OPN->type & TYPE_LFOPAN)
                {
                        SLOT->amon = (unsigned char)(v>>7);
                        SLOT->ams = CH->ams * SLOT->amon;
                }
#endif
                break;
        case 0x70:      /*     SR */
                set_sr(SLOT,v,OPN->ST.DR_TABLE);
                break;
        case 0x80:      /* SL, RR */
                set_sl_rr(SLOT,v,OPN->ST.DR_TABLE);
                break;
        case 0x90:      /* SSG-EG */
                SLOT->SEG = (unsigned char)(v&0x0f);
                break;
        case 0xa0:
                switch( OPN_SLOT(r) ){
                case 0:         /* 0xa0-0xa2 : FNUM1 */
                        {
                                unsigned int fn  = (((unsigned int)( (CH->fn_h)&7))<<8) + v;
                                unsigned char blk = (unsigned char)(CH->fn_h>>3);
                                /* make keyscale code */
                                CH->kcode = (unsigned char)((blk<<2)|OPN_FKTABLE[(fn>>7)]);
                                /* make basic increment counter 32bit = 1 cycle */
                                CH->fc = OPN->FN_TABLE[fn]>>(7-blk);
                                CH->SLOT[SLOT1].Incr=(unsigned)-1;
                        }
                        break;
                case 1:         /* 0xa4-0xa6 : FNUM2,BLK */
                        CH->fn_h = (unsigned char)(v&0x3f);
                        break;
                case 2:         /* 0xa8-0xaa : 3CH FNUM1 */
                        if( r < 0x100)
                        {
                                unsigned int fn  = (((unsigned int)(OPN->SL3.fn_h[c]&7))<<8) + v;
                                unsigned char blk = (unsigned char)(OPN->SL3.fn_h[c]>>3);
                                /* make keyscale code */
                                OPN->SL3.kcode[c]= (unsigned char)((blk<<2)|OPN_FKTABLE[(fn>>7)]);
                                /* make basic increment counter 32bit = 1 cycle */
                                OPN->SL3.fc[c] = OPN->FN_TABLE[fn]>>(7-blk);
                                (OPN->P_CH)[2].SLOT[SLOT1].Incr=(unsigned)-1;
                        }
                        break;
                case 3:         /* 0xac-0xae : 3CH FNUM2,BLK */
                        if( r < 0x100)
                                OPN->SL3.fn_h[c] = (unsigned char)(v&0x3f);
                        break;
                }
                break;
        case 0xb0:
                switch( OPN_SLOT(r) ){
                case 0:         /* 0xb0-0xb2 : FB,ALGO */
                        {
                                int feedback = (v>>3)&7;
                                CH->ALGO = (unsigned char)(v&7);
                                CH->FB   = (unsigned char)(feedback ? 8+1 - feedback : 0);
                                set_algorythm( CH );
                        }
                        break;
                case 1:         /* 0xb4-0xb6 : L , R , AMS , PMS (YM2612/YM2608) */
                        if( OPN->type & TYPE_LFOPAN)
                        {
#ifdef LFO_SUPPORT
                                /* b0-2 PMS */
                                /* 0,3.4,6.7,10,14,20,40,80(cent) */
                                static const double pmd_table[8]={0,3.4,6.7,10,14,20,40,80};
                                static const int amd_table[4]={0,(int)(1.4/EG_STEP),(int)(5.9/EG_STEP),(int)(11.8/EG_STEP) };
                                CH->pms = (int)((1.5/1200.0)*pmd_table[(v>>4) & 0x07] * PMS_RATE);
                                /* b4-5 AMS */
                                /* 0 , 1.4 , 5.9 , 11.8(dB) */
                                CH->ams = amd_table[(v>>4) & 0x03];
                                CH->SLOT[SLOT1].ams = CH->ams * CH->SLOT[SLOT1].amon;
                                CH->SLOT[SLOT2].ams = CH->ams * CH->SLOT[SLOT2].amon;
                                CH->SLOT[SLOT3].ams = CH->ams * CH->SLOT[SLOT3].amon;
                                CH->SLOT[SLOT4].ams = CH->ams * CH->SLOT[SLOT4].amon;
#endif
                                /* PAN */
                                CH->PAN = (unsigned char)((v>>6)&0x03); /* PAN : b6 = R , b7 = L */
                                set_algorythm( CH );
                                /* Log(LOG_INF,"OPN %d,%d : PAN %d\n",n,c,CH->PAN);*/
                        }
                        break;
                }
                break;
        }
}

/*******************************************************************************/
/*              YM2612 local section                                                   */
/*******************************************************************************/
static YM2612 *FM2612=NULL;     /* array of YM2612's */

static int dacen;

/* ---------- update one of chip ----------- */
void YM2612UpdateOne(int num, void **buffer, int length)
{
        YM2612 *F2612 = &(FM2612[num]);
        FM_OPN *OPN   = &(FM2612[num].OPN);
        int i;
        int dacout  = F2612->dacout;

        /* set bufer */
        bufL = (FMSAMPLE *)buffer[0];
        bufR = (FMSAMPLE *)buffer[1];

        if( (void *)F2612 != cur_chip ){
                cur_chip = (void *)F2612;

                State = &OPN->ST;
                cch[0]   = &F2612->CH[0];
                cch[1]   = &F2612->CH[1];
                cch[2]   = &F2612->CH[2];
                cch[3]   = &F2612->CH[3];
                cch[4]   = &F2612->CH[4];
                cch[5]   = &F2612->CH[5];
                /* DAC mode */
                dacen = F2612->dacen;
#ifdef LFO_SUPPORT
                LFOCnt  = OPN->LFOCnt;
                LFOIncr = OPN->LFOIncr;
                if( !LFOIncr ) lfo_amd = lfo_pmd = 0;
                LFO_wave = OPN->LFO_wave;
#endif
        }
        /* update frequency counter */
        CALC_FCOUNT( cch[0] );
        CALC_FCOUNT( cch[1] );
        if( (State->mode & 0xc0) ){
#ifdef LFO_SUPPORT
                /* LFO */
                if( LFOIncr )
                {
                        lfo_amd = LFO_wave[(LFOCnt+=LFOIncr)>>LFO_SHIFT];
                        lfo_pmd = lfo_amd-(LFO_RATE/2);
                }
#endif
                /* 3SLOT MODE */
                if( cch[2]->SLOT[SLOT1].Incr==(unsigned)-1){
                        /* 3 slot mode */
                        CALC_FCSLOT(&cch[2]->SLOT[SLOT1] , OPN->SL3.fc[1] , OPN->SL3.kcode[1] );
                        CALC_FCSLOT(&cch[2]->SLOT[SLOT2] , OPN->SL3.fc[2] , OPN->SL3.kcode[2] );
                        CALC_FCSLOT(&cch[2]->SLOT[SLOT3] , OPN->SL3.fc[0] , OPN->SL3.kcode[0] );
                        CALC_FCSLOT(&cch[2]->SLOT[SLOT4] , cch[2]->fc , cch[2]->kcode );
                }
        }else CALC_FCOUNT( cch[2] );
        CALC_FCOUNT( cch[3] );
        CALC_FCOUNT( cch[4] );
        CALC_FCOUNT( cch[5] );
        /* buffering */
    for( i=0; i < length ; i++ )
        {
                /* clear output acc. */
                outd[OUTD_LEFT] = outd[OUTD_RIGHT] = outd[OUTD_CENTER] = 0;
                /* calcrate channel output */
		FM_CALC_CH(cch[0]);
		FM_CALC_CH(cch[1]);
		FM_CALC_CH(cch[2]);
		FM_CALC_CH(cch[3]);
		FM_CALC_CH(cch[4]);
		if(dacen)
		    *cch[5]->connect4 += dacout;
                else
		    FM_CALC_CH(cch[5]);
                /* buffering */
                FM_BUFFERING_STEREO;
                /* timer A controll */
                INTERNAL_TIMER_A( State , cch[2] )
        }
        INTERNAL_TIMER_B(State,length)
#ifdef LFO_SUPPORT
        OPN->LFOCnt = LFOCnt;
#endif
}

/* -------------------------- YM2612 ---------------------------------- */
int YM2612Init(int num, int clock, int rate,
               FM_TIMERHANDLER TimerHandler,FM_IRQHANDLER IRQHandler)
{
        int i;

    if (FM2612) return 0x20000000;    /* duplicate init. */
    cur_chip = NULL;    /* hiro-shi!! */

        FMNumChips = num;

        /* allocate extend state space */
        if( (FM2612 = (YM2612 *)malloc(sizeof(YM2612) * FMNumChips))==NULL)
                return 1;
        /* clear */
        memset(FM2612,0,sizeof(YM2612) * FMNumChips);
        /* allocate total level table (128kb space) */
        i = FMInitTable();
        if(i)
        {
                free(FM2612);
                return i;
        }

        for ( i = 0 ; i < FMNumChips; i++ ) {
                FM2612[i].OPN.ST.index = (unsigned char)i;
                FM2612[i].OPN.type = TYPE_YM2612;
                FM2612[i].OPN.P_CH = FM2612[i].CH;
                FM2612[i].OPN.ST.clock = clock;
                FM2612[i].OPN.ST.rate = rate;
                /* FM2612[i].OPN.ST.irq = 0; */
                /* FM2612[i].OPN.ST.status = 0; */
                FM2612[i].OPN.ST.timermodel = FM_TIMER_INTERVAL;
                /* Extend handler */
                FM2612[i].OPN.ST.Timer_Handler = TimerHandler;
                FM2612[i].OPN.ST.IRQ_Handler   = IRQHandler;
                YM2612ResetChip(i);
        }
        return 0;
}

/* ---------- shut down emurator ----------- */
void YM2612Shutdown()
{
    if (!FM2612) return;

        FMCloseTable();
        free(FM2612);
        FM2612 = NULL;
}

/* ---------- reset one of chip ---------- */
void YM2612ResetChip(int num)
{
        int i;
        YM2612 *F2612 = &(FM2612[num]);
        FM_OPN *OPN   = &(FM2612[num].OPN);

        OPNSetPris( OPN , 12*12, 12*12);
        /* status clear */
        FM_IRQMASK_SET(&OPN->ST,0x03);
        OPNWriteMode(OPN,0x27,0x30); /* mode 0 , timer reset */

        reset_channel( &OPN->ST , &F2612->CH[0] , 6 );

        for(i = 0xb6 ; i >= 0xb4 ; i-- )
        {
                OPNWriteReg(OPN,i      ,0xc0);
                OPNWriteReg(OPN,i|0x100,0xc0);
        }
        for(i = 0xb2 ; i >= 0x30 ; i-- )
        {
                OPNWriteReg(OPN,i      ,0);
                OPNWriteReg(OPN,i|0x100,0);
        }
        for(i = 0x26 ; i >= 0x20 ; i-- ) OPNWriteReg(OPN,i,0);
        /* DAC mode clear */
        F2612->dacen = 0;
}

/* YM2612 write */
/* n = number  */
/* a = address */
/* v = value   */
int YM2612Write(int n, int a,unsigned char v)
{
        YM2612 *F2612 = &(FM2612[n]);
        int addr;

        switch( a&3){
        case 0: /* address port 0 */
                F2612->OPN.ST.address = (unsigned char)(v & 0xff);
                break;
        case 1: /* data port 0    */
                addr = F2612->OPN.ST.address;
                switch( addr & 0xf0 )
                {
                case 0x20:      /* 0x20-0x2f Mode */
                        switch( addr )
                        {
                        case 0x2a:      /* DAC data (YM2612) */
                                F2612->dacout = ((int)v-0x80)<<(TL_BITS-7);
                                break;
                        case 0x2b:      /* DAC Sel  (YM2612) */
                                /* b7 = dac enable */
                                F2612->dacen = v & 0x80;
                                cur_chip = NULL;
                                break;
                        default:        /* OPN section */
                                /* write register */
                                 OPNWriteMode(&(F2612->OPN),addr,v);
                        }
                        break;
                default:        /* 0x30-0xff OPN section */
                        /* write register */
                         OPNWriteReg(&(F2612->OPN),addr,v);
                }
                break;
        case 2: /* address port 1 */
                F2612->address1 = v & 0xff;
                break;
        case 3: /* data port 1    */
                addr = F2612->address1;
                OPNWriteReg(&(F2612->OPN),addr|0x100,v);
                break;
        }
        return F2612->OPN.ST.irq;
}
