package projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation {
  public class ArtilleryElevatingBarrelCC {
    private var _control:int;
    private var _elevation:Number;

    public function ArtilleryElevatingBarrelCC(param1:int = 0, param2:Number = 0) {
      super();
      this._control = param1;
      this._elevation = param2;
    }

    public function get control() : int {
      return this._control;
    }

    public function set control(param1:int) : void {
      this._control = param1;
    }

    public function get elevation() : Number {
      return this._elevation;
    }

    public function set elevation(param1:Number) : void {
      this._elevation = param1;
    }

    public function toString() : String {
      var local1:String = "ArtilleryElevatingBarrelCC [";
      local1 += "control = " + this.control + " ";
      local1 += "elevation = " + this.elevation + " ";
      return local1 + "]";
    }
  }
}
