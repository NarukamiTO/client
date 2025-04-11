package alternativa.startup {
  import flash.display.Sprite;
  import flash.system.Capabilities;

  public class StartupSettings {
    public static var preLauncher:Sprite;

    public function StartupSettings() {
      super();
    }

    public static function closeApplication() : void {
      if(preLauncher != null) {
        preLauncher["closeLauncher"]();
      }
    }

    public static function isUserFromTutorial() : Boolean {
      if(preLauncher != null) {
        return preLauncher["isUserFromTutorial"]();
      }
      return false;
    }

    public static function get isDesktop() : Boolean {
      return Capabilities.playerType == "Desktop" || Capabilities.playerType == "External";
    }
  }
}
