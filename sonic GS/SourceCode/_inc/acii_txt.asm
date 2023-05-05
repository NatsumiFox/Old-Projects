s2_ASCII:
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "ZONE ID                           ACT ID",$FF
		dc.b $FF
		dc.b "   00                               00",$FF
		dc.b "   01                               01",$FF
		dc.b "   02                               02",$FF
		dc.b "   03                               03",$FF
		dc.b "   04",$FF
		dc.b "   05",$FF
		dc.b "   06",$FF
		dc.b "   07",$FF
		dc.b "   08",$FF
		dc.b "   09",$FF
		dc.b "   0A",$FF
		dc.b "   0B",$FF
		dc.b "   0C",$FF
		dc.b "   0D",$FF
		dc.b "   0E",$FF
		dc.b "   0F",$FF
		dc.b "   GAME MODES",$FF
		dc.b $FF
		dc.b "   LEVEL RAM = $FFFE10 = $XXXX",$FF
		dc.b $FF
		dc.b $FF
		dc.b "",$FF
		dc.b "",$FF
		dc.b "",$FF
		dc.b "",$FF

		dc.b 0
		even
LevSel_ASCII:
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "ZONE ID                           ACT ID",$FF
		dc.b $FF
		dc.b "   00                               00",$FF
		dc.b "   01                               01",$FF
		dc.b "   02                               02",$FF
		dc.b "   03                               03",$FF
		dc.b "   04",$FF
		dc.b "   05",$FF
		dc.b "   06",$FF
		dc.b "   07",$FF
		dc.b "   08",$FF
		dc.b "   09",$FF
		dc.b "   0A",$FF
		dc.b "   0B",$FF
		dc.b "   0C",$FF
		dc.b "   0D",$FF
		dc.b "   0E",$FF
		dc.b "   0F",$FF
		dc.b "   GAME MODES",$FF
		dc.b $FF
		dc.b "   LEVEL RAM = $FFFE10 = $XXXX",$FF
		dc.b $FF
		dc.b $FF
		dc.b "",$FF
		dc.b "",$FF
		dc.b "",$FF
		dc.b "",$FF

		dc.b 0
		even


TitleSCR_ASCII:
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "           *** DEBUG MODE ***           ",$FF
		dc.b "                                        ",$FF
		dc.b "           A: LEVEL SELECT              ",$FF
		dc.b "           B: SOUND TEST                ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "   Romhack by Green Snake Hacking       ",$FF

		dc.b 0
		even
SELCHAR_ASCII:
		dc.b $FF
		dc.b "  Sonic",$FF
		dc.b "  Tails",$FF
		dc.b "  Green Snake",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b " CHARACTER SELECT",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "                                        ",$FF
		dc.b $FF

		dc.b 0
		even
ROMInfo_ASCII:
                dc.b $FF
		dc.b "      - - - Sonic Green Snake - - -",$FF
		dc.b $FF
		dc.b $FF
		dc.b "Warning!",$FF
		dc.b $FF
		dc.b "This game is unofficial. This means,",$FF
		dc.b "this game is not created by or under",$FF
		dc.b "SEGA Enterprises.",$FF
		dc.b $FF
		dc.b "This game is based on heavily modified",$FF
		dc.b "code and data from the original game",$FF
		dc.b "Sonic The Hedgehog, created by",$FF
		dc.b "Sonic Team.",$FF
		dc.b $FF
		dc.b "SEGA Retains rights to the original",$FF
		dc.b "code, data, and others, while all the",$FF
		dc.b "new content on this game is created by",$FF
		dc.b "us.",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "     - - - PRESS A,B,C BUTTON - - -     ",$FF

		dc.b 0
		even
SoundTest_ASCII:
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF
		dc.b "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",$FF

		dc.b 0
		even
PALREG_ASCII:
		dc.b $FF
		dc.b "      - - -  - - -",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "      PAL REGIONS ARE ALLOWED",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "                  ",$FF
		dc.b "                 ",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "                                       ",$FF
		dc.b $FF

		dc.b 0
		even
Warning_ASCII_Spa:
		dc.b $FF
		dc.b "      - - - Sonic Green Snake - - -",$FF
		dc.b $FF
		dc.b $FF
		dc.b "Hack By Green Snake Hacking",$FF
		dc.b $FF
		dc.b $FF
		dc.b "Only for use of nice people,",$FF
		dc.b "Not anyone mean people who just",$FF
		dc.b "wants to steal our job or fuck us up",$FF
		dc.b $FF
		dc.b $FF
		dc.b "Current version is Sonic Hacking Contest",$FF
		dc.b "                        2012 Beta",$FF
		dc.b "       SHC2012 Final coming soon.",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "While waiting, play this crap.",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "Most contents made by Green Snake",$FF
		dc.b "                   No refunds!!!",$FF
		dc.b $FF
		dc.b "     - - - PRESS A,B,C BUTTON - - -     ",$FF

		dc.b 0
		even

Warning_ASCII:
		dc.b $FF
		dc.b "        - - - y5der - - -",$FF
		dc.b $FF
		dc.b $FF
		dc.b "Overworld",$FF
		dc.b $FF
		dc.b "We're sorry, but the content that",$FF
		dc.b "you want to acceed was already taken",$FF
		dc.b "by other hack.",$FF
		dc.b $FF
		dc.b "Sorry the inconvenience.",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "     - - - PRESS START BUTTON - - -     ",$FF

		dc.b 0
		even

Warning_ASCII_Prev:
		dc.b $FF
		dc.b "      - - - SONIC ALPHAOMEGA - - -",$FF
		dc.b $FF
		dc.b $FF
		dc.b "Warning!",$FF
		dc.b $FF
		dc.b "This game is unofficial. This means,",$FF
		dc.b "this game is not created by or under",$FF
		dc.b "SEGA Enterprises.",$FF
		dc.b $FF
		dc.b "This game is based on heavily modified",$FF
		dc.b "code and data from the original game",$FF
		dc.b "Sonic The Hedgehog, created by",$FF
		dc.b "Sonic Team.",$FF
		dc.b $FF
		dc.b "SEGA Retains rights to the original",$FF
		dc.b "code, data, and others, while all the",$FF
		dc.b "new content on this game is created by",$FF
		dc.b "us.",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "     - - - PRESS START BUTTON - - -     ",$FF

		dc.b 0
		even

Lang_ASCII:
		dc.b $FF
		dc.b "      - - - SONIC ALPHAOMEGA - - -",$FF
		dc.b $FF
		dc.b $FF
		dc.b "    SELECT LANG / SELECCIONA IDIOMA",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "       =========       =========",$FF
		dc.b "       =ESPANOL=       =ENGLISH=",$FF
		dc.b "       =========       =========",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF

		dc.b 0
		even
Xulpico_ASCII:
		dc.b $FF
		dc.b "               HELLO WORLD",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF
		dc.b "                                        ",$FF

		dc.b 0
		even
pico_ASCII:
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b " SAAVEDRA GAY REQL Y LA CONCHETUMARE!!!",$FF
		dc.b $FF
		dc.b "                 CHUPALO",$FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF

		dc.b 0
		even
Checksum_ASCII:
		dc.b "Wrong Checksum!",$FF

		dc.b 0
		even
LS_ASCII:
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b "      - - - SONIC ALPHAOMEGA - - -",$FF

		dc.b 0
		even