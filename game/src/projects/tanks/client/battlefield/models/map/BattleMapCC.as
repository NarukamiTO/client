package projects.tanks.client.battlefield.models.map {
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.clients.flash.resources.resource.MapResource;

  public class BattleMapCC {
    private var _dustParams:DustParams;
    private var _dynamicShadowParams:DynamicShadowParams;
    private var _environmentSound:SoundResource;
    private var _fogParams:FogParams;
    private var _gravity:Number;
    private var _mapResource:MapResource;
    private var _skyBoxRevolutionAxis:Vector3d;
    private var _skyBoxRevolutionSpeed:Number;
    private var _skyboxSides:SkyboxSides;
    private var _ssaoColor:int;

    public function BattleMapCC(param1:DustParams = null, param2:DynamicShadowParams = null, param3:SoundResource = null, param4:FogParams = null, param5:Number = 0, param6:MapResource = null, param7:Vector3d = null, param8:Number = 0, param9:SkyboxSides = null, param10:int = 0) {
      super();
      this._dustParams = param1;
      this._dynamicShadowParams = param2;
      this._environmentSound = param3;
      this._fogParams = param4;
      this._gravity = param5;
      this._mapResource = param6;
      this._skyBoxRevolutionAxis = param7;
      this._skyBoxRevolutionSpeed = param8;
      this._skyboxSides = param9;
      this._ssaoColor = param10;
    }

    public function get dustParams() : DustParams {
      return this._dustParams;
    }

    public function set dustParams(param1:DustParams) : void {
      this._dustParams = param1;
    }

    public function get dynamicShadowParams() : DynamicShadowParams {
      return this._dynamicShadowParams;
    }

    public function set dynamicShadowParams(param1:DynamicShadowParams) : void {
      this._dynamicShadowParams = param1;
    }

    public function get environmentSound() : SoundResource {
      return this._environmentSound;
    }

    public function set environmentSound(param1:SoundResource) : void {
      this._environmentSound = param1;
    }

    public function get fogParams() : FogParams {
      return this._fogParams;
    }

    public function set fogParams(param1:FogParams) : void {
      this._fogParams = param1;
    }

    public function get gravity() : Number {
      return this._gravity;
    }

    public function set gravity(param1:Number) : void {
      this._gravity = param1;
    }

    public function get mapResource() : MapResource {
      return this._mapResource;
    }

    public function set mapResource(param1:MapResource) : void {
      this._mapResource = param1;
    }

    public function get skyBoxRevolutionAxis() : Vector3d {
      return this._skyBoxRevolutionAxis;
    }

    public function set skyBoxRevolutionAxis(param1:Vector3d) : void {
      this._skyBoxRevolutionAxis = param1;
    }

    public function get skyBoxRevolutionSpeed() : Number {
      return this._skyBoxRevolutionSpeed;
    }

    public function set skyBoxRevolutionSpeed(param1:Number) : void {
      this._skyBoxRevolutionSpeed = param1;
    }

    public function get skyboxSides() : SkyboxSides {
      return this._skyboxSides;
    }

    public function set skyboxSides(param1:SkyboxSides) : void {
      this._skyboxSides = param1;
    }

    public function get ssaoColor() : int {
      return this._ssaoColor;
    }

    public function set ssaoColor(param1:int) : void {
      this._ssaoColor = param1;
    }

    public function toString() : String {
      var local1:String = "BattleMapCC [";
      local1 += "dustParams = " + this.dustParams + " ";
      local1 += "dynamicShadowParams = " + this.dynamicShadowParams + " ";
      local1 += "environmentSound = " + this.environmentSound + " ";
      local1 += "fogParams = " + this.fogParams + " ";
      local1 += "gravity = " + this.gravity + " ";
      local1 += "mapResource = " + this.mapResource + " ";
      local1 += "skyBoxRevolutionAxis = " + this.skyBoxRevolutionAxis + " ";
      local1 += "skyBoxRevolutionSpeed = " + this.skyBoxRevolutionSpeed + " ";
      local1 += "skyboxSides = " + this.skyboxSides + " ";
      local1 += "ssaoColor = " + this.ssaoColor + " ";
      return local1 + "]";
    }
  }
}
