using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using SonicRetro.SonLVL.API;

namespace S3KObjectDefinitions.LBZ
{
	class TubeElevator : Common.AutomaticTunnel
	{
		private Sprite[] sprites;

		public override string Name
		{
			get { return "Tube Elevator"; }
		}

		public override bool Debug
		{
			get { return false; }
		}

		public override Sprite Image
		{
			get { return sprites[0]; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return sprites[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			if ((obj.SubType & 0x1F) >= paths.Length) return base.GetSprite(obj);
			return sprites[(obj.SubType & 0x40) == 0 ? obj.XFlip ? 2 : 1 : 0];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if ((obj.SubType & 0x40) != 0) return null;
			return base.GetDebugOverlay(obj);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override void Init(ObjectData data)
		{
			base.Init(data);

			var art = LevelData.ReadFile(
				"../Levels/LBZ/Nemesis Art/Tube Transport.kosm", CompressionType.KosinskiM);
			var map =LevelData.ASMToBin(
				"../Levels/LBZ/Misc Object Data/Map - Tube Elevator.asm", LevelData.Game.MappingsVersion);

			sprites = new Sprite[3];
			sprites[0] = ObjectHelper.MapToBmp(art, map, 0, 1);
			sprites[1] = ObjectHelper.MapToBmp(art, map, 2, 1);
			sprites[2] = new Sprite(sprites[1], true, false);

			properties[2] = new PropertySpec("Closed", typeof(bool), "Extended",
				"If set, the elevator will be closed from the start.", null,
				(obj) => (obj.SubType & 0x40) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xBF) | ((bool)value ? 0x40 : 0)));
		}
	}

	class PipePlug : Common.AutomaticTunnel
	{
		private Sprite sprite;

		public override string Name
		{
			get { return "Pipe Plug"; }
		}

		public override bool Debug
		{
			get { return false; }
		}

		public override Sprite Image
		{
			get { return sprite; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return sprite;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			if (obj.SubType == 0x1F || (obj.SubType & 0x1F) < paths.Length) return sprite;
			return base.GetSprite(obj);
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			if (obj.SubType == 0 || obj.SubType == 0x1F) return null;
			return base.GetDebugOverlay(obj);
		}

		public override int GetDepth(ObjectEntry obj)
		{
			return 4;
		}

		public override void Init(ObjectData data)
		{
			base.Init(data);

			var indexer = new MultiFileIndexer<byte>();
			indexer.AddFile(new List<byte>(LevelData.ReadFile(
				"../Levels/LBZ/Nemesis Art/Act 2 Misc Art.kosm", CompressionType.KosinskiM)), 128);
			sprite = ObjectHelper.MapASMToBmp(indexer.ToArray(),
				"../Levels/LBZ/Misc Object Data/Map - PipePlug.asm", 7, 2);

			properties = new[]
			{
				new PropertySpec("Path ID", typeof(string), "Extended",
					"The path information associated with this object.", null,
					(obj) =>
					{
						var path = obj.SubType & 0x1F;
						return path == 0 ? "None" : path == 0x1F ? "None (water rise)" : path.ToString();
					},
					(obj, value) => obj.SubType = (byte)((obj.SubType & 0xE0) | (int.Parse((string)value) & 0x1F))),
				properties[1],
				properties[2],
				new PropertySpec("Water Pipe", typeof(bool), "Extended",
					"If set, the tunnel will remove Flame and Thunder Barriers.", null,
					(obj) => (obj.SubType & 0x20) != 0,
					(obj, value) => obj.SubType = (byte)((obj.SubType & 0xDF) | ((bool)value ? 0x20 : 0)))
			};
		}
	}
}

namespace S3KObjectDefinitions.Common
{
	class AutomaticTunnel : ObjectDefinition
	{
		protected PropertySpec[] properties;
		private ReadOnlyCollection<byte> subtypes;
		private Sprite[] unknownSprite;

		private Point[] startCoords;
		private Point[] endCoords;
		protected Sprite[] paths;

		public override string Name
		{
			get { return "Automatic Tunnel"; }
		}

		public override bool Debug
		{
			get { return true; }
		}

