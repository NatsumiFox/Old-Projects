package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by NAT on 19.10.29.
 */
public class RemapLevelTiles {
	static final File tiles = new File("G:\\hacks\\not mine\\Hellfire Saga\\Levels\\GMZ\\Tiles\\Primary.bin");
	static final File tilesx = new File("G:\\hacks\\not mine\\Hellfire Saga\\Levels\\GMZ\\Tiles\\Primary.unc");
	static final File blocks = new File("G:\\hacks\\not mine\\Hellfire Saga\\Levels\\GMZ\\Blocks\\Primary.bin");
	static final File blocksx = new File("G:\\hacks\\not mine\\Hellfire Saga\\Levels\\GMZ\\Blocks\\Primary.bin");
	static final String tilecmp = "koscmp.exe -m";
	static final String blockcmp = null;

	static final int[] remap = new int[]{
			0x223, 0x243, 0x248,
			0xE4, 0xE7, 0x248,
			0xD8, 0xDB, 0x248,
			0xCE, 0xD1, 0x248,
			0xC3, 0xC5, 0x248,
			0xAD, 0xB3, 0x248,
			0x9C, 0xA7, 0x248,
			0x93, 0x96, 0x248,
			0x8D, 0x8E, 0x248,
			0x40, 0x5D, 0x248,
			0x1BF, 0x1CD, 0x160,
	};

	public static void main(String[] args) throws IOException {
		// init tile load
		if(tilecmp != null) call(tilecmp +" -x", tiles.getPath(), tilesx.getPath());
		byte[] t = Files.readAllBytes(tilesx.toPath());

		if((t.length & 0x1F) != 0){
			System.out.println("tile file is invalid");
			return;
		}

		// load tile data
		List<Tile> tls = new ArrayList<>();

		for(int i = 0;i < t.length;i += 32){
			byte[] data = new byte[32];
			System.arraycopy(t, i, data, 0, 32);
			tls.add(new Tile(data));
		}

		// init block load
		if(blockcmp != null) call(blockcmp +" -x", blocks.getPath(), blocksx.getPath());
		byte[] b = Files.readAllBytes(blocksx.toPath());

		if((b.length & 1) != 0){
			System.out.println("block file is invalid");
			return;
		}

		// load block data
		List<TileRef> blk = new ArrayList<>();

		for(int i = 0;i < b.length;i += 2){
			int data = (0xFF00 & (b[i] << 8)) | (0xFF & b[i + 1]);
			blk.add(new TileRef(data, tls));
		}

		// remap tiles
		int offs = 0;
		for(int r = 0;r < remap.length;r += 3){
			for(int i = remap[r + 1];i >= remap[r];i--){
				tls.add(remap[r + 2], tls.remove(i + offs));

				if(remap[r + 2] < i + offs) offs++;
			}
		}

		// save tiles
		for(int i = 0;i < tls.size();i ++)
			System.arraycopy(tls.get(i).data, 0, t, i * 32, 32);

		Files.write(tilesx.toPath(), t);
		if(tilecmp != null){
			call(tilecmp, tilesx.getPath(), tiles.getPath());
			Files.delete(tilesx.toPath());
		}

		// save blocks
		for(int i = 0;i < blk.size();i ++){
			int v = blk.get(i).getValue(tls);
			b[i * 2] = (byte)(v >> 8);
			b[(i * 2)+1] = (byte)v;
		}

		Files.write(blocksx.toPath(), b);
		if(blockcmp != null){
			call(blockcmp, blocks.getPath(), blocksx.getPath());
			Files.delete(blocksx.toPath());
		}
	}

	private static void call(String s, String fin, String fout) {
		try {
			Process p = Runtime.getRuntime().exec("G:\\hacks\\archive\\s41\\bin\\FW_KENSC\\"+ s +" \""+ fin +"\" \""+ fout +"\"");
			p.waitFor();
		} catch (InterruptedException | IOException e) {
			e.printStackTrace();
		}
	}

	private static class Tile {
		Tile(byte[] d){
			data = d;
		}

		byte[] data;
	}

	private static class TileRef {
		TileRef(int d, List<Tile> t){
			mode = d & 0xF800;
			d &= 0x7FF;

			if(d >= t.size()){
				tile = null;
				mode |= d;

			} else {
				tile = t.get(d);
			}
		}

		Tile tile;
		int mode;

		int getValue(List<Tile> t){
			return mode | t.indexOf(tile);
		}
	}
}
