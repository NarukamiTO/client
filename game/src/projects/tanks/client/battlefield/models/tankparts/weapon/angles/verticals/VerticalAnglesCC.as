package projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals {
  public class VerticalAnglesCC {
    private var _angleDown:Number;
    private var _angleUp:Number;

    public function VerticalAnglesCC(param1:Number = 0, param2:Number = 0) {
      super();
      this._angleDown = param1;
      this._angleUp = param2;
    }

    public function get angleDown() : Number {
      return this._angleDown;
    }

    public function set angleDown(param1:Number) : void {
      this._angleDown = param1;
    }

    public function get angleUp() : Number {
      return this._angleUp;
    }

    public function set angleUp(param1:Number) : void {
      this._angleUp = param1;
    }

    public function toString() : String {
      var local1:String = "VerticalAnglesCC [";
      local1 += "angleDown = " + this.angleDown + " ";
      local1 += "angleUp = " + this.angleUp + " ";
      return local1 + "]";
    }
  }
}
