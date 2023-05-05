package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

/**
 * Created by NAT on 16.10.12.
 */
public class ConvertPNGtoMD {
	public static String fol = "G:\\hacks\\current\\s41\\dat\\ani\\";
	public static String get = "G:\\tools\\art\\getart\\";

	public static void main(String[] args) throws IOException {
		assert false;   // assert this is 100% safe ;)
		for(File f : new File(fol).listFiles((dir, name)->name.endsWith(".png"))){
			Files.delete(new File(get + "Bitmap.png").toPath());
			Files.copy(f.toPath(), new File(get + "Bitmap.png").toPath());

			Process p = Runtime.getRuntime().exec("cmd /c cd "+ get +"&& GetArt.NET.exe");
			try {
				p.waitFor();
			} catch (InterruptedException e) {
				e.printStackTrace();
				return;
			}

			UnMapper.main(new File(fol + (f.getName().replace(".png", ".unmap.unc"))));
		}
	}
}
