package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;

/**
 * Created by NAT on 16.10.12.
 */
public class PlaneShareTiles {
	private static String fol = "G:\\hacks\\current\\s41\\dat\\ani\\";
	public static String comp = "G:\\hacks\\current\\s41\\bin\\FW_KENSC\\";
	private static ArrayList<HashedTile> tiles;
	private static ArrayList<HashedTile>[] tilmisc;

	public static void main(String[] args) throws Exception {
		File[] all = new File(fol).listFiles((dir, name)->name.endsWith(".unmap.unc"));
		if(all == null) return;
		tiles = new ArrayList<>();

		System.out.println("--- Pass One ---");
		int file = 0;
		for(File f : all){
			System.out.print(f.toPath());
			byte[] d = Files.readAllBytes(f.toPath());

			int t = 0;
			for(int i = 0;i < d.length;i += 32){
				byte[] tile = new byte[32];
				System.arraycopy(d, i, tile, 0, 32);
				t += AddHash(tile, file) ? 1 : 0;
			}

			System.out.println(" "+ t +" "+ Integer.toHexString(t * 32));
			file ++;
		}

		tilmisc = new ArrayList[file];
		System.out.println("--- Pass Two ---");

		// no we need to reparse all tiles to sort to correct arraylists
		file = 0;
		for(File f : all){
			tilmisc[file] = new ArrayList<>();
			System.out.print(f.toPath());
			byte[] d = Files.readAllBytes(f.toPath());

			for(int i = 0;i < d.length;i += 32){
				byte[] tile = new byte[32];
				System.arraycopy(d, i, tile, 0, 32);
				HashedTile h = GetByHash(CreateHash(tile));
				if(h == null){
					tilmisc[file].add(new HashedTile(tile, file));

				} else if(h.uses < 2){
					tilmisc[file].add(h);
					tiles.remove(h);
				}
			}

			System.out.println(" "+ tilmisc[file].size() +" "+ Integer.toHexString(tilmisc[file].size() * 32));
			file ++;
		}

		System.out.println("--- Pass Three ---");
		file = 0;
		for(File f : all){
			System.out.print(f.toPath());
			byte[] til = new byte[32 * tilmisc[file].size()];
			byte[] map = new byte[0x658];
			byte[] d = Files.readAllBytes(f.toPath());

			int toff = 0;
			for(HashedTile h : tilmisc[file]){
				System.arraycopy(h.tile, 0, til, toff, 32);
				toff += 32;
			}

			System.out.print(" "+ Integer.toHexString(til.length));
			Files.write(new File(f.getParent() +"\\"+ f.getName().replace(".unmap.unc", ".tiles.unc")).toPath(), til);
			compress(f.getParent() +"\\"+ f.getName().replace(".unmap.unc", ".tiles."), "kos");

			for(int i = 0, t = 0;i < d.length;i += 32, t += 2){
				byte[] tile = new byte[32];
				System.arraycopy(d, i, tile, 0, 32);
				short h = GetTileHash(CreateHash(tile));
				if(h == -1) h = GetTileHash(CreateHash(tile), tilmisc[file]);
				putshort(map, t, h);
			}

			System.out.println(" "+ Integer.toHexString(map.length));
			Files.write(new File(f.getParent() +"\\"+ f.getName().replace(".unmap.unc", ".map.unc")).toPath(), map);
			compress(f.getParent() +"\\"+ f.getName().replace(".unmap.unc", ".map."), "eni");
			file ++;
		}

		byte[] til = new byte[32 * (tiles.size())];
		int toff = 0;
		for(HashedTile h : tiles){
			System.arraycopy(h.tile, 0, til, toff, 32);
			toff += 32;
		}

		System.out.println(tiles.size() +" "+ Integer.toHexString(tiles.size() * 32));
		Files.write(new File(fol +"main.tiles.unc").toPath(), til);
		compress(fol +"main.tiles.", "kos");
	}

	private static void compress(String file, String fmt) {
		try {
			Process p = Runtime.getRuntime().exec("cmd /c cd "+ comp +"&& "+ fmt +"cmp.exe "+ file +"unc "+ file + fmt);
			p.waitFor();

		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
		}
	}

	private static void putshort(byte[] dat, int off, short val) {
		dat[off] = (byte)(val >> 8);
		dat[off + 1] = (byte)(val);
	}

