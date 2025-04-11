package alternativa.tanks.battle.objects.tank.tankskin.materialfactory {
  import alternativa.osgi.service.display.IDisplay;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.MouseEvent;

  public class DebugBitmapLayer {
    [Inject]
    public static var display:IDisplay;

    private static var isShowing:Boolean = false;
    private static var queue:Vector.<BitmapData> = new Vector.<BitmapData>();
    private static var canvas:Sprite = new Sprite();

    public function DebugBitmapLayer() {
      super();
    }

    public static function show(param1:BitmapData) : void {
      queue.push(param1);
      if(!isShowing) {
        isShowing = true;
        doShow(queue.shift());
      }
    }

    private static function doShow(param1:BitmapData) : void {
      canvas.graphics.clear();
      canvas.graphics.beginFill(11141120);
      canvas.graphics.drawRect(0,0,150,150);
      canvas.graphics.endFill();
      canvas.graphics.beginBitmapFill(param1);
      canvas.graphics.drawRect(0,0,param1.width,param1.height);
      canvas.graphics.endFill();
      canvas.addEventListener(MouseEvent.CLICK,onMouseClick);
      display.stage.addChild(canvas);
    }

    private static function onMouseClick(param1:MouseEvent) : void {
      canvas.removeEventListener(MouseEvent.CLICK,onMouseClick);
      isShowing = false;
      display.stage.removeChild(canvas);
      if(queue.length > 0) {
        isShowing = true;
        doShow(queue.shift());
      }
    }
  }
}
