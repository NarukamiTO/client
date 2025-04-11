package projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity {
  public class FacilitySphericalZoneCC {
    private var _centerOffsetZ:Number;
    private var _radius:Number;

    public function FacilitySphericalZoneCC(param1:Number = 0, param2:Number = 0) {
      super();
      this._centerOffsetZ = param1;
      this._radius = param2;
    }

    public function get centerOffsetZ() : Number {
      return this._centerOffsetZ;
    }

    public function set centerOffsetZ(param1:Number) : void {
      this._centerOffsetZ = param1;
    }

    public function get radius() : Number {
      return this._radius;
    }

    public function set radius(param1:Number) : void {
      this._radius = param1;
    }

    public function toString() : String {
      var local1:String = "FacilitySphericalZoneCC [";
      local1 += "centerOffsetZ = " + this.centerOffsetZ + " ";
      local1 += "radius = " + this.radius + " ";
      return local1 + "]";
    }
  }
}
