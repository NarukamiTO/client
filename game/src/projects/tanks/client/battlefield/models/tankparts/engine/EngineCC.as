package projects.tanks.client.battlefield.models.tankparts.engine {
  import platform.client.fp10.core.resource.types.SoundResource;

  public class EngineCC {
    private var _engineIdleSound:SoundResource;
    private var _engineMovingSound:SoundResource;
    private var _engineStartMovingSound:SoundResource;
    private var _engineStartSound:SoundResource;
    private var _engineStopMovingSound:SoundResource;

    public function EngineCC(param1:SoundResource = null, param2:SoundResource = null, param3:SoundResource = null, param4:SoundResource = null, param5:SoundResource = null) {
      super();
      this._engineIdleSound = param1;
      this._engineMovingSound = param2;
      this._engineStartMovingSound = param3;
      this._engineStartSound = param4;
      this._engineStopMovingSound = param5;
    }

    public function get engineIdleSound() : SoundResource {
      return this._engineIdleSound;
    }

    public function set engineIdleSound(param1:SoundResource) : void {
      this._engineIdleSound = param1;
    }

    public function get engineMovingSound() : SoundResource {
      return this._engineMovingSound;
    }

    public function set engineMovingSound(param1:SoundResource) : void {
      this._engineMovingSound = param1;
    }

    public function get engineStartMovingSound() : SoundResource {
      return this._engineStartMovingSound;
    }

    public function set engineStartMovingSound(param1:SoundResource) : void {
      this._engineStartMovingSound = param1;
    }

    public function get engineStartSound() : SoundResource {
      return this._engineStartSound;
    }

    public function set engineStartSound(param1:SoundResource) : void {
      this._engineStartSound = param1;
    }

    public function get engineStopMovingSound() : SoundResource {
      return this._engineStopMovingSound;
    }

    public function set engineStopMovingSound(param1:SoundResource) : void {
      this._engineStopMovingSound = param1;
    }

    public function toString() : String {
      var local1:String = "EngineCC [";
      local1 += "engineIdleSound = " + this.engineIdleSound + " ";
      local1 += "engineMovingSound = " + this.engineMovingSound + " ";
      local1 += "engineStartMovingSound = " + this.engineStartMovingSound + " ";
      local1 += "engineStartSound = " + this.engineStartSound + " ";
      local1 += "engineStopMovingSound = " + this.engineStopMovingSound + " ";
      return local1 + "]";
    }
  }
}
