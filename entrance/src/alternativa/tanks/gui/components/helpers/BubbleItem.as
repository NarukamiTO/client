package alternativa.tanks.gui.components.helpers {
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class BubbleItem extends BubbleHelper {
    private static var instance:BubbleItem;

    public function BubbleItem() {
      super();
      addEventListener(MouseEvent.CLICK,this.onMouseClick);
    }

    public static function createBubble(param1:String, param2:DisplayObject, param3:DisplayObjectContainer) : BubbleItem {
      if(instance == null) {
        instance = new BubbleItem();
      }
      instance.text = param1;
      instance.arrowLehgth = 20;
      instance.arrowAlign = HelperAlign.BOTTOM_LEFT;
      instance.x = param2.x;
      instance.y = param2.y - 45;
      instance.targetPoint = new Point(param2.x,20);
      instance.draw(instance.size);
      param3.addChild(instance);
      return instance;
    }

    public static function hide() : void {
      if(instance != null) {
        instance.hide();
      }
    }

    private function onMouseClick(param1:MouseEvent) : void {
      this.hide();
    }

    private function hide() : void {
      if(Boolean(parent)) {
        parent.removeChild(this);
      }
    }
  }
}
