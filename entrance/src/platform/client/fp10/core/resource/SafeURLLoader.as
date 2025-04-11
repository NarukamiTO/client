package platform.client.fp10.core.resource {
  import alternativa.startup.CacheURLLoader;
  import flash.events.Event;

  public class SafeURLLoader extends CacheURLLoader {
    private var opened:Boolean;
    private var closed:Boolean;

    public function SafeURLLoader() {
      super();
      addEventListener(Event.OPEN,this.onOpen,false,int.MAX_VALUE);
    }

    override public function close() : void {
      if(this.opened) {
        this.opened = false;
        super.close();
      } else {
        this.closed = true;
      }
    }

    private function onOpen(param1:Event) : void {
      this.opened = true;
      if(this.closed) {
        this.close();
      }
    }
  }
}