	private static boolean AddHash(byte[] tile, int file) {
		if(!HasHash(CreateHash(tile), file)){
			tiles.add(new HashedTile(tile, file));
			return true;
		}

		return false;
	}

	private static boolean HasHash(String hash, int file) {
		for(HashedTile h : tiles){
			if(h.hash.equals(hash) || h.hashx.equals(hash) || h.hashy.equals(hash)|| h.hashxy.equals(hash)){
				if(file != -1 && h.file != file){
					h.file = file;
					h.uses ++;
				}
				return true;
			}
		}

		return false;
	}

	private static HashedTile GetByHash(String hash) {
		for(HashedTile h : tiles){
			if(h.hash.equals(hash) || h.hashx.equals(hash) || h.hashy.equals(hash)|| h.hashxy.equals(hash)) return h;
		}

		return null;
	}

	private static short GetTileHash(String hash) {
		short i = 0;
		for(HashedTile h : tiles){
			if(h.hash.equals(hash)) return (short)(i + 0x670);
			if(h.hashx.equals(hash)) return (short)((i + 0x670) | 0x800);
			if(h.hashy.equals(hash)) return (short)((i + 0x670) | 0x1000);
			if(h.hashxy.equals(hash)) return (short)((i + 0x670) | 0x1800);
			i++;
		}

		return -1;
	}

	private static short GetTileHash(String hash, ArrayList<HashedTile> tls) {
		short i = 0;
		for(HashedTile h : tls){
			if(h.hash.equals(hash)) return (short)(i + 1);
			if(h.hashx.equals(hash)) return (short)((i + 1) | 0x800);
			if(h.hashy.equals(hash)) return (short)((i + 1) | 0x1000);
			if(h.hashxy.equals(hash)) return (short)((i + 1) | 0x1800);
			i++;
		}

		return -1;
	}

	private static String CreateHash(byte[] t) {
		String o = "";
		for(int x = 0;x < 32;x ++){
			o += (char)(15 + (t[x] & 0x7) + ((t[x] & 0x70) >> 1));
		}
		return o;
	}

	private static byte[] dohFlip(byte[] data){
		byte[] o = new byte[32];
		for(int i = 0;i < 32;i += 4){
			putInt(o, i, invertBits(readInt(data, i)));
		}
		return o;
	}

	private static byte[] dovFlip(byte[] data) {
		byte[] o = new byte[32];
		for(int i = 32-4, t = 0;i >= 0;i -= 4, t += 4){
			putInt(o, t, readInt(data, i));
		}
		return o;
	}

	private static byte[] dohvFlip(byte[] data) {
		byte[] o = new byte[32];
		for(int i = 32-4, t = 0;i >= 0;i -= 4, t += 4){
			putInt(o, t, invertBits(readInt(data, i)));
		}
		return o;
	}

	private static void putInt(byte[] to, int off, int data) {
		to[off] =     (byte)(data >> 24);
		to[off + 1] = (byte)(data >> 16);
		to[off + 2] = (byte)(data >> 8);
		to[off + 3] = (byte)(data);
	}

	private static int readInt(byte[] d, int i) {
		return d[i] << 24 | (d[i + 1] & 0xFF) << 16 | (d[i + 2] & 0xFF) << 8 | (d[i + 3] & 0xFF);
	}

	private static int invertBits(int i) {
		return (((i << 28) & 0xF0000000) |
				((i << 20) & 0xF000000) |
				((i << 12) & 0xF00000) |
				((i << 4)  & 0xF0000) |
				((i >> 4)  & 0xF000) |
				((i >> 12) & 0xF00) |
				((i >> 20) & 0xF0) |
				((i >> 28) & 0xF));
	}

	private static class HashedTile {
		final String hash, hashx, hashy, hashxy;
		final byte[] tile;
		int uses, file;

		HashedTile(byte[] tile, int file){
			if(tile.length != 32){
				throw new IllegalArgumentException("tile must always be 32 bytes");
			}

			uses = 1;
			this.file = file;
			this.tile = tile;
			hash = CreateHash(tile);
			hashx = CreateHash(dohFlip(tile));
			hashy = CreateHash(dovFlip(tile));
			hashxy = CreateHash(dohvFlip(tile));
		}
	}
}
