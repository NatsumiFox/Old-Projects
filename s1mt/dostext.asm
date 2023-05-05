DOS_SEGA_ERROR:
	DOS_String 'OOPS! This emular does not support SRAM.'
	dc.b	DOS_Text_NewLine
	DOS_String 'This means, most parts of the game would'
	DOS_String 'be severily broken. If you do not like  '
	DOS_String 'this, complain to SEGA of Europe and    '
	DOS_String 'tell them you do not like the broken    '
	DOS_String 'nature of this emulator.'
	dc.b	DOS_Text_NewLine, DOS_Text_NewLine
	DOS_String 'Maybe we can get a decent emulator for  '
	DOS_String 'once. Though I am probably being too    '
	DOS_String 'optimistic knowing SEGA. Sorry for any  '
	DOS_String 'employee reading this, but SEGA is not  '
	DOS_String 'too competent in my eyes.'
	dc.b	DOS_Text_NewLine, DOS_Text_NewLine
	DOS_String 'This message will not appear if SRAM    '
	DOS_String 'works properly. Press enter try to to   '
	DOS_String 'play the hack anyway. Bugs galore!'
	dc.b	DOS_Text_End
		even

DOS_StartUp:	; init VDP
		dc.b	DOS_Text_Delay,60*2	; arbitrary delay for starters
		DOS_String 'Display device found!'
		dc.b	DOS_Text_NewLine
		DOS_String 'YM7101 Detected!'
		dc.b	DOS_Text_NewLine
		DOS_String '315-5313, 320x224 display, 40x28 cells,'
		dc.b	DOS_Text_NewLine
		DOS_String '61 colors 0BGR 0333, h-full v-full,'
		dc.b	DOS_Text_NewLine
		DOS_String '64kB VRAM'
		dc.b	DOS_Text_NewLine
		DOS_String 'Adjusting display device '
		dc.b DOS_Text_Percent, $1C, 15
		DOS_String '...done!'
		dc.b	DOS_Text_NewLine, DOS_Text_NewLine

		; init YM
		DOS_String 'Sound device found!'
		dc.b	DOS_Text_NewLine
		DOS_String 'YM2612 Detected!'
		dc.b	DOS_Text_NewLine
		DOS_String '5 FM 1 DAC, 8-bit PCM'
		dc.b	DOS_Text_NewLine
		DOS_String 'Adjusting sound device '
		dc.b DOS_Text_Percent, $1F, 9
		DOS_String '...done!'
		dc.b	DOS_Text_NewLine, DOS_Text_NewLine

		; init controller
		DOS_String 'Controller not recognized!'
		dc.b	DOS_Text_NewLine
		DOS_String 'Defaulting to 3-button controller!'
		dc.b	DOS_Text_NewLine
		DOS_String 'Adjusting controller '
		dc.b DOS_Text_Percent, $3F, 5
		DOS_String '...done!'
		dc.b	DOS_Text_NewLine, DOS_Text_NewLine

		; init processor
		DOS_String 'Processor found!'
		dc.b	DOS_Text_NewLine
		DOS_String 'Motorola 68000 detected!'
		dc.b	DOS_Text_NewLine, DOS_Text_ClockSPD
		DOS_String 'MHz, 64kb RAM, 0xFF0000-0xFFFFFF'
		dc.b	DOS_Text_NewLine,DOS_Text_NewLine

		DOS_String '----------------------------------------'
		DOS_String '---Control scheme---'
		dc.b	DOS_Text_NewLine
		DOS_String 'C - change control mode'
		dc.b	DOS_Text_NewLine
		DOS_String '--Control mode a--'
		dc.b	DOS_Text_NewLine
		DOS_String 'UP,DOWN - Change letter at cursor'
		dc.b	DOS_Text_NewLine
		DOS_String 'RIGHT,LEFT - Change cursor position'
		dc.b	DOS_Text_NewLine
		DOS_String 'A - Erase last letter'
		dc.b	DOS_Text_NewLine
		DOS_String 'B - Erase all letters'
		dc.b	DOS_Text_NewLine
		DOS_String 'START - Accept input'
		dc.b	DOS_Text_NewLine,DOS_Text_NewLine
		DOS_String '--Control mode b--'
		dc.b	DOS_Text_NewLine
		DOS_String 'UP - Read history'
		dc.b	DOS_Text_NewLine
		DOS_String 'DOWN - Read present'
		dc.b	DOS_Text_NewLine
		DOS_String 'LEFT - Scroll to first line'
		dc.b	DOS_Text_NewLine
		DOS_String 'RIGHT - Scroll to last line'
		dc.b	DOS_Text_NewLine
		DOS_String '----------------------------------------'
		DOS_String 'Running M$-DOS 3.68 MegaDrive beta'
		dc.b	DOS_Text_NewLine
		DOS_String 'type ''HELP'' for help'
		dc.b	DOS_Text_End
		even

DOS_CHKDSK:	DOS_String 'Checking Disk! '
		dc.b	DOS_Text_Delay,9
		dc.b	DOS_Text_Percent, 1, 12
		DOS_String '...done!'
		dc.b	DOS_Text_NewLine
		DOS_String 'Found 856 issues in 544 files!'
		dc.b	DOS_Text_NewLine
		DOS_String 'Found 2347 files and 142 folders!'
		dc.b	DOS_Text_NewLine
		DOS_String 'FAT-MD-5, 1MB, 0001, minimal'
		dc.b	DOS_Text_NewLine

		DOS_String 'filesystem errors print'
		dc.b	DOS_Text_NewLine, DOS_Text_NewLine
		DOS_String '0x020001: NULL'
		dc.b	DOS_Text_NewLine
		DOS_String '0x020021: NULL'
		dc.b	DOS_Text_NewLine
		DOS_String '0x02009F > 0x020021: NULL'
		dc.b	DOS_Text_NewLine
		DOS_String '0x020169 > 0x020169: ILLEGAL'
		dc.b	DOS_Text_NewLine
		DOS_String '0x020275 > 0xFFF731: NOT MEMORY'
		dc.b	DOS_Text_NewLine
		DOS_String '0x0207AD: NOT FOUND'
		dc.b	DOS_Text_NewLine
		DOS_String '0x020EEE: NOT FOUND'
		dc.b	DOS_Text_NewLine
		DOS_String '0x020FD1: NOT FOUND'
		dc.b	DOS_Text_NewLine
		DOS_String '0x021747 > 0xFFFACK: ILLEGAL'
		dc.b	DOS_Text_NewLine
		DOS_String '0x029233: NULL'
		dc.b	DOS_Text_NewLine
		DOS_String 'LINE 1111 EMULATOR $0002ACDB'
		dc.b	DOS_Text_NewLine, DOS_Text_NewLine
		DOS_String 'Command failed!'
		dc.b	DOS_Text_End
		even

DOS_fanfic:	DOS_String 'Are you thinking SEGA would allow me to'
		DOS_String 'have this in? Crazy talk! Go watch'
		DOS_String 'Selbi Inkille''s video of. (NSFW)'
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		DOS_String ' '
		dc.b	DOS_Text_End
		even

DOS_toolong:	DOS_String 'Can not generate more text in current'
		dc.b	DOS_Text_NewLine
		DOS_String 'instance of the operating system! Please'
		DOS_String 'restart your Genesis or Mega Drive.'
		dc.b	DOS_Text_End
		even

DOS_readerr:	DOS_String 'This is not a File, or is corrupted'
		dc.b	DOS_Text_NewLine
		DOS_String 'or unknown format'
		dc.b	DOS_Text_End
		even

DOS_mem:	DOS_String 'System RAM'
		dc.b	DOS_Text_NewLine
		DOS_String '64kb RAM, 0xFF0000-0xFFFFFF'
		dc.b	DOS_Text_End
		even

DOS_ver:	DOS_String 'M$-DOS 3.68 MegaDrive beta'
		dc.b	DOS_Text_End
		even

DOS_Help:	DOS_String 'Commands list'
		dc.b	DOS_Text_NewLine
		DOS_String 'HELP                CLS'
		dc.b	DOS_Text_NewLine
		DOS_String 'DIR                 CD'
		dc.b	DOS_Text_NewLine
		DOS_String 'CHKDSK              MEM'
		dc.b	DOS_Text_NewLine
		DOS_String 'VER                 READ'
		dc.b	DOS_Text_NewLine,DOS_Text_NewLine
		DOS_String 'Use  Help CMD  for further help'
		dc.b	DOS_Text_End
		even


DOS_Help_mem:	DOS_String 'Usage - MEM'
		dc.b	DOS_Text_NewLine
		DOS_String 'prints information about system memory'
		dc.b	DOS_Text_End
		even

DOS_Help_ver:	DOS_String 'Usage - VER'
		dc.b	DOS_Text_NewLine
		DOS_String 'prints version ID'
		dc.b	DOS_Text_End
		even

DOS_Help_cls:	DOS_String 'Usage - CLS'
		dc.b	DOS_Text_NewLine
		DOS_String 'Clears all text from the screen'
		dc.b	DOS_Text_End
		even

DOS_Help_dir:	DOS_String 'Usage - DIR'
		dc.b	DOS_Text_NewLine
		DOS_String 'lists all files in current directory'
		dc.b	DOS_Text_End
		even

DOS_Help_cd:	DOS_String 'Usage - CD dir'
		dc.b	DOS_Text_NewLine
		DOS_String 'Changes current directory to specified'
		dc.b	DOS_Text_NewLine
		DOS_String 'subdirectory. If none is specified,'
		dc.b	DOS_Text_NewLine
		DOS_String 'it prints the current directory'
		dc.b	DOS_Text_End
		even

DOS_Help_CHKDSK:DOS_String 'Usage - CHKDSK'
		dc.b	DOS_Text_NewLine
		DOS_String 'checks the filesystem for errors and'
		dc.b	DOS_Text_NewLine
		DOS_String 'prints some miscellaneous information'
		dc.b	DOS_Text_End
		even

DOS_Help_read:	DOS_String 'Usage - READ file'
		dc.b	DOS_Text_NewLine
		DOS_String 'Reads any TXT file contents'
		dc.b	DOS_Text_End
		even


DOS_dir_asc:	DOS_String 'Current directory'
		dc.b	DOS_Text_End
		even

DOS_cd_asc:	DOS_String 'No such directory!'
		dc.b	DOS_Text_End
		even

DOS_cd_nodir:	DOS_String 'No superdirectory to go to!'
		dc.b	DOS_Text_End
		even

DOS_dirname_Sys:
		DOS_String '$sys'
		dc.b	DOS_Text_End
		even

DOS_dirname_Initialdir:
		DOS_String '$sys>s1mt'
		dc.b	DOS_Text_End
		even

DOS_dirname_SSRG:
		DOS_String '$sys>s1mt>SSRG'
		dc.b	DOS_Text_End
		even

DOS_dirname_anim:
		DOS_String '$sys>s1mt>_anim'
		dc.b	DOS_Text_End
		even

DOS_dirname_dlls:
		DOS_String '$sys>s1mt>_dlls'
		dc.b	DOS_Text_End
		even

DOS_dirname_inc:
		DOS_String '$sys>s1mt>_inc'
		dc.b	DOS_Text_End
		even

DOS_dirname_maps:
		DOS_String '$sys>s1mt>_maps'
		dc.b	DOS_Text_End
		even

DOS_dirname_artkos:
		DOS_String '$sys>s1mt>artkos'
		dc.b	DOS_Text_End
		even

DOS_dirname_artnem:
		DOS_String '$sys>s1mt>artnem'
		dc.b	DOS_Text_End
		even

DOS_dirname_artunc:
		DOS_String '$sys>s1mt>artunc'
		dc.b	DOS_Text_End
		even

DOS_dirname_boss:
		DOS_String '$sys>s1mt>boss'
		dc.b	DOS_Text_End
		even

DOS_dirname_collide:
		DOS_String '$sys>s1mt>collide'
		dc.b	DOS_Text_End
		even

DOS_dirname_dac:
		DOS_String '$sys>s1mt>dac'
		dc.b	DOS_Text_End
		even

DOS_dirname_demodata:
		DOS_String '$sys>s1mt>demodata'
		dc.b	DOS_Text_End
		even

DOS_dirname_levels:
		DOS_String '$sys>s1mt>levels'
		dc.b	DOS_Text_End
		even

DOS_dirname_map16:
		DOS_String '$sys>s1mt>map16'
		dc.b	DOS_Text_End
		even

DOS_dirname_map256:
		DOS_String '$sys>s1mt>map128'
		dc.b	DOS_Text_End
		even

DOS_dirname_mapeni:
		DOS_String '$sys>s1mt>mapeni'
		dc.b	DOS_Text_End
		even

DOS_dirname_misc:
		DOS_String '$sys>s1mt>misc'
		dc.b	DOS_Text_End
		even

DOS_dirname_objpos:
		DOS_String '$sys>s1mt>objpos'
		dc.b	DOS_Text_End
		even

DOS_dirname_pallet:
		DOS_String '$sys>s1mt>pallet'
		dc.b	DOS_Text_End
		even

DOS_dirname_s3k:
		DOS_String '$sys>s1mt>s3k'
		dc.b	DOS_Text_End
		even

DOS_dirname_s3l:
		DOS_String '$sys>s1mt>s3l'
		dc.b	DOS_Text_End
		even

DOS_dirname_SMPS:
		DOS_String '$sys>s1mt>SMPS'
		dc.b	DOS_Text_End
		even

DOS_dirname_sound:
		DOS_String '$sys>s1mt>sound'
		dc.b	DOS_Text_End
		even

DOS_dirname_startpos:
		DOS_String '$sys>s1mt>startpos'
		dc.b	DOS_Text_End
		even

DOS_dirname_compart:
		DOS_String '$sys>s1mt>s3k>Comper Art'
		dc.b	DOS_Text_End
		even

DOS_dirname_compmap:
		DOS_String '$sys>s1mt>s3k>Comper Map'
		dc.b	DOS_Text_End
		even

DOS_dirname_Enigma:
		DOS_String '$sys>s1mt>s3k>Enigma Map'
		dc.b	DOS_Text_End
		even

DOS_dirname_Kosinski:
		DOS_String '$sys>s1mt>s3k>Kosinski Art'
		dc.b	DOS_Text_End
		even

DOS_dirname_KosinskiM:
		DOS_String '$sys>s1mt>s3k>KosinskiM Art'
		dc.b	DOS_Text_End
		even

DOS_dirname_Nemesis:
		DOS_String '$sys>s1mt>s3k>Nemesis Art'
		dc.b	DOS_Text_End
		even

DOS_dirname_Palette:
		DOS_String '$sys>s1mt>s3k>Palette'
		dc.b	DOS_Text_End
		even


		dc.w 24-1
DOS_dircont_s1mt:
		dc.w .ssrg-DOS_dircont_s1mt-2
		dc.w ._anim-DOS_dircont_s1mt-4
		dc.w ._dlls-DOS_dircont_s1mt-6
		dc.w ._inc-DOS_dircont_s1mt-8
		dc.w ._maps-DOS_dircont_s1mt-10
		dc.w .artkos-DOS_dircont_s1mt-12
		dc.w .artnem-DOS_dircont_s1mt-14
		dc.w .artunc-DOS_dircont_s1mt-16
		dc.w .boss-DOS_dircont_s1mt-18
		dc.w .collide-DOS_dircont_s1mt-20
		dc.w .dac-DOS_dircont_s1mt-22
		dc.w .demodata-DOS_dircont_s1mt-24
		dc.w .levels-DOS_dircont_s1mt-26
		dc.w .map16-DOS_dircont_s1mt-28
		dc.w .map256-DOS_dircont_s1mt-30
		dc.w .mapeni-DOS_dircont_s1mt-32
		dc.w .misc-DOS_dircont_s1mt-34
		dc.w .objpos-DOS_dircont_s1mt-36
		dc.w .pallet-DOS_dircont_s1mt-38
		dc.w .s3k-DOS_dircont_s1mt-40
		dc.w .s3l-DOS_dircont_s1mt-42
		dc.w .SMPS-DOS_dircont_s1mt-44
		dc.w .sound-DOS_dircont_s1mt-46
		dc.w .startpos-DOS_dircont_s1mt-48

.ssrg		dc.b 4-1, 0
		DOS_String 'ssrg'
		moveq	#1,d0
		rts

._anim		dc.b 5-1
		DOS_String '_anim'
		moveq	#2,d0
		rts

._dlls		dc.b 5-1
		DOS_String '_dlls'
		moveq	#3,d0
		rts

._inc		dc.b 4-1, 0
		DOS_String '_inc'
		moveq	#4,d0
		rts

._maps		dc.b 5-1
		DOS_String '_maps'
		moveq	#5,d0
		rts

.artkos		dc.b 6-1, 0
		DOS_String 'artkos'
		moveq	#6,d0
		rts

.artnem		dc.b 6-1, 0
		DOS_String 'artnem'
		moveq	#7,d0
		rts

.artunc		dc.b 6-1, 0
		DOS_String 'artunc'
		moveq	#8,d0
		rts

.boss		dc.b 4-1, 0
		DOS_String 'boss'
		moveq	#9,d0
		rts

.collide	dc.b 7-1
		DOS_String 'collide'
		moveq	#10,d0
		rts

.dac		dc.b 3-1
		DOS_String 'dac'
		moveq	#11,d0
		rts

.demodata	dc.b 8-1, 0
		DOS_String 'demodata'
		moveq	#12,d0
		rts

.levels		dc.b 6-1, 0
		DOS_String 'levels'
		moveq	#13,d0
		rts

.map16		dc.b 5-1
		DOS_String 'map16'
		moveq	#14,d0
		rts

.map256		dc.b 6-1, 0
		DOS_String 'map128'
		moveq	#15,d0
		rts

.mapeni		dc.b 6-1, 0
		DOS_String 'mapeni'
		moveq	#16,d0
		rts

.misc		dc.b 4-1, 0
		DOS_String 'misc'
		moveq	#17,d0
		rts

.objpos		dc.b 6-1, 0
		DOS_String 'objpos'
		moveq	#18,d0
		rts

.pallet		dc.b 7-1
		DOS_String 'palette'
		moveq	#19,d0
		rts

.s3k		dc.b 3-1
		DOS_String 's3k'
		moveq	#20,d0
		rts

.s3l		dc.b 3-1
		DOS_String 's3l'
		moveq	#21,d0
		rts

.SMPS		dc.b 4-1, 0
		DOS_String 'SMPS'
		moveq	#22,d0
		rts

.sound		dc.b 5-1
		DOS_String 'sound'
		moveq	#23,d0
		rts

.startpos	dc.b 8-1, 0
		DOS_String 'startpos'
		moveq	#24,d0
		rts


		dc.w 8-1
DOS_dircont_s3k:
		dc.w .comperart-DOS_dircont_s3k-2
		dc.w .compermap-DOS_dircont_s3k-4
		dc.w .enigmamap-DOS_dircont_s3k-6
		dc.w .kosinskiart-DOS_dircont_s3k-8
		dc.w .kosinskim-DOS_dircont_s3k-10
		dc.w .nemesisart-DOS_dircont_s3k-12
		dc.w .palettes-DOS_dircont_s3k-14
		dc.w .null-DOS_dircont_s3k-16

.comperart	dc.b 10-1, 0
		DOS_String 'Comper Art'
		moveq	#25,d0
		rts

.compermap	dc.b 10-1, 0
		DOS_String 'Comper Map'
		moveq	#26,d0
		rts

.enigmamap	dc.b 10-1, 0
		DOS_String 'Enigma Map'
		moveq	#27,d0
		rts

.kosinskiart	dc.b 12-1, 0
		DOS_String 'Kosinski Art'
		moveq	#28,d0
		rts

.kosinskim	dc.b 13-1
		DOS_String 'KosinskiM Art'
		moveq	#29,d0
		rts

.nemesisart	dc.b 11-1
		DOS_String 'Nemesis Art'
		moveq	#30,d0
		rts

.palettes	dc.b 7-1
		DOS_String 'Palette'
		moveq	#31,d0
		rts

.null		dc.b 1-1
		DOS_String ' '

		dc.w 1-1
DOS_dircont_sys:
		dc.w .s1mt-DOS_dircont_sys-2

.s1mt		dc.b 4-1, 0
		DOS_String 's1mt'
		moveq	#0,d0
		rts

		dc.w 1-1
DOS_dirfile_sys:
		dc.w .fan-DOS_dirfile_sys-2

.fan		dc.b 10-1, 0
		DOS_String 'TXT fanfic'

DOS_redarr:	dc.w .fan-DOS_redarr-2
		dc.w .fant-DOS_redarr-4

.fan		dc.b 6-1, 0
		DOS_String 'fanfic'
		bra.s	.code

.fant		dc.b 10-1, 0
		DOS_String 'fanfic.txt'

.code		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		lea	DOS_fanfic,DOS_txtreg		; text
		jmp	LoadText			; load it

		dc.w 18-1
DOS_dirfile_s1mt:
		dc.w .asm68k-DOS_dirfile_s1mt-2
		dc.w .build-DOS_dirfile_s1mt-4
		dc.w .credits-DOS_dirfile_s1mt-6
		dc.w .currentbuild-DOS_dirfile_s1mt-8
		dc.w .dos-DOS_dirfile_s1mt-10
		dc.w .dosequ-DOS_dirfile_s1mt-12
		dc.w .dostext-DOS_dirfile_s1mt-14
		dc.w .equ-DOS_dirfile_s1mt-16
		dc.w .fixheadr-DOS_dirfile_s1mt-18
		dc.w .megapcm-DOS_dirfile_s1mt-20
		dc.w .megapcm_-DOS_dirfile_s1mt-22
		dc.w .rompad-DOS_dirfile_s1mt-24
		dc.w .smps-DOS_dirfile_s1mt-26
		dc.w .sonic1-DOS_dirfile_s1mt-28
		dc.w .sonic1mt-DOS_dirfile_s1mt-30
		dc.w .sourcelisting-DOS_dirfile_s1mt-32
		dc.w .thebettergame-DOS_dirfile_s1mt-34
		dc.w DOS_null-DOS_dirfile_s1mt-36

.asm68k		dc.b 10-1, 0
		DOS_String 'EXE asm68k'

.build		dc.b 9-1
		DOS_String 'BAT build'

.credits	dc.b 11-1
		DOS_String 'ASM credits'

.currentbuild	dc.b 16-1, 0
		DOS_String 'ASM currentbuild'

.dos		dc.b 7-1
		DOS_String 'ASM dos'

.dosequ		dc.b 10-1, 0
		DOS_String 'ASM dosequ'

.dostext	dc.b 11-1
		DOS_String 'ASM dostext'

.equ		dc.b 7-1
		DOS_String 'ASM equ'

.fixheadr	dc.b 12-1, 0
		DOS_String 'EXE fixheadr'

.megapcm	dc.b 11-1
		DOS_String 'ASM megapcm'

.megapcm_	dc.b 11-1
		DOS_String 'Z80 megapcm'

.rompad		dc.b 10-1, 0
		DOS_String 'EXE rompad'

