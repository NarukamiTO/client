package projects.tanks.client.battlefield.models.battle.pointbased.flag {
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class ClientFlag {
    private var _fallingData:ClientFlagFlyingData;
    private var _flagCarrierId:Long;
    private var _flagId:int;
    private var _flagPosition:Vector3d;
    private var _state:FlagState;

    public function ClientFlag(param1:ClientFlagFlyingData = null, param2:Long = null, param3:int = 0, param4:Vector3d = null, param5:FlagState = null) {
      super();
      this._fallingData = param1;
      this._flagCarrierId = param2;
      this._flagId = param3;
      this._flagPosition = param4;
      this._state = param5;
    }

    public function get fallingData() : ClientFlagFlyingData {
      return this._fallingData;
    }

    public function set fallingData(param1:ClientFlagFlyingData) : void {
      this._fallingData = param1;
    }

    public function get flagCarrierId() : Long {
      return this._flagCarrierId;
    }

    public function set flagCarrierId(param1:Long) : void {
      this._flagCarrierId = param1;
    }

    public function get flagId() : int {
      return this._flagId;
    }

    public function set flagId(param1:int) : void {
      this._flagId = param1;
    }

    public function get flagPosition() : Vector3d {
      return this._flagPosition;
    }

    public function set flagPosition(param1:Vector3d) : void {
      this._flagPosition = param1;
    }

    public function get state() : FlagState {
      return this._state;
    }

    public function set state(param1:FlagState) : void {
      this._state = param1;
    }

    public function toString() : String {
      var local1:String = "ClientFlag [";
      local1 += "fallingData = " + this.fallingData + " ";
      local1 += "flagCarrierId = " + this.flagCarrierId + " ";
      local1 += "flagId = " + this.flagId + " ";
      local1 += "flagPosition = " + this.flagPosition + " ";
      local1 += "state = " + this.state + " ";
      return local1 + "]";
    }
  }
}
