package projects.tanks.clients.fp10.TanksLauncher.background {
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.events.Event;

  public class Background extends Shape {
    private static const tileClass:Class = Background_tileClass;
    private static const tileBitmapData:BitmapData = new tileClass().bitmapData;

    public function Background() {
      super();
      this.init();
    }

    private function init() : void {
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    private function onAddedToStage(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      stage.addEventListener(Event.RESIZE,this.onResize);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      this.redrawBackground();
    }

    private function onRemoveFromStage(param1:Event) : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      stage.removeEventListener(Event.RESIZE,this.onResize);
    }

    private function onResize(param1:Event) : void {
      this.redrawBackground();
    }

    private function redrawBackground() : void {
      this.graphics.clear();
      this.graphics.beginBitmapFill(tileBitmapData);
      this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
    }
  }
}