.smps		dc.b 8-1, 0
		DOS_String 'ASM smps'

.sonic1		dc.b 10-1, 0
		DOS_String 'ASM sonic1'

.sonic1mt	dc.b 12-1, 0
		DOS_String 'BIN sonic1mt'

.sourcelisting	dc.b 17-1
		DOS_String 'LST sourcelisting'

.thebettergame	dc.b 17-1
		DOS_String 'ASM thebettergame'


		dc.w 12-1
DOS_dirfile_ssrg:
		dc.w .logo-DOS_dirfile_ssrg-2
		dc.w .Logo_Bnk1-DOS_dirfile_ssrg-4
		dc.w .Logo_Bnk2-DOS_dirfile_ssrg-6
		dc.w .Logomaps-DOS_dirfile_ssrg-8
		dc.w .scenedata-DOS_dirfile_ssrg-10
		dc.w .sonic-DOS_dirfile_ssrg-12
		dc.w .Sonic_Pt1-DOS_dirfile_ssrg-14
		dc.w .Sonic_Pt2-DOS_dirfile_ssrg-16
		dc.w .asm-DOS_dirfile_ssrg-18
		dc.w .titleart-DOS_dirfile_ssrg-20
		dc.w .titlepal-DOS_dirfile_ssrg-22
		dc.w DOS_null-DOS_dirfile_ssrg-24

.logo		dc.b 8-1, 0
		DOS_String 'PAL Logo'

.Logo_Bnk1	dc.b 18-1, 0
		DOS_String 'KOS Logo_Bnk1.4bpp'

.Logo_Bnk2	dc.b 18-1, 0
		DOS_String 'KOS Logo_Bnk2.4bpp'

.Logomaps	dc.b 16-1, 0
		DOS_String 'KOS LogoMaps.bin'

.scenedata	dc.b 13-1
		DOS_String 'BIN SceneData'

.sonic		dc.b 14-1, 0
		DOS_String 'NEM Sonic.4bpp'

.Sonic_Pt1	dc.b 13-1
		DOS_String 'PAL Sonic_Pt1'

.Sonic_Pt2	dc.b 13-1
		DOS_String 'PAL Sonic_Pt2'

.asm		dc.b 15-1
		DOS_String 'ASM SSRG_Screen'

.titleart	dc.b 14-1, 0
		DOS_String 'NEM Title.4bpp'

.titlepal	dc.b 9-1
		DOS_String 'PAL Title'


DOS_null:	dc.b 1-1
		DOS_String ' '


		dc.w 52-1
DOS_dirfile_anim:
		dc.w .Eggman-DOS_dirfile_anim-2
		dc.w .Knux-DOS_dirfile_anim-4
		dc.w .08-DOS_dirfile_anim-6
		dc.w .0A-DOS_dirfile_anim-8
		dc.w .0C-DOS_dirfile_anim-10
		dc.w .0E-DOS_dirfile_anim-12
		dc.w .0F-DOS_dirfile_anim-14
		dc.w .14-DOS_dirfile_anim-16
		dc.w .15-DOS_dirfile_anim-18
		dc.w .1E-DOS_dirfile_anim-20
		dc.w .1F-DOS_dirfile_anim-22
		dc.w .22-DOS_dirfile_anim-24
		dc.w .23-DOS_dirfile_anim-26
		dc.w .25-DOS_dirfile_anim-28
		dc.w .26-DOS_dirfile_anim-30
		dc.w .2A-DOS_dirfile_anim-32
		dc.w .2B-DOS_dirfile_anim-34
		dc.w .2C-DOS_dirfile_anim-36
		dc.w .2D-DOS_dirfile_anim-38
		dc.w .35-DOS_dirfile_anim-40
		dc.w .38-DOS_dirfile_anim-42
		dc.w .3E-DOS_dirfile_anim-44
		dc.w .40-DOS_dirfile_anim-46
		dc.w .41-DOS_dirfile_anim-48
		dc.w .42-DOS_dirfile_anim-50
		dc.w .43-DOS_dirfile_anim-52
		dc.w .47-DOS_dirfile_anim-54
		dc.w .4A-DOS_dirfile_anim-56
		dc.w .4C-DOS_dirfile_anim-58
		dc.w .4E-DOS_dirfile_anim-60
		dc.w .50-DOS_dirfile_anim-62
		dc.w .55-DOS_dirfile_anim-64
		dc.w .5F-DOS_dirfile_anim-66
		dc.w .60-DOS_dirfile_anim-68
		dc.w .64-DOS_dirfile_anim-70
		dc.w .65-DOS_dirfile_anim-72
		dc.w .69-DOS_dirfile_anim-74
		dc.w .6C-DOS_dirfile_anim-76
		dc.w .6D-DOS_dirfile_anim-78
		dc.w .6E-DOS_dirfile_anim-80
		dc.w .6F-DOS_dirfile_anim-82
		dc.w .78-DOS_dirfile_anim-84
		dc.w .81-DOS_dirfile_anim-86
		dc.w .82-DOS_dirfile_anim-88
		dc.w .85-DOS_dirfile_anim-90
		dc.w .86-DOS_dirfile_anim-92
		dc.w .86a-DOS_dirfile_anim-94
		dc.w .87-DOS_dirfile_anim-96
		dc.w .8B-DOS_dirfile_anim-98
		dc.w .Sonic-DOS_dirfile_anim-100
		dc.w .Tails-DOS_dirfile_anim-102
		dc.w .Tail-DOS_dirfile_anim-104

.Eggman		dc.b 10-1, 0
		DOS_String 'ASM Eggman'

.Knux		dc.b 8-1, 0
		DOS_String 'ASM Knux'

.08		dc.b 9-1
		DOS_String 'ASM obj08'

.0A		dc.b 9-1
		DOS_String 'ASM obj0A'

.0C		dc.b 9-1
		DOS_String 'ASM obj0C'

.0E		dc.b 9-1
		DOS_String 'ASM obj0E'

.0F		dc.b 9-1
		DOS_String 'ASM obj0F'

.14		dc.b 9-1
		DOS_String 'ASM obj14'

.15		dc.b 9-1
		DOS_String 'ASM obj15'

.1E		dc.b 9-1
		DOS_String 'ASM obj1E'

.1F		dc.b 9-1
		DOS_String 'ASM obj1F'

.22		dc.b 9-1
		DOS_String 'ASM obj22'

.23		dc.b 9-1
		DOS_String 'ASM obj23'

.25		dc.b 9-1
		DOS_String 'ASM obj25'

.26		dc.b 9-1
		DOS_String 'ASM obj26'

.2A		dc.b 9-1
		DOS_String 'ASM obj2A'

.2B		dc.b 9-1
		DOS_String 'ASM obj2B'

.2C		dc.b 9-1
		DOS_String 'ASM obj2C'

.2D		dc.b 9-1
		DOS_String 'ASM obj2D'

.35		dc.b 9-1
		DOS_String 'ASM obj35'

.38		dc.b 9-1
		DOS_String 'ASM obj38'

.3E		dc.b 9-1
		DOS_String 'ASM obj3E'

.40		dc.b 9-1
		DOS_String 'ASM obj40'

.41		dc.b 9-1
		DOS_String 'ASM obj41'

.42		dc.b 9-1
		DOS_String 'ASM obj42'

.43		dc.b 9-1
		DOS_String 'ASM obj43'

.47		dc.b 9-1
		DOS_String 'ASM obj47'

.4A		dc.b 9-1
		DOS_String 'ASM obj4A'

.4C		dc.b 9-1
		DOS_String 'ASM obj4C'

.4E		dc.b 9-1
		DOS_String 'ASM obj4E'

.50		dc.b 9-1
		DOS_String 'ASM obj50'

.55		dc.b 9-1
		DOS_String 'ASM obj55'

.5F		dc.b 9-1
		DOS_String 'ASM obj5F'

.60		dc.b 9-1
		DOS_String 'ASM obj60'

.64		dc.b 9-1
		DOS_String 'ASM obj64'

.65		dc.b 9-1
		DOS_String 'ASM obj65'

.69		dc.b 9-1
		DOS_String 'ASM obj69'

.6C		dc.b 9-1
		DOS_String 'ASM obj6C'

.6D		dc.b 9-1
		DOS_String 'ASM obj6D'

.6E		dc.b 9-1
		DOS_String 'ASM obj6E'

.6F		dc.b 9-1
		DOS_String 'ASM obj6F'

.78		dc.b 9-1
		DOS_String 'ASM obj78'

.81		dc.b 9-1
		DOS_String 'ASM obj81'

.82		dc.b 9-1
		DOS_String 'ASM obj82'

.85		dc.b 9-1
		DOS_String 'ASM obj85'

.86		dc.b 9-1
		DOS_String 'ASM obj86'

.86a		dc.b 10-1, 0
		DOS_String 'ASM obj86a'

.87		dc.b 9-1
		DOS_String 'ASM obj87'

.8B		dc.b 9-1
		DOS_String 'ASM obj8B'

.Sonic		dc.b 9-1
		DOS_String 'ASM Sonic'

.Tails		dc.b 9-1
		DOS_String 'ASM Tails'

.Tail		dc.b 8-1, 0
		DOS_String 'ASM Tail'


		dc.w 4-1
DOS_dirfile_dlls:
		dc.w .Enigma-DOS_dirfile_dlls-2
		dc.w .Kosinski-DOS_dirfile_dlls-4
		dc.w .Nemesis-DOS_dirfile_dlls-6
		dc.w DOS_null-DOS_dirfile_dlls-8

.Nemesis	dc.b 11-1
		DOS_String 'DLL Nemesis'

.Kosinski	dc.b 12-1, 0
		DOS_String 'DLL Kosinski'

.Enigma		dc.b 10-1, 0
		DOS_String 'DLL Enigma'

		dc.w 30-1
DOS_dirfile_inc:
		dc.w .asc-DOS_dirfile_inc-2
		dc.w .collindxptr-DOS_dirfile_inc-4
		dc.w .cutscene-DOS_dirfile_inc-6
		dc.w .dbglst_end-DOS_dirfile_inc-8
		dc.w .dbglst_ghz-DOS_dirfile_inc-10
		dc.w .dbglst_lz-DOS_dirfile_inc-12
		dc.w .dbglst_mz-DOS_dirfile_inc-14
		dc.w .dbglst_sbz-DOS_dirfile_inc-16
		dc.w .dbglst_slz-DOS_dirfile_inc-18
		dc.w .dbglst_syz-DOS_dirfile_inc-20
		dc.w .dbglst_ptrs-DOS_dirfile_inc-22
		dc.w .dmptr_end-DOS_dirfile_inc-24
		dc.w .dmptr_mn-DOS_dirfile_inc-26
		dc.w .dplc_endsign-DOS_dirfile_inc-28
		dc.w .dplc_bubble-DOS_dirfile_inc-30
		dc.w .dplc_dash-DOS_dirfile_inc-32
		dc.w .dplc_fire-DOS_dirfile_inc-34
		dc.w .dplc_insta-DOS_dirfile_inc-36
		dc.w .dplc_lightning-DOS_dirfile_inc-38
		dc.w .dplc_stars-DOS_dirfile_inc-40
		dc.w .dplc_knux-DOS_dirfile_inc-42
		dc.w .dplc_sonic-DOS_dirfile_inc-44
		dc.w .dplc_taila-DOS_dirfile_inc-46
		dc.w .dplc_tail-DOS_dirfile_inc-48
		dc.w .mllb-DOS_dirfile_inc-50
		dc.w .objptr-DOS_dirfile_inc-52
		dc.w .palptr-DOS_dirfile_inc-54
		dc.w .plc-DOS_dirfile_inc-56
		dc.w .sbzpal1-DOS_dirfile_inc-58
		dc.w .sbzpal2-DOS_dirfile_inc-60

.asc		dc.b 16-1, 0
		DOS_String 'ASM ASCIIStrings'

.collindxptr	dc.b 19-1
		DOS_String 'ASM Coll index ptrs'

.cutscene	dc.b 12-1, 0
		DOS_String 'ASM cutscene'

.dbglst_end	dc.b 19-1
		DOS_String 'ASM Debuglist - End'

.dbglst_ghz	dc.b 19-1
		DOS_String 'ASM Debuglist - GHZ'

.dbglst_lz	dc.b 18-1, 0
		DOS_String 'ASM Debuglist - LZ'

.dbglst_mz	dc.b 18-1, 0
		DOS_String 'ASM Debuglist - MZ'

.dbglst_sbz	dc.b 19-1
		DOS_String 'ASM Debuglist - SBZ'

.dbglst_slz	dc.b 19-1
		DOS_String 'ASM Debuglist - SLZ'

.dbglst_syz	dc.b 19-1
		DOS_String 'ASM Debuglist - SYZ'

.dbglst_ptrs	dc.b 18-1, 0
		DOS_String 'ASM Debuglist Ptrs'

.dmptr_end	dc.b 18-1, 0
		DOS_String 'ASM Demoptrs - End'

.dmptr_mn	dc.b 19-1
		DOS_String 'ASM Demoptrs - demo'

.dplc_endsign	dc.b 17-1
		DOS_String 'ASM DPLC EndSigns'

.dplc_bubble	dc.b 19-1
		DOS_String 'ASM DPLC Bubble Shl'

.dplc_dash	dc.b 18-1, 0
		DOS_String 'ASM DPLC Dash Dust'

.dplc_fire	dc.b 17-1
		DOS_String 'ASM DPLC Fire Shl'

.dplc_insta	dc.b 18-1, 0
		DOS_String 'ASM DPLC Insta Shl'

.dplc_lightning	dc.b 18-1, 0
		DOS_String 'ASM DPLC Light Shl'

.dplc_stars	dc.b 14-1, 0
		DOS_String 'ASM DPLC Stars'

.dplc_knux	dc.b 13-1
		DOS_String 'ASM DPLC Knux'

.dplc_taila	dc.b 14-1, 0
		DOS_String 'ASM DPLC Tails'

.dplc_tail	dc.b 13-1
		DOS_String 'ASM DPLC Tail'

.dplc_sonic	dc.b 14-1, 0
		DOS_String 'ASM DPLC Sonic'

.mllb		dc.b 18-1, 0
		DOS_String 'ASM MainLoadBlocks'

.objptr		dc.b 19-1
		DOS_String 'ASM Object Pointers'

.palptr		dc.b 19-1
		DOS_String 'ASM Palette Pointer'

.plc		dc.b 16-1, 0
		DOS_String 'ASM Pattern Cues'

.sbzpal1	dc.b 19-1
		DOS_String 'ASM SBZ Pal Script1'

.sbzpal2	dc.b 19-1
		DOS_String 'ASM SBZ Pal Script2'


		dc.w 1-1
DOS_dirfile_artkos:
		dc.w .flowers-DOS_dirfile_artkos-2

.flowers	dc.b 11-1
		DOS_String 'BIN flowers'


		dc.w 148-1
DOS_dirfile_maps:
		dc.w .Boss_items-DOS_dirfile_maps-2
		dc.w .Bubbleshie-DOS_dirfile_maps-4
		dc.w .DashDust-DOS_dirfile_maps-6
		dc.w .Eggman-DOS_dirfile_maps-8
		dc.w .Eggman2-DOS_dirfile_maps-10
		dc.w .End_Signs-DOS_dirfile_maps-12
		dc.w .FireShield-DOS_dirfile_maps-14
		dc.w .FZ_boss-DOS_dirfile_maps-16
		dc.w .HPZ_Platfo-DOS_dirfile_maps-18
		dc.w .insta-DOS_dirfile_maps-20
		dc.w .Instashiel-DOS_dirfile_maps-22
		dc.w .Knux-DOS_dirfile_maps-24
		dc.w .Lightning-DOS_dirfile_maps-26
		dc.w .obj08-DOS_dirfile_maps-28
		dc.w .obj0A-DOS_dirfile_maps-30
		dc.w .obj0B-DOS_dirfile_maps-32
		dc.w .obj0C-DOS_dirfile_maps-34
		dc.w .obj0D-DOS_dirfile_maps-36
		dc.w .obj0E-DOS_dirfile_maps-38
		dc.w .obj0F-DOS_dirfile_maps-40
		dc.w .obj11-DOS_dirfile_maps-42
		dc.w .obj11_HPZ-DOS_dirfile_maps-44
		dc.w .obj12-DOS_dirfile_maps-46
		dc.w .obj14-DOS_dirfile_maps-48
		dc.w .obj15ghz-DOS_dirfile_maps-50
		dc.w .obj15sbz-DOS_dirfile_maps-52
		dc.w .obj15slz-DOS_dirfile_maps-54
		dc.w .obj16-DOS_dirfile_maps-56
		dc.w .obj17-DOS_dirfile_maps-58
		dc.w .obj18ghz-DOS_dirfile_maps-60
		dc.w .obj18slz-DOS_dirfile_maps-62
		dc.w .obj18syz-DOS_dirfile_maps-64
		dc.w .obj18x-DOS_dirfile_maps-66
		dc.w .obj1A-DOS_dirfile_maps-68
		dc.w .obj1B-DOS_dirfile_maps-70
		dc.w .obj1C-DOS_dirfile_maps-72
		dc.w .obj1D-DOS_dirfile_maps-74
		dc.w .obj1E-DOS_dirfile_maps-76
		dc.w .obj1F-DOS_dirfile_maps-78
		dc.w .obj21-DOS_dirfile_maps-80
		dc.w .obj22-DOS_dirfile_maps-82
		dc.w .obj23-DOS_dirfile_maps-84
		dc.w .obj24-DOS_dirfile_maps-86
		dc.w .obj25-DOS_dirfile_maps-88
		dc.w .obj26-DOS_dirfile_maps-90
		dc.w .obj28-DOS_dirfile_maps-92
		dc.w .obj28a-DOS_dirfile_maps-94
		dc.w .obj28b-DOS_dirfile_maps-96
		dc.w .obj29-DOS_dirfile_maps-98
		dc.w .obj2A-DOS_dirfile_maps-100
		dc.w .obj2B-DOS_dirfile_maps-102
		dc.w .obj2C-DOS_dirfile_maps-104
		dc.w .obj2D-DOS_dirfile_maps-106
		dc.w .obj2F-DOS_dirfile_maps-108
		dc.w .obj30-DOS_dirfile_maps-110
		dc.w .obj31-DOS_dirfile_maps-112
		dc.w .obj32-DOS_dirfile_maps-114
		dc.w .obj33-DOS_dirfile_maps-116
		dc.w .obj36-DOS_dirfile_maps-118
		dc.w .obj38-DOS_dirfile_maps-120
		dc.w .obj39-DOS_dirfile_maps-122
		dc.w .obj3B-DOS_dirfile_maps-124
		dc.w .obj3C-DOS_dirfile_maps-126
		dc.w .obj3E-DOS_dirfile_maps-128
		dc.w .obj40-DOS_dirfile_maps-130
		dc.w .obj41-DOS_dirfile_maps-132
		dc.w .obj42-DOS_dirfile_maps-134
		dc.w .obj43-DOS_dirfile_maps-136
		dc.w .obj44-DOS_dirfile_maps-138
		dc.w .obj45-DOS_dirfile_maps-140
		dc.w .obj46-DOS_dirfile_maps-142
		dc.w .obj47-DOS_dirfile_maps-144
		dc.w .obj48-DOS_dirfile_maps-146
		dc.w .obj4A-DOS_dirfile_maps-148
		dc.w .obj4B-DOS_dirfile_maps-150
		dc.w .obj4C-DOS_dirfile_maps-152
		dc.w .obj4E-DOS_dirfile_maps-154
		dc.w .obj50-DOS_dirfile_maps-156
		dc.w .obj51-DOS_dirfile_maps-158
		dc.w .obj52lz-DOS_dirfile_maps-160
		dc.w .obj52mz-DOS_dirfile_maps-162
		dc.w .obj53-DOS_dirfile_maps-164
		dc.w .obj54-DOS_dirfile_maps-166
		dc.w .obj55-DOS_dirfile_maps-168
		dc.w .obj56-DOS_dirfile_maps-170
		dc.w .obj57lz-DOS_dirfile_maps-172
		dc.w .obj57syz-DOS_dirfile_maps-174
		dc.w .obj59-DOS_dirfile_maps-176
		dc.w .obj5A-DOS_dirfile_maps-178
		dc.w .obj5B-DOS_dirfile_maps-180
		dc.w .obj5C-DOS_dirfile_maps-182
		dc.w .obj5D-DOS_dirfile_maps-184
		dc.w .obj5E-DOS_dirfile_maps-186
		dc.w .obj5Eballs-DOS_dirfile_maps-188
		dc.w .obj5F-DOS_dirfile_maps-190
		dc.w .obj60-DOS_dirfile_maps-192
		dc.w .obj61-DOS_dirfile_maps-194
		dc.w .obj62-DOS_dirfile_maps-196
		dc.w .obj63-DOS_dirfile_maps-198
		dc.w .obj64-DOS_dirfile_maps-200
		dc.w .obj65-DOS_dirfile_maps-202
		dc.w .obj66-DOS_dirfile_maps-204
		dc.w .obj67-DOS_dirfile_maps-206
		dc.w .obj69-DOS_dirfile_maps-208
		dc.w .obj69a-DOS_dirfile_maps-210
		dc.w .obj6A-DOS_dirfile_maps-212
		dc.w .obj6B-DOS_dirfile_maps-214
		dc.w .obj6C-DOS_dirfile_maps-216
		dc.w .obj6D-DOS_dirfile_maps-218
		dc.w .obj6E-DOS_dirfile_maps-220
		dc.w .obj70-DOS_dirfile_maps-222
		dc.w .obj71-DOS_dirfile_maps-224
		dc.w .obj76-DOS_dirfile_maps-226
		dc.w .obj78-DOS_dirfile_maps-228
		dc.w .obj79-DOS_dirfile_maps-230
		dc.w .obj7B-DOS_dirfile_maps-232
		dc.w .obj7C-DOS_dirfile_maps-234
		dc.w .obj7D-DOS_dirfile_maps-236
		dc.w .obj7F-DOS_dirfile_maps-238
		dc.w .obj80-DOS_dirfile_maps-240
		dc.w .obj82-DOS_dirfile_maps-242
		dc.w .obj83-DOS_dirfile_maps-244
		dc.w .obj84-DOS_dirfile_maps-246
		dc.w .obj86-DOS_dirfile_maps-248
		dc.w .obj86a-DOS_dirfile_maps-250
		dc.w .obj87-DOS_dirfile_maps-252
		dc.w .obj88-DOS_dirfile_maps-254
		dc.w .obj89-DOS_dirfile_maps-256
		dc.w .obj8A-DOS_dirfile_maps-258
		dc.w .obj8B-DOS_dirfile_maps-260
		dc.w .Orbs-DOS_dirfile_maps-262
		dc.w .Signs-DOS_dirfile_maps-264
		dc.w .Signs_op-DOS_dirfile_maps-266
		dc.w .Signs_ow-DOS_dirfile_maps-268
		dc.w .Sonic-DOS_dirfile_maps-270
		dc.w .Sparks-DOS_dirfile_maps-272
		dc.w .SSDOWNbloc-DOS_dirfile_maps-274
		dc.w .SSglassblo-DOS_dirfile_maps-276
		dc.w .SSRblock-DOS_dirfile_maps-278
		dc.w .SSUPblock-DOS_dirfile_maps-280
		dc.w .SSwalls-DOS_dirfile_maps-282
		dc.w .stars-DOS_dirfile_maps-284
		dc.w .Syz2Boss_B-DOS_dirfile_maps-286
		dc.w .Tail-DOS_dirfile_maps-288
		dc.w .Tails-DOS_dirfile_maps-290
		dc.w .TitleStars-DOS_dirfile_maps-292
		dc.w .Waterfall-DOS_dirfile_maps-294
		dc.w DOS_null-DOS_dirfile_maps-296