		public override Sprite Image
		{
			get { return unknownSprite[0]; }
		}

		public override PropertySpec[] CustomProperties
		{
			get { return properties; }
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return subtypes; }
		}

		public override string SubtypeName(byte subtype)
		{
			return null;
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return unknownSprite[0];
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return unknownSprite[(obj.XFlip ? 1 : 0) | (obj.YFlip ? 2 : 0)];
		}

		public override Sprite GetDebugOverlay(ObjectEntry obj)
		{
			var index = obj.SubType & 0x1F;
			if (index >= paths.Length) return null;

			int minX = obj.X, maxX = obj.X, minY = obj.Y, maxY = obj.Y;
			var coord = obj.SubType < 0x80 ? startCoords[index] : endCoords[index];
			if (coord.X < minX) minX = coord.X; else if (coord.X > maxX) maxX = coord.X;
			if (coord.Y < minY) minY = coord.Y; else if (coord.Y > maxY) maxY = coord.Y;

			var white = new BitmapBits(maxX - minX + 1, maxY - minY + 1);
			var black = new BitmapBits(white.Width + 1, white.Height + 1);
			int x1 = obj.X - minX, y1 = obj.Y - minY;
			int x2 = coord.X - minX, y2 = coord.Y - minY;

			white.DrawLine(LevelData.ColorWhite, x1, y1, x2, y2);
			black.DrawLine(LevelData.ColorBlack, x1, y1 + 1, x2, y2 + 1);
			black.DrawLine(LevelData.ColorBlack, x1 + 1, y1, x2 + 1, y2);
			black.DrawLine(LevelData.ColorBlack, x1 + 1, y1 + 1, x2 + 1, y2 + 1);

			var overlay = new Sprite(
				new Sprite(black, minX, minY), paths[index], new Sprite(white, minX, minY));

			overlay.Offset(-obj.X, -obj.Y);
			return overlay;
		}

		public override void Init(ObjectData data)
		{
			properties = new PropertySpec[3];
			subtypes = new ReadOnlyCollection<byte>(new byte[0]);
			unknownSprite = BuildFlippedSprites(ObjectHelper.UnknownObject);

			properties[0] = new PropertySpec("Path ID", typeof(int), "Extended",
				"The path information associated with this object.", null,
				(obj) => obj.SubType & 0x1F,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xE0) | ((int)value & 0x1F)));

