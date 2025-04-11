package projects.tanks.clients.fp10.TanksLauncherErrorScreen {
  import flash.text.Font;
  import flash.text.TextFormat;
  import projects.tanks.clients.tankslauncershared.service.Locale;

  public class TankFont {
    private static const MyriadPro:Class = TankFont_MyriadPro;

    public function TankFont() {
      super();
      Font.registerFont(MyriadPro);
    }

    public static function getLocaleTextFormat(locale:String, size:int) : TextFormat {
      if(locale == Locale.CN) {
        return new TextFormat("simsun",size);
      }
      return new TextFormat("MyriadPro",size);
    }

    public static function needEmbedFont(locale:String) : Boolean {
      return locale != Locale.CN;
    }
  }
}
