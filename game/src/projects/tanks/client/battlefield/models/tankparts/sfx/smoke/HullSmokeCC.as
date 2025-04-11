package projects.tanks.client.battlefield.models.tankparts.sfx.smoke {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;

  public class HullSmokeCC {
    private var _alpha:Number;
    private var _density:Number;
    private var _enabled:Boolean;
    private var _fadeTime:int;
    private var _farDistance:Number;
    private var _nearDistance:Number;
    private var _particle:MultiframeTextureResource;
    private var _size:Number;

    public function HullSmokeCC(param1:Number = 0, param2:Number = 0, param3:Boolean = false, param4:int = 0, param5:Number = 0, param6:Number = 0, param7:MultiframeTextureResource = null, param8:Number = 0) {
      super();
      this._alpha = param1;
      this._density = param2;
      this._enabled = param3;
      this._fadeTime = param4;
      this._farDistance = param5;
      this._nearDistance = param6;
      this._particle = param7;
      this._size = param8;
    }

    public function get alpha() : Number {
      return this._alpha;
    }

    public function set alpha(param1:Number) : void {
      this._alpha = param1;
    }

    public function get density() : Number {
      return this._density;
    }

    public function set density(param1:Number) : void {
      this._density = param1;
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function set enabled(param1:Boolean) : void {
      this._enabled = param1;
    }

    public function get fadeTime() : int {
      return this._fadeTime;
    }

    public function set fadeTime(param1:int) : void {
      this._fadeTime = param1;
    }

    public function get farDistance() : Number {
      return this._farDistance;
    }

    public function set farDistance(param1:Number) : void {
      this._farDistance = param1;
    }

    public function get nearDistance() : Number {
      return this._nearDistance;
    }

    public function set nearDistance(param1:Number) : void {
      this._nearDistance = param1;
    }

    public function get particle() : MultiframeTextureResource {
      return this._particle;
    }

    public function set particle(param1:MultiframeTextureResource) : void {
      this._particle = param1;
    }

    public function get size() : Number {
      return this._size;
    }

    public function set size(param1:Number) : void {
      this._size = param1;
    }

    public function toString() : String {
      var local1:String = "HullSmokeCC [";
      local1 += "alpha = " + this.alpha + " ";
      local1 += "density = " + this.density + " ";
      local1 += "enabled = " + this.enabled + " ";
      local1 += "fadeTime = " + this.fadeTime + " ";
      local1 += "farDistance = " + this.farDistance + " ";
      local1 += "nearDistance = " + this.nearDistance + " ";
      local1 += "particle = " + this.particle + " ";
      local1 += "size = " + this.size + " ";
      return local1 + "]";
    }
  }
}
