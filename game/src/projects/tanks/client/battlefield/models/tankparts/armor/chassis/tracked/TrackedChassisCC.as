package projects.tanks.client.battlefield.models.tankparts.armor.chassis.tracked {
  public class TrackedChassisCC {
    private var _damping:Number;

    public function TrackedChassisCC(param1:Number = 0) {
      super();
      this._damping = param1;
    }

    public function get damping() : Number {
      return this._damping;
    }

    public function set damping(param1:Number) : void {
      this._damping = param1;
    }

    public function toString() : String {
      var local1:String = "TrackedChassisCC [";
      local1 += "damping = " + this.damping + " ";
      return local1 + "]";
    }
  }
}
