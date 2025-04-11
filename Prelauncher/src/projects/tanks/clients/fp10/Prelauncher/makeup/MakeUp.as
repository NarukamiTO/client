package projects.tanks.clients.fp10.Prelauncher.makeup {
  import flash.display.Bitmap;
  import flash.text.Font;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.toppanel.TopPanelButton;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;

  public class MakeUp {
    private static var myriadProFont:Class = MakeUp_myriadProFont;
    private static var myriadProBoldFont:Class = MakeUp_myriadProBoldFont;
    private static var gameIconMakeUp:Class = MakeUp_gameIconMakeUp;
    private static var gameActiveIconMakeUp:Class = MakeUp_gameActiveIconMakeUp;
    private static var materialsIconMakeUp:Class = MakeUp_materialsIconMakeUp;
    private static var materialsActiveIconMakeUp:Class = MakeUp_materialsActiveIconMakeUp;
    private static var tournamentsIconMakeUp:Class = MakeUp_tournamentsIconMakeUp;
    private static var tournamentsActiveIconMakeUp:Class = MakeUp_tournamentsActiveIconMakeUp;
    private static var forumIconMakeUp:Class = MakeUp_forumIconMakeUp;
    private static var forumActiveIconMakeUp:Class = MakeUp_forumActiveIconMakeUp;
    private static var wikiIconMakeUp:Class = MakeUp_wikiIconMakeUp;
    private static var wikiActiveIconMakeUp:Class = MakeUp_wikiActiveIconMakeUp;
    private static var ratingsIconMakeUp:Class = MakeUp_ratingsIconMakeUp;
    private static var ratingsActiveIconMakeUp:Class = MakeUp_ratingsActiveIconMakeUp;
    private static var helpIconMakeUp:Class = MakeUp_helpIconMakeUp;
    private static var helpActiveIconMakeUp:Class = MakeUp_helpActiveIconMakeUp;
    private static var logoMakeUp:Class = MakeUp_logoMakeUp;
    private static var chineseLogoMakeUp:Class = MakeUp_chineseLogoMakeUp;
    private static var buttonGreen:Class = MakeUp_buttonGreen;
    private static var buttonGreenOver:Class = MakeUp_buttonGreenOver;
    private static var buttonRed:Class = MakeUp_buttonRed;
    private static var buttonRedOver:Class = MakeUp_buttonRedOver;
    private static var dropGreen:Class = MakeUp_dropGreen;
    private static var dropWhite:Class = MakeUp_dropWhite;
    private static var vkIcon:Class = MakeUp_vkIcon;
    private static var facebookIcon:Class = MakeUp_facebookIcon;
    private static var twitterIcon:Class = MakeUp_twitterIcon;
    private static var twitchIcon:Class = MakeUp_twitchIcon;
    private static var youtubeIcon:Class = MakeUp_youtubeIcon;
    private static var instIcon:Class = MakeUp_instIcon;
    private static var okIcon:Class = MakeUp_okIcon;
    private static var gplusIcon:Class = MakeUp_gplusIcon;

    public function MakeUp() {
      super();
    }

    public static function getStartButtonMakeUp() : Bitmap {
      return new buttonGreen();
    }

    public static function getActiveStartButtonMakeUp() : Bitmap {
      return new buttonGreenOver();
    }

    public static function getExitButtonMakeUp() : Bitmap {
      return new buttonRed();
    }

    public static function getActiveExitButtonMakeUp() : Bitmap {
      return new buttonRedOver();
    }

    public static function getDropGreenMakeUp() : Bitmap {
      return new dropGreen();
    }

    public static function getDropMakeUp() : Bitmap {
      return new dropWhite();
    }

    public static function getLogoMakeUp(locale:Locale) : Bitmap {
      if(locale.name == Locales.CN) {
        return new chineseLogoMakeUp();
      }
      return new logoMakeUp();
    }

    public static function getIconMakeUp(type:String) : Bitmap {
      switch(type) {
        case TopPanelButton.GAME:
          return new gameIconMakeUp();
        case TopPanelButton.MATERIALS:
          return new materialsIconMakeUp();
        case TopPanelButton.TOURNAMENTS:
          return new tournamentsIconMakeUp();
        case TopPanelButton.FORUM:
          return new forumIconMakeUp();
        case TopPanelButton.WIKI:
          return new wikiIconMakeUp();
        case TopPanelButton.RATINGS:
          return new ratingsIconMakeUp();
        case TopPanelButton.HELP:
          return new helpIconMakeUp();
        default:
          return null;
      }
    }

    public static function getActiveIconMakeUp(type:String) : Bitmap {
      switch(type) {
        case TopPanelButton.GAME:
          return new gameActiveIconMakeUp();
        case TopPanelButton.MATERIALS:
          return new materialsActiveIconMakeUp();
        case TopPanelButton.TOURNAMENTS:
          return new tournamentsActiveIconMakeUp();
        case TopPanelButton.FORUM:
          return new forumActiveIconMakeUp();
        case TopPanelButton.WIKI:
          return new wikiActiveIconMakeUp();
        case TopPanelButton.RATINGS:
          return new ratingsActiveIconMakeUp();
        case TopPanelButton.HELP:
          return new helpActiveIconMakeUp();
        default:
          return null;
      }
    }

    public static function getVKIcon() : Bitmap {
      return new vkIcon();
    }

    public static function getFacebookIcon() : Bitmap {
      return new facebookIcon();
    }

    public static function getTwitterIcon() : Bitmap {
      return new twitterIcon();
    }

    public static function getYoutubeIcon() : Bitmap {
      return new youtubeIcon();
    }

    public static function getInstagramIcon() : Bitmap {
      return new instIcon();
    }

    public static function getOKIcon() : Bitmap {
      return new okIcon();
    }

    public static function getGooglePlusIcon() : Bitmap {
      return new gplusIcon();
    }

    public static function getTwitchIcon() : Bitmap {
      return new twitchIcon();
    }

    private static function hasEmbeddedFont(fontName:String) : Boolean {
      var font:Font = null;
      var fonts:Array = Font.enumerateFonts();
      for each(font in fonts) {
        if(font.fontName == fontName) {
          return true;
        }
      }
      return false;
    }

    public static function getFont(locale:Locale) : String {
      if(locale.name == Locales.CN) {
        return "Arial";
      }
      if(hasEmbeddedFont("Myriad Pro")) {
        return "Myriad Pro";
      }
      return "Embedded Myriad Pro Bold";
    }
  }
}