			properties[1] = new PropertySpec("Reverse", typeof(bool), "Extended",
				"If set, the tunnel path will be run in the opposite direction.", null,
				(obj) => obj.SubType >= 0x80,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0x7F) | ((bool)value ? 0x80 : 0)));

			properties[2] = new PropertySpec("Launch", typeof(bool), "Extended",
				"If set, the player will launch off at the end of the path.", null,
				(obj) => (obj.SubType & 0x40) != 0,
				(obj, value) => obj.SubType = (byte)((obj.SubType & 0xBF) | ((bool)value ? 0x40 : 0)));

			startCoords = new Point[26];
			endCoords = new Point[26];
			paths = new Sprite[26];

			BuildPathsCoords(0,
				0xF60, 0x578, 0xF60, 0x548, 0xF60, 0x378);

			BuildPathsCoords(1,
				0xD40, 0x770, 0xD48, 0x770, 0xD50, 0x770, 0xD58, 0x770, 0xD60, 0x770, 0xDB0, 0x770,
				0xDD0, 0x77C, 0xDE0, 0x79C, 0xDD6, 0x7BC, 0xDB6, 0x7CE, 0xD96, 0x7CE, 0xD86, 0x7C8,
				0xD70, 0x7A8, 0xD70, 0x688);

			startCoords[2] = startCoords[1];
			endCoords[2] = endCoords[1];
			paths[2] = paths[1];

			BuildPathsCoords(3,
				0xD30, 0x770, 0xDB0, 0x770, 0xDD0, 0x77C, 0xDE0, 0x79C, 0xDD6, 0x7BC, 0xDB6, 0x7CE,
				0xD96, 0x7CE, 0xD86, 0x7C8, 0xD70, 0x7A8, 0xD70, 0x748);

			BuildPathsCoords(4,
				0x2CC0, 0x9F0, 0x2CC8, 0x9F0, 0x2CD0, 0x9F0, 0x2CD8, 0x9F0, 0x2CE0, 0x9F0, 0x2D30, 0x9F0,
				0x2D50, 0x9FC, 0x2D60, 0xA1C, 0x2D56, 0xA3C, 0x2D36, 0xA4E, 0x2D16, 0xA4E, 0x2D06, 0xA48,
				0x2CF0, 0xA28, 0x2CF0, 0x908);

			BuildPathsCoords(5,
				0x2CB0, 0x9F0, 0x2D30, 0x9F0, 0x2D50, 0x9FC, 0x2D60, 0xA1C, 0x2D56, 0xA3C, 0x2D36, 0xA4E,
				0x2D16, 0xA4E, 0x2D06, 0xA48, 0x2CF0, 0xA28, 0x2CF0, 0x9C8);

			BuildPathsCoords(6,
				0x3640, 0xA70, 0x3648, 0xA70, 0x3650, 0xA70, 0x3658, 0xA70, 0x3660, 0xA70, 0x36B0, 0xA70,
				0x36D0, 0xA7C, 0x36E0, 0xA9C, 0x36D6, 0xABC, 0x36B6, 0xACE, 0x3696, 0xACE, 0x3686, 0xAC8,
				0x3670, 0xAA8, 0x3670, 0x988);

			BuildPathsCoords(7,
				0x3630, 0xA70, 0x36B0, 0xA70, 0x36D0, 0xA7C, 0x36E0, 0xA9C, 0x36D6, 0xABC, 0x36B6, 0xACE,
				0x3696, 0xACE, 0x3686, 0xAC8, 0x3670, 0xAA8, 0x3670, 0xA48);

			BuildPathsCoords(8,
				0x37C0, 0x7F0, 0x37C8, 0x7F0, 0x37D0, 0x7F0, 0x37D8, 0x7F0, 0x37E0, 0x7F0, 0x3830, 0x7F0,
				0x3850, 0x7FC, 0x3860, 0x81C, 0x3856, 0x83C, 0x3836, 0x84E, 0x3816, 0x84E, 0x3806, 0x848,
				0x37F0, 0x828, 0x37F0, 0x708);

			BuildPathsCoords(9,
				0x37B0, 0x7F0, 0x3830, 0x7F0, 0x3850, 0x7FC, 0x3860, 0x81C, 0x3856, 0x83C, 0x3836, 0x84E,
				0x3816, 0x84E, 0x3806, 0x848, 0x37F0, 0x828, 0x37F0, 0x7C8);

			BuildPathsCoords(10,
				0x29C0, 0x470, 0x29C8, 0x470, 0x29D0, 0x470, 0x29D8, 0x470, 0x29E0, 0x470, 0x2A30, 0x470,
				0x2A50, 0x47C, 0x2A60, 0x49C, 0x2A56, 0x4BC, 0x2A36, 0x4CE, 0x2A16, 0x4CE, 0x2A06, 0x4C8,
				0x29F0, 0x4A8, 0x29F0, 0x388);

			BuildPathsCoords(11,
				0x29B0, 0x470, 0x2A30, 0x470, 0x2A50, 0x47C, 0x2A60, 0x49C, 0x2A56, 0x4BC, 0x2A36, 0x4CE,
				0x2A16, 0x4CE, 0x2A06, 0x4C8, 0x29F0, 0x4A8, 0x29F0, 0x448);

			BuildPathsCoords(12,
				0x26C0, 0x530, 0x26C0, 0x6E0, 0x26B2, 0x700, 0x2692, 0x710, 0x25F2, 0x710, 0x25D2, 0x704,
				0x25C0, 0x6E4, 0x25C0, 0x4B4, 0x25B0, 0x484, 0x2590, 0x464, 0x2560, 0x450, 0x24D0, 0x450,
				0x2490, 0x43B, 0x2450, 0x41F, 0x2400, 0x410, 0x2300, 0x410, 0x22D0, 0x415, 0x22A0, 0x42B,
				0x2280, 0x448, 0x2240, 0x468, 0x2200, 0x470, 0x21C0, 0x468, 0x2180, 0x448, 0x2160, 0x42B,
				0x2130, 0x415, 0x2100, 0x410, 0x20D0, 0x415, 0x20A0, 0x42B, 0x2080, 0x448, 0x2040, 0x468,
				0x2000, 0x470, 0x1FC0, 0x468, 0x1F80, 0x448, 0x1F60, 0x42B, 0x1F30, 0x415, 0x1F00, 0x410,
				0x1ED0, 0x415, 0x1EA0, 0x42B, 0x1E80, 0x448, 0x1E40, 0x468, 0x1E00, 0x470, 0x1C70, 0x470,
				0x1C40, 0x440, 0x1C40, 0x320, 0x1C50, 0x300, 0x1C70, 0x2F0, 0x1F80, 0x2F0, 0x1FD0, 0x2E4,
				0x2000, 0x2C8, 0x2020, 0x2AB, 0x2040, 0x29A, 0x2080, 0x290, 0x20C0, 0x2A7, 0x2170, 0x357,
				0x21B0, 0x370, 0x2400, 0x370, 0x2440, 0x380, 0x2480, 0x390, 0x24B0, 0x384, 0x24C0, 0x364,
				0x24C0, 0xC4, 0x2490, 0x90, 0x2450, 0x9C, 0x2440, 0xCC, 0x2440, 0xFC);

			BuildPathsCoords(13,
				0x33C0, 0x130, 0x33C0, 0x1E0, 0x33D0, 0x200, 0x3400, 0x210, 0x3450, 0x220, 0x34A0, 0x270,
				0x34C0, 0x2A0, 0x34C0, 0x460, 0x34CE, 0x480, 0x34F0, 0x490, 0x3710, 0x490, 0x372E, 0x480,
				0x3740, 0x460, 0x3740, 0x330, 0x3720, 0x310, 0x35F0, 0x310, 0x35CE, 0x300, 0x35C0, 0x2E0,
				0x35C0, 0x40, 0x35CC, 0x20, 0x3600, 0x10, 0x3690, 0x10, 0x36B4, 0x20, 0x36C0, 0x40,
				0x36C0, 0x80);

			BuildPathsCoords(14,
				0x14C0, 0xAB0, 0x14C0, 0xB60, 0x14D0, 0xB80, 0x14F0, 0xB90, 0x1610, 0xB90, 0x1630, 0xB80,
				0x1640, 0xB60, 0x1640, 0x8C0, 0x1650, 0x8A0, 0x1670, 0x890, 0x1890, 0x890, 0x18B0, 0x89C,
				0x18C0, 0x8BC, 0x18C0, 0x8FC);

			BuildPathsCoords(15,
				0x3840, 0x730, 0x3840, 0x860, 0x3832, 0x880, 0x3802, 0x890, 0x37D2, 0x884, 0x37C0, 0x864,
				0x37C0, 0x3D4, 0x37D0, 0x3B4, 0x37F0, 0x39C, 0x3820, 0x390, 0x3990, 0x390, 0x39B0, 0x39C,
				0x39C0, 0x3BC, 0x39C0, 0x3FC);

			BuildPathsCoords(16,
				0xF60, 0x5C8, 0xF60, 0x950, 0xF64, 0x980, 0xF68, 0x990, 0xF73, 0x9B0, 0xF82, 0x9D0,
				0xF8C, 0x9E0, 0xF98, 0x9F0, 0xFA5, 0xA00, 0xFB5, 0xA10, 0xFC5, 0xA1C, 0xFD5, 0xA28,
				0xFF5, 0xA38, 0x1005, 0xA40, 0x1025, 0xA4A, 0x1035, 0xA4C, 0x1055, 0xA50, 0x1265, 0xA50,
				0x12A5, 0xA48, 0x12C5, 0xA3C, 0x12E5, 0xA2C, 0x12F5, 0xA20, 0x1305, 0xA14, 0x1315, 0xA08,
				0x1320, 0x9F8, 0x132F, 0x9E8, 0x1343, 0x9C8, 0x1350, 0x9A8, 0x135A, 0x988, 0x1360, 0x958,
				0x1360, 0x878);

			BuildPathsCoords(17,
				0x3760, 0x1C8, 0x3760, 0x510, 0x375A, 0x540, 0x3750, 0x560, 0x3743, 0x580, 0x372F, 0x5A0,
				0x3720, 0x5B0, 0x3715, 0x5C0, 0x3705, 0x5CC, 0x36F5, 0x5D8, 0x36E5, 0x5E4, 0x36C5, 0x5F4,
				0x36A5, 0x600, 0x3665, 0x608, 0x3655, 0x608, 0x3635, 0x604, 0x3625, 0x602, 0x3605, 0x5F8,
				0x35F5, 0x5F0, 0x35D5, 0x5E0, 0x35C5, 0x5D4, 0x35B5, 0x5C8, 0x35A5, 0x5B8, 0x3598, 0x5A8,
				0x358C, 0x598, 0x3582, 0x588, 0x3573, 0x568, 0x3568, 0x548, 0x3564, 0x538, 0x3560, 0x508,
				0x3560, 0x478);

			BuildPathsCoords(18,
				0x3460, 0x5C8, 0x3460, 0x690, 0x345A, 0x6C0, 0x3450, 0x6E0, 0x3443, 0x700, 0x342F, 0x720,
				0x3420, 0x730, 0x3415, 0x740, 0x3405, 0x74C, 0x33F5, 0x758, 0x33E5, 0x764, 0x33C5, 0x774,
				0x33A5, 0x780, 0x3365, 0x788, 0x3355, 0x788, 0x3335, 0x784, 0x3325, 0x782, 0x3305, 0x778,
				0x32F5, 0x770, 0x32D5, 0x760, 0x32C5, 0x754, 0x32B5, 0x748, 0x32A5, 0x738, 0x3298, 0x728,
				0x328C, 0x718, 0x3282, 0x708, 0x3273, 0x6E8, 0x3268, 0x6C8, 0x3264, 0x6B8, 0x3260, 0x688,
				0x3260, 0x5F8);

			BuildPathsCoords(19,
				0x1C70, 0x730, 0x1C70, 0x6C0, 0x1C62, 0x6A0, 0x1C42, 0x692, 0x1C32, 0x692, 0x1C12, 0x69B,
				0x1C00, 0x6BB, 0x1C08, 0x6DB, 0x1C28, 0x6F0, 0x1CA8, 0x6F0);

			BuildPathsCoords(20,
				0x3670, 0x830, 0x3670, 0x7C0, 0x3662, 0x7A0, 0x3642, 0x792, 0x3632, 0x792, 0x3612, 0x79B,
				0x3600, 0x7BB, 0x3608, 0x7DB, 0x3628, 0x7F0, 0x36A8, 0x7F0);

			BuildPathsCoords(21,
				0x11B8, 0x6F0, 0x1270, 0x6F0, 0x128C, 0x6F3, 0x12A1, 0x6FE, 0x12AD, 0x710, 0x12B0, 0x728,
				0x12B0, 0x8B0, 0x12AC, 0x8D1, 0x12A0, 0x8E3, 0x128C, 0x8EE, 0x1270, 0x8F0, 0x11B8, 0x8F0);

			BuildPathsCoords(22,
				0x17B8, 0xB70, 0x1870, 0xB70, 0x1890, 0xB6D, 0x18A0, 0xB63, 0x18AD, 0xB53, 0x18B0, 0xB33,
				0x18B0, 0x8B0, 0x18B2, 0x893, 0x18BC, 0x880, 0x18CE, 0x872, 0x18F0, 0x870, 0x1A70, 0x870,
				0x1A90, 0x86D, 0x1AA2, 0x862, 0x1AAE, 0x84E, 0x1AB0, 0x830, 0x1AB0, 0x6B0, 0x1AB2, 0x692,
				0x1ABD, 0x67E, 0x1AD2, 0x671, 0x1AF0, 0x670, 0x1B70, 0x670, 0x1B90, 0x66D, 0x1BA2, 0x662,
				0x1BAF, 0x64E, 0x1BB0, 0x630, 0x1BB0, 0x4B0, 0x1BB0, 0x495, 0x1BA2, 0x47E, 0x1B8D, 0x471,
				0x1B70, 0x470, 0x1AB8, 0x470);

			BuildPathsCoords(23,
				0x22B8, 0x70, 0x2370, 0x70, 0x2390, 0x73, 0x23A1, 0x7E, 0x23AD, 0x90, 0x23B0, 0xB0,
				0x23B0, 0x1B0, 0x23B2, 0x1D1, 0x23BF, 0x1E4, 0x23D6, 0x1F0, 0x2448, 0x1F0);

			BuildPathsCoords(24,
				0x2D48, 0x7F0, 0x2CF0, 0x7F0, 0x2CD0, 0x7EE, 0x2CBD, 0x7E3, 0x2CB2, 0x7D0, 0x2CB0, 0x7B0,
				0x2CB0, 0x430, 0x2CB1, 0x411, 0x2CBB, 0x3FF, 0x2CCF, 0x3F2, 0x2CF0, 0x3F0, 0x2D70, 0x3F0,
				0x2D90, 0x3ED, 0x2DA2, 0x3E2, 0x2DAF, 0x3CE, 0x2DB0, 0x3B0, 0x2DB0, 0x330, 0x2DB2, 0x311,
				0x2DBC, 0x2FE, 0x2DD1, 0x2F1, 0x2DEF, 0x2F0, 0x30F0, 0x2F0);

			BuildPathsCoords(25,
				0x3A38, 0x3F0, 0x3AF0, 0x3F0, 0x3B10, 0x3EE, 0x3B23, 0x3E0, 0x3B2F, 0x3CA, 0x3B30, 0x3B0,
				0x3B30, 0x230, 0x3B32, 0x211, 0x3B3C, 0x1FF, 0x3B50, 0x1F2, 0x3B70, 0x1F0, 0x3BC8, 0x1F0);
		}

		private void BuildPathsCoords(int index, int startX, int startY, params int[] waypoints)
		{
			startCoords[index] = new Point(startX, startY);
			int minX = startX, maxX = startX, minY = startY, maxY = startY;

			for (var i = 0; i < waypoints.Length; i += 2)
			{
				var curX = waypoints[i];
				if (curX < minX) minX = curX; else if (curX > maxX) maxX = curX;
				var curY = waypoints[i + 1];
				if (curY < minY) minY = curY; else if (curY > maxY) maxY = curY;
			}

			var bitmap = new BitmapBits(maxX - minX + 2, maxY - minY + 2);
			int x1 = startX - minX , y1 = startY - minY;
			var previous = new Point(x1, y1);

			for (var i = 0; i < waypoints.Length; i += 2)
			{
				int x2 = waypoints[i] - minX, y2 = waypoints[i + 1] - minY;
				bitmap.DrawLine(LevelData.ColorBlack, x1, y1 + 1, x2, y2 + 1);
				bitmap.DrawLine(LevelData.ColorBlack, x1 + 1, y1, x2 + 1, y2);
				bitmap.DrawLine(LevelData.ColorBlack, x1 + 1, y1 + 1, x2 + 1, y2 + 1);
				x1 = x2; y1 = y2;
			}

			for (var i = 0; i < waypoints.Length; i += 2)
			{
				var current = new Point(waypoints[i] - minX, waypoints[i + 1] - minY);
				bitmap.DrawLine(LevelData.ColorWhite, previous, current);
				previous = current;
			}

			previous.Offset(minX, minY);
			endCoords[index] = previous;
			paths[index] = new Sprite(bitmap, minX, minY);
		}

		private Sprite[] BuildFlippedSprites(Sprite sprite)
		{
			var flipX = new Sprite(sprite, true, false);
			var flipY = new Sprite(sprite, false, true);
			var flipXY = new Sprite(sprite, true, true);

			return new[] { sprite, flipX, flipY, flipXY };
		}
	}
}
