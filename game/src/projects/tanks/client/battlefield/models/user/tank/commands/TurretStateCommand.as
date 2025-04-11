package projects.tanks.client.battlefield.models.user.tank.commands {
  public class TurretStateCommand {
    private var _controlInput:Number;
    private var _controlType:TurretControlType;
    private var _direction:Number;
    private var _rotationSpeedNumber:int;

    public function TurretStateCommand(param1:Number = 0, param2:TurretControlType = null, param3:Number = 0, param4:int = 0) {
      super();
      this._controlInput = param1;
      this._controlType = param2;
      this._direction = param3;
      this._rotationSpeedNumber = param4;
    }

    public function get controlInput() : Number {
      return this._controlInput;
    }

    public function set controlInput(param1:Number) : void {
      this._controlInput = param1;
    }

    public function get controlType() : TurretControlType {
      return this._controlType;
    }

    public function set controlType(param1:TurretControlType) : void {
      this._controlType = param1;
    }

    public function get direction() : Number {
      return this._direction;
    }

    public function set direction(param1:Number) : void {
      this._direction = param1;
    }

    public function get rotationSpeedNumber() : int {
      return this._rotationSpeedNumber;
    }

    public function set rotationSpeedNumber(param1:int) : void {
      this._rotationSpeedNumber = param1;
    }

    public function toString() : String {
      var local1:String = "TurretStateCommand [";
      local1 += "controlInput = " + this.controlInput + " ";
      local1 += "controlType = " + this.controlType + " ";
      local1 += "direction = " + this.direction + " ";
      local1 += "rotationSpeedNumber = " + this.rotationSpeedNumber + " ";
      return local1 + "]";
    }
  }
}
