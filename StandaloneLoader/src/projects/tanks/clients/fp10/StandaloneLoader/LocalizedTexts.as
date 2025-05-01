package projects.tanks.clients.fp10.StandaloneLoader {
  public class LocalizedTexts {
    public static const LOCALE_RU:String = "ru";
    public static const LOCALE_BR:String = "br";
    public static const LOCALE_CN:String = "cn";

    private static var _NEW_VERSION_AVAILABLE:String = "";
    private static var _CONNECTION_ERROR:String = "";

    public function LocalizedTexts() {
      super();
    }

    public static function setLocale(newLocale:String) : void {
      switch(newLocale) {
        case LOCALE_RU:
          setLocaleRU();
          break;
        case LOCALE_BR:
          setLocaleUS();
          break;
        default:
          setLocaleUS();
      }
    }

    private static function setLocaleRU() : void {
      _NEW_VERSION_AVAILABLE = "Доступна новая версия: %VERSION%\nТекущая версия: %CURRENT_VERSION%\n" + "Пожалуйста скачайте новую версию с http://tankionline.com";
      _CONNECTION_ERROR = "Ошибка подключения! Проверьте доступ к сети интернет.";
    }

    private static function setLocaleUS() : void {
      _NEW_VERSION_AVAILABLE = "New version available: %VERSION%\nCurrent version: %CURRENT_VERSION%\n" + "Please visit: http://tankionline.com";
      _CONNECTION_ERROR = "Connection error! Please check your internet connection.";
    }

    public static function NEW_VERSION_AVAILABLE(version:String, currentVersion:String) : String {
      return _NEW_VERSION_AVAILABLE.replace("%VERSION%",version).replace("%CURRENT_VERSION%",currentVersion);
    }

    public static function get CONNECTION_ERROR() : String {
      return _CONNECTION_ERROR;
    }
  }
}