.Boss_items:	dc.b 14-1, 0
		DOS_String 'ASM Boss items'

.Bubbleshie:	dc.b 16-1, 0
		DOS_String 'ASM Bubbleshield'

.DashDust:	dc.b 12-1, 0
		DOS_String 'ASM DashDust'

.Eggman:	dc.b 10-1, 0
		DOS_String 'ASM Eggman'

.Eggman2:	dc.b 11-1
		DOS_String 'ASM Eggman2'

.End_Signs:	dc.b 13-1
		DOS_String 'ASM End Signs'

.FireShield:	dc.b 14-1, 0
		DOS_String 'ASM FireShield'

.FZ_boss:	dc.b 11-1
		DOS_String 'ASM FZ boss'

.HPZ_Platfo:	dc.b 16-1, 0
		DOS_String 'ASM HPZ_Platform'

.insta:	dc.b 9-1
		DOS_String 'ASM insta'

.Instashiel:	dc.b 15-1
		DOS_String 'ASM Instashield'

.Knux:	dc.b 8-1, 0
		DOS_String 'ASM Knux'

.Lightning:	dc.b 13-1
		DOS_String 'ASM Lightning'

.obj08:	dc.b 9-1
		DOS_String 'ASM obj08'

.obj0A:	dc.b 9-1
		DOS_String 'ASM obj0A'

.obj0B:	dc.b 9-1
		DOS_String 'ASM obj0B'

.obj0C:	dc.b 9-1
		DOS_String 'ASM obj0C'

.obj0D:	dc.b 9-1
		DOS_String 'ASM obj0D'

.obj0E:	dc.b 9-1
		DOS_String 'ASM obj0E'

.obj0F:	dc.b 9-1
		DOS_String 'ASM obj0F'

.obj11:	dc.b 9-1
		DOS_String 'ASM obj11'

.obj11_HPZ:	dc.b 13-1
		DOS_String 'ASM obj11_HPZ'

.obj12:	dc.b 9-1
		DOS_String 'ASM obj12'

.obj14:	dc.b 9-1
		DOS_String 'ASM obj14'

.obj15ghz:	dc.b 12-1, 0
		DOS_String 'ASM obj15ghz'

.obj15sbz:	dc.b 12-1, 0
		DOS_String 'ASM obj15sbz'

.obj15slz:	dc.b 12-1, 0
		DOS_String 'ASM obj15slz'

.obj16:	dc.b 9-1
		DOS_String 'ASM obj16'

.obj17:	dc.b 9-1
		DOS_String 'ASM obj17'

.obj18ghz:	dc.b 12-1, 0
		DOS_String 'ASM obj18ghz'

.obj18slz:	dc.b 12-1, 0
		DOS_String 'ASM obj18slz'

.obj18syz:	dc.b 12-1, 0
		DOS_String 'ASM obj18syz'

.obj18x:	dc.b 10-1, 0
		DOS_String 'ASM obj18x'

.obj1A:	dc.b 9-1
		DOS_String 'ASM obj1A'

.obj1B:	dc.b 9-1
		DOS_String 'ASM obj1B'

.obj1C:	dc.b 9-1
		DOS_String 'ASM obj1C'

.obj1D:	dc.b 9-1
		DOS_String 'ASM obj1D'

.obj1E:	dc.b 9-1
		DOS_String 'ASM obj1E'

.obj1F:	dc.b 9-1
		DOS_String 'ASM obj1F'

.obj21:	dc.b 9-1
		DOS_String 'ASM obj21'

.obj22:	dc.b 9-1
		DOS_String 'ASM obj22'

.obj23:	dc.b 9-1
		DOS_String 'ASM obj23'

.obj24:	dc.b 9-1
		DOS_String 'ASM obj24'

.obj25:	dc.b 9-1
		DOS_String 'ASM obj25'

.obj26:	dc.b 9-1
		DOS_String 'ASM obj26'

.obj28:	dc.b 9-1
		DOS_String 'ASM obj28'

.obj28a:	dc.b 10-1, 0
		DOS_String 'ASM obj28a'

.obj28b:	dc.b 10-1, 0
		DOS_String 'ASM obj28b'

.obj29:	dc.b 9-1
		DOS_String 'ASM obj29'

.obj2A:	dc.b 9-1
		DOS_String 'ASM obj2A'

.obj2B:	dc.b 9-1
		DOS_String 'ASM obj2B'

.obj2C:	dc.b 9-1
		DOS_String 'ASM obj2C'

.obj2D:	dc.b 9-1
		DOS_String 'ASM obj2D'

.obj2F:	dc.b 9-1
		DOS_String 'ASM obj2F'

.obj30:	dc.b 9-1
		DOS_String 'ASM obj30'

.obj31:	dc.b 9-1
		DOS_String 'ASM obj31'

.obj32:	dc.b 9-1
		DOS_String 'ASM obj32'

.obj33:	dc.b 9-1
		DOS_String 'ASM obj33'

.obj36:	dc.b 9-1
		DOS_String 'ASM obj36'

.obj38:	dc.b 9-1
		DOS_String 'ASM obj38'

.obj39:	dc.b 9-1
		DOS_String 'ASM obj39'

.obj3B:	dc.b 9-1
		DOS_String 'ASM obj3B'

.obj3C:	dc.b 9-1
		DOS_String 'ASM obj3C'

.obj3E:	dc.b 9-1
		DOS_String 'ASM obj3E'

.obj40:	dc.b 9-1
		DOS_String 'ASM obj40'

.obj41:	dc.b 9-1
		DOS_String 'ASM obj41'

.obj42:	dc.b 9-1
		DOS_String 'ASM obj42'

.obj43:	dc.b 9-1
		DOS_String 'ASM obj43'

.obj44:	dc.b 9-1
		DOS_String 'ASM obj44'

.obj45:	dc.b 9-1
		DOS_String 'ASM obj45'

.obj46:	dc.b 9-1
		DOS_String 'ASM obj46'

.obj47:	dc.b 9-1
		DOS_String 'ASM obj47'

.obj48:	dc.b 9-1
		DOS_String 'ASM obj48'

.obj4A:	dc.b 9-1
		DOS_String 'ASM obj4A'

.obj4B:	dc.b 9-1
		DOS_String 'ASM obj4B'

.obj4C:	dc.b 9-1
		DOS_String 'ASM obj4C'

.obj4E:	dc.b 9-1
		DOS_String 'ASM obj4E'

.obj50:	dc.b 9-1
		DOS_String 'ASM obj50'

.obj51:	dc.b 9-1
		DOS_String 'ASM obj51'

.obj52lz:	dc.b 11-1
		DOS_String 'ASM obj52lz'

.obj52mz:	dc.b 11-1
		DOS_String 'ASM obj52mz'

.obj53:	dc.b 9-1
		DOS_String 'ASM obj53'

.obj54:	dc.b 9-1
		DOS_String 'ASM obj54'

.obj55:	dc.b 9-1
		DOS_String 'ASM obj55'

.obj56:	dc.b 9-1
		DOS_String 'ASM obj56'

.obj57lz:	dc.b 11-1
		DOS_String 'ASM obj57lz'

.obj57syz:	dc.b 12-1, 0
		DOS_String 'ASM obj57syz'

.obj59:	dc.b 9-1
		DOS_String 'ASM obj59'

.obj5A:	dc.b 9-1
		DOS_String 'ASM obj5A'

.obj5B:	dc.b 9-1
		DOS_String 'ASM obj5B'

.obj5C:	dc.b 9-1
		DOS_String 'ASM obj5C'

.obj5D:	dc.b 9-1
		DOS_String 'ASM obj5D'

.obj5E:	dc.b 9-1
		DOS_String 'ASM obj5E'

.obj5Eballs:	dc.b 14-1, 0
		DOS_String 'ASM obj5Eballs'

.obj5F:	dc.b 9-1
		DOS_String 'ASM obj5F'

.obj60:	dc.b 9-1
		DOS_String 'ASM obj60'

.obj61:	dc.b 9-1
		DOS_String 'ASM obj61'

.obj62:	dc.b 9-1
		DOS_String 'ASM obj62'

.obj63:	dc.b 9-1
		DOS_String 'ASM obj63'

.obj64:	dc.b 9-1
		DOS_String 'ASM obj64'

.obj65:	dc.b 9-1
		DOS_String 'ASM obj65'

.obj66:	dc.b 9-1
		DOS_String 'ASM obj66'

.obj67:	dc.b 9-1
		DOS_String 'ASM obj67'

.obj69:	dc.b 9-1
		DOS_String 'ASM obj69'

.obj69a:	dc.b 10-1, 0
		DOS_String 'ASM obj69a'

.obj6A:	dc.b 9-1
		DOS_String 'ASM obj6A'

.obj6B:	dc.b 9-1
		DOS_String 'ASM obj6B'

.obj6C:	dc.b 9-1
		DOS_String 'ASM obj6C'

.obj6D:	dc.b 9-1
		DOS_String 'ASM obj6D'

.obj6E:	dc.b 9-1
		DOS_String 'ASM obj6E'

.obj70:	dc.b 9-1
		DOS_String 'ASM obj70'

.obj71:	dc.b 9-1
		DOS_String 'ASM obj71'

.obj76:	dc.b 9-1
		DOS_String 'ASM obj76'

.obj78:	dc.b 9-1
		DOS_String 'ASM obj78'

.obj79:	dc.b 9-1
		DOS_String 'ASM obj79'

.obj7B:	dc.b 9-1
		DOS_String 'ASM obj7B'

.obj7C:	dc.b 9-1
		DOS_String 'ASM obj7C'

.obj7D:	dc.b 9-1
		DOS_String 'ASM obj7D'

.obj7F:	dc.b 9-1
		DOS_String 'ASM obj7F'

.obj80:	dc.b 9-1
		DOS_String 'ASM obj80'

.obj82:	dc.b 9-1
		DOS_String 'ASM obj82'

.obj83:	dc.b 9-1
		DOS_String 'ASM obj83'

.obj84:	dc.b 9-1
		DOS_String 'ASM obj84'

.obj86:	dc.b 9-1
		DOS_String 'ASM obj86'

.obj86a:	dc.b 10-1, 0
		DOS_String 'ASM obj86a'

.obj87:	dc.b 9-1
		DOS_String 'ASM obj87'

.obj88:	dc.b 9-1
		DOS_String 'ASM obj88'

.obj89:	dc.b 9-1
		DOS_String 'ASM obj89'

.obj8A:	dc.b 9-1
		DOS_String 'ASM obj8A'

.obj8B:	dc.b 9-1
		DOS_String 'ASM obj8B'

.Orbs:	dc.b 8-1, 0
		DOS_String 'ASM Orbs'

.Signs:	dc.b 9-1
		DOS_String 'ASM Signs'

.Signs_op:	dc.b 12-1, 0
		DOS_String 'ASM Signs_op'

.Signs_ow:	dc.b 12-1, 0
		DOS_String 'ASM Signs_ow'

.Sonic:	dc.b 9-1
		DOS_String 'ASM Sonic'

.Sparks:	dc.b 10-1, 0
		DOS_String 'ASM Sparks'

.SSDOWNbloc:	dc.b 15-1
		DOS_String 'ASM SSDOWNblock'

.SSglassblo:	dc.b 16-1, 0
		DOS_String 'ASM SSglassblock'

.SSRblock:	dc.b 12-1, 0
		DOS_String 'ASM SSRblock'

.SSUPblock:	dc.b 13-1
		DOS_String 'ASM SSUPblock'

.SSwalls:	dc.b 11-1
		DOS_String 'ASM SSwalls'

.stars:	dc.b 9-1
		DOS_String 'ASM stars'

.Syz2Boss_B:	dc.b 19-1
		DOS_String 'ASM Syz2Boss_Blocks'

.Tail:	dc.b 8-1, 0
		DOS_String 'ASM Tail'

.Tails:	dc.b 9-1
		DOS_String 'ASM Tails'

.TitleStars:	dc.b 14-1, 0
		DOS_String 'ASM TitleStars'

.Waterfall:	dc.b 13-1
		DOS_String 'ASM Waterfall'


		dc.w 168-1
DOS_dirfile_artnem:
		dc.w .8x8-DOS_dirfile_artnem-2
		dc.w .8x8ghz-DOS_dirfile_artnem-4
		dc.w .8x8lz-DOS_dirfile_artnem-6
		dc.w .8x8mz-DOS_dirfile_artnem-8
		dc.w .8x8ow-DOS_dirfile_artnem-10
		dc.w .8x8sbz-DOS_dirfile_artnem-12
		dc.w .8x8slz-DOS_dirfile_artnem-14
		dc.w .8x8syz-DOS_dirfile_artnem-16
		dc.w .8x8tit1-DOS_dirfile_artnem-18
		dc.w .8x8tit2-DOS_dirfile_artnem-20
		dc.w .ASCII-DOS_dirfile_artnem-22
		dc.w .ballhog-DOS_dirfile_artnem-24
		dc.w .basaran-DOS_dirfile_artnem-26
		dc.w .blackbrd-DOS_dirfile_artnem-28
		dc.w .bomb-DOS_dirfile_artnem-30
		dc.w .bonus-DOS_dirfile_artnem-32
		dc.w .bossflam-DOS_dirfile_artnem-34
		dc.w .bossmain-DOS_dirfile_artnem-36
		dc.w .bossxtra-DOS_dirfile_artnem-38
		dc.w .Bridge-DOS_dirfile_artnem-40
		dc.w .burrobot-DOS_dirfile_artnem-42
		dc.w .buzzbomb-DOS_dirfile_artnem-44
		dc.w .caterkil-DOS_dirfile_artnem-46
		dc.w .chicken-DOS_dirfile_artnem-48
		dc.w .chopper-DOS_dirfile_artnem-50
		dc.w .cntother-DOS_dirfile_artnem-52
		dc.w .cntsonic-DOS_dirfile_artnem-54
		dc.w .crabmeat-DOS_dirfile_artnem-56
		dc.w .credits-DOS_dirfile_artnem-58
		dc.w .endemera-DOS_dirfile_artnem-60
		dc.w .endflowe-DOS_dirfile_artnem-62
		dc.w .endsonic-DOS_dirfile_artnem-64
		dc.w .endtext-DOS_dirfile_artnem-66
		dc.w .explosio-DOS_dirfile_artnem-68
		dc.w .flicky-DOS_dirfile_artnem-70
		dc.w .fzboss-DOS_dirfile_artnem-72
		dc.w .fzboss2-DOS_dirfile_artnem-74
		dc.w .gameover-DOS_dirfile_artnem-76
		dc.w .ghzball-DOS_dirfile_artnem-78
		dc.w .ghzbridg-DOS_dirfile_artnem-80
		dc.w .ghzlog-DOS_dirfile_artnem-82
		dc.w .ghzrock-DOS_dirfile_artnem-84
		dc.w .ghzstalk-DOS_dirfile_artnem-86
		dc.w .ghzswing-DOS_dirfile_artnem-88
		dc.w .ghzwall1-DOS_dirfile_artnem-90
		dc.w .ghzwall2-DOS_dirfile_artnem-92
		dc.w .hud-DOS_dirfile_artnem-94
		dc.w .japcreds-DOS_dirfile_artnem-96
		dc.w .jaws-DOS_dirfile_artnem-98
		dc.w .KnuxLifeIc-DOS_dirfile_artnem-100
		dc.w .lamppost-DOS_dirfile_artnem-102
		dc.w .lifeicon-DOS_dirfile_artnem-104
		dc.w .LifeIconX-DOS_dirfile_artnem-106
		dc.w .lzblock1-DOS_dirfile_artnem-108
		dc.w .lzblock2-DOS_dirfile_artnem-110
		dc.w .lzblock3-DOS_dirfile_artnem-112
		dc.w .lzbubble-DOS_dirfile_artnem-114
		dc.w .lzcork-DOS_dirfile_artnem-116
		dc.w .lzflapdo-DOS_dirfile_artnem-118
		dc.w .lzgargoy-DOS_dirfile_artnem-120
		dc.w .lzharpoo-DOS_dirfile_artnem-122
		dc.w .lzhdoor-DOS_dirfile_artnem-124
		dc.w .lzpole-DOS_dirfile_artnem-126
		dc.w .lzptform-DOS_dirfile_artnem-128
		dc.w .lzspball-DOS_dirfile_artnem-130
		dc.w .lzsplash-DOS_dirfile_artnem-132
		dc.w .lzvdoor-DOS_dirfile_artnem-134
		dc.w .lzwater-DOS_dirfile_artnem-136
		dc.w .lzwheel-DOS_dirfile_artnem-138
		dc.w .monitors-DOS_dirfile_artnem-140
		dc.w .motobug-DOS_dirfile_artnem-142
		dc.w .mzblock-DOS_dirfile_artnem-144
		dc.w .mzfire-DOS_dirfile_artnem-146
		dc.w .mzglassy-DOS_dirfile_artnem-148
		dc.w .mzlava-DOS_dirfile_artnem-150
		dc.w .mzmetal-DOS_dirfile_artnem-152
		dc.w .mzswitch-DOS_dirfile_artnem-154
		dc.w .newtron-DOS_dirfile_artnem-156
		dc.w .orbinaut-DOS_dirfile_artnem-158
		dc.w .Orbs-DOS_dirfile_artnem-160
		dc.w .pig-DOS_dirfile_artnem-162
		dc.w .Platform-DOS_dirfile_artnem-164
		dc.w .points-DOS_dirfile_artnem-166
		dc.w .PortalLock-DOS_dirfile_artnem-168
		dc.w .press-DOS_dirfile_artnem-170
		dc.w .prison-DOS_dirfile_artnem-172
		dc.w .rabbit-DOS_dirfile_artnem-174
		dc.w .rings-DOS_dirfile_artnem-176
		dc.w .rngflash-DOS_dirfile_artnem-178
		dc.w .roller-DOS_dirfile_artnem-180
		dc.w .sbz2boss-DOS_dirfile_artnem-182
		dc.w .sbzcutte-DOS_dirfile_artnem-184
		dc.w .sbzflame-DOS_dirfile_artnem-186
		dc.w .sbzfloor-DOS_dirfile_artnem-188
		dc.w .sbzgirde-DOS_dirfile_artnem-190
		dc.w .sbzhdoor-DOS_dirfile_artnem-192
		dc.w .sbzpform-DOS_dirfile_artnem-194
		dc.w .sbzshock-DOS_dirfile_artnem-196
		dc.w .sbzslide-DOS_dirfile_artnem-198
		dc.w .sbzstomp-DOS_dirfile_artnem-200
		dc.w .sbztrapd-DOS_dirfile_artnem-202
		dc.w .sbzvanis-DOS_dirfile_artnem-204
		dc.w .sbzvdoor-DOS_dirfile_artnem-206
		dc.w .sbzwhee1-DOS_dirfile_artnem-208
		dc.w .sbzwhee2-DOS_dirfile_artnem-210
		dc.w .seal-DOS_dirfile_artnem-212
		dc.w .segalogo-DOS_dirfile_artnem-214
		dc.w .shield-DOS_dirfile_artnem-216
		dc.w .signpost-DOS_dirfile_artnem-218
		dc.w .slzblock-DOS_dirfile_artnem-220
		dc.w .slzcanno-DOS_dirfile_artnem-222
		dc.w .slzfan-DOS_dirfile_artnem-224
		dc.w .slzpylon-DOS_dirfile_artnem-226
		dc.w .slzseesa-DOS_dirfile_artnem-228
		dc.w .slzspike-DOS_dirfile_artnem-230
		dc.w .slzswing-DOS_dirfile_artnem-232
		dc.w .slzwall-DOS_dirfile_artnem-234
		dc.w .spikes-DOS_dirfile_artnem-236
		dc.w .splats-DOS_dirfile_artnem-238
		dc.w .springh-DOS_dirfile_artnem-240
		dc.w .springv-DOS_dirfile_artnem-242
		dc.w .squirrel-DOS_dirfile_artnem-244
		dc.w .ss1up-DOS_dirfile_artnem-246
		dc.w .ssbg1-DOS_dirfile_artnem-248
		dc.w .ssbg2-DOS_dirfile_artnem-250
		dc.w .ssemeral-DOS_dirfile_artnem-252
		dc.w .ssemstar-DOS_dirfile_artnem-254
		dc.w .ssghost-DOS_dirfile_artnem-256
		dc.w .ssglass-DOS_dirfile_artnem-258
		dc.w .ssgoal-DOS_dirfile_artnem-260
		dc.w .ssr-DOS_dirfile_artnem-262
		dc.w .ssredwhi-DOS_dirfile_artnem-264
		dc.w .ssresems-DOS_dirfile_artnem-266
		dc.w .ssupdown-DOS_dirfile_artnem-268
		dc.w .ssw-DOS_dirfile_artnem-270
		dc.w .sswalls-DOS_dirfile_artnem-272
		dc.w .sszone1-DOS_dirfile_artnem-274
		dc.w .sszone2-DOS_dirfile_artnem-276
		dc.w .sszone3-DOS_dirfile_artnem-278
		dc.w .sszone4-DOS_dirfile_artnem-280
		dc.w .sszone5-DOS_dirfile_artnem-282
		dc.w .sszone6-DOS_dirfile_artnem-284
		dc.w .switch-DOS_dirfile_artnem-286
		dc.w .SYZ2_Boss_-DOS_dirfile_artnem-288
		dc.w .syzbumpe-DOS_dirfile_artnem-290
		dc.w .syzlspik-DOS_dirfile_artnem-292
		dc.w .syzsspik-DOS_dirfile_artnem-294
		dc.w .TailsLifeI-DOS_dirfile_artnem-296
		dc.w .titlefor-DOS_dirfile_artnem-298
		dc.w .titleson-DOS_dirfile_artnem-300
		dc.w .titlestars-DOS_dirfile_artnem-302
		dc.w .titletm-DOS_dirfile_artnem-304
		dc.w .tryagain-DOS_dirfile_artnem-306
		dc.w .ttlcards-DOS_dirfile_artnem-308
		dc.w .WatrFall-DOS_dirfile_artnem-310
		dc.w .xxxend-DOS_dirfile_artnem-312
		dc.w .xxxexplo-DOS_dirfile_artnem-314
		dc.w .xxxfire-DOS_dirfile_artnem-316
		dc.w .xxxflash-DOS_dirfile_artnem-318
		dc.w .xxxghzbl-DOS_dirfile_artnem-320
		dc.w .xxxghzlo-DOS_dirfile_artnem-322
		dc.w .xxxgoggl-DOS_dirfile_artnem-324
		dc.w .xxxgrass-DOS_dirfile_artnem-326
		dc.w .xxxlzson-DOS_dirfile_artnem-328
		dc.w .xxxmzblo-DOS_dirfile_artnem-330
		dc.w .xxxsmoke-DOS_dirfile_artnem-332
		dc.w .xxxstars-DOS_dirfile_artnem-334
		dc.w .yadrin-DOS_dirfile_artnem-336


