package co.tracker.core;

import co.tracker.api.FixedSpriteBatchShader;
import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.files.FileHandle;
import com.badlogic.gdx.graphics.*;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.utils.ScreenUtils;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Random;

public class CTracker extends ApplicationAdapter {
	private static CTracker INSTANCE;

	private OrthographicCamera camera;
	SpriteBatch batch;
	Texture spx;
	Random r;
	ArrayList<MovingPixel> px1 = new ArrayList<>();
	ArrayList<MovingPixel> px2 = new ArrayList<>();
	ArrayList<MovingPixel> px3 = new ArrayList<>();
	ArrayList<MovingPixel> px4 = new ArrayList<>();
	public static final int RCTMSAMOUNT = 20;
	int rctms = 0;
	
	@Override
	public void create () {
		INSTANCE = this;
		camera = new OrthographicCamera(256, 224);
		camera.setToOrtho(true);

		batch = FixedSpriteBatchShader.i();
		batch.setProjectionMatrix(camera.combined);

		spx = new Texture("singlepixel.png");
		r = new Random(System.currentTimeMillis());
	}

	@Override
	public void render() {
		Gdx.gl.glClearColor(0, 0, 0, 0);
		Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
		batch.begin();
		batch.setColor(Color.BLACK);
		batch.draw(spx, 0, 0, Gdx.graphics.getHeight(), Gdx.graphics.getWidth());

		render(px1.toArray(new MovingPixel[px1.size()]), 256 / 2);
		render(px4.toArray(new MovingPixel[px4.size()]), 256 / 2);
		render(px3.toArray(new MovingPixel[px3.size()]), 256 / 2);
		render(px2.toArray(new MovingPixel[px2.size()]), 256 / 2);

		batch.end();
		float w = 256 / 2;

		while(px1.size() + px2.size() + px3.size() + px4.size() < 2000){
			float baseX = intPoses[Math.abs(r.nextInt() % intPoses.length)];
			float _x = baseX + (getxMul(baseX) == 0 ? 0 : Math.abs(r.nextInt() % 50)), _y = (Math.abs(r.nextInt()) % (224 + 60)) - 30;
			float _w = pixelSizes[(int)((_x / (w / 3) * 4) + Math.abs(r.nextInt() % 3))];
			float _h = pixelSizes[(int)((_x / (w / 3) * 4) + Math.abs(r.nextInt() % 3))];

			if(_x >= ((256 / 2) / 4) * 2){
				_h *= 2;
			}

			Color c = new Color(colorList[((getxMul(_x) * 4) + Math.abs(r.nextInt() % 3))]);
			getList(_x).add(0, new MovingPixel(_x, _y, _w, _h, c));
		}

		if(Gdx.input.isKeyJustPressed(Input.Keys.SPACE)){
			rctms = RCTMSAMOUNT;
		}

		if(rctms-- > 0) {
			FileHandle fh = new FileHandle(Gdx.files.getLocalStoragePath() +"screenshot"+ getHex(2, RCTMSAMOUNT - rctms - 1) +".png");
			if(fh.exists()) fh.delete();

			Pixmap pixmap = getScreenshot(0, 0, 256 / 2, 224, false);
			PixmapIO.writePNG(fh, pixmap);
			pixmap.dispose();
		}
	}

	private Pixmap getScreenshot(int x, int y, int w, int h, boolean yDown) {
		final Pixmap pixmap = ScreenUtils.getFrameBufferPixmap(x, y, w, h);

		if (yDown) {
			// Flip the pixmap upside down
			ByteBuffer pixels = pixmap.getPixels();
			int numBytes = w * h * 4;
			byte[] lines = new byte[numBytes];
			int numBytesPerLine = w * 4;

			for (int i = 0; i < h; i++) {
				pixels.position((h - i - 1) * numBytesPerLine);
				pixels.get(lines, i * numBytesPerLine, numBytesPerLine);
			}

			pixels.clear();
			pixels.put(lines);
		}

		return pixmap;
	}

	public static String getHex(int amount, int value) {
		return String.format("%0"+ amount +"X", value);
	}

	private int getxMul(float x) {
		if(x < ((256 / 2) / 4) * ipMuls[0]) return 0;
		if(x < ((256 / 2) / 4) * ipMuls[1]) return 1;
		if(x < ((256 / 2) / 4) * ipMuls[2]) return 2;

		return 3;
	}

	private ArrayList<MovingPixel> getList(float x) {
		switch ((int) (x / (256 / 8))){
			case 0:
				return px1;

			case 1:
				return px2;

			case 2:
				return px3;

			case 3:
				return px4;
		}

		System.err.println("x = "+ (int) (x / (256 / 8)) +" "+ x);
		return px4;
	}

