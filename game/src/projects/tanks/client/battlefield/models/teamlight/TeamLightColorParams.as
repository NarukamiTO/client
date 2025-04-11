package projects.tanks.client.battlefield.models.teamlight {
  public class TeamLightColorParams {
    private var _color:String;
    private var _intensity:Number;

    public function TeamLightColorParams(param1:String = null, param2:Number = 0) {
      super();
      this._color = param1;
      this._intensity = param2;
    }

    public function get color() : String {
      return this._color;
    }

    public function set color(param1:String) : void {
      this._color = param1;
    }

    public function get intensity() : Number {
      return this._intensity;
    }

    public function set intensity(param1:Number) : void {
      this._intensity = param1;
    }

    public function toString() : String {
      var local1:String = "TeamLightColorParams [";
      local1 += "color = " + this.color + " ";
      local1 += "intensity = " + this.intensity + " ";
      return local1 + "]";
    }
  }
}