.8x8:	dc.b 7-1
		DOS_String 'BIN 8x8'

.8x8ghz:	dc.b 10-1, 0
		DOS_String 'BIN 8x8ghz'

.8x8lz:	dc.b 9-1
		DOS_String 'BIN 8x8lz'

.8x8mz:	dc.b 9-1
		DOS_String 'BIN 8x8mz'

.8x8ow:	dc.b 9-1
		DOS_String 'BIN 8x8ow'

.8x8sbz:	dc.b 10-1, 0
		DOS_String 'BIN 8x8sbz'

.8x8slz:	dc.b 10-1, 0
		DOS_String 'BIN 8x8slz'

.8x8syz:	dc.b 10-1, 0
		DOS_String 'BIN 8x8syz'

.8x8tit1:	dc.b 11-1
		DOS_String 'BIN 8x8tit1'

.8x8tit2:	dc.b 11-1
		DOS_String 'BIN 8x8tit2'

.ASCII:	dc.b 9-1
		DOS_String 'NEM ASCII'

.ballhog:	dc.b 11-1
		DOS_String 'BIN ballhog'

.basaran:	dc.b 11-1
		DOS_String 'BIN basaran'

.blackbrd:	dc.b 12-1, 0
		DOS_String 'BIN blackbrd'

.bomb:	dc.b 8-1, 0
		DOS_String 'BIN bomb'

.bonus:	dc.b 9-1
		DOS_String 'BIN bonus'

.bossflam:	dc.b 12-1, 0
		DOS_String 'BIN bossflam'

.bossmain:	dc.b 12-1, 0
		DOS_String 'BIN bossmain'

.bossxtra:	dc.b 12-1, 0
		DOS_String 'BIN bossxtra'

.Bridge:	dc.b 10-1, 0
		DOS_String 'NEM Bridge'

.burrobot:	dc.b 12-1, 0
		DOS_String 'BIN burrobot'

.buzzbomb:	dc.b 12-1, 0
		DOS_String 'BIN buzzbomb'

.caterkil:	dc.b 12-1, 0
		DOS_String 'BIN caterkil'

.chicken:	dc.b 11-1
		DOS_String 'BIN chicken'

.chopper:	dc.b 11-1
		DOS_String 'BIN chopper'

.cntother:	dc.b 12-1, 0
		DOS_String 'BIN cntother'

.cntsonic:	dc.b 12-1, 0
		DOS_String 'BIN cntsonic'

.crabmeat:	dc.b 12-1, 0
		DOS_String 'BIN crabmeat'

.credits:	dc.b 11-1
		DOS_String 'BIN credits'

.endemera:	dc.b 12-1, 0
		DOS_String 'BIN endemera'

.endflowe:	dc.b 12-1, 0
		DOS_String 'BIN endflowe'

.endsonic:	dc.b 12-1, 0
		DOS_String 'BIN endsonic'

.endtext:	dc.b 11-1
		DOS_String 'BIN endtext'

.explosio:	dc.b 12-1, 0
		DOS_String 'BIN explosio'

.flicky:	dc.b 10-1, 0
		DOS_String 'BIN flicky'

.fzboss:	dc.b 10-1, 0
		DOS_String 'BIN fzboss'

.fzboss2:	dc.b 11-1
		DOS_String 'BIN fzboss2'

.gameover:	dc.b 12-1, 0
		DOS_String 'BIN gameover'

.ghzball:	dc.b 11-1
		DOS_String 'BIN ghzball'

.ghzbridg:	dc.b 12-1, 0
		DOS_String 'BIN ghzbridg'

.ghzlog:	dc.b 10-1, 0
		DOS_String 'BIN ghzlog'

.ghzrock:	dc.b 11-1
		DOS_String 'BIN ghzrock'

.ghzstalk:	dc.b 12-1, 0
		DOS_String 'BIN ghzstalk'

.ghzswing:	dc.b 12-1, 0
		DOS_String 'BIN ghzswing'

.ghzwall1:	dc.b 12-1, 0
		DOS_String 'BIN ghzwall1'

.ghzwall2:	dc.b 12-1, 0
		DOS_String 'BIN ghzwall2'

.hud:	dc.b 7-1
		DOS_String 'BIN hud'

.japcreds:	dc.b 12-1, 0
		DOS_String 'BIN japcreds'

.jaws:	dc.b 8-1, 0
		DOS_String 'BIN jaws'

.KnuxLifeIc:	dc.b 16-1, 0
		DOS_String 'BIN KnuxLifeIcon'

.lamppost:	dc.b 12-1, 0
		DOS_String 'BIN lamppost'

.lifeicon:	dc.b 12-1, 0
		DOS_String 'BIN lifeicon'

.LifeIconX:	dc.b 13-1
		DOS_String 'BIN LifeIconX'

.lzblock1:	dc.b 12-1, 0
		DOS_String 'BIN lzblock1'

.lzblock2:	dc.b 12-1, 0
		DOS_String 'BIN lzblock2'

.lzblock3:	dc.b 12-1, 0
		DOS_String 'BIN lzblock3'

.lzbubble:	dc.b 12-1, 0
		DOS_String 'BIN lzbubble'

.lzcork:	dc.b 10-1, 0
		DOS_String 'BIN lzcork'

.lzflapdo:	dc.b 12-1, 0
		DOS_String 'BIN lzflapdo'

.lzgargoy:	dc.b 12-1, 0
		DOS_String 'BIN lzgargoy'

.lzharpoo:	dc.b 12-1, 0
		DOS_String 'BIN lzharpoo'

.lzhdoor:	dc.b 11-1
		DOS_String 'BIN lzhdoor'

.lzpole:	dc.b 10-1, 0
		DOS_String 'BIN lzpole'

.lzptform:	dc.b 12-1, 0
		DOS_String 'BIN lzptform'

.lzspball:	dc.b 12-1, 0
		DOS_String 'BIN lzspball'

.lzsplash:	dc.b 12-1, 0
		DOS_String 'BIN lzsplash'

.lzvdoor:	dc.b 11-1
		DOS_String 'BIN lzvdoor'

.lzwater:	dc.b 11-1
		DOS_String 'BIN lzwater'

.lzwheel:	dc.b 11-1
		DOS_String 'BIN lzwheel'

.monitors:	dc.b 12-1, 0
		DOS_String 'BIN monitors'

.motobug:	dc.b 11-1
		DOS_String 'BIN motobug'

.mzblock:	dc.b 11-1
		DOS_String 'BIN mzblock'

.mzfire:	dc.b 10-1, 0
		DOS_String 'BIN mzfire'

.mzglassy:	dc.b 12-1, 0
		DOS_String 'BIN mzglassy'

.mzlava:	dc.b 10-1, 0
		DOS_String 'BIN mzlava'

.mzmetal:	dc.b 11-1
		DOS_String 'BIN mzmetal'

.mzswitch:	dc.b 12-1, 0
		DOS_String 'BIN mzswitch'

.newtron:	dc.b 11-1
		DOS_String 'BIN newtron'

.orbinaut:	dc.b 12-1, 0
		DOS_String 'BIN orbinaut'

.Orbs:	dc.b 8-1, 0
		DOS_String 'NEM Orbs'

.pig:	dc.b 7-1
		DOS_String 'BIN pig'

.Platform:	dc.b 12-1, 0
		DOS_String 'NEM Platform'

.points:	dc.b 10-1, 0
		DOS_String 'BIN points'

.PortalLock:	dc.b 15-1
		DOS_String 'NEM PortalLocks'

.press:	dc.b 9-1
		DOS_String 'BIN press'

.prison:	dc.b 10-1, 0
		DOS_String 'BIN prison'

.rabbit:	dc.b 10-1, 0
		DOS_String 'BIN rabbit'

.rings:	dc.b 9-1
		DOS_String 'BIN rings'

.rngflash:	dc.b 12-1, 0
		DOS_String 'BIN rngflash'

.roller:	dc.b 10-1, 0
		DOS_String 'BIN roller'

.sbz2boss:	dc.b 12-1, 0
		DOS_String 'BIN sbz2boss'

.sbzcutte:	dc.b 12-1, 0
		DOS_String 'BIN sbzcutte'

.sbzflame:	dc.b 12-1, 0
		DOS_String 'BIN sbzflame'

.sbzfloor:	dc.b 12-1, 0
		DOS_String 'BIN sbzfloor'

.sbzgirde:	dc.b 12-1, 0
		DOS_String 'BIN sbzgirde'

.sbzhdoor:	dc.b 12-1, 0
		DOS_String 'BIN sbzhdoor'

.sbzpform:	dc.b 12-1, 0
		DOS_String 'BIN sbzpform'

.sbzshock:	dc.b 12-1, 0
		DOS_String 'BIN sbzshock'

.sbzslide:	dc.b 12-1, 0
		DOS_String 'BIN sbzslide'

.sbzstomp:	dc.b 12-1, 0
		DOS_String 'BIN sbzstomp'

.sbztrapd:	dc.b 12-1, 0
		DOS_String 'BIN sbztrapd'

.sbzvanis:	dc.b 12-1, 0
		DOS_String 'BIN sbzvanis'

.sbzvdoor:	dc.b 12-1, 0
		DOS_String 'BIN sbzvdoor'

.sbzwhee1:	dc.b 12-1, 0
		DOS_String 'BIN sbzwhee1'

.sbzwhee2:	dc.b 12-1, 0
		DOS_String 'BIN sbzwhee2'

.seal:	dc.b 8-1, 0
		DOS_String 'BIN seal'

.segalogo:	dc.b 12-1, 0
		DOS_String 'BIN segalogo'

.shield:	dc.b 10-1, 0
		DOS_String 'BIN shield'

.signpost:	dc.b 12-1, 0
		DOS_String 'BIN signpost'

.slzblock:	dc.b 12-1, 0
		DOS_String 'BIN slzblock'

.slzcanno:	dc.b 12-1, 0
		DOS_String 'BIN slzcanno'

.slzfan:	dc.b 10-1, 0
		DOS_String 'BIN slzfan'

.slzpylon:	dc.b 12-1, 0
		DOS_String 'BIN slzpylon'

.slzseesa:	dc.b 12-1, 0
		DOS_String 'BIN slzseesa'

.slzspike:	dc.b 12-1, 0
		DOS_String 'BIN slzspike'

.slzswing:	dc.b 12-1, 0
		DOS_String 'BIN slzswing'

.slzwall:	dc.b 11-1
		DOS_String 'BIN slzwall'

.spikes:	dc.b 10-1, 0
		DOS_String 'BIN spikes'

.splats:	dc.b 10-1, 0
		DOS_String 'BIN splats'

.springh:	dc.b 11-1
		DOS_String 'BIN springh'

.springv:	dc.b 11-1
		DOS_String 'BIN springv'

.squirrel:	dc.b 12-1, 0
		DOS_String 'BIN squirrel'

.ss1up:	dc.b 9-1
		DOS_String 'BIN ss1up'

.ssbg1:	dc.b 9-1
		DOS_String 'BIN ssbg1'

.ssbg2:	dc.b 9-1
		DOS_String 'BIN ssbg2'

.ssemeral:	dc.b 12-1, 0
		DOS_String 'BIN ssemeral'

.ssemstar:	dc.b 12-1, 0
		DOS_String 'BIN ssemstar'

.ssghost:	dc.b 11-1
		DOS_String 'BIN ssghost'

.ssglass:	dc.b 11-1
		DOS_String 'BIN ssglass'

.ssgoal:	dc.b 10-1, 0
		DOS_String 'BIN ssgoal'

.ssr:	dc.b 7-1
		DOS_String 'BIN ssr'

.ssredwhi:	dc.b 12-1, 0
		DOS_String 'BIN ssredwhi'

.ssresems:	dc.b 12-1, 0
		DOS_String 'BIN ssresems'

.ssupdown:	dc.b 12-1, 0
		DOS_String 'BIN ssupdown'

.ssw:	dc.b 7-1
		DOS_String 'BIN ssw'

.sswalls:	dc.b 11-1
		DOS_String 'BIN sswalls'

.sszone1:	dc.b 11-1
		DOS_String 'BIN sszone1'

.sszone2:	dc.b 11-1
		DOS_String 'BIN sszone2'

.sszone3:	dc.b 11-1
		DOS_String 'BIN sszone3'

.sszone4:	dc.b 11-1
		DOS_String 'BIN sszone4'

.sszone5:	dc.b 11-1
		DOS_String 'BIN sszone5'

.sszone6:	dc.b 11-1
		DOS_String 'BIN sszone6'

.switch:	dc.b 10-1, 0
		DOS_String 'BIN switch'

.SYZ2_Boss_:	dc.b 19-1
		DOS_String 'BIN SYZ2_Boss_Block'

.syzbumpe:	dc.b 12-1, 0
		DOS_String 'BIN syzbumpe'

.syzlspik:	dc.b 12-1, 0
		DOS_String 'BIN syzlspik'

.syzsspik:	dc.b 12-1, 0
		DOS_String 'BIN syzsspik'

.TailsLifeI:	dc.b 17-1
		DOS_String 'BIN TailsLifeIcon'

.titlefor:	dc.b 12-1, 0
		DOS_String 'BIN titlefor'

.titleson:	dc.b 12-1, 0
		DOS_String 'BIN titleson'

.titlestars:	dc.b 14-1, 0
		DOS_String 'BIN titlestars'

.titletm:	dc.b 11-1
		DOS_String 'BIN titletm'

.tryagain:	dc.b 12-1, 0
		DOS_String 'BIN tryagain'

.ttlcards:	dc.b 12-1, 0
		DOS_String 'BIN ttlcards'

.WatrFall:	dc.b 12-1, 0
		DOS_String 'NEM WatrFall'

.xxxend:	dc.b 10-1, 0
		DOS_String 'BIN xxxend'

.xxxexplo:	dc.b 12-1, 0
		DOS_String 'BIN xxxexplo'

.xxxfire:	dc.b 11-1
		DOS_String 'BIN xxxfire'

.xxxflash:	dc.b 12-1, 0
		DOS_String 'BIN xxxflash'

.xxxghzbl:	dc.b 12-1, 0
		DOS_String 'BIN xxxghzbl'

.xxxghzlo:	dc.b 12-1, 0
		DOS_String 'BIN xxxghzlo'

.xxxgoggl:	dc.b 12-1, 0
		DOS_String 'BIN xxxgoggl'

.xxxgrass:	dc.b 12-1, 0
		DOS_String 'BIN xxxgrass'

.xxxlzson:	dc.b 12-1, 0
		DOS_String 'BIN xxxlzson'

.xxxmzblo:	dc.b 12-1, 0
		DOS_String 'BIN xxxmzblo'

.xxxsmoke:	dc.b 12-1, 0
		DOS_String 'BIN xxxsmoke'

.xxxstars:	dc.b 12-1, 0
		DOS_String 'BIN xxxstars'

.yadrin:	dc.b 10-1, 0
		DOS_String 'BIN yadrin'


		dc.w 42-1
DOS_dirfile_artunc:
		dc.w .8x8-DOS_dirfile_artunc-2
		dc.w .ArtUnc_Bub-DOS_dirfile_artunc-4
		dc.w .ArtUnc_Fir-DOS_dirfile_artunc-6
		dc.w .ArtUnc_Ins-DOS_dirfile_artunc-8
		dc.w .ArtUnc_Inv-DOS_dirfile_artunc-10
		dc.w .ArtUnc_Lig-DOS_dirfile_artunc-12
		dc.w .bigring-DOS_dirfile_artunc-14
		dc.w .ElectricSh-DOS_dirfile_artunc-16
		dc.w .ElectricSh2-DOS_dirfile_artunc-18
		dc.w .End_Signs-DOS_dirfile_artunc-20
		dc.w .End_Signs.-DOS_dirfile_artunc-22
		dc.w .GHZ1_text1-DOS_dirfile_artunc-24
		dc.w .GHZ1_text2-DOS_dirfile_artunc-26
		dc.w .GHZ1_text3-DOS_dirfile_artunc-28
		dc.w .GHZ1_text4-DOS_dirfile_artunc-30
		dc.w .GHZ1_text5-DOS_dirfile_artunc-32
		dc.w .GHZ1_text6-DOS_dirfile_artunc-34
		dc.w .ghzflowl-DOS_dirfile_artunc-36
		dc.w .ghzflows-DOS_dirfile_artunc-38
		dc.w .ghzwater-DOS_dirfile_artunc-40
		dc.w .HUD-DOS_dirfile_artunc-42
		dc.w .InvStars.b-DOS_dirfile_artunc-44
		dc.w .Knux-DOS_dirfile_artunc-46
		dc.w .Knuxpost-DOS_dirfile_artunc-48
		dc.w .livescnt-DOS_dirfile_artunc-50
		dc.w .menutext-DOS_dirfile_artunc-52
		dc.w .monshield-DOS_dirfile_artunc-54
		dc.w .monshield2-DOS_dirfile_artunc-56
		dc.w .mzlava1-DOS_dirfile_artunc-58
		dc.w .mzlava2-DOS_dirfile_artunc-60
		dc.w .mztorch-DOS_dirfile_artunc-62
		dc.w .sbzsmoke-DOS_dirfile_artunc-64
		dc.w .shield-DOS_dirfile_artunc-66
		dc.w .Slide-DOS_dirfile_artunc-68
		dc.w .sonic-DOS_dirfile_artunc-70
		dc.w .spindust-DOS_dirfile_artunc-72
		dc.w .tail-DOS_dirfile_artunc-74
		dc.w .Tails-DOS_dirfile_artunc-76
		dc.w .Tailspost-DOS_dirfile_artunc-78
		dc.w .titlecards-DOS_dirfile_artunc-80
		dc.w ._-DOS_dirfile_artunc-82
		dc.w ._End_Signs-DOS_dirfile_artunc-84


.8x8:	dc.b 7-1
		DOS_String 'BIN 8x8'

.ArtUnc_Bub:	dc.b 16-1, 0
		DOS_String 'BIN BubbleShield'

.ArtUnc_Fir:	dc.b 14-1, 0
		DOS_String 'BIN FireShield'

.ArtUnc_Ins:	dc.b 9-1
		DOS_String 'BIN Insta'

.ArtUnc_Inv:	dc.b 17-1
		DOS_String 'BIN Invincibility'

.ArtUnc_Lig:	dc.b 19-1
		DOS_String 'BIN LightningShield'

.bigring:	dc.b 11-1
		DOS_String 'BIN bigring'

.ElectricSh:	dc.b 15-1
		DOS_String 'BIN LightSparks'

.ElectricSh2:	dc.b 18-1, 0
		DOS_String 'COMPER LightSparks'

.End_Signs:	dc.b 13-1
		DOS_String 'BIN End Signs'

.End_Signs.:	dc.b 17-1
		DOS_String 'BAK End Signs.bin'

.GHZ1_text1:	dc.b 14-1, 0
		DOS_String 'BIN GHZ1_text1'

.GHZ1_text2:	dc.b 14-1, 0
		DOS_String 'BIN GHZ1_text2'

.GHZ1_text3:	dc.b 14-1, 0
		DOS_String 'BIN GHZ1_text3'

.GHZ1_text4:	dc.b 14-1, 0
		DOS_String 'BIN GHZ1_text4'

.GHZ1_text5:	dc.b 14-1, 0
		DOS_String 'BIN GHZ1_text5'

.GHZ1_text6:	dc.b 14-1, 0
		DOS_String 'BIN GHZ1_text6'

.ghzflowl:	dc.b 12-1, 0
		DOS_String 'BIN ghzflowl'

.ghzflows:	dc.b 12-1, 0
		DOS_String 'BIN ghzflows'

.ghzwater:	dc.b 12-1, 0
		DOS_String 'BIN ghzwater'

.HUD:	dc.b 7-1
		DOS_String 'BIN HUD'

.InvStars.b:	dc.b 19-1
		DOS_String 'COMPER InvStars.bin'

.Knux:	dc.b 8-1, 0
		DOS_String 'BIN Knux'

.Knuxpost:	dc.b 12-1, 0
		DOS_String 'BIN Knuxpost'

.livescnt:	dc.b 12-1, 0
		DOS_String 'BIN livescnt'

.menutext:	dc.b 12-1, 0
		DOS_String 'BIN menutext'

.monshield:	dc.b 16-1, 0
		DOS_String 'COMPER monshield'

.monshield2:	dc.b 13-1
		DOS_String 'UNC monshield'

.mzlava1:	dc.b 11-1
		DOS_String 'BIN mzlava1'

.mzlava2:	dc.b 11-1
		DOS_String 'BIN mzlava2'

.mztorch:	dc.b 11-1
		DOS_String 'BIN mztorch'

.sbzsmoke:	dc.b 12-1, 0
		DOS_String 'BIN sbzsmoke'

.shield:	dc.b 13-1
		DOS_String 'COMPER shield'

.Slide:	dc.b 9-1
		DOS_String 'BIN Slide'

.sonic:	dc.b 9-1
		DOS_String 'BIN sonic'

.spindust:	dc.b 12-1, 0
		DOS_String 'BIN spindust'

.tail:	dc.b 8-1, 0
		DOS_String 'BIN tail'

.Tails:	dc.b 9-1
		DOS_String 'BIN Tails'

.Tailspost:	dc.b 13-1
		DOS_String 'BIN Tailspost'

.titlecards:	dc.b 14-1, 0
		DOS_String 'UNC titlecards'

._:	dc.b 5-1
		DOS_String 'BIN _'

._End_Signs:	dc.b 14-1, 0
		DOS_String 'BIN _End Signs'


		dc.w 28-1
