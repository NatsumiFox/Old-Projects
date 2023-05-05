package co.tracker.core.desktop;

import com.badlogic.gdx.backends.lwjgl.LwjglApplication;
import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration;
import co.tracker.core.CTracker;
import com.badlogic.gdx.graphics.Color;

public class DesktopLauncher {
	public static void main (String[] arg) {
		LwjglApplicationConfiguration config = new LwjglApplicationConfiguration();
		config.vSyncEnabled = true;
		config.title = "Loading...";
		config.backgroundFPS = 6;
		config.foregroundFPS = 30;
		config.width =  256;
		config.height = 224;
		config.fullscreen = false;
		config.initialBackgroundColor = Color.BLACK;
		config.useGL30 = true;
		config.resizable = true;
		new LwjglApplication(new CTracker(), config);
	}
}
