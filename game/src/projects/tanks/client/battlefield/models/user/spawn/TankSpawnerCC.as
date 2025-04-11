package projects.tanks.client.battlefield.models.user.spawn {
  public class TankSpawnerCC {
    private var _incarnationId:int;

    public function TankSpawnerCC(param1:int = 0) {
      super();
      this._incarnationId = param1;
    }

    public function get incarnationId() : int {
      return this._incarnationId;
    }

    public function set incarnationId(param1:int) : void {
      this._incarnationId = param1;
    }

    public function toString() : String {
      var local1:String = "TankSpawnerCC [";
      local1 += "incarnationId = " + this.incarnationId + " ";
      return local1 + "]";
    }
  }
}
