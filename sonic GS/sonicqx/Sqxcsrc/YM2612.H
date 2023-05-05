/*
 File: ym2612.h -- header file for software emuration for FM sound genelator

 See ym2612.c for copyright information.

*/
#ifndef	YM2612_H_ALREADY_INCLUDED
#define	YM2612_H_ALREADY_INCLUDED

/* output bit size 8 or 16 */
#define FM_OUTPUT_BIT 16

#define YM2612_NUMBUF 2    /* FM L+R */

#if (FM_OUTPUT_BIT==16)
typedef unsigned short FMSAMPLE;
typedef unsigned long FMSAMPLE_MIX;
#endif
#if (FM_OUTPUT_BIT==8)
typedef unsigned char  FMSAMPLE;
typedef unsigned short FMSAMPLE_MIX;
#endif

/* For YM2151/YM2608/YM2612 option */

typedef void (*FM_TIMERHANDLER)(int n,int c,int cnt,double stepTime);
typedef void (*FM_IRQHANDLER)(int n,int irq);
/* FM_TIMERHANDLER : Stop or Start timer         */
/* int n          = chip number                  */
/* int c          = Channel 0=TimerA,1=TimerB    */
/* int count      = timer count (0=stop)         */
/* doube stepTime = step time of one count (sec.)*/

/* FM_IRQHHANDLER : IRQ level changing sense     */
/* int n       = chip number                     */
/* int irq     = IRQ level 0=OFF,1=ON            */

int YM2612Init(int num, int baseclock, int rate, FM_TIMERHANDLER TimerHandler,FM_IRQHANDLER IRQHandler);
void YM2612Shutdown(void);
void YM2612UpdateOne(int num, void **buffer, int length);
int YM2612Write(int n, int a,unsigned char v);
void YM2612ResetChip(int num);

#endif /* YM2612_H_ALREADY_INCLUDED */