DOS_dirfile_boss:
		dc.w .FZ-DOS_dirfile_boss-2
		dc.w .FZ2-DOS_dirfile_boss-4
		dc.w .GHZ2-DOS_dirfile_boss-6
		dc.w .GHZ3-DOS_dirfile_boss-8
		dc.w .LBZfacea-DOS_dirfile_boss-10
		dc.w .LBZface-DOS_dirfile_boss-12
		dc.w .LBZmaps-DOS_dirfile_boss-14
		dc.w .LBZpalette-DOS_dirfile_boss-16
		dc.w .LBZtiles-DOS_dirfile_boss-18
		dc.w .LBZtiles1-DOS_dirfile_boss-20
		dc.w .LBZtiles2-DOS_dirfile_boss-22
		dc.w .LBZtiles3-DOS_dirfile_boss-24
		dc.w .LZ3-DOS_dirfile_boss-26
		dc.w .LZ6-DOS_dirfile_boss-28
		dc.w .MZ2-DOS_dirfile_boss-30
		dc.w .MZ3-DOS_dirfile_boss-32
		dc.w .SBZ2-DOS_dirfile_boss-34
		dc.w .SBZ3-DOS_dirfile_boss-36
		dc.w .SLZ2-DOS_dirfile_boss-38
		dc.w .SLZ3-DOS_dirfile_boss-40
		dc.w .SYZ2-DOS_dirfile_boss-42
		dc.w .SYZ3-DOS_dirfile_boss-44


.FZ:	dc.b 6-1, 0
		DOS_String 'ASM FZ'

.FZ2:	dc.b 7-1
		DOS_String 'ASM FZ2'

.GHZ2:	dc.b 8-1, 0
		DOS_String 'ASM GHZ2'

.GHZ3:	dc.b 8-1, 0
		DOS_String 'ASM GHZ3'

.LBZfacea:	dc.b 11-1
		DOS_String 'ASM LBZface'

.LBZface:	dc.b 11-1
		DOS_String 'KOS LBZface'

.LBZmaps:	dc.b 11-1
		DOS_String 'ASM LBZmaps'

.LBZpalette:	dc.b 14-1, 0
		DOS_String 'BIN LBZpalette'

.LBZtiles:	dc.b 12-1, 0
		DOS_String 'KOS LBZtiles'

.LBZtiles1:	dc.b 13-1
		DOS_String 'KOS LBZtiles1'

.LBZtiles2:	dc.b 13-1
		DOS_String 'KOS LBZtiles2'

.LBZtiles3:	dc.b 13-1
		DOS_String 'KOS LBZtiles3'

.LZ3:	dc.b 7-1
		DOS_String 'ASM LZ3'

.LZ6:	dc.b 7-1
		DOS_String 'ASM LZ6'

.MZ2:	dc.b 7-1
		DOS_String 'ASM MZ2'

.MZ3:	dc.b 7-1
		DOS_String 'ASM MZ3'

.SBZ2:	dc.b 8-1, 0
		DOS_String 'ASM SBZ2'

.SBZ3:	dc.b 8-1, 0
		DOS_String 'ASM SBZ3'

.SLZ2:	dc.b 8-1, 0
		DOS_String 'ASM SLZ2'

.SLZ3:	dc.b 8-1, 0
		DOS_String 'ASM SLZ3'

.SYZ2:	dc.b 8-1, 0
		DOS_String 'ASM SYZ2'

.SYZ3:	dc.b 8-1, 0
		DOS_String 'ASM SYZ3'


		dc.w 22-1
DOS_dirfile_collide:
		dc.w .anglemap-DOS_dirfile_collide-2
		dc.w .anglemap2-DOS_dirfile_collide-4
		dc.w .array21-DOS_dirfile_collide-6
		dc.w .array22-DOS_dirfile_collide-8
		dc.w .carray_n-DOS_dirfile_collide-10
		dc.w .carray_r-DOS_dirfile_collide-12
		dc.w .ghz1-DOS_dirfile_collide-14
		dc.w .ghz12-DOS_dirfile_collide-16
		dc.w .ghz2-DOS_dirfile_collide-18
		dc.w .ghz22-DOS_dirfile_collide-20
		dc.w .lz1-DOS_dirfile_collide-22
		dc.w .lz2-DOS_dirfile_collide-24
		dc.w .mz1-DOS_dirfile_collide-26
		dc.w .mz2-DOS_dirfile_collide-28
		dc.w .ow1-DOS_dirfile_collide-30
		dc.w .ow2-DOS_dirfile_collide-32
		dc.w .sbz1-DOS_dirfile_collide-34
		dc.w .sbz2-DOS_dirfile_collide-36
		dc.w .slz1-DOS_dirfile_collide-38
		dc.w .slz2-DOS_dirfile_collide-40
		dc.w .syz1-DOS_dirfile_collide-42
		dc.w .syz2-DOS_dirfile_collide-44


.anglemap:	dc.b 12-1, 0
		DOS_String 'BIN anglemap'

.anglemap2:	dc.b 13-1
		DOS_String 'BIN anglemap2'

.array21:	dc.b 11-1
		DOS_String 'BIN array21'

.array22:	dc.b 11-1
		DOS_String 'BIN array22'

.carray_n:	dc.b 12-1, 0
		DOS_String 'BIN carray_n'

.carray_r:	dc.b 12-1, 0
		DOS_String 'BIN carray_r'

.ghz1:	dc.b 8-1, 0
		DOS_String 'BIN ghz1'

.ghz12:	dc.b 9-1
		DOS_String 'BIN ghz12'

.ghz2:	dc.b 8-1, 0
		DOS_String 'BIN ghz2'

.ghz22:	dc.b 9-1
		DOS_String 'BIN ghz22'

.lz1:	dc.b 7-1
		DOS_String 'BIN lz1'

.lz2:	dc.b 7-1
		DOS_String 'BIN lz2'

.mz1:	dc.b 7-1
		DOS_String 'BIN mz1'

.mz2:	dc.b 7-1
		DOS_String 'BIN mz2'

.ow1:	dc.b 7-1
		DOS_String 'BIN ow1'

.ow2:	dc.b 7-1
		DOS_String 'BIN ow2'

.sbz1:	dc.b 8-1, 0
		DOS_String 'BIN sbz1'

.sbz2:	dc.b 8-1, 0
		DOS_String 'BIN sbz2'

.slz1:	dc.b 8-1, 0
		DOS_String 'BIN slz1'

.slz2:	dc.b 8-1, 0
		DOS_String 'BIN slz2'

.syz1:	dc.b 8-1, 0
		DOS_String 'BIN syz1'

.syz2:	dc.b 8-1, 0
		DOS_String 'BIN syz2'


		dc.w 50-1
DOS_dirfile_dac:
		dc.w .banana-DOS_dirfile_dac-2
		dc.w .D8D8E-DOS_dirfile_dac-4
		dc.w .D8F-DOS_dirfile_dac-6
		dc.w .D9093-DOS_dirfile_dac-8
		dc.w .DanceSnare-DOS_dirfile_dac-10
		dc.w .Disc_Scrat-DOS_dirfile_dac-12
		dc.w .dpcm2pcm-DOS_dirfile_dac-14
		dc.w .gmoverscre-DOS_dirfile_dac-16
		dc.w .Go-DOS_dirfile_dac-18
		dc.w .ground-DOS_dirfile_dac-20
		dc.w .Gununknown-DOS_dirfile_dac-22
		dc.w .horn-DOS_dirfile_dac-24
		dc.w .horns-DOS_dirfile_dac-26
		dc.w .longkick-DOS_dirfile_dac-28
		dc.w .lost-DOS_dirfile_dac-30
		dc.w .moon_clap-DOS_dirfile_dac-32
		dc.w .pan-DOS_dirfile_dac-34
		dc.w .pcm2dpcm-DOS_dirfile_dac-36
		dc.w .portal_die1-DOS_dirfile_dac-38
		dc.w .portal_die2-DOS_dirfile_dac-40
		dc.w .portal_die3-DOS_dirfile_dac-42
		dc.w .portal_die4-DOS_dirfile_dac-44
		dc.w .portal_fou1-DOS_dirfile_dac-46
		dc.w .portal_fou2-DOS_dirfile_dac-48
		dc.w .portal_fou3-DOS_dirfile_dac-50
		dc.w .portal_fou4-DOS_dirfile_dac-52
		dc.w .portal_los1-DOS_dirfile_dac-54
		dc.w .portal_los2-DOS_dirfile_dac-56
		dc.w .portal_los3-DOS_dirfile_dac-58
		dc.w .portal_los4-DOS_dirfile_dac-60
		dc.w .Rhythm_Emo-DOS_dirfile_dac-62
		dc.w .s3kCrashCy-DOS_dirfile_dac-64
		dc.w .s3kkick-DOS_dirfile_dac-66
		dc.w .S3ksteeldr-DOS_dirfile_dac-68
		dc.w .s3kTightSn-DOS_dirfile_dac-70
		dc.w .scream1-DOS_dirfile_dac-72
		dc.w .scream2-DOS_dirfile_dac-74
		dc.w .scream3-DOS_dirfile_dac-76
		dc.w .scream4-DOS_dirfile_dac-78
		dc.w .segapcm-DOS_dirfile_dac-80
		dc.w .smoke-DOS_dirfile_dac-82
		dc.w .spiel-DOS_dirfile_dac-84
		dc.w .Streetssna-DOS_dirfile_dac-86
		dc.w .TF2Nope-DOS_dirfile_dac-88
		dc.w .Timpani-DOS_dirfile_dac-90
		dc.w .trump-DOS_dirfile_dac-92
		dc.w .Vecbass2-DOS_dirfile_dac-94
		dc.w ._8F_Sonic3-DOS_dirfile_dac-96
		dc.w ._90_Sonic3-DOS_dirfile_dac-98


.banana:	dc.b 10-1, 0
		DOS_String 'RAW banana'

.D8D8E:	dc.b 9-1
		DOS_String 'BIN D8D8E'

.D8F:	dc.b 7-1
		DOS_String 'BIN D8F'

.D9093:	dc.b 9-1
		DOS_String 'BIN D9093'

.DanceSnare:	dc.b 14-1, 0
		DOS_String 'WAV DanceSnare'

.Disc_Scrat:	dc.b 16-1, 0
		DOS_String 'RAW Disc_Scratch'

.dpcm2pcm:	dc.b 12-1, 0
		DOS_String 'EXE dpcm2pcm'

.gmoverscre:	dc.b 16-1, 0
		DOS_String 'RAW gmoverscrean'

.Go:	dc.b 6-1, 0
		DOS_String 'BIN Go'

.ground:	dc.b 10-1, 0
		DOS_String 'RAW ground'

.Gununknown:	dc.b 14-1, 0
		DOS_String 'RAW Gununknown'

.horn:	dc.b 8-1, 0
		DOS_String 'RAW horn'

.horns:	dc.b 9-1
		DOS_String 'RAW horns'

.longkick:	dc.b 12-1, 0
		DOS_String 'RAW longkick'

.lost:	dc.b 8-1, 0
		DOS_String 'RAW lost'

.moon_clap:	dc.b 13-1
		DOS_String 'RAW moon_clap'

.pan:	dc.b 7-1
		DOS_String 'RAW pan'

.pcm2dpcm:	dc.b 12-1, 0
		DOS_String 'EXE pcm2dpcm'

.portal_die1:	dc.b 15-1
		DOS_String 'RAW portal_die1'

.portal_die2:	dc.b 15-1
		DOS_String 'RAW portal_die2'

.portal_die3:	dc.b 15-1
		DOS_String 'RAW portal_die3'

.portal_die4:	dc.b 15-1
		DOS_String 'RAW portal_die4'

.portal_fou1:	dc.b 17-1
		DOS_String 'RAW portal_found1'

.portal_fou2:	dc.b 17-1
		DOS_String 'RAW portal_found2'

.portal_fou3:	dc.b 17-1
		DOS_String 'RAW portal_found3'

.portal_fou4:	dc.b 17-1
		DOS_String 'RAW portal_found4'

.portal_los1:	dc.b 16-1, 0
		DOS_String 'RAW portal_lost1'

.portal_los2:	dc.b 16-1, 0
		DOS_String 'RAW portal_lost2'

.portal_los3:	dc.b 16-1, 0
		DOS_String 'RAW portal_lost3'

.portal_los4:	dc.b 16-1, 0
		DOS_String 'RAW portal_lost4'

.Rhythm_Emo:	dc.b 19-1
		DOS_String 'RAW Rhythm_Emotion_'

.s3kCrashCy:	dc.b 18-1, 0
		DOS_String 'BIN s3kCrashCymbal'

.s3kkick:	dc.b 11-1
		DOS_String 'BIN s3kkick'

.S3ksteeldr:	dc.b 16-1, 0
		DOS_String 'BIN S3ksteeldrum'

.s3kTightSn:	dc.b 17-1
		DOS_String 'BIN s3kTightSnare'

.scream1:	dc.b 11-1
		DOS_String 'RAW scream1'

.scream2:	dc.b 11-1
		DOS_String 'RAW scream2'

.scream3:	dc.b 11-1
		DOS_String 'RAW scream3'

.scream4:	dc.b 11-1
		DOS_String 'RAW scream4'

.segapcm:	dc.b 11-1
		DOS_String 'BIN segapcm'

.smoke:	dc.b 9-1
		DOS_String 'RAW smoke'

.spiel:	dc.b 9-1
		DOS_String 'RAW spiel'

.Streetssna:	dc.b 16-1, 0
		DOS_String 'RAW Streetssnare'

.TF2Nope:	dc.b 11-1
		DOS_String 'RAW TF2Nope'

.Timpani:	dc.b 11-1
		DOS_String 'BIN Timpani'

.trump:	dc.b 9-1
		DOS_String 'RAW trump'

.Vecbass2:	dc.b 12-1, 0
		DOS_String 'RAW Vecbass2'

._8F_Sonic3:	dc.b 19-1
		DOS_String 'RAW _8F_Sonic3snare'

._90_Sonic3:	dc.b 18-1, 0
		DOS_String 'RAW _90_Sonic3kick'


		dc.w 12-1
DOS_dirfile_demodata:
		dc.w .e_ghz1-DOS_dirfile_demodata-2
		dc.w .e_ghz2-DOS_dirfile_demodata-4
		dc.w .e_lz-DOS_dirfile_demodata-6
		dc.w .e_mz-DOS_dirfile_demodata-8
		dc.w .e_sbz1-DOS_dirfile_demodata-10
		dc.w .e_sbz2-DOS_dirfile_demodata-12
		dc.w .e_slz-DOS_dirfile_demodata-14
		dc.w .e_syz-DOS_dirfile_demodata-16
		dc.w .i_ghz-DOS_dirfile_demodata-18
		dc.w .i_mz-DOS_dirfile_demodata-20
		dc.w .i_ss-DOS_dirfile_demodata-22
		dc.w .i_syz-DOS_dirfile_demodata-24


.e_ghz1:	dc.b 10-1, 0
		DOS_String 'BIN e_ghz1'

.e_ghz2:	dc.b 10-1, 0
		DOS_String 'BIN e_ghz2'

.e_lz:	dc.b 8-1, 0
		DOS_String 'BIN e_lz'

.e_mz:	dc.b 8-1, 0
		DOS_String 'BIN e_mz'

.e_sbz1:	dc.b 10-1, 0
		DOS_String 'BIN e_sbz1'

.e_sbz2:	dc.b 10-1, 0
		DOS_String 'BIN e_sbz2'

.e_slz:	dc.b 9-1
		DOS_String 'BIN e_slz'

.e_syz:	dc.b 9-1
		DOS_String 'BIN e_syz'

.i_ghz:	dc.b 9-1
		DOS_String 'BIN i_ghz'

.i_mz:	dc.b 8-1, 0
		DOS_String 'BIN i_mz'

.i_ss:	dc.b 8-1, 0
		DOS_String 'BIN i_ss'

.i_syz:	dc.b 9-1
		DOS_String 'BIN i_syz'


		dc.w 40-1
DOS_dirfile_levels:
		dc.w .ending-DOS_dirfile_levels-2
		dc.w .ghz1-DOS_dirfile_levels-4
		dc.w .ghz12-DOS_dirfile_levels-6
		dc.w .ghz2-DOS_dirfile_levels-8
		dc.w .ghz3-DOS_dirfile_levels-10
		dc.w .ghz4-DOS_dirfile_levels-12
		dc.w .ghzbg-DOS_dirfile_levels-14
		dc.w .ghzSC-DOS_dirfile_levels-16
		dc.w .lz1-DOS_dirfile_levels-18
		dc.w .lz2-DOS_dirfile_levels-20
		dc.w .lz3-DOS_dirfile_levels-22
		dc.w .lz3_wall-DOS_dirfile_levels-24
		dc.w .lz6-DOS_dirfile_levels-26
		dc.w .lzbg-DOS_dirfile_levels-28
		dc.w .mz1-DOS_dirfile_levels-30
		dc.w .mz1bg-DOS_dirfile_levels-32
		dc.w .mz2-DOS_dirfile_levels-34
		dc.w .mz2bg-DOS_dirfile_levels-36
		dc.w .mz2_fall-DOS_dirfile_levels-38
		dc.w .mz3-DOS_dirfile_levels-40
		dc.w .mz3bg-DOS_dirfile_levels-42
		dc.w .mz4-DOS_dirfile_levels-44
		dc.w .ow1-DOS_dirfile_levels-46
		dc.w .sbz1-DOS_dirfile_levels-48
		dc.w .sbz1bg-DOS_dirfile_levels-50
		dc.w .sbz2-DOS_dirfile_levels-52
		dc.w .sbz2bg-DOS_dirfile_levels-54
		dc.w .sbz3-DOS_dirfile_levels-56
		dc.w .sbz4-DOS_dirfile_levels-58
		dc.w .slz1-DOS_dirfile_levels-60
		dc.w .slz2-DOS_dirfile_levels-62
		dc.w .slz3-DOS_dirfile_levels-64
		dc.w .slz4-DOS_dirfile_levels-66
		dc.w .slzbg-DOS_dirfile_levels-68
		dc.w .syz1-DOS_dirfile_levels-70
		dc.w .syz2-DOS_dirfile_levels-72
		dc.w .syz3-DOS_dirfile_levels-74
		dc.w .syz4-DOS_dirfile_levels-76
		dc.w .syzbg-DOS_dirfile_levels-78
		dc.w DOS_null-DOS_dirfile_levels-80


.ending:	dc.b 10-1, 0
		DOS_String 'BIN ending'

.ghz1:	dc.b 8-1, 0
		DOS_String 'BIN ghz1'

.ghz12:	dc.b 9-1
		DOS_String 'BIN ghz12'

.ghz2:	dc.b 8-1, 0
		DOS_String 'BIN ghz2'

.ghz3:	dc.b 8-1, 0
		DOS_String 'BIN ghz3'

.ghz4:	dc.b 8-1, 0
		DOS_String 'BIN ghz4'

.ghzbg:	dc.b 9-1
		DOS_String 'BIN ghzbg'

.ghzSC:	dc.b 9-1
		DOS_String 'BIN ghzSC'

.lz1:	dc.b 7-1
		DOS_String 'BIN lz1'

.lz2:	dc.b 7-1
		DOS_String 'BIN lz2'

.lz3:	dc.b 7-1
		DOS_String 'BIN lz3'

.lz3_wall:	dc.b 12-1, 0
		DOS_String 'BIN lz3_wall'

.lz6:	dc.b 7-1
		DOS_String 'BIN lz6'

.lzbg:	dc.b 8-1, 0
		DOS_String 'BIN lzbg'

.mz1:	dc.b 7-1
		DOS_String 'BIN mz1'

.mz1bg:	dc.b 9-1
		DOS_String 'BIN mz1bg'

.mz2:	dc.b 7-1
		DOS_String 'BIN mz2'

.mz2bg:	dc.b 9-1
		DOS_String 'BIN mz2bg'

.mz2_fall:	dc.b 12-1, 0
		DOS_String 'BIN mz2_fall'

.mz3:	dc.b 7-1
		DOS_String 'BIN mz3'

.mz3bg:	dc.b 9-1
		DOS_String 'BIN mz3bg'

.mz4:	dc.b 7-1
		DOS_String 'BIN mz4'

.ow1:	dc.b 7-1
		DOS_String 'BIN ow1'

.sbz1:	dc.b 8-1, 0
		DOS_String 'BIN sbz1'

.sbz1bg:	dc.b 10-1, 0
		DOS_String 'BIN sbz1bg'

.sbz2:	dc.b 8-1, 0
		DOS_String 'BIN sbz2'

.sbz2bg:	dc.b 10-1, 0
		DOS_String 'BIN sbz2bg'

.sbz3:	dc.b 8-1, 0
		DOS_String 'BIN sbz3'

.sbz4:	dc.b 8-1, 0
		DOS_String 'BIN sbz4'

.slz1:	dc.b 8-1, 0
		DOS_String 'BIN slz1'

.slz2:	dc.b 8-1, 0
		DOS_String 'BIN slz2'

.slz3:	dc.b 8-1, 0
		DOS_String 'BIN slz3'

.slz4:	dc.b 8-1, 0
		DOS_String 'BIN slz4'

.slzbg:	dc.b 9-1
		DOS_String 'BIN slzbg'

.syz1:	dc.b 8-1, 0
		DOS_String 'BIN syz1'

.syz2:	dc.b 8-1, 0
		DOS_String 'BIN syz2'

.syz3:	dc.b 8-1, 0
		DOS_String 'BIN syz3'

.syz4:	dc.b 8-1, 0
		DOS_String 'BIN syz4'

.syzbg:	dc.b 9-1
		DOS_String 'BIN syzbg'


		dc.w 8-1
DOS_dirfile_map16:
		dc.w .ghz-DOS_dirfile_map16-2
		dc.w .ghz1-DOS_dirfile_map16-4
		dc.w .lz-DOS_dirfile_map16-6
		dc.w .mz-DOS_dirfile_map16-8
		dc.w .ow-DOS_dirfile_map16-10
		dc.w .sbz-DOS_dirfile_map16-12
		dc.w .slz-DOS_dirfile_map16-14
		dc.w .syz-DOS_dirfile_map16-16


.ghz:	dc.b 7-1
		DOS_String 'BIN ghz'

.ghz1:	dc.b 8-1, 0
		DOS_String 'BIN ghz1'

.lz:	dc.b 6-1, 0
		DOS_String 'BIN lz'

.mz:	dc.b 6-1, 0
		DOS_String 'BIN mz'

.ow:	dc.b 6-1, 0
		DOS_String 'BIN ow'

.sbz:	dc.b 7-1
		DOS_String 'BIN sbz'

.slz:	dc.b 7-1
		DOS_String 'BIN slz'

.syz:	dc.b 7-1
		DOS_String 'BIN syz'


		dc.w 8-1
DOS_dirfile_map256:
		dc.w .ghz-DOS_dirfile_map256-2
		dc.w .ghz1-DOS_dirfile_map256-4
		dc.w .lz-DOS_dirfile_map256-6
		dc.w .mz-DOS_dirfile_map256-8
		dc.w .ow-DOS_dirfile_map256-10
		dc.w .sbz-DOS_dirfile_map256-12
		dc.w .slz-DOS_dirfile_map256-14
		dc.w .syz-DOS_dirfile_map256-16


.ghz:	dc.b 7-1
		DOS_String 'BIN ghz'

.ghz1:	dc.b 8-1, 0
		DOS_String 'BIN ghz1'

.lz:	dc.b 6-1, 0
		DOS_String 'BIN lz'

.mz:	dc.b 6-1, 0
		DOS_String 'BIN mz'

