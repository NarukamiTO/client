package projects.tanks.client.battlefield.models.teamlight {
  public class TeamLightCC {
    private var _lightModes:Vector.<TeamLightParams>;

    public function TeamLightCC(param1:Vector.<TeamLightParams> = null) {
      super();
      this._lightModes = param1;
    }

    public function get lightModes() : Vector.<TeamLightParams> {
      return this._lightModes;
    }

    public function set lightModes(param1:Vector.<TeamLightParams>) : void {
      this._lightModes = param1;
    }

    public function toString() : String {
      var local1:String = "TeamLightCC [";
      local1 += "lightModes = " + this.lightModes + " ";
      return local1 + "]";
    }
  }
}
