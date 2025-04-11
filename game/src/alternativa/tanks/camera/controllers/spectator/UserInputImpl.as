package alternativa.tanks.camera.controllers.spectator {
  import alternativa.tanks.utils.BitMask;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;
  import flash.utils.Dictionary;

  public class UserInputImpl implements UserInput, KeyboardHandler {
    public static const BIT_FORWARD:int = 0;
    public static const BIT_BACK:int = 1;
    public static const BIT_LEFT:int = 2;
    public static const BIT_RIGHT:int = 3;
    public static const BIT_UP:int = 4;
    public static const BIT_DOWN:int = 5;
    public static const BIT_ACCELERATION:int = 6;
    public static const BIT_YAW_LEFT:int = 7;
    public static const BIT_YAW_RIGHT:int = 8;
    public static const BIT_PITCH_UP:int = 9;
    public static const BIT_PITCH_DOWN:int = 10;

    private static const ROTATION_MASK:int = 1 << BIT_PITCH_DOWN | 1 << BIT_PITCH_UP | 1 << BIT_YAW_LEFT | 1 << BIT_YAW_RIGHT;

    private var keyMap:Dictionary = new Dictionary();
    private var controlBits:BitMask = new BitMask();

    public function UserInputImpl() {
      super();
      this.keyMap[Keyboard.W] = BIT_FORWARD;
      this.keyMap[Keyboard.S] = BIT_BACK;
      this.keyMap[Keyboard.A] = BIT_LEFT;
      this.keyMap[Keyboard.D] = BIT_RIGHT;
      this.keyMap[Keyboard.Q] = BIT_DOWN;
      this.keyMap[Keyboard.E] = BIT_UP;
      this.keyMap[Keyboard.SHIFT] = BIT_ACCELERATION;
      this.keyMap[Keyboard.LEFT] = BIT_YAW_LEFT;
      this.keyMap[Keyboard.RIGHT] = BIT_YAW_RIGHT;
      this.keyMap[Keyboard.UP] = BIT_PITCH_UP;
      this.keyMap[Keyboard.DOWN] = BIT_PITCH_DOWN;
    }

    public function getForwardDirection() : int {
      return this.getDirection(BIT_FORWARD,BIT_BACK);
    }

    public function getSideDirection() : int {
      return this.getDirection(BIT_RIGHT,BIT_LEFT);
    }

    public function getVerticalDirection() : int {
      return this.getDirection(BIT_UP,BIT_DOWN);
    }

    public function isAccelerated() : Boolean {
      return this.controlBits.getBitValue(BIT_ACCELERATION) == 1;
    }

    public function handleKeyDown(param1:KeyboardEvent) : void {
      if(this.keyMap[param1.keyCode] != null) {
        this.controlBits.setBit(this.keyMap[param1.keyCode]);
      }
    }

    public function handleKeyUp(param1:KeyboardEvent) : void {
      if(this.keyMap[param1.keyCode] != null) {
        this.controlBits.clearBit(this.keyMap[param1.keyCode]);
      }
    }

    public function getYawDirection() : int {
      return this.getDirection(BIT_YAW_LEFT,BIT_YAW_RIGHT);
    }

    public function getPitchDirection() : int {
      return this.getDirection(BIT_PITCH_UP,BIT_PITCH_DOWN);
    }

    public function isRotating() : Boolean {
      return this.controlBits.hasAnyBit(ROTATION_MASK);
    }

    private function getDirection(param1:int, param2:int) : int {
      return this.controlBits.getBitValue(param1) - this.controlBits.getBitValue(param2);
    }

    public function reset() : void {
      this.controlBits.clear();
    }
  }
}