.ow:	dc.b 6-1, 0
		DOS_String 'BIN ow'

.sbz:	dc.b 7-1
		DOS_String 'BIN sbz'

.slz:	dc.b 7-1
		DOS_String 'BIN slz'

.syz:	dc.b 7-1
		DOS_String 'BIN syz'


		dc.w 6-1
DOS_dirfile_mapeni:
		dc.w .japcreds-DOS_dirfile_mapeni-2
		dc.w .segalogo-DOS_dirfile_mapeni-4
		dc.w .ssbg1-DOS_dirfile_mapeni-6
		dc.w .ssbg2-DOS_dirfile_mapeni-8
		dc.w .titlescr-DOS_dirfile_mapeni-10
		dc.w DOS_null-DOS_dirfile_levels-12


.japcreds:	dc.b 12-1, 0
		DOS_String 'BIN japcreds'

.segalogo:	dc.b 12-1, 0
		DOS_String 'BIN segalogo'

.ssbg1:	dc.b 9-1
		DOS_String 'BIN ssbg1'

.ssbg2:	dc.b 9-1
		DOS_String 'BIN ssbg2'

.titlescr:	dc.b 12-1, 0
		DOS_String 'BIN titlescr'


		dc.w 30-1
DOS_dirfile_misc:
		dc.w .angles-DOS_dirfile_misc-2
		dc.w .dm_ord1-DOS_dirfile_misc-4
		dc.w .dm_ord2-DOS_dirfile_misc-6
		dc.w .ghzbend1-DOS_dirfile_misc-8
		dc.w .ghzbend2-DOS_dirfile_misc-10
		dc.w .ghzledge-DOS_dirfile_misc-12
		dc.w .loopnums-DOS_dirfile_misc-14
		dc.w .ls_jcode-DOS_dirfile_misc-16
		dc.w .ls_point-DOS_dirfile_misc-18
		dc.w .ls_ucode-DOS_dirfile_misc-20
		dc.w .menutext-DOS_dirfile_misc-22
		dc.w .muslist1-DOS_dirfile_misc-24
		dc.w .muslist2-DOS_dirfile_misc-26
		dc.w .mz_pfm1-DOS_dirfile_misc-28
		dc.w .mz_pfm2-DOS_dirfile_misc-30
		dc.w .mz_pfm3-DOS_dirfile_misc-32
		dc.w .Orbs-DOS_dirfile_misc-34
		dc.w .padding-DOS_dirfile_misc-36
		dc.w .padding2-DOS_dirfile_misc-38
		dc.w .padding3-DOS_dirfile_misc-40
		dc.w .padding4-DOS_dirfile_misc-42
		dc.w .sinewave-DOS_dirfile_misc-44
		dc.w .sloc_end-DOS_dirfile_misc-46
		dc.w .sloc_lev-DOS_dirfile_misc-48
		dc.w .sloc_ss-DOS_dirfile_misc-50
		dc.w .slzssaw1-DOS_dirfile_misc-52
		dc.w .slzssaw2-DOS_dirfile_misc-54
		dc.w .titleart-DOS_dirfile_misc-56
		dc.w .titlemap-DOS_dirfile_misc-58
		dc.w .titlepal-DOS_dirfile_misc-60


.angles:	dc.b 10-1, 0
		DOS_String 'BIN angles'

.dm_ord1:	dc.b 11-1
		DOS_String 'BIN dm_ord1'

.dm_ord2:	dc.b 11-1
		DOS_String 'BIN dm_ord2'

.ghzbend1:	dc.b 12-1, 0
		DOS_String 'BIN ghzbend1'

.ghzbend2:	dc.b 12-1, 0
		DOS_String 'BIN ghzbend2'

.ghzledge:	dc.b 12-1, 0
		DOS_String 'BIN ghzledge'

.loopnums:	dc.b 12-1, 0
		DOS_String 'BIN loopnums'

.ls_jcode:	dc.b 12-1, 0
		DOS_String 'BIN ls_jcode'

.ls_point:	dc.b 12-1, 0
		DOS_String 'BIN ls_point'

.ls_ucode:	dc.b 12-1, 0
		DOS_String 'BIN ls_ucode'

.menutext:	dc.b 12-1, 0
		DOS_String 'BIN menutext'

.muslist1:	dc.b 12-1, 0
		DOS_String 'BIN muslist1'

.muslist2:	dc.b 12-1, 0
		DOS_String 'BIN muslist2'

.mz_pfm1:	dc.b 11-1
		DOS_String 'BIN mz_pfm1'

.mz_pfm2:	dc.b 11-1
		DOS_String 'BIN mz_pfm2'

.mz_pfm3:	dc.b 11-1
		DOS_String 'BIN mz_pfm3'

.Orbs:	dc.b 8-1, 0
		DOS_String 'DAT Orbs'

.padding:	dc.b 11-1
		DOS_String 'BIN padding'

.padding2:	dc.b 12-1, 0
		DOS_String 'BIN padding2'

.padding3:	dc.b 12-1, 0
		DOS_String 'BIN padding3'

.padding4:	dc.b 12-1, 0
		DOS_String 'BIN padding4'

.sinewave:	dc.b 12-1, 0
		DOS_String 'BIN sinewave'

.sloc_end:	dc.b 12-1, 0
		DOS_String 'BIN sloc_end'

.sloc_lev:	dc.b 12-1, 0
		DOS_String 'BIN sloc_lev'

.sloc_ss:	dc.b 11-1
		DOS_String 'BIN sloc_ss'

.slzssaw1:	dc.b 12-1, 0
		DOS_String 'BIN slzssaw1'

.slzssaw2:	dc.b 12-1, 0
		DOS_String 'BIN slzssaw2'

.titleart:	dc.b 12-1, 0
		DOS_String 'BIN titleart'

.titlemap:	dc.b 12-1, 0
		DOS_String 'BIN titlemap'

.titlepal:	dc.b 12-1, 0
		DOS_String 'BIN titlepal'


		dc.w 42-1
DOS_dirfile_objpos:
		dc.w .ending-DOS_dirfile_objpos-2
		dc.w .fz-DOS_dirfile_objpos-4
		dc.w .ghz1-DOS_dirfile_objpos-6
		dc.w .ghz12-DOS_dirfile_objpos-8
		dc.w .ghz2-DOS_dirfile_objpos-10
		dc.w .ghz3-DOS_dirfile_objpos-12
		dc.w .ghz4-DOS_dirfile_objpos-14
		dc.w .ghzSC-DOS_dirfile_objpos-16
		dc.w .lz1-DOS_dirfile_objpos-18
		dc.w .lz1pf1-DOS_dirfile_objpos-20
		dc.w .lz1pf2-DOS_dirfile_objpos-22
		dc.w .lz2-DOS_dirfile_objpos-24
		dc.w .lz2pf1-DOS_dirfile_objpos-26
		dc.w .lz2pf2-DOS_dirfile_objpos-28
		dc.w .lz3-DOS_dirfile_objpos-30
		dc.w .lz3pf1-DOS_dirfile_objpos-32
		dc.w .lz3pf2-DOS_dirfile_objpos-34
		dc.w .lz6-DOS_dirfile_objpos-36
		dc.w .mz1-DOS_dirfile_objpos-38
		dc.w .mz2-DOS_dirfile_objpos-40
		dc.w .mz3-DOS_dirfile_objpos-42
		dc.w .mz4-DOS_dirfile_objpos-44
		dc.w .ow1-DOS_dirfile_objpos-46
		dc.w .sbz1-DOS_dirfile_objpos-48
		dc.w .sbz1pf1-DOS_dirfile_objpos-50
		dc.w .sbz1pf2-DOS_dirfile_objpos-52
		dc.w .sbz1pf3-DOS_dirfile_objpos-54
		dc.w .sbz1pf4-DOS_dirfile_objpos-56
		dc.w .sbz1pf5-DOS_dirfile_objpos-58
		dc.w .sbz1pf6-DOS_dirfile_objpos-60
		dc.w .sbz2-DOS_dirfile_objpos-62
		dc.w .sbz3-DOS_dirfile_objpos-64
		dc.w .sbz4-DOS_dirfile_objpos-66
		dc.w .slz1-DOS_dirfile_objpos-68
		dc.w .slz2-DOS_dirfile_objpos-70
		dc.w .slz3-DOS_dirfile_objpos-72
		dc.w .slz4-DOS_dirfile_objpos-74
		dc.w .syz1-DOS_dirfile_objpos-76
		dc.w .syz2-DOS_dirfile_objpos-78
		dc.w .syz3-DOS_dirfile_objpos-80
		dc.w .syz4-DOS_dirfile_objpos-82
		dc.w DOS_null-DOS_dirfile_levels-84


.ending:	dc.b 10-1, 0
		DOS_String 'BIN ending'

.fz:	dc.b 6-1, 0
		DOS_String 'BIN fz'

.ghz1:	dc.b 8-1, 0
		DOS_String 'BIN ghz1'

.ghz12:	dc.b 9-1
		DOS_String 'BIN ghz12'

.ghz2:	dc.b 8-1, 0
		DOS_String 'BIN ghz2'

.ghz3:	dc.b 8-1, 0
		DOS_String 'BIN ghz3'

.ghz4:	dc.b 8-1, 0
		DOS_String 'BIN ghz4'

.ghzSC:	dc.b 9-1
		DOS_String 'BIN ghzSC'

.lz1:	dc.b 7-1
		DOS_String 'BIN lz1'

.lz1pf1:	dc.b 10-1, 0
		DOS_String 'BIN lz1pf1'

.lz1pf2:	dc.b 10-1, 0
		DOS_String 'BIN lz1pf2'

.lz2:	dc.b 7-1
		DOS_String 'BIN lz2'

.lz2pf1:	dc.b 10-1, 0
		DOS_String 'BIN lz2pf1'

.lz2pf2:	dc.b 10-1, 0
		DOS_String 'BIN lz2pf2'

.lz3:	dc.b 7-1
		DOS_String 'BIN lz3'

.lz3pf1:	dc.b 10-1, 0
		DOS_String 'BIN lz3pf1'

.lz3pf2:	dc.b 10-1, 0
		DOS_String 'BIN lz3pf2'

.lz6:	dc.b 7-1
		DOS_String 'BIN lz6'

.mz1:	dc.b 7-1
		DOS_String 'BIN mz1'

.mz2:	dc.b 7-1
		DOS_String 'BIN mz2'

.mz3:	dc.b 7-1
		DOS_String 'BIN mz3'

.mz4:	dc.b 7-1
		DOS_String 'BIN mz4'

.ow1:	dc.b 7-1
		DOS_String 'BIN ow1'

.sbz1:	dc.b 8-1, 0
		DOS_String 'BIN sbz1'

.sbz1pf1:	dc.b 11-1
		DOS_String 'BIN sbz1pf1'

.sbz1pf2:	dc.b 11-1
		DOS_String 'BIN sbz1pf2'

.sbz1pf3:	dc.b 11-1
		DOS_String 'BIN sbz1pf3'

.sbz1pf4:	dc.b 11-1
		DOS_String 'BIN sbz1pf4'

.sbz1pf5:	dc.b 11-1
		DOS_String 'BIN sbz1pf5'

.sbz1pf6:	dc.b 11-1
		DOS_String 'BIN sbz1pf6'

.sbz2:	dc.b 8-1, 0
		DOS_String 'BIN sbz2'

.sbz3:	dc.b 8-1, 0
		DOS_String 'BIN sbz3'

.sbz4:	dc.b 8-1, 0
		DOS_String 'BIN sbz4'

.slz1:	dc.b 8-1, 0
		DOS_String 'BIN slz1'

.slz2:	dc.b 8-1, 0
		DOS_String 'BIN slz2'

.slz3:	dc.b 8-1, 0
		DOS_String 'BIN slz3'

.slz4:	dc.b 8-1, 0
		DOS_String 'BIN slz4'

.syz1:	dc.b 8-1, 0
		DOS_String 'BIN syz1'

.syz2:	dc.b 8-1, 0
		DOS_String 'BIN syz2'

.syz3:	dc.b 8-1, 0
		DOS_String 'BIN syz3'

.syz4:	dc.b 8-1, 0
		DOS_String 'BIN syz4'


		dc.w 76-1
DOS_dirfile_palette:
		dc.w .1_B-DOS_dirfile_palette-2
		dc.w .c_ghz-DOS_dirfile_palette-4
		dc.w .c_lz_bel-DOS_dirfile_palette-6
		dc.w .c_lz_buw-DOS_dirfile_palette-8
		dc.w .c_lz_wat-DOS_dirfile_palette-10
		dc.w .c_sbz3_w-DOS_dirfile_palette-12
		dc.w .c_sbz_1-DOS_dirfile_palette-14
		dc.w .c_sbz_10-DOS_dirfile_palette-16
		dc.w .c_sbz_2-DOS_dirfile_palette-18
		dc.w .c_sbz_3-DOS_dirfile_palette-20
		dc.w .c_sbz_4-DOS_dirfile_palette-22
		dc.w .c_sbz_5-DOS_dirfile_palette-24
		dc.w .c_sbz_6-DOS_dirfile_palette-26
		dc.w .c_sbz_7-DOS_dirfile_palette-28
		dc.w .c_sbz_8-DOS_dirfile_palette-30
		dc.w .c_sbz_9-DOS_dirfile_palette-32
		dc.w .c_slz-DOS_dirfile_palette-34
		dc.w .c_ss_1-DOS_dirfile_palette-36
		dc.w .c_ss_2-DOS_dirfile_palette-38
		dc.w .c_syz_1-DOS_dirfile_palette-40
		dc.w .c_syz_2-DOS_dirfile_palette-42
		dc.w .c_title-DOS_dirfile_palette-44
		dc.w .ending-DOS_dirfile_palette-46
		dc.w .ghz-DOS_dirfile_palette-48
		dc.w .Knux-DOS_dirfile_palette-50
		dc.w .Knux2-DOS_dirfile_palette-52
		dc.w .KnuxE-DOS_dirfile_palette-54
		dc.w .KnuxM-DOS_dirfile_palette-56
		dc.w .KnuxN-DOS_dirfile_palette-58
		dc.w .Knuxuw-DOS_dirfile_palette-60
		dc.w .levelsel-DOS_dirfile_palette-62
		dc.w .lz-DOS_dirfile_palette-64
		dc.w .lz_uw-DOS_dirfile_palette-66
		dc.w .lz_uw.bin-DOS_dirfile_palette-68
		dc.w .lz_uw2-DOS_dirfile_palette-70
		dc.w .mz-DOS_dirfile_palette-72
		dc.w .ow-DOS_dirfile_palette-74
		dc.w .ow2-DOS_dirfile_palette-76
		dc.w .ow3-DOS_dirfile_palette-78
		dc.w .ow4-DOS_dirfile_palette-80
		dc.w .sbz2_1-DOS_dirfile_palette-82
		dc.w .sbz2_2-DOS_dirfile_palette-84
		dc.w .sbz2_3-DOS_dirfile_palette-86
		dc.w .sbz2_4-DOS_dirfile_palette-88
		dc.w .sbz2_5-DOS_dirfile_palette-90
		dc.w .sbz2_6-DOS_dirfile_palette-92
		dc.w .sbz2_7-DOS_dirfile_palette-94
		dc.w .sbz2_8-DOS_dirfile_palette-96
		dc.w .sbz_a3uw-DOS_dirfile_palette-98
		dc.w .sbz_act1-DOS_dirfile_palette-100
		dc.w .sbz_act2-DOS_dirfile_palette-102
		dc.w .sbz_act3-DOS_dirfile_palette-104
		dc.w .sega1-DOS_dirfile_palette-106
		dc.w .sega2-DOS_dirfile_palette-108
		dc.w .sega_bg-DOS_dirfile_palette-110
		dc.w .slz-DOS_dirfile_palette-112
		dc.w .sonic-DOS_dirfile_palette-114
		dc.w .Sonic2-DOS_dirfile_palette-116
		dc.w .SonicE-DOS_dirfile_palette-118
		dc.w .SonicM-DOS_dirfile_palette-120
		dc.w .SonicN-DOS_dirfile_palette-122
		dc.w .son_lzuw-DOS_dirfile_palette-124
		dc.w .son_sbzu-DOS_dirfile_palette-126
		dc.w .special-DOS_dirfile_palette-128
		dc.w .sscontin-DOS_dirfile_palette-130
		dc.w .ssresult-DOS_dirfile_palette-132
		dc.w .syz-DOS_dirfile_palette-134
		dc.w .tails-DOS_dirfile_palette-136
		dc.w .tails2-DOS_dirfile_palette-138
		dc.w .tailsE-DOS_dirfile_palette-140
		dc.w .tailsM-DOS_dirfile_palette-142
		dc.w .tailsN-DOS_dirfile_palette-144
		dc.w .tailsuw-DOS_dirfile_palette-146
		dc.w .title-DOS_dirfile_palette-148
		dc.w .titlepal-DOS_dirfile_palette-150


.1_B:	dc.b 7-1
		DOS_String 'BIN 1_B'

.c_ghz:	dc.b 9-1
		DOS_String 'BIN c_ghz'

.c_lz_bel:	dc.b 12-1, 0
		DOS_String 'BIN c_lz_bel'

.c_lz_buw:	dc.b 12-1, 0
		DOS_String 'BIN c_lz_buw'

.c_lz_wat:	dc.b 12-1, 0
		DOS_String 'BIN c_lz_wat'

.c_sbz3_w:	dc.b 12-1, 0
		DOS_String 'BIN c_sbz3_w'

.c_sbz_1:	dc.b 11-1
		DOS_String 'BIN c_sbz_1'

.c_sbz_10:	dc.b 12-1, 0
		DOS_String 'BIN c_sbz_10'

.c_sbz_2:	dc.b 11-1
		DOS_String 'BIN c_sbz_2'

.c_sbz_3:	dc.b 11-1
		DOS_String 'BIN c_sbz_3'

.c_sbz_4:	dc.b 11-1
		DOS_String 'BIN c_sbz_4'

.c_sbz_5:	dc.b 11-1
		DOS_String 'BIN c_sbz_5'

.c_sbz_6:	dc.b 11-1
		DOS_String 'BIN c_sbz_6'

.c_sbz_7:	dc.b 11-1
		DOS_String 'BIN c_sbz_7'

.c_sbz_8:	dc.b 11-1
		DOS_String 'BIN c_sbz_8'

.c_sbz_9:	dc.b 11-1
		DOS_String 'BIN c_sbz_9'

.c_slz:	dc.b 9-1
		DOS_String 'BIN c_slz'

.c_ss_1:	dc.b 10-1, 0
		DOS_String 'BIN c_ss_1'

.c_ss_2:	dc.b 10-1, 0
		DOS_String 'BIN c_ss_2'

.c_syz_1:	dc.b 11-1
		DOS_String 'BIN c_syz_1'

.c_syz_2:	dc.b 11-1
		DOS_String 'BIN c_syz_2'

.c_title:	dc.b 11-1
		DOS_String 'BIN c_title'

.ending:	dc.b 10-1, 0
		DOS_String 'BIN ending'

.ghz:	dc.b 7-1
		DOS_String 'BIN ghz'

.Knux:	dc.b 8-1, 0
		DOS_String 'BIN Knux'

.Knux2:	dc.b 9-1
		DOS_String 'BIN Knux2'

.KnuxE:	dc.b 9-1
		DOS_String 'BIN KnuxE'

.KnuxM:	dc.b 9-1
		DOS_String 'BIN KnuxM'

.KnuxN:	dc.b 9-1
		DOS_String 'BIN KnuxN'

.Knuxuw:	dc.b 10-1, 0
		DOS_String 'BIN Knuxuw'

.levelsel:	dc.b 12-1, 0
		DOS_String 'BIN levelsel'

.lz:	dc.b 6-1, 0
		DOS_String 'BIN lz'

.lz_uw:	dc.b 9-1
		DOS_String 'BIN lz_uw'

.lz_uw.bin:	dc.b 13-1
		DOS_String 'BAK lz_uw.bin'

.lz_uw2:	dc.b 10-1, 0
		DOS_String 'BIN lz_uw2'

.mz:	dc.b 6-1, 0
		DOS_String 'BIN mz'

.ow:	dc.b 6-1, 0
		DOS_String 'BIN ow'

.ow2:	dc.b 7-1
		DOS_String 'BIN ow2'

.ow3:	dc.b 7-1
		DOS_String 'BIN ow3'

.ow4:	dc.b 7-1
		DOS_String 'BIN ow4'

.sbz2_1:	dc.b 10-1, 0
		DOS_String 'BIN sbz2_1'

.sbz2_2:	dc.b 10-1, 0
		DOS_String 'BIN sbz2_2'

.sbz2_3:	dc.b 10-1, 0
		DOS_String 'BIN sbz2_3'

.sbz2_4:	dc.b 10-1, 0
		DOS_String 'BIN sbz2_4'

.sbz2_5:	dc.b 10-1, 0
		DOS_String 'BIN sbz2_5'

.sbz2_6:	dc.b 10-1, 0
		DOS_String 'BIN sbz2_6'

.sbz2_7:	dc.b 10-1, 0
		DOS_String 'BIN sbz2_7'

.sbz2_8:	dc.b 10-1, 0
		DOS_String 'BIN sbz2_8'

.sbz_a3uw:	dc.b 12-1, 0
		DOS_String 'BIN sbz_a3uw'

.sbz_act1:	dc.b 12-1, 0
		DOS_String 'BIN sbz_act1'

.sbz_act2:	dc.b 12-1, 0
		DOS_String 'BIN sbz_act2'

.sbz_act3:	dc.b 12-1, 0
		DOS_String 'BIN sbz_act3'

.sega1:	dc.b 9-1
		DOS_String 'BIN sega1'

.sega2:	dc.b 9-1
		DOS_String 'BIN sega2'

.sega_bg:	dc.b 11-1
		DOS_String 'BIN sega_bg'

.slz:	dc.b 7-1
		DOS_String 'BIN slz'

.sonic:	dc.b 9-1
		DOS_String 'BIN sonic'

.Sonic2:	dc.b 10-1, 0
		DOS_String 'BIN Sonic2'

.SonicE:	dc.b 10-1, 0
		DOS_String 'BIN SonicE'

.SonicM:	dc.b 10-1, 0
		DOS_String 'BIN SonicM'

.SonicN:	dc.b 10-1, 0
		DOS_String 'BIN SonicN'

.son_lzuw:	dc.b 12-1, 0
		DOS_String 'BIN son_lzuw'

.son_sbzu:	dc.b 12-1, 0
		DOS_String 'BIN son_sbzu'

.special:	dc.b 11-1
		DOS_String 'BIN special'

.sscontin:	dc.b 12-1, 0
		DOS_String 'BIN sscontin'

.ssresult:	dc.b 12-1, 0
		DOS_String 'BIN ssresult'

.syz:	dc.b 7-1
		DOS_String 'BIN syz'

.tails:	dc.b 9-1
		DOS_String 'BIN tails'

