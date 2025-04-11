package projects.tanks.clients.fp10.Prelauncher.controls.toppanel {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.LocalizedControl;

  public class TopPanel extends LocalizedControl {
    private static var topLine:Class = TopPanel_topLine;

    public static var topLineData:BitmapData = (new topLine() as Bitmap).bitmapData;

    public function TopPanel() {
      super();
      addChild(new TopPanelButton(TopPanelButton.GAME));
      addChild(new TopPanelButton(TopPanelButton.MATERIALS));
      addChild(new TopPanelButton(TopPanelButton.TOURNAMENTS));
      addChild(new TopPanelButton(TopPanelButton.FORUM));
      addChild(new TopPanelButton(TopPanelButton.WIKI));
      addChild(new TopPanelButton(TopPanelButton.RATINGS));
      addChild(new TopPanelButton(TopPanelButton.HELP));
    }

    override protected function onResize(e:Event) : void {
      this.graphics.clear();
      this.graphics.beginBitmapFill(topLineData);
      this.graphics.drawRect(-1000,0,3000,topLineData.height);
      this.graphics.endFill();
    }

    override public function switchLocale(locale:Locale) : void {
      var child:DisplayObject = null;
      var offsetX:int = 20;
      for(var i:int = 0; i < this.numChildren; i++) {
        child = this.getChildAt(i);
        if(child is LocalizedControl) {
          (child as LocalizedControl).switchLocale(locale);
          if(child is TopPanelButton) {
            child.x = offsetX;
            offsetX += (child as TopPanelButton).BUTTON_WIDTH;
          }
        }
      }
    }

    public function addAlignRight(obj:LocalizedControl) : void {
      addChild(obj);
      obj.x = stage.stageWidth - obj.width - 10;
    }
  }
}