	private void render(MovingPixel[] px, int x) {
		for (MovingPixel p : px) {
			p.run();
			batch.setColor(p.getColor());
			batch.draw(spx, x + p.getX(), p.getY(), p.getW(), p.getH());
			batch.draw(spx, x - p.getX() - p.getW(), p.getY(), p.getW(), p.getH());
		}
	}

	private float[] pixelSizes = new float[]{
			 1,  2,  2,  3,
			15, 18, 24, 28,
			20, 22, 28, 36,
			30, 45, 50, 60,
	};
	/*private Color[] colorList = new Color[]{
			new Color(1f, 1f, 1f, 1f), new Color(0f, 1f, 1f, 1f), new Color(1f, 0f, 1f, 1f), new Color(1f, 1f, 0f, 1f),
			new Color(0f, 0f, 1f, 1f), new Color(0f, 1f, 0f, 1f), new Color(1f, 0f, 0f, 1f), new Color(0.5f, 0.5f, 0.5f, 1f),
			new Color(0f, 0.5f, 0.5f, 1f), new Color(0.5f, 0f, 0.5f, 1f), new Color(0.5f, 0.5f, 0f, 1f), new Color(0f, 0f, 0.5f, 1f),
			new Color(0f, 0.5f, 0f, 1f), new Color(0.5f, 0f, 0f, 1f), new Color(0f, 0.5f, 1f, 1f), new Color(1f, 0.5f, 0f, 1f),
	};*/
	private Color[] colorList = new Color[]{
			new Color(0.65f, 0f, 0f, 0.65f), new Color(0.65f, 0.35f, 0f, 0.65f), new Color(0.35f, 0.65f, 0f, 0.65f), new Color(0f, 0.65f, 0f, 0.65f),
			new Color(0.65f, 0f, 0f, 0.65f), new Color(0.65f, 0.35f, 0f, 0.65f), new Color(0.35f, 0.65f, 0f, 0.65f), new Color(0f, 0.65f, 0f, 0.65f),
			new Color(0.65f, 0f, 0f, 0.65f), new Color(0.65f, 0.35f, 0f, 0.65f), new Color(0.35f, 0.65f, 0f, 0.65f), new Color(0f, 0.65f, 0f, 0.65f),
			new Color(0.65f, 0f, 0f, 0.65f), new Color(0.65f, 0.35f, 0f, 0.65f), new Color(0.35f, 0.65f, 0f, 0.65f), new Color(0f, 0.65f, 0f, 0.65f),
	};
	private float[] ipMuls = new float[]{
			0.5f, 1.2f, 2.2f,
	};
	private float[] intPoses = new float[]{
			0, 0,
			((256 / 2) / 4)*ipMuls[0], ((256 / 2) / 4)*ipMuls[0], ((256 / 2) / 4)*ipMuls[0], ((256 / 2) / 4)*ipMuls[0], ((256 / 2) / 4)*ipMuls[0], ((256 / 2) / 4)*ipMuls[0], ((256 / 2) / 4)*ipMuls[0],
			((256 / 2) / 4)*ipMuls[1], ((256 / 2) / 4)*ipMuls[1], ((256 / 2) / 4)*ipMuls[1], ((256 / 2) / 4)*ipMuls[1], ((256 / 2) / 4)*ipMuls[1], ((256 / 2) / 4)*ipMuls[1],
			((256 / 2) / 4)*ipMuls[2], ((256 / 2) / 4)*ipMuls[2], ((256 / 2) / 4)*ipMuls[2],
	};

	@Override
	public void resize(int width, int height) {
		camera.setToOrtho(true, 256, 224);
		batch.setProjectionMatrix(camera.combined);
	}

	private void remove(MovingPixel px) {
		px1.remove(px);
		px2.remove(px);
		px3.remove(px);
		px4.remove(px);
	}

	private class MovingPixel {
		private float x, y, w, h;
		private float xv = 0, xspd, fspd;
		private Color color;

		public MovingPixel(float _x, float _y, float _w, float _h, Color c) {
			x = _x;
			y = _y;
			w = _w;
			h = _h;
			color = c;
			xspd = 1 + (r.nextFloat());
			fspd = 0.025f + (r.nextFloat() / 6);
		}

		public void run() {
			xv += xspd;
			x += xv;
			if(x > Gdx.graphics.getWidth() / 2){
				remove(this);
			}
		}

		public float getX() {
			return x;
		}

		public float getY() {
			return y;
		}

		public float getW() {
			return w;
		}

		public float getH() {
			return h;
		}

		public Color getColor() {
			return color;
		}
	}
}