.tails2:	dc.b 10-1, 0
		DOS_String 'BIN tails2'

.tailsE:	dc.b 10-1, 0
		DOS_String 'BIN tailsE'

.tailsM:	dc.b 10-1, 0
		DOS_String 'BIN tailsM'

.tailsN:	dc.b 10-1, 0
		DOS_String 'BIN tailsN'

.tailsuw:	dc.b 11-1
		DOS_String 'BIN tailsuw'

.title:	dc.b 9-1
		DOS_String 'BIN title'

.titlepal:	dc.b 12-1, 0
		DOS_String 'BIN titlepal'



		dc.w 18-1
DOS_dirfile_s3k:
		dc.w .Anim_S3_-DOS_dirfile_s3k-2
		dc.w .Anim_S3_2-DOS_dirfile_s3k-4
		dc.w .Anim_S3_3-DOS_dirfile_s3k-6
		dc.w .Anim_SK_-DOS_dirfile_s3k-8
		dc.w .Map_ANDK-DOS_dirfile_s3k-10
		dc.w .Map_S3_A-DOS_dirfile_s3k-12
		dc.w .Map_S3_B-DOS_dirfile_s3k-14
		dc.w .Map_S3_c-DOS_dirfile_s3k-16
		dc.w .Map_S3_S-DOS_dirfile_s3k-18
		dc.w .Map_S3_S3-DOS_dirfile_s3k-20
		dc.w .Map_S3_T-DOS_dirfile_s3k-22
		dc.w .Map_SK_B-DOS_dirfile_s3k-24
		dc.w .Map_SK_C-DOS_dirfile_s3k-26
		dc.w .Map_SK_D-DOS_dirfile_s3k-28
		dc.w .Map_SK_I-DOS_dirfile_s3k-30
		dc.w .Map_SK_M-DOS_dirfile_s3k-32
		dc.w .Map_SK_S2-DOS_dirfile_s3k-34
		dc.w .Map_SK_T-DOS_dirfile_s3k-36


.Anim_S3_:	dc.b 19-1
		DOS_String 'ASM AnimSonicFinger'

.Anim_S3_2:	dc.b 19-1
		DOS_String 'ASM Anim Sonic Wink'

.Anim_S3_3:	dc.b 19-1
		DOS_String 'ASM Anim TailsPlane'

.Anim_SK_:	dc.b 13-1
		DOS_String 'ASM Anim Icon'

.Map_ANDK:	dc.b 19-1
		DOS_String 'ASM Map ANDKnuckles'

.Map_S3_A:	dc.b 19-1
		DOS_String 'ASM Map ANDKnuckle_'

.Map_S3_B:	dc.b 15-1
		DOS_String 'ASM Map Banner3'

.Map_S3_c:	dc.b 12-1, 0
		DOS_String 'ASM Map card'

.Map_S3_S:	dc.b 19-1
		DOS_String 'ASM Map Screen Text'

.Map_S3_S3:	dc.b 18-1, 0
		DOS_String 'ASM Map Sonic Anim'

.Map_S3_T:	dc.b 19-1
		DOS_String 'ASM Map Tails Plane'

.Map_SK_B:	dc.b 15-1
		DOS_String 'ASM Map BannerK'

.Map_SK_C:	dc.b 17-1
		DOS_String 'ASM Map Copyright'

.Map_SK_D:	dc.b 17-1
		DOS_String 'ASM Map Death Egg'

.Map_SK_I:	dc.b 12-1, 0
		DOS_String 'ASM Map Icon'

.Map_SK_M:	dc.b 16-1, 0
		DOS_String 'ASM Map Mountain'

.Map_SK_S2:	dc.b 18-1, 0
		DOS_String 'ASM Map Sonic Fall'

.Map_SK_T:	dc.b 10-1, 0
		DOS_String 'ASM Map TM'


		dc.w 8-1
DOS_dirfile_s3l:
		dc.w .2P_Options-DOS_dirfile_s3l-2
		dc.w .2P_Options2-DOS_dirfile_s3l-4
		dc.w .inc-DOS_dirfile_s3l-6
		dc.w .main-DOS_dirfile_s3l-8
		dc.w .map-DOS_dirfile_s3l-10
		dc.w .Signpost-DOS_dirfile_s3l-12
		dc.w .SonicAndTa-DOS_dirfile_s3l-14
		dc.w .SONICMILES-DOS_dirfile_s3l-16


.2P_Options:	dc.b 18-1, 0
		DOS_String 'BIN 2P Options Eni'

.2P_Options2:	dc.b 14-1, 0
		DOS_String 'BIN 2P Options'

.inc:	dc.b 7-1
		DOS_String 'ASM inc'

.main:	dc.b 8-1, 0
		DOS_String 'ASM main'

.map:	dc.b 7-1
		DOS_String 'BIN map'

.Signpost:	dc.b 12-1, 0
		DOS_String 'BIN Signpost'

.SonicAndTa:	dc.b 19-1
		DOS_String 'BIN SonicAndTailsS2'

.SONICMILES:	dc.b 14-1, 0
		DOS_String 'BIN SONICMILES'


DOS_dirfile_smps:
		dc.w .smps-DOS_dirfile_smps-2
		dc.w .ext-DOS_dirfile_smps-4

.smps		dc.b 12-1, 0
		DOS_String 'ASM swa.smps'

.ext		dc.b 16-1, 0
		DOS_String 'ASM swa.smps.ext'


		dc.w 154-1
DOS_dirfile_sound:
		dc.w .81-DOS_dirfile_sound-2
		dc.w .86-DOS_dirfile_sound-4
		dc.w .8F-DOS_dirfile_sound-6
		dc.w .90_93-DOS_dirfile_sound-8
		dc.w .bakamenu-DOS_dirfile_sound-10
		dc.w .crash-DOS_dirfile_sound-12
		dc.w .c_hat-DOS_dirfile_sound-14
		dc.w .dac10-DOS_dirfile_sound-16
		dc.w .dac1d-DOS_dirfile_sound-18
		dc.w .dac2d-DOS_dirfile_sound-20
		dc.w .dac3d-DOS_dirfile_sound-22
		dc.w .dac4d-DOS_dirfile_sound-24
		dc.w .dac5d-DOS_dirfile_sound-26
		dc.w .dac6d-DOS_dirfile_sound-28
		dc.w .dac7d-DOS_dirfile_sound-30
		dc.w .dac9-DOS_dirfile_sound-32
		dc.w .dacA-DOS_dirfile_sound-34
		dc.w .dacB-DOS_dirfile_sound-36
		dc.w .dacC-DOS_dirfile_sound-38
		dc.w .dacD-DOS_dirfile_sound-40
		dc.w .dacE-DOS_dirfile_sound-42
		dc.w .dacF-DOS_dirfile_sound-44
		dc.w .dacpitched-DOS_dirfile_sound-46
		dc.w .dancesnare-DOS_dirfile_sound-48
		dc.w .eletricsou-DOS_dirfile_sound-50
		dc.w .em00-DOS_dirfile_sound-52
		dc.w .em08-DOS_dirfile_sound-54
		dc.w .em22-DOS_dirfile_sound-56
		dc.w .mmx_sigma_-DOS_dirfile_sound-58
		dc.w .music81-DOS_dirfile_sound-60
		dc.w .music82-DOS_dirfile_sound-62
		dc.w .music83-DOS_dirfile_sound-64
		dc.w .music84-DOS_dirfile_sound-66
		dc.w .music85-DOS_dirfile_sound-68
		dc.w .music86-DOS_dirfile_sound-70
		dc.w .music87-DOS_dirfile_sound-72
		dc.w .music88-DOS_dirfile_sound-74
		dc.w .music89-DOS_dirfile_sound-76
		dc.w .music8A-DOS_dirfile_sound-78
		dc.w .music8B-DOS_dirfile_sound-80
		dc.w .music8C-DOS_dirfile_sound-82
		dc.w .music8D-DOS_dirfile_sound-84
		dc.w .music8E-DOS_dirfile_sound-86
		dc.w .music8F-DOS_dirfile_sound-88
		dc.w .music90-DOS_dirfile_sound-90
		dc.w .music91-DOS_dirfile_sound-92
		dc.w .music92-DOS_dirfile_sound-94
		dc.w .music93-DOS_dirfile_sound-96
		dc.w .musicE5-DOS_dirfile_sound-98
		dc.w .musice6-DOS_dirfile_sound-100
		dc.w .musice7-DOS_dirfile_sound-102
		dc.w .musice8-DOS_dirfile_sound-104
		dc.w .musicE9-DOS_dirfile_sound-106
		dc.w .musicEA-DOS_dirfile_sound-108
		dc.w .musicEB-DOS_dirfile_sound-110
		dc.w .musicEC-DOS_dirfile_sound-112
		dc.w .musicED-DOS_dirfile_sound-114
		dc.w .musicEE-DOS_dirfile_sound-116
		dc.w .musicEF-DOS_dirfile_sound-118
		dc.w .musicF0-DOS_dirfile_sound-120
		dc.w .OperaOfEgg-DOS_dirfile_sound-122
		dc.w .o_hat-DOS_dirfile_sound-124
		dc.w .powerkick-DOS_dirfile_sound-126
		dc.w .powersnare-DOS_dirfile_sound-128
		dc.w .powertom-DOS_dirfile_sound-130
		dc.w .psg1-DOS_dirfile_sound-132
		dc.w .psg2-DOS_dirfile_sound-134
		dc.w .psg3-DOS_dirfile_sound-136
		dc.w .psg4-DOS_dirfile_sound-138
		dc.w .psg5-DOS_dirfile_sound-140
		dc.w .psg6-DOS_dirfile_sound-142
		dc.w .psg7-DOS_dirfile_sound-144
		dc.w .psg8-DOS_dirfile_sound-146
		dc.w .psg9-DOS_dirfile_sound-148
		dc.w .rvcym-DOS_dirfile_sound-150
		dc.w .s2b_D8-DOS_dirfile_sound-152
		dc.w .S3KSpecial-DOS_dirfile_sound-154
		dc.w .Slots-DOS_dirfile_sound-156
		dc.w .Sonic3Titl-DOS_dirfile_sound-158
		dc.w .Sonic3Titl2-DOS_dirfile_sound-160
		dc.w .sound94-DOS_dirfile_sound-162
		dc.w .sound95-DOS_dirfile_sound-164
		dc.w .sound96-DOS_dirfile_sound-166
		dc.w .sound97-DOS_dirfile_sound-168
		dc.w .sound98-DOS_dirfile_sound-170
		dc.w .sound99-DOS_dirfile_sound-172
		dc.w .sound9A-DOS_dirfile_sound-174
		dc.w .sound9B-DOS_dirfile_sound-176
		dc.w .soundA0-DOS_dirfile_sound-178
		dc.w .soundA1-DOS_dirfile_sound-180
		dc.w .soundA2-DOS_dirfile_sound-182
		dc.w .soundA3-DOS_dirfile_sound-184
		dc.w .soundA4-DOS_dirfile_sound-186
		dc.w .soundA5-DOS_dirfile_sound-188
		dc.w .soundA6-DOS_dirfile_sound-190
		dc.w .soundA7-DOS_dirfile_sound-192
		dc.w .soundA8-DOS_dirfile_sound-194
		dc.w .soundA9-DOS_dirfile_sound-196
		dc.w .soundAA-DOS_dirfile_sound-198
		dc.w .soundAB-DOS_dirfile_sound-200
		dc.w .soundAC-DOS_dirfile_sound-202
		dc.w .soundAD-DOS_dirfile_sound-204
		dc.w .soundAE-DOS_dirfile_sound-206
		dc.w .soundAF-DOS_dirfile_sound-208
		dc.w .soundB0-DOS_dirfile_sound-210
		dc.w .soundB1-DOS_dirfile_sound-212
		dc.w .soundB2-DOS_dirfile_sound-214
		dc.w .soundB3-DOS_dirfile_sound-216
		dc.w .soundB4-DOS_dirfile_sound-218
		dc.w .soundB5-DOS_dirfile_sound-220
		dc.w .soundB6-DOS_dirfile_sound-222
		dc.w .soundB7-DOS_dirfile_sound-224
		dc.w .soundB8-DOS_dirfile_sound-226
		dc.w .soundB9-DOS_dirfile_sound-228
		dc.w .soundBA-DOS_dirfile_sound-230
		dc.w .soundBB-DOS_dirfile_sound-232
		dc.w .soundBC-DOS_dirfile_sound-234
		dc.w .soundBD-DOS_dirfile_sound-236
		dc.w .soundBE-DOS_dirfile_sound-238
		dc.w .soundBF-DOS_dirfile_sound-240
		dc.w .soundC0-DOS_dirfile_sound-242
		dc.w .soundC1-DOS_dirfile_sound-244
		dc.w .soundC2-DOS_dirfile_sound-246
		dc.w .soundC3-DOS_dirfile_sound-248
		dc.w .soundC4-DOS_dirfile_sound-250
		dc.w .soundC5-DOS_dirfile_sound-252
		dc.w .soundC6-DOS_dirfile_sound-254
		dc.w .soundC7-DOS_dirfile_sound-256
		dc.w .soundC8-DOS_dirfile_sound-258
		dc.w .soundC9-DOS_dirfile_sound-260
		dc.w .soundCA-DOS_dirfile_sound-262
		dc.w .soundCB-DOS_dirfile_sound-264
		dc.w .soundCC-DOS_dirfile_sound-266
		dc.w .soundCD-DOS_dirfile_sound-268
		dc.w .soundCE-DOS_dirfile_sound-270
		dc.w .soundCF-DOS_dirfile_sound-272
		dc.w .soundD0-DOS_dirfile_sound-274
		dc.w .soundD1-DOS_dirfile_sound-276
		dc.w .TF3_boss2-DOS_dirfile_sound-278
		dc.w .TF3_BossRe-DOS_dirfile_sound-280
		dc.w .TF4_BossRe-DOS_dirfile_sound-282
		dc.w .TF4_Config-DOS_dirfile_sound-284
		dc.w .TF_st5-DOS_dirfile_sound-286
		dc.w .whirlwind-DOS_dirfile_sound-288
		dc.w .z80-DOS_dirfile_sound-290
		dc.w .z80_1-DOS_dirfile_sound-292
		dc.w .z80_2-DOS_dirfile_sound-294
		dc.w .Z80_BGM_0C-DOS_dirfile_sound-296
		dc.w .Z80_BGM_No-DOS_dirfile_sound-298
		dc.w .z80_drv-DOS_dirfile_sound-300
		dc.w .Z80_MusicB-DOS_dirfile_sound-302
		dc.w .Z80_MusicB2-DOS_dirfile_sound-304
		dc.w .Z80_MusicB3-DOS_dirfile_sound-306
		dc.w .z80_new-DOS_dirfile_sound-308
		dc.w .z80_newu-DOS_dirfile_sound-310


.81:	dc.b 6-1, 0
		DOS_String 'BIN 81'

.86:	dc.b 6-1, 0
		DOS_String 'BIN 86'

.8F:	dc.b 6-1, 0
		DOS_String 'BIN 8F'

.90_93:	dc.b 9-1
		DOS_String 'BIN 90-93'

.bakamenu:	dc.b 12-1, 0
		DOS_String 'BIN bakamenu'

.crash:	dc.b 9-1
		DOS_String 'BIN crash'

.c_hat:	dc.b 9-1
		DOS_String 'BIN c_hat'

.dac10:	dc.b 9-1
		DOS_String 'BIN dac10'

.dac1d:	dc.b 9-1
		DOS_String 'BIN dac1d'

.dac2d:	dc.b 9-1
		DOS_String 'BIN dac2d'

.dac3d:	dc.b 9-1
		DOS_String 'BIN dac3d'

.dac4d:	dc.b 9-1
		DOS_String 'BIN dac4d'

.dac5d:	dc.b 9-1
		DOS_String 'BIN dac5d'

.dac6d:	dc.b 9-1
		DOS_String 'BIN dac6d'

.dac7d:	dc.b 9-1
		DOS_String 'BIN dac7d'

.dac9:	dc.b 8-1, 0
		DOS_String 'BIN dac9'

.dacA:	dc.b 8-1, 0
		DOS_String 'BIN dacA'

.dacB:	dc.b 8-1, 0
		DOS_String 'BIN dacB'

.dacC:	dc.b 8-1, 0
		DOS_String 'BIN dacC'

.dacD:	dc.b 8-1, 0
		DOS_String 'BIN dacD'

.dacE:	dc.b 8-1, 0
		DOS_String 'BIN dacE'

.dacF:	dc.b 8-1, 0
		DOS_String 'BIN dacF'

.dacpitched:	dc.b 19-1
		DOS_String 'BIN dacpitchedsnare'

.dancesnare:	dc.b 14-1, 0
		DOS_String 'BIN dancesnare'

.eletricsou:	dc.b 16-1, 0
		DOS_String 'BIN eletricsound'

.em00:	dc.b 8-1, 0
		DOS_String 'ASM em00'

.em08:	dc.b 8-1, 0
		DOS_String 'ASM em08'

.em22:	dc.b 8-1, 0
		DOS_String 'ASM em22'

.mmx_sigma_:	dc.b 19-1
		DOS_String 'ASM mmx_sigma_fort1'

.music81:	dc.b 11-1
		DOS_String 'BIN music81'

.music82:	dc.b 11-1
		DOS_String 'BIN music82'

.music83:	dc.b 11-1
		DOS_String 'BIN music83'

.music84:	dc.b 11-1
		DOS_String 'BIN music84'

.music85:	dc.b 11-1
		DOS_String 'BIN music85'

.music86:	dc.b 11-1
		DOS_String 'BIN music86'

.music87:	dc.b 11-1
		DOS_String 'BIN music87'

.music88:	dc.b 11-1
		DOS_String 'BIN music88'

.music89:	dc.b 11-1
		DOS_String 'BIN music89'

.music8A:	dc.b 11-1
		DOS_String 'BIN music8A'

.music8B:	dc.b 11-1
		DOS_String 'BIN music8B'

.music8C:	dc.b 11-1
		DOS_String 'BIN music8C'

.music8D:	dc.b 11-1
		DOS_String 'BIN music8D'

.music8E:	dc.b 11-1
		DOS_String 'BIN music8E'

.music8F:	dc.b 11-1
		DOS_String 'BIN music8F'

.music90:	dc.b 11-1
		DOS_String 'BIN music90'

.music91:	dc.b 11-1
		DOS_String 'BIN music91'

.music92:	dc.b 11-1
		DOS_String 'BIN music92'

.music93:	dc.b 11-1
		DOS_String 'BIN music93'

.musicE5:	dc.b 11-1
		DOS_String 'BIN musicE5'

.musice6:	dc.b 11-1
		DOS_String 'BIN musice6'

.musice7:	dc.b 11-1
		DOS_String 'BIN musice7'

.musice8:	dc.b 11-1
		DOS_String 'BIN musice8'

.musicE9:	dc.b 11-1
		DOS_String 'BIN musicE9'

.musicEA:	dc.b 11-1
		DOS_String 'BIN musicEA'

.musicEB:	dc.b 11-1
		DOS_String 'BIN musicEB'

.musicEC:	dc.b 11-1
		DOS_String 'BIN musicEC'

.musicED:	dc.b 11-1
		DOS_String 'BIN musicED'

.musicEE:	dc.b 11-1
		DOS_String 'BIN musicEE'

.musicEF:	dc.b 11-1
		DOS_String 'BIN musicEF'

.musicF0:	dc.b 11-1
		DOS_String 'BIN musicF0'

.OperaOfEgg:	dc.b 17-1
		DOS_String 'ASM OperaOfEggman'

.o_hat:	dc.b 9-1
		DOS_String 'BIN o_hat'

.powerkick:	dc.b 13-1
		DOS_String 'BIN powerkick'

.powersnare:	dc.b 14-1, 0
		DOS_String 'BIN powersnare'

.powertom:	dc.b 12-1, 0
		DOS_String 'BIN powertom'

.psg1:	dc.b 8-1, 0
		DOS_String 'BIN psg1'

.psg2:	dc.b 8-1, 0
		DOS_String 'BIN psg2'

.psg3:	dc.b 8-1, 0
		DOS_String 'BIN psg3'

.psg4:	dc.b 8-1, 0
		DOS_String 'BIN psg4'

.psg5:	dc.b 8-1, 0
		DOS_String 'BIN psg5'

.psg6:	dc.b 8-1, 0
		DOS_String 'BIN psg6'

.psg7:	dc.b 8-1, 0
		DOS_String 'BIN psg7'

.psg8:	dc.b 8-1, 0
		DOS_String 'BIN psg8'

.psg9:	dc.b 8-1, 0
		DOS_String 'BIN psg9'

.rvcym:	dc.b 9-1
		DOS_String 'BIN rvcym'

.s2b_D8:	dc.b 10-1, 0
		DOS_String 'BIN s2b_D8'

.S3KSpecial:	dc.b 19-1
		DOS_String 'ASM S3KSpecialStage'

.Slots:	dc.b 9-1
		DOS_String 'ASM Slots'

.Sonic3Titl:	dc.b 15-1
		DOS_String 'ASM Sonic3Title'

.Sonic3Titl2:	dc.b 15-1
		DOS_String 'BIN Sonic3Title'

.sound94:	dc.b 11-1
		DOS_String 'BIN sound94'

.sound95:	dc.b 11-1
		DOS_String 'BIN sound95'

.sound96:	dc.b 11-1
		DOS_String 'BIN sound96'

.sound97:	dc.b 11-1
		DOS_String 'BIN sound97'

.sound98:	dc.b 11-1
		DOS_String 'BIN sound98'

.sound99:	dc.b 11-1
		DOS_String 'BIN sound99'

.sound9A:	dc.b 11-1
		DOS_String 'BIN sound9A'

.sound9B:	dc.b 11-1
		DOS_String 'BIN sound9B'

.soundA0:	dc.b 11-1
		DOS_String 'BIN soundA0'

.soundA1:	dc.b 11-1
		DOS_String 'BIN soundA1'

.soundA2:	dc.b 11-1
		DOS_String 'BIN soundA2'

.soundA3:	dc.b 11-1
		DOS_String 'BIN soundA3'

.soundA4:	dc.b 11-1
		DOS_String 'BIN soundA4'

.soundA5:	dc.b 11-1
		DOS_String 'BIN soundA5'

.soundA6:	dc.b 11-1
		DOS_String 'BIN soundA6'

.soundA7:	dc.b 11-1
		DOS_String 'BIN soundA7'

.soundA8:	dc.b 11-1
		DOS_String 'BIN soundA8'

.soundA9:	dc.b 11-1
		DOS_String 'BIN soundA9'

.soundAA:	dc.b 11-1
		DOS_String 'BIN soundAA'

.soundAB:	dc.b 11-1
		DOS_String 'BIN soundAB'

.soundAC:	dc.b 11-1
		DOS_String 'BIN soundAC'

.soundAD:	dc.b 11-1
		DOS_String 'BIN soundAD'

.soundAE:	dc.b 11-1
		DOS_String 'BIN soundAE'

