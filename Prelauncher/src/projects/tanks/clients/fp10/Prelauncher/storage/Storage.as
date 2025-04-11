package projects.tanks.clients.fp10.Prelauncher.storage {
  import flash.filesystem.File;
  import flash.filesystem.FileMode;
  import flash.filesystem.FileStream;
  import flash.net.SharedObject;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.LocalesFactory;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;

  public class Storage {
    private static const DISPLAY_STATE:String = "display.bin";
    private static const LAST_LOCALE:String = "LAST_LOCALE";
    private static const LAST_SERVER:String = "LAST_SERVER";
    private static const DEFAULT_STATE:DisplayState = new DisplayState(100,100,1024,768,false);

    private static var sharedObject:SharedObject = SharedObject.getLocal("launcherStorage");

    public function Storage() {
      super();
    }

    private static function getProperty(name:String) : Object {
      return sharedObject.data.hasOwnProperty(name) ? sharedObject.data[name] : null;
    }

    public static function set lastSessionLocale(value:int) : void {
      sharedObject.data[LAST_LOCALE] = value;
      sharedObject.flush();
    }

    public static function setBattleServer(value:int) : void {
      sharedObject.data[LAST_SERVER] = value;
      sharedObject.flush();
    }

    public static function setDisplayState(x:int, y:int, width:int, height:int, isInFullscreen:Boolean) : void {
      var file:File = File.applicationStorageDirectory.resolvePath(DISPLAY_STATE);
      var fileStream:FileStream = new FileStream();
      try {
        fileStream.open(file,FileMode.WRITE);
        fileStream.writeInt(x);
        fileStream.writeInt(y);
        fileStream.writeInt(width);
        fileStream.writeInt(height);
        fileStream.writeBoolean(isInFullscreen);
        fileStream.close();
      }
      catch(e:Error) {
      }
    }

    public static function getLastSessionLocale(defaultLocale:Locale) : Locale {
      var localeIndex:Object = getProperty(LAST_LOCALE);
      return localeIndex == null ? defaultLocale : LocalesFactory.getLocale(Locales.list[int(localeIndex)]);
    }

    public static function getLastBattleServer() : int {
      var server:Object = getProperty(LAST_SERVER);
      if(server != null) {
        delete sharedObject.data[LAST_SERVER];
      }
      return server == null ? -1 : int(server);
    }

    public static function getDisplayState() : DisplayState {
      var fileStream:FileStream;
      var state:DisplayState = null;
      var file:File = File.applicationStorageDirectory.resolvePath(DISPLAY_STATE);
      if(!file.exists) {
        return DEFAULT_STATE;
      }
      fileStream = new FileStream();
      try {
        fileStream.open(file,FileMode.READ);
        state = new DisplayState(fileStream.readInt(),fileStream.readInt(),fileStream.readInt(),fileStream.readInt(),fileStream.readBoolean());
        fileStream.close();
      }
      catch(e:Error) {
        state = DEFAULT_STATE;
      }
      finally {
        return state;
      }
    }
  }
}
