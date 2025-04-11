package alternativa.tanks.battle.objects.tank.controllers {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.utils.BitMask;
  import alternativa.tanks.utils.MathUtils;
  import platform.client.fp10.core.type.AutoClosable;

  public class ChassisController implements AutoClosable {
    public static const BIT_FORWARD:int = 0;
    public static const BIT_BACK:int = 1;
    public static const BIT_LEFT:int = 2;
    public static const BIT_RIGHT:int = 3;
    public static const BIT_REVERSE_TURN:int = 4;

    protected var controlState:int;
    protected var turnSpeedNumber:int;
    protected var appliedControlState:int;

    private var tank:Tank;
    private var lockMask:BitMask = new BitMask();

    protected var listener:ChassisControlListener;

    public function ChassisController(param1:Tank, param2:ChassisControlListener) {
      super();
      this.tank = param1;
      this.listener = param2;
    }

    private function isNotLocked() : Boolean {
      return this.lockMask.isEmpty();
    }

    public function lock(param1:int) : void {
      var local2:Boolean = this.isNotLocked();
      this.lockMask.setBits(param1);
      if(local2 && !this.isNotLocked()) {
        this.applyControlState(0,0);
      }
    }

    public function unlock(param1:int) : void {
      var local2:Boolean = this.isNotLocked();
      this.lockMask.clearBits(param1);
      if(this.isNotLocked() && !local2) {
        this.applyControlState(this.controlState,this.turnSpeedNumber);
      }
    }

    public function getControlState() : int {
      return this.isNotLocked() ? this.controlState : 0;
    }

    public function setControlState(param1:int, param2:int) : void {
      this.controlState = param1;
      this.turnSpeedNumber = param2;
      if(this.isNotLocked()) {
        this.applyControlState(param1,param2);
      }
    }

    private function applyControlState(param1:int, param2:int) : void {
      var local3:int = this.appliedControlState;
      this.appliedControlState = param1;
      var local4:int = MathUtils.getBitValue(param1,BIT_FORWARD) - MathUtils.getBitValue(param1,BIT_BACK);
      var local5:Number = MathUtils.getBitValue(param1,BIT_LEFT) - MathUtils.getBitValue(param1,BIT_RIGHT);
      var local6:Boolean = MathUtils.getBitValue(param1,BIT_REVERSE_TURN) == 1;
      this.tank.setMovementParams(local4,local5,param2,local6);
      if(local3 != this.appliedControlState) {
        this.onAppliedControlStateChanged(this.appliedControlState);
      }
    }

    protected function onAppliedControlStateChanged(param1:int) : void {
      this.listener.onChassisControlChanged(param1,false);
    }

    protected function getTank() : Tank {
      return this.tank;
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.tank = null;
    }
  }
}
