package projects.tanks.clients.fp10.Prelauncher.controls {
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import projects.tanks.clients.fp10.Prelauncher.Locale;

  public class LocalizedControl extends Sprite {
    public function LocalizedControl() {
      super();
      addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
    }

    private function addedToStage(e:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      addEventListener(Event.RESIZE,this.onResize);
      this.onResize(null);
    }

    private function removedFromStage(e:Event) : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      removeEventListener(Event.RESIZE,this.onResize);
    }

    protected function onResize(e:Event) : void {
    }

    public function switchLocale(locale:Locale) : void {
    }

    protected function addChildToCenter(child:DisplayObject) : void {
      addChild(child);
      child.x = -child.width >> 1;
      child.y = -child.height >> 1;
    }
  }
}
