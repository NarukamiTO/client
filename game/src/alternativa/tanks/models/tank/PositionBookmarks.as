package alternativa.tanks.models.tank {
  import alternativa.math.Vector3;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.objects.tank.Tank;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;

  public class PositionBookmarks {
    [Inject]
    public static var display:IDisplay;

    private var tank:Tank;
    private var bookmarks:Vector.<Vector3>;
    private var keyCodes:Vector.<uint>;

    public function PositionBookmarks(param1:Tank) {
      super();
      this.tank = param1;
      this.bookmarks = new Vector.<Vector3>(10);
      this.keyCodes = Vector.<uint>([Keyboard.NUMBER_1,Keyboard.NUMBER_2,Keyboard.NUMBER_3,Keyboard.NUMBER_4,Keyboard.NUMBER_5,Keyboard.NUMBER_6,Keyboard.NUMBER_7,Keyboard.NUMBER_8,Keyboard.NUMBER_9,Keyboard.NUMBER_0]);
    }

    public function enable() : void {
      display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
    }

    public function disable() : void {
      display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
    }

    private function onKeyDown(param1:KeyboardEvent) : void {
      var local2:int = int(this.keyCodes.indexOf(param1.keyCode));
      if(local2 >= 0) {
        if(param1.ctrlKey) {
          this.storePosition(local2);
        } else {
          this.restorePosition(local2);
        }
      }
    }

    private function storePosition(param1:int) : void {
      this.bookmarks[param1] = this.tank.getBody().state.position.clone();
    }

    private function restorePosition(param1:int) : void {
      var local2:Vector3 = this.bookmarks[param1];
      if(local2 != null) {
        this.tank.getBody().setPosition(local2);
      }
    }
  }
}
