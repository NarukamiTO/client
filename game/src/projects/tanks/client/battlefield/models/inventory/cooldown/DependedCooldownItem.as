package projects.tanks.client.battlefield.models.inventory.cooldown {
  import alternativa.types.Long;

  public class DependedCooldownItem {
    private var _duration:int;
    private var _id:Long;

    public function DependedCooldownItem(param1:int = 0, param2:Long = null) {
      super();
      this._duration = param1;
      this._id = param2;
    }

    public function get duration() : int {
      return this._duration;
    }

    public function set duration(param1:int) : void {
      this._duration = param1;
    }

    public function get id() : Long {
      return this._id;
    }

    public function set id(param1:Long) : void {
      this._id = param1;
    }

    public function toString() : String {
      var local1:String = "DependedCooldownItem [";
      local1 += "duration = " + this.duration + " ";
      local1 += "id = " + this.id + " ";
      return local1 + "]";
    }
  }
}
