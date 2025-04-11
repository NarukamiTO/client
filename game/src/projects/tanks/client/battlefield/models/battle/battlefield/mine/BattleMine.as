package projects.tanks.client.battlefield.models.battle.battlefield.mine {
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class BattleMine {
    private var _activated:Boolean;
    private var _expirationMine:Boolean;
    private var _expirationTaskId:Long;
    private var _mineId:Long;
    private var _ownerId:Long;
    private var _position:Vector3d;

    public function BattleMine(param1:Boolean = false, param2:Boolean = false, param3:Long = null, param4:Long = null, param5:Long = null, param6:Vector3d = null) {
      super();
      this._activated = param1;
      this._expirationMine = param2;
      this._expirationTaskId = param3;
      this._mineId = param4;
      this._ownerId = param5;
      this._position = param6;
    }

    public function get activated() : Boolean {
      return this._activated;
    }

    public function set activated(param1:Boolean) : void {
      this._activated = param1;
    }

    public function get expirationMine() : Boolean {
      return this._expirationMine;
    }

    public function set expirationMine(param1:Boolean) : void {
      this._expirationMine = param1;
    }

    public function get expirationTaskId() : Long {
      return this._expirationTaskId;
    }

    public function set expirationTaskId(param1:Long) : void {
      this._expirationTaskId = param1;
    }

    public function get mineId() : Long {
      return this._mineId;
    }

    public function set mineId(param1:Long) : void {
      this._mineId = param1;
    }

    public function get ownerId() : Long {
      return this._ownerId;
    }

    public function set ownerId(param1:Long) : void {
      this._ownerId = param1;
    }

    public function get position() : Vector3d {
      return this._position;
    }

    public function set position(param1:Vector3d) : void {
      this._position = param1;
    }

    public function toString() : String {
      var local1:String = "BattleMine [";
      local1 += "activated = " + this.activated + " ";
      local1 += "expirationMine = " + this.expirationMine + " ";
      local1 += "expirationTaskId = " + this.expirationTaskId + " ";
      local1 += "mineId = " + this.mineId + " ";
      local1 += "ownerId = " + this.ownerId + " ";
      local1 += "position = " + this.position + " ";
      return local1 + "]";
    }
  }
}
