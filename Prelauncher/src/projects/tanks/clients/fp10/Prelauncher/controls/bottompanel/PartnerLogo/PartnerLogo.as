package projects.tanks.clients.fp10.Prelauncher.controls.bottompanel.PartnerLogo {
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  import projects.tanks.clients.fp10.Prelauncher.makeup.MakeUp;

  public class PartnerLogo extends Sprite {
    public static var VK:String = "VK";
    public static var FB:String = "FB";
    public static var GP:String = "G+";
    public static var YOUTUBE:String = "YOUTUBE";
    public static var TWITTER:String = "TWITTER";
    public static var INSTAGRAM:String = "INSTAGRAM";
    public static var TWITCH:String = "2TWITCH";
    public static var OK:String = "OK";

    public var actualWidth:Number = 0;

    private var link:String = "";
    private var type:String = "";

    public function PartnerLogo(type:String, link:String) {
      super();
      this.link = link;
      this.type = type;
      addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void {
        Mouse.cursor = MouseCursor.BUTTON;
      });
      addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void {
        Mouse.cursor = MouseCursor.AUTO;
      });
      addEventListener(MouseEvent.CLICK,this.onClick);
      switch(type) {
        case VK:
          this.addLogo(MakeUp.getVKIcon());
          break;
        case FB:
          this.addLogo(MakeUp.getFacebookIcon());
          break;
        case GP:
          this.addLogo(MakeUp.getGooglePlusIcon());
          break;
        case YOUTUBE:
          this.addLogo(MakeUp.getYoutubeIcon());
          break;
        case TWITTER:
          this.addLogo(MakeUp.getTwitterIcon());
          break;
        case TWITCH:
          this.addLogo(MakeUp.getTwitchIcon());
          break;
        case INSTAGRAM:
          this.addLogo(MakeUp.getInstagramIcon());
          break;
        case OK:
          this.addLogo(MakeUp.getOKIcon());
      }
    }

    private function addLogo(logo:Bitmap) : void {
      this.actualWidth = logo.width;
      addChild(logo);
      logo.x = -logo.width >> 1;
      logo.y = -logo.height >> 1;
    }

    private function onClick(e:MouseEvent) : void {
      navigateToURL(new URLRequest(this.link));
    }
  }
}
