package projects.tanks.clients.fp10.Prelauncher {
  import projects.tanks.clients.fp10.Prelauncher.locales.TextLinkPair;

  public class Locale {
    public static var current:Locale;

    public var partners:Array;
    public var playText:String;
    public var exitText:String;
    public var aboutCompany:TextLinkPair;
    public var techSupport:TextLinkPair;
    public var email:TextLinkPair;
    public var rules:TextLinkPair;
    public var confidentialityPolicy:TextLinkPair;
    public var license:TextLinkPair;
    public var game:TextLinkPair;
    public var materials:TextLinkPair;
    public var tournaments:TextLinkPair;
    public var forum:TextLinkPair;
    public var wiki:TextLinkPair;
    public var ratings:TextLinkPair;
    public var help:TextLinkPair;
    public var name:String;

    public function Locale() {
      super();
      this.partners = [];
    }
  }
}
