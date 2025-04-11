package projects.tanks.client.battlefield.models.tankparts.weapon.laser {
  public class LaserPointerCC {
    private var _fadeInTimeMs:int;
    private var _laserPointerBlueColor:String;
    private var _laserPointerRedColor:String;
    private var _locallyVisible:Boolean;

    public function LaserPointerCC(param1:int = 0, param2:String = null, param3:String = null, param4:Boolean = false) {
      super();
      this._fadeInTimeMs = param1;
      this._laserPointerBlueColor = param2;
      this._laserPointerRedColor = param3;
      this._locallyVisible = param4;
    }

    public function get fadeInTimeMs() : int {
      return this._fadeInTimeMs;
    }

    public function set fadeInTimeMs(param1:int) : void {
      this._fadeInTimeMs = param1;
    }

    public function get laserPointerBlueColor() : String {
      return this._laserPointerBlueColor;
    }

    public function set laserPointerBlueColor(param1:String) : void {
      this._laserPointerBlueColor = param1;
    }

    public function get laserPointerRedColor() : String {
      return this._laserPointerRedColor;
    }

    public function set laserPointerRedColor(param1:String) : void {
      this._laserPointerRedColor = param1;
    }

    public function get locallyVisible() : Boolean {
      return this._locallyVisible;
    }

    public function set locallyVisible(param1:Boolean) : void {
      this._locallyVisible = param1;
    }

    public function toString() : String {
      var local1:String = "LaserPointerCC [";
      local1 += "fadeInTimeMs = " + this.fadeInTimeMs + " ";
      local1 += "laserPointerBlueColor = " + this.laserPointerBlueColor + " ";
      local1 += "laserPointerRedColor = " + this.laserPointerRedColor + " ";
      local1 += "locallyVisible = " + this.locallyVisible + " ";
      return local1 + "]";
    }
  }
}
