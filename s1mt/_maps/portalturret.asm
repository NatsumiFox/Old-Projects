; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

Map_TurretArmR:	dc.w Map_TurretArmR_normal-Map_TurretArmR, Map_TurretArmR_right-Map_TurretArmR, Map_TurretArmR_left-Map_TurretArmR
Map_TurretArmL:	dc.w Map_TurretArmL_normal-Map_TurretArmL, Map_TurretArmL_right-Map_TurretArmL, Map_TurretArmL_left-Map_TurretArmL
Map_PortalTurret:dc.w .normal-Map_PortalTurret, .right-Map_PortalTurret, .left-Map_PortalTurret

.normal		dc.b 2
		dc.b $EA, 6, 0, 0, $F8
		dc.b 0, 9, 0, $C, $F4
.right		dc.b 2
		dc.b $EA, 6, 0, 6, $F8
		dc.b 0, 9, 0, $12, $F4
.left		dc.b 2
		dc.b $EA, 6, 8, 6, $F8
		dc.b 0, 9, 8, $12, $F4

Map_TurretArmR_normal:	dc.b 1
			dc.b $F4, 1, 0, $18, 6
Map_TurretArmR_right:	dc.b 1
			dc.b $F4, 1, 0, $18, 6
Map_TurretArmR_left:	dc.b 1
			dc.b $F4, 1, 8, $1A, 5

Map_TurretArmL_normal:	dc.b 1
			dc.b $F4, 1, 8, $18, $F3
Map_TurretArmL_right:	dc.b 1
			dc.b $F4, 1, 0, $1A, $F3
Map_TurretArmL_left:	dc.b 1
			dc.b $F4, 1, 8, $18, $F2

Map_TurretEye:		dc.b -4, 0, 0, $1C, -4
		even