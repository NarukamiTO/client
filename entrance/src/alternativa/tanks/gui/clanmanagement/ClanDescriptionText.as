package alternativa.tanks.gui.clanmanagement {
  import alternativa.tanks.utils.LinksInterceptor;
  import controls.base.LabelBase;
  import flash.events.TextEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;

  public class ClanDescriptionText extends LabelBase {
    public function ClanDescriptionText() {
      super();
    }

    override public function set text(param1:String) : void {
      var local2:LinksInterceptor = new LinksInterceptor(new Vector.<String>());
      var local3:String = local2.checkLinks(param1);
      var local4:Boolean = local2.htmlFlag;
      if(local4) {
        super.htmlText = local3;
      } else {
        super.text = local3;
      }
      correctCursorBehaviour = false;
      selectable = true;
      addEventListener(TextEvent.LINK,this.onTextLink);
    }

    private function onTextLink(param1:TextEvent) : void {
      var local2:String = param1.text;
      navigateToURL(new URLRequest(local2),"_blank");
    }
  }
}
