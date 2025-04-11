package projects.tanks.client.battlefield.models.tankparts.weapon.twins {
  public class TwinsCC {
    private var _shellRadius:Number;
    private var _speed:Number;

    public function TwinsCC(param1:Number = 0, param2:Number = 0) {
      super();
      this._shellRadius = param1;
      this._speed = param2;
    }

    public function get shellRadius() : Number {
      return this._shellRadius;
    }

    public function set shellRadius(param1:Number) : void {
      this._shellRadius = param1;
    }

    public function get speed() : Number {
      return this._speed;
    }

    public function set speed(param1:Number) : void {
      this._speed = param1;
    }

    public function toString() : String {
      var local1:String = "TwinsCC [";
      local1 += "shellRadius = " + this.shellRadius + " ";
      local1 += "speed = " + this.speed + " ";
      return local1 + "]";
    }
  }
}
