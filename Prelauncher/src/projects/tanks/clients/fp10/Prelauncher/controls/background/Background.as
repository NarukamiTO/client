package projects.tanks.clients.fp10.Prelauncher.controls.background {
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.Event;

  public class Background extends Sprite {
    private static var background:Class = Background_background;

    public function Background() {
      super();
      addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
    }

    private function addedToStage(e:Event) : void {
      var bitmap:Bitmap = new background() as Bitmap;
      bitmap.scaleX = stage.stageWidth / bitmap.width;
      bitmap.scaleY = bitmap.scaleX;
      addChild(bitmap);
      removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
    }

    private function removedFromStage(e:Event) : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
    }
  }
}
