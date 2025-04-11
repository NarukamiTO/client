package projects.tanks.clients.fp10.Prelauncher.controls.bottompanel.LinkField {
  import flash.events.MouseEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.makeup.MakeUp;

  public class LinkField extends TextField {
    public static const ABOUT:String = "aboutCompany";
    public static const TECHSUPPORT:String = "techSupport";
    public static const EMAIL:String = "email";
    public static const RULES:String = "rules";
    public static const CONFIDENT:String = "confidentialityPolicy";
    public static const LICENSE:String = "license";

    private const TEXT_COLOR:uint = 16777215;

    private var textFormat:TextFormat = new TextFormat();
    private var link:String;
    private var fieldType:String;

    public function LinkField(type:String, _locale:Locale = null) {
      super();
      var locale:Locale = _locale == null ? Locale.current : _locale;
      if(locale[type] == null) {
        return;
      }
      this.textFormat.font = MakeUp.getFont(locale);
      this.textFormat.size = 12;
      this.fieldType = type;
      this.autoSize = TextFieldAutoSize.LEFT;
      this.selectable = false;
      this.textColor = this.TEXT_COLOR;
      this.embedFonts = locale.name != Locales.CN;
      if(locale[type].link != "") {
        this.textFormat.underline = true;
        this.link = locale[type].link;
        addEventListener(MouseEvent.CLICK,this.onMouseClick);
        addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      this.defaultTextFormat = this.textFormat;
      this.text = locale[type].text;
    }

    private function onMouseOver(e:MouseEvent) : void {
      Mouse.cursor = MouseCursor.BUTTON;
    }

    private function onMouseOut(e:MouseEvent) : void {
      Mouse.cursor = MouseCursor.AUTO;
    }

    private function onMouseClick(e:MouseEvent) : void {
      navigateToURL(new URLRequest(this.link));
    }
  }
}
