# build script for Sonic 4 in 1.
##################################################
# defines
export AS_MSGPATH=$(AS)msg
export USEANSI=n
TARGETS = dat\scaler\scaler.dat dat\scaler\scaler.kos dat\z80\z80.unc dat\z80\z80.kos dat\pcm\.unc dat\pcm\.kos s1\.bin s2/s2built.bin sk/1.bin UPMEM/.bin Sonic_4_in_1.debug.md
KOS = bin/FW_KENSC/koscmp
NEM = bin/FW_KENSC/nemcmp
ENI = bin/FW_KENSC/enicmp
SAX = bin/FW_KENSC/saxcmp
COMP = bin/FW_KENSC/compcmp
ASM68K = bin/asm68k
VASM = bin/vasmz80
AS = bin/as/
ASW = $(AS)asw
P2BIN = $(AS)p2bin
S2P2BIN = $(AS)s2p2bin
S2FIXPTR = $(AS)fixpointer
SKP2BIN = $(AS)s3p2bin
JAVA = java -jar
S2POST = $(JAVA) ../bin/s2postprocessor.jar
SKPOST = $(JAVA) ../bin/skpostprocessor.jar
CHKSUM = $(JAVA) bin/checksumgen.jar


# rule: all
all:	$(TARGETS)

# build main
Sonic_4_in_1.debug.md: main.asm equ.asm dat/font/font.asm ScalerMacros.asm s3_1.bin s3_2.bin s3_3.bin dat/bg.map.eni dat/bg.pal dat/bg.tiles.kos dat/gf.s1.art.slice.unc dat/gf.s1.pal dat/gf.s2.art.slice.unc dat/gf.s2.pal dat/gf.s3.art.slice.unc dat/gf.s3.pal dat/gf.sk.art.slice.unc dat/gf.sk.pal dat/gf.bp.art.slice.unc dat/gf.bp.pal dat/nat.art.kos dat/nat.map.eni dat/nat.map.eni dat/scaler/scaler.kos dat/sr/main.asm dat/sr/logo.kos dat/sr/emerald.kos dat/sr/sr.pal dat/sr/logo.map.eni dat/sr/bg.smps.asm dat/ssrg/SSRG_Screen.asm dat/ssrg/Logo.pal dat/ssrg/Logo_Bnk1.4bpp.kos dat/ssrg/Logo_Bnk2.4bpp.kos dat/ssrg/LogoMaps.kos dat/ssrg/SceneData.bin dat/ssrg/Sonic.4bpp.nem dat/ssrg/Sonic_Pt1.pal dat/ssrg/Sonic_Pt2.pal dat/ssrg/Title.4bpp.nem dat/ssrg/Title.pal dat/ani/code.asm dat/z80/z80.kos dat/pcm/.kos s1/.bin s2/0.bin sk/1.bin sk/2.bin upmem/.bin
	$(ASM68K) /p $<, $@, , .lst
	$(CHKSUM) "$@"

# build scaler code
dat\scaler\scaler.dat: dat/scaler/main.asm dat/scaler/out.asm
	$(ASM68K) /j dat\scaler* /p $<, $@, , dat\scaler\.lst

dat\scaler\scaler.kos: dat/scaler/scaler.dat
	$(KOS) $< $@

# build sound driver code
dat\z80\z80.unc: dat/z80/z80.asm
	$(VASM) -Fbin -maxerrors=25 -nocase -L dat/z80/z80.lst -o $@ $<

dat\z80\z80.kos: dat/z80/z80.unc
	$(KOS) $< $@

# build DAC driver code (secret :>)
dat\pcm\.unc: dat\pcm\MegaPCM.asm
	$(ASM68K) /p $<, $@

dat\pcm\.kos: dat\pcm\.unc
	$(KOS) $< $@

# build Sonic 1
s1\.bin: s1/sonic1.asm s1/sound/z80/z80.kos
	$(ASM68K) /j s1* /p $<, $@, , s1\.lst

# build Sonic 1 Z80 driver
s1/sound/z80/z80.kos: s1/sound/z80/z80.asm
	"$(ASW)" -i s1/sound/z80 -xx -c -A -L s1/sound/z80/z80.asm && \
	cd bin/as/p2bin && "../../../$(P2BIN)" ../../../s1/sound/z80/z80.p ../../../s1/sound/z80/z80.unc -r 0x-0x && \
	"../../../$(KOS)" ../../../s1/sound/z80/z80.unc ../../../$@

# build Sonic 2
s2/s2built.bin: s2/s2.asm s2/s2.constants.asm
	"$(ASW)" -i s2 -xx -c -A -L s2/s2.asm && \
	"$(S2P2BIN)" s2/s2.p s2/s2built.bin s2/s2.h && \
	"$(S2FIXPTR)" s2/s2.h s2/s2built.bin Header MapRUnc_Sonic $2D 0 4 Header Obj5F_MapUnc_7240 2 2 1 && \
	cd s2 && $(S2POST)

# build Sonic & Knuckles
sk/1.bin: sk/sonic3k.asm sk/sonic3k.h sk/sonic3k.constants.asm
	"$(ASW)" -i sk -xx -a -D Sonic3_Complete=0 -E -A -L sk/sonic3k.asm && \
	"$(SKP2BIN)" sk/sonic3k.p sk/skbuilt.bin sk/sonic3k.h && \
	cd sk && $(SKPOST)

# build UPMEM
UPMEM/.bin: UPMEM/s2k.asm s2/s2.inc sk/sonic3k.inc
	$(ASM68K) /j upmem* /p $<, $@