.soundAF:	dc.b 11-1
		DOS_String 'BIN soundAF'

.soundB0:	dc.b 11-1
		DOS_String 'BIN soundB0'

.soundB1:	dc.b 11-1
		DOS_String 'BIN soundB1'

.soundB2:	dc.b 11-1
		DOS_String 'BIN soundB2'

.soundB3:	dc.b 11-1
		DOS_String 'BIN soundB3'

.soundB4:	dc.b 11-1
		DOS_String 'BIN soundB4'

.soundB5:	dc.b 11-1
		DOS_String 'BIN soundB5'

.soundB6:	dc.b 11-1
		DOS_String 'BIN soundB6'

.soundB7:	dc.b 11-1
		DOS_String 'BIN soundB7'

.soundB8:	dc.b 11-1
		DOS_String 'BIN soundB8'

.soundB9:	dc.b 11-1
		DOS_String 'BIN soundB9'

.soundBA:	dc.b 11-1
		DOS_String 'BIN soundBA'

.soundBB:	dc.b 11-1
		DOS_String 'BIN soundBB'

.soundBC:	dc.b 11-1
		DOS_String 'BIN soundBC'

.soundBD:	dc.b 11-1
		DOS_String 'BIN soundBD'

.soundBE:	dc.b 11-1
		DOS_String 'BIN soundBE'

.soundBF:	dc.b 11-1
		DOS_String 'BIN soundBF'

.soundC0:	dc.b 11-1
		DOS_String 'BIN soundC0'

.soundC1:	dc.b 11-1
		DOS_String 'BIN soundC1'

.soundC2:	dc.b 11-1
		DOS_String 'BIN soundC2'

.soundC3:	dc.b 11-1
		DOS_String 'BIN soundC3'

.soundC4:	dc.b 11-1
		DOS_String 'BIN soundC4'

.soundC5:	dc.b 11-1
		DOS_String 'BIN soundC5'

.soundC6:	dc.b 11-1
		DOS_String 'BIN soundC6'

.soundC7:	dc.b 11-1
		DOS_String 'BIN soundC7'

.soundC8:	dc.b 11-1
		DOS_String 'BIN soundC8'

.soundC9:	dc.b 11-1
		DOS_String 'BIN soundC9'

.soundCA:	dc.b 11-1
		DOS_String 'BIN soundCA'

.soundCB:	dc.b 11-1
		DOS_String 'BIN soundCB'

.soundCC:	dc.b 11-1
		DOS_String 'BIN soundCC'

.soundCD:	dc.b 11-1
		DOS_String 'BIN soundCD'

.soundCE:	dc.b 11-1
		DOS_String 'BIN soundCE'

.soundCF:	dc.b 11-1
		DOS_String 'BIN soundCF'

.soundD0:	dc.b 11-1
		DOS_String 'BIN soundD0'

.soundD1:	dc.b 11-1
		DOS_String 'BIN soundD1'

.TF3_boss2:	dc.b 13-1
		DOS_String 'ASM TF3_boss2'

.TF3_BossRe:	dc.b 17-1
		DOS_String 'ASM TF3_BossRemix'

.TF4_BossRe:	dc.b 19-1
		DOS_String 'ASM TF4BossRemaster'

.TF4_Config:	dc.b 14-1, 0
		DOS_String 'ASM TF4_Config'

.TF_st5:	dc.b 10-1, 0
		DOS_String 'ASM TF_st5'

.whirlwind:	dc.b 13-1
		DOS_String 'ASM whirlwind'

.z80:	dc.b 7-1
		DOS_String 'BIN z80'

.z80_1:	dc.b 9-1
		DOS_String 'BIN z80_1'

.z80_2:	dc.b 9-1
		DOS_String 'BIN z80_2'

.Z80_BGM_0C:	dc.b 14-1, 0
		DOS_String 'ASM Z80_BGM_0C'

.Z80_BGM_No:	dc.b 19-1
		DOS_String 'ASM No_time_to_lose'

.z80_drv:	dc.b 11-1
		DOS_String 'BIN z80_drv'

.Z80_MusicB:	dc.b 11-1
		DOS_String 'ASM Stage_7'

.Z80_MusicB2:	dc.b 11-1
		DOS_String 'ASM Boss_10'

.Z80_MusicB3:	dc.b 10-1, 0
		DOS_String 'ASM Boss_5'

.z80_new:	dc.b 11-1
		DOS_String 'BIN z80_new'

.z80_newu:	dc.b 12-1, 0
		DOS_String 'BIN z80_newu'


		dc.w 40-1
DOS_dirfile_start:
		dc.w .end1-DOS_dirfile_start-2
		dc.w .end2-DOS_dirfile_start-4
		dc.w .end3-DOS_dirfile_start-6
		dc.w .end4-DOS_dirfile_start-8
		dc.w .ez1-DOS_dirfile_start-10
		dc.w .ez2-DOS_dirfile_start-12
		dc.w .ghz1-DOS_dirfile_start-14
		dc.w .ghz12-DOS_dirfile_start-16
		dc.w .ghz2-DOS_dirfile_start-18
		dc.w .ghz3-DOS_dirfile_start-20
		dc.w .ghz4-DOS_dirfile_start-22
		dc.w .ghzSC-DOS_dirfile_start-24
		dc.w .kghz1-DOS_dirfile_start-26
		dc.w .kghz12-DOS_dirfile_start-28
		dc.w .kghz2-DOS_dirfile_start-30
		dc.w .kghz3-DOS_dirfile_start-32
		dc.w .lz1-DOS_dirfile_start-34
		dc.w .lz2-DOS_dirfile_start-36
		dc.w .lz3-DOS_dirfile_start-38
		dc.w .lz4-DOS_dirfile_start-40
		dc.w .lz6-DOS_dirfile_start-42
		dc.w .mz1-DOS_dirfile_start-44
		dc.w .mz2-DOS_dirfile_start-46
		dc.w .mz3-DOS_dirfile_start-48
		dc.w .mz4-DOS_dirfile_start-50
		dc.w .ow1-DOS_dirfile_start-52
		dc.w .sbz1-DOS_dirfile_start-54
		dc.w .sbz2-DOS_dirfile_start-56
		dc.w .sbz3-DOS_dirfile_start-58
		dc.w .sbz4-DOS_dirfile_start-60
		dc.w .slz1-DOS_dirfile_start-62
		dc.w .slz2-DOS_dirfile_start-64
		dc.w .slz3-DOS_dirfile_start-66
		dc.w .slz4-DOS_dirfile_start-68
		dc.w .ss1-DOS_dirfile_start-70
		dc.w .syz1-DOS_dirfile_start-72
		dc.w .syz2-DOS_dirfile_start-74
		dc.w .syz3-DOS_dirfile_start-76
		dc.w .syz4-DOS_dirfile_start-78


.end1:	dc.b 8-1, 0
		DOS_String 'BIN end1'

.end2:	dc.b 8-1, 0
		DOS_String 'BIN end2'

.end3:	dc.b 8-1, 0
		DOS_String 'BIN end3'

.end4:	dc.b 8-1, 0
		DOS_String 'BIN end4'

.ez1:	dc.b 7-1
		DOS_String 'BIN ez1'

.ez2:	dc.b 7-1
		DOS_String 'BIN ez2'

.ghz1:	dc.b 8-1, 0
		DOS_String 'BIN ghz1'

.ghz12:	dc.b 9-1
		DOS_String 'BIN ghz12'

.ghz2:	dc.b 8-1, 0
		DOS_String 'BIN ghz2'

.ghz3:	dc.b 8-1, 0
		DOS_String 'BIN ghz3'

.ghz4:	dc.b 8-1, 0
		DOS_String 'BIN ghz4'

.ghzSC:	dc.b 9-1
		DOS_String 'BIN ghzSC'

.kghz1:	dc.b 9-1
		DOS_String 'BIN kghz1'

.kghz12:	dc.b 10-1, 0
		DOS_String 'BIN kghz12'

.kghz2:	dc.b 9-1
		DOS_String 'BIN kghz2'

.kghz3:	dc.b 9-1
		DOS_String 'BIN kghz3'

.lz1:	dc.b 7-1
		DOS_String 'BIN lz1'

.lz2:	dc.b 7-1
		DOS_String 'BIN lz2'

.lz3:	dc.b 7-1
		DOS_String 'BIN lz3'

.lz4:	dc.b 7-1
		DOS_String 'BIN lz4'

.lz6:	dc.b 7-1
		DOS_String 'BIN lz6'

.mz1:	dc.b 7-1
		DOS_String 'BIN mz1'

.mz2:	dc.b 7-1
		DOS_String 'BIN mz2'

.mz3:	dc.b 7-1
		DOS_String 'BIN mz3'

.mz4:	dc.b 7-1
		DOS_String 'BIN mz4'

.ow1:	dc.b 7-1
		DOS_String 'BIN ow1'

.sbz1:	dc.b 8-1, 0
		DOS_String 'BIN sbz1'

.sbz2:	dc.b 8-1, 0
		DOS_String 'BIN sbz2'

.sbz3:	dc.b 8-1, 0
		DOS_String 'BIN sbz3'

.sbz4:	dc.b 8-1, 0
		DOS_String 'BIN sbz4'

.slz1:	dc.b 8-1, 0
		DOS_String 'BIN slz1'

.slz2:	dc.b 8-1, 0
		DOS_String 'BIN slz2'

.slz3:	dc.b 8-1, 0
		DOS_String 'BIN slz3'

.slz4:	dc.b 8-1, 0
		DOS_String 'BIN slz4'

.ss1:	dc.b 7-1
		DOS_String 'BIN ss1'

.syz1:	dc.b 8-1, 0
		DOS_String 'BIN syz1'

.syz2:	dc.b 8-1, 0
		DOS_String 'BIN syz2'

.syz3:	dc.b 8-1, 0
		DOS_String 'BIN syz3'

.syz4:	dc.b 8-1, 0
		DOS_String 'BIN syz4'


		dc.w 8-1
DOS_dirfile_s3kca:
		dc.w .Sonic_1-DOS_dirfile_s3kca-2
		dc.w .Sonic_8-DOS_dirfile_s3kca-4
		dc.w .Sonic_9-DOS_dirfile_s3kca-6
		dc.w .Sonic_A-DOS_dirfile_s3kca-8
		dc.w .Sonic_B-DOS_dirfile_s3kca-10
		dc.w .Sonic_C-DOS_dirfile_s3kca-12
		dc.w .Sonic_D-DOS_dirfile_s3kca-14
		dc.w DOS_null-DOS_dirfile_s3kca-16


.Sonic_1:	dc.b 11-1
		DOS_String 'BIN Sonic 1'

.Sonic_8:	dc.b 11-1
		DOS_String 'BIN Sonic 8'

.Sonic_9:	dc.b 11-1
		DOS_String 'BIN Sonic 9'

.Sonic_A:	dc.b 11-1
		DOS_String 'BIN Sonic A'

.Sonic_B:	dc.b 11-1
		DOS_String 'BIN Sonic B'

.Sonic_C:	dc.b 11-1
		DOS_String 'BIN Sonic C'

.Sonic_D:	dc.b 11-1
		DOS_String 'BIN Sonic D'


		dc.w 14-1
DOS_dirfile_s3kcm:
		dc.w .Sonic_1-DOS_dirfile_s3kcm-2
		dc.w .Sonic_2-DOS_dirfile_s3kcm-4
		dc.w .Sonic_3-DOS_dirfile_s3kcm-6
		dc.w .Sonic_4-DOS_dirfile_s3kcm-8
		dc.w .Sonic_5-DOS_dirfile_s3kcm-10
		dc.w .Sonic_6-DOS_dirfile_s3kcm-12
		dc.w .Sonic_7-DOS_dirfile_s3kcm-14
		dc.w .Sonic_8-DOS_dirfile_s3kcm-16
		dc.w .Sonic_9-DOS_dirfile_s3kcm-18
		dc.w .Sonic_A-DOS_dirfile_s3kcm-20
		dc.w .Sonic_B-DOS_dirfile_s3kcm-22
		dc.w .Sonic_C-DOS_dirfile_s3kcm-24
		dc.w .Sonic_D-DOS_dirfile_s3kcm-26
		dc.w DOS_null-DOS_dirfile_s3kcm-28


.Sonic_1:	dc.b 11-1
		DOS_String 'BIN Sonic 1'

.Sonic_2:	dc.b 11-1
		DOS_String 'BIN Sonic 2'

.Sonic_3:	dc.b 11-1
		DOS_String 'BIN Sonic 3'

.Sonic_4:	dc.b 11-1
		DOS_String 'BIN Sonic 4'

.Sonic_5:	dc.b 11-1
		DOS_String 'BIN Sonic 5'

.Sonic_6:	dc.b 11-1
		DOS_String 'BIN Sonic 6'

.Sonic_7:	dc.b 11-1
		DOS_String 'BIN Sonic 7'

.Sonic_8:	dc.b 11-1
		DOS_String 'BIN Sonic 8'

.Sonic_9:	dc.b 11-1
		DOS_String 'BIN Sonic 9'

.Sonic_A:	dc.b 11-1
		DOS_String 'BIN Sonic A'

.Sonic_B:	dc.b 11-1
		DOS_String 'BIN Sonic B'

.Sonic_C:	dc.b 11-1
		DOS_String 'BIN Sonic C'

.Sonic_D:	dc.b 11-1
		DOS_String 'BIN Sonic D'


		dc.w 22-1
DOS_dirfile_s3kem:
		dc.w .S3_BG-DOS_dirfile_s3kem-2
		dc.w .S3_Menu_BG-DOS_dirfile_s3kem-4
		dc.w .S3_Sonic_1-DOS_dirfile_s3kem-6
		dc.w .S3_Sonic_2-DOS_dirfile_s3kem-8
		dc.w .S3_Sonic_3-DOS_dirfile_s3kem-10
		dc.w .S3_Sonic_4-DOS_dirfile_s3kem-12
		dc.w .S3_Sonic_5-DOS_dirfile_s3kem-14
		dc.w .S3_Sonic_6-DOS_dirfile_s3kem-16
		dc.w .S3_Sonic_7-DOS_dirfile_s3kem-18
		dc.w .S3_Sonic_8-DOS_dirfile_s3kem-20
		dc.w .S3_Sonic_9-DOS_dirfile_s3kem-22
		dc.w .S3_Sonic_A-DOS_dirfile_s3kem-24
		dc.w .S3_Sonic_B-DOS_dirfile_s3kem-26
		dc.w .S3_Sonic_C-DOS_dirfile_s3kem-28
		dc.w .S3_Sonic_D-DOS_dirfile_s3kem-30
		dc.w .SK_Backgro-DOS_dirfile_s3kem-32
		dc.w .SK_SEGA-DOS_dirfile_s3kem-34
		dc.w .SK_SonicKn-DOS_dirfile_s3kem-36
		dc.w .SK_SonicKn2-DOS_dirfile_s3kem-38
		dc.w .SK_SonicKn3-DOS_dirfile_s3kem-40
		dc.w .SK_SonicKn4-DOS_dirfile_s3kem-42
		dc.w DOS_null-DOS_dirfile_s3kcm-44


.S3_BG:	dc.b 9-1
		DOS_String 'BIN S3 BG'

.S3_Menu_BG:	dc.b 14-1, 0
		DOS_String 'BIN S3 Menu BG'

.S3_Sonic_1:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 1'

.S3_Sonic_2:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 2'

.S3_Sonic_3:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 3'

.S3_Sonic_4:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 4'

.S3_Sonic_5:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 5'

.S3_Sonic_6:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 6'

.S3_Sonic_7:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 7'

.S3_Sonic_8:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 8'

.S3_Sonic_9:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 9'

.S3_Sonic_A:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic A'

.S3_Sonic_B:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic B'

.S3_Sonic_C:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic C'

.S3_Sonic_D:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic D'

.SK_Backgro:	dc.b 17-1
		DOS_String 'BIN SK Background'

.SK_SEGA:	dc.b 11-1
		DOS_String 'BIN SK SEGA'

.SK_SonicKn	dc.b 19-1
		DOS_String 'BIN SonKnux Frame 1'

.SK_SonicKn2	dc.b 19-1
		DOS_String 'BIN SonKnux Frame 2'

.SK_SonicKn3	dc.b 19-1
		DOS_String 'BIN SonKnux Frame 3'

.SK_SonicKn4	dc.b 19-1
		DOS_String 'BIN SonKnux Frame 4'


		dc.w 14-1
DOS_dirfile_s3kka:
		dc.w .S3_Sonic_1-DOS_dirfile_s3kka-2
		dc.w .S3_Sonic_8-DOS_dirfile_s3kka-4
		dc.w .S3_Sonic_9-DOS_dirfile_s3kka-6
		dc.w .S3_Sonic_A-DOS_dirfile_s3kka-8
		dc.w .S3_Sonic_B-DOS_dirfile_s3kka-10
		dc.w .S3_Sonic_C-DOS_dirfile_s3kka-12
		dc.w .S3_Sonic_D-DOS_dirfile_s3kka-14
		dc.w .SK_ANDKnuc-DOS_dirfile_s3kka-16
		dc.w .SK_Big_SEG-DOS_dirfile_s3kka-18
		dc.w .SK_Death_E-DOS_dirfile_s3kka-20
		dc.w .SK_Mountai-DOS_dirfile_s3kka-22
		dc.w .SK_Screen_-DOS_dirfile_s3kka-24
		dc.w .SK_Sonic_a-DOS_dirfile_s3kka-26
		dc.w .SK_Sonic_F-DOS_dirfile_s3kka-28


.S3_Sonic_1:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 1'

.S3_Sonic_8:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 8'

.S3_Sonic_9:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 9'

.S3_Sonic_A:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic A'

.S3_Sonic_B:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic B'

.S3_Sonic_C:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic C'

.S3_Sonic_D:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic D'

.SK_ANDKnuc:	dc.b 15-1
		DOS_String 'BIN ANDKnuckles'

.SK_Big_SEG:	dc.b 15-1
		DOS_String 'BIN SK Big SEGA'

.SK_Death_E:	dc.b 16-1, 0
		DOS_String 'BIN SK Death Egg'

.SK_Mountai:	dc.b 19-1
		DOS_String 'BIN Mountain Sprite'

.SK_Screen_:	dc.b 16-1, 0
		DOS_String 'BIN SK Screen Bg'

.SK_Sonic_a:	dc.b 18-1
		DOS_String 'BIN Son Knux Hands'

.SK_Sonic_F:	dc.b 16-1, 0
		DOS_String 'BIN Sonic Falling'


		dc.w 4-1
DOS_dirfile_s3kkma:
		dc.w .SK_Banner-DOS_dirfile_s3kkma-2
		dc.w .SK_Menu-DOS_dirfile_s3kkma-4
		dc.w .SK_Sonic_K-DOS_dirfile_s3kkma-6
		dc.w .SK_Sonic_L-DOS_dirfile_s3kkma-8


.SK_Banner:	dc.b 13-1
		DOS_String 'BIN SK Banner'

.SK_Menu:	dc.b 11-1
		DOS_String 'BIN SK Menu'

.SK_Sonic_K:	dc.b 18-1, 0
		DOS_String 'BIN Sonic Knuckles'

.SK_Sonic_L:	dc.b 17-1
		DOS_String 'BIN SK Sonic Land'


		dc.w 6-1
DOS_dirfile_s3kna:
		dc.w .S3_8x16_Fo-DOS_dirfile_s3kna-2
		dc.w .S3_Banner-DOS_dirfile_s3kna-4
		dc.w .S3_Ending_-DOS_dirfile_s3kna-6
		dc.w .S3_Sonic_S-DOS_dirfile_s3kna-8
		dc.w .SK_ANDKnuc-DOS_dirfile_s3kna-10
		dc.w .SK_Screen_-DOS_dirfile_s3kna-12


.S3_8x16_Fo:	dc.b 16-1, 0
		DOS_String 'BIN S3 8x16 Font'

.S3_Banner:	dc.b 13-1
		DOS_String 'BIN S3 Banner'

.S3_Ending_:	dc.b 19-1
		DOS_String 'BIN Ending Graphics'

.S3_Sonic_S:	dc.b 17-1
		DOS_String 'BIN Sonic Sprites'

.SK_ANDKnuc:	dc.b 18-1, 0
		DOS_String 'BIN SK ANDKnuckles'

.SK_Screen_:	dc.b 18-1, 0
		DOS_String 'BIN SK Screen Text'


		dc.w 18-1
DOS_dirfile_s3kpal:
		dc.w .S3_Sonic_1-DOS_dirfile_s3kpal-2
		dc.w .S3_Sonic_2-DOS_dirfile_s3kpal-4
		dc.w .S3_Sonic_3-DOS_dirfile_s3kpal-6
		dc.w .S3_Sonic_4-DOS_dirfile_s3kpal-8
		dc.w .S3_Sonic_5-DOS_dirfile_s3kpal-10
		dc.w .S3_Sonic_6-DOS_dirfile_s3kpal-12
		dc.w .S3_Sonic_7-DOS_dirfile_s3kpal-14
		dc.w .S3_Sonic_8-DOS_dirfile_s3kpal-16
		dc.w .S3_Sonic_9-DOS_dirfile_s3kpal-18
		dc.w .S3_Sonic_A-DOS_dirfile_s3kpal-20
		dc.w .S3_Sonic_B-DOS_dirfile_s3kpal-22
		dc.w .S3_Sonic_C-DOS_dirfile_s3kpal-24
		dc.w .S3_Sonic_D-DOS_dirfile_s3kpal-26
		dc.w .S3_Water_A-DOS_dirfile_s3kpal-28
		dc.w .S3-DOS_dirfile_s3kpal-30
		dc.w .SK_Knuckle-DOS_dirfile_s3kpal-32
		dc.w .SK_Sega_an-DOS_dirfile_s3kpal-34
		dc.w .SK_Sonic-DOS_dirfile_s3kpal-36


.S3_Sonic_1:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 1'

.S3_Sonic_2:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 2'

.S3_Sonic_3:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 3'

.S3_Sonic_4:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 4'

.S3_Sonic_5:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 5'

.S3_Sonic_6:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 6'

.S3_Sonic_7:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 7'

.S3_Sonic_8:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 8'

.S3_Sonic_9:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic 9'

.S3_Sonic_A:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic A'

.S3_Sonic_B:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic B'

.S3_Sonic_C:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic C'

.S3_Sonic_D:	dc.b 14-1, 0
		DOS_String 'BIN S3 Sonic D'

.S3_Water_A:	dc.b 17-1
		DOS_String 'BIN S3 Water Anim'

.S3:	dc.b 6-1, 0
		DOS_String 'BIN S3'

.SK_Knuckle:	dc.b 15-1
		DOS_String 'BIN SK Knuckles'

.SK_Sega_an:	dc.b 18-1, 0
		DOS_String 'BIN SK Sega and BG'

.SK_Sonic:	dc.b 12-1, 0
		DOS_String 'BIN SK Sonic'
