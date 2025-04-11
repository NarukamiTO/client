package projects.tanks.clients.fp10.Prelauncher.steam {
  import flash.display.Shape;
  import flash.events.Event;

  public class SteamRenderer extends Shape {
    public function SteamRenderer() {
      super();
      graphics.beginFill(0,0);
      graphics.drawRect(0,0,1,1);
      graphics.endFill();
      addEventListener(Event.ADDED,this.onAdded);
    }

    private function onAdded(event:Event) : void {
      removeEventListener(Event.ADDED,this.onAdded);
      addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
    }

    private function onEnterFrame(event:Event) : void {
      rotation += 1;
    }
  }
}
