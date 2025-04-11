package projects.tanks.client.battlefield.models.tankparts.sfx.isis {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class IsisSFXCC {
    private var _damagingBall:MultiframeTextureResource;
    private var _damagingRay:TextureResource;
    private var _damagingSound:SoundResource;
    private var _healingBall:MultiframeTextureResource;
    private var _healingRay:TextureResource;
    private var _healingSound:SoundResource;
    private var _idleSound:SoundResource;
    private var _lightingSFXEntity:LightingSFXEntity;

    public function IsisSFXCC(param1:MultiframeTextureResource = null, param2:TextureResource = null, param3:SoundResource = null, param4:MultiframeTextureResource = null, param5:TextureResource = null, param6:SoundResource = null, param7:SoundResource = null, param8:LightingSFXEntity = null) {
      super();
      this._damagingBall = param1;
      this._damagingRay = param2;
      this._damagingSound = param3;
      this._healingBall = param4;
      this._healingRay = param5;
      this._healingSound = param6;
      this._idleSound = param7;
      this._lightingSFXEntity = param8;
    }

    public function get damagingBall() : MultiframeTextureResource {
      return this._damagingBall;
    }

    public function set damagingBall(param1:MultiframeTextureResource) : void {
      this._damagingBall = param1;
    }

    public function get damagingRay() : TextureResource {
      return this._damagingRay;
    }

    public function set damagingRay(param1:TextureResource) : void {
      this._damagingRay = param1;
    }

    public function get damagingSound() : SoundResource {
      return this._damagingSound;
    }

    public function set damagingSound(param1:SoundResource) : void {
      this._damagingSound = param1;
    }

    public function get healingBall() : MultiframeTextureResource {
      return this._healingBall;
    }

    public function set healingBall(param1:MultiframeTextureResource) : void {
      this._healingBall = param1;
    }

    public function get healingRay() : TextureResource {
      return this._healingRay;
    }

    public function set healingRay(param1:TextureResource) : void {
      this._healingRay = param1;
    }

    public function get healingSound() : SoundResource {
      return this._healingSound;
    }

    public function set healingSound(param1:SoundResource) : void {
      this._healingSound = param1;
    }

    public function get idleSound() : SoundResource {
      return this._idleSound;
    }

    public function set idleSound(param1:SoundResource) : void {
      this._idleSound = param1;
    }

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function toString() : String {
      var local1:String = "IsisSFXCC [";
      local1 += "damagingBall = " + this.damagingBall + " ";
      local1 += "damagingRay = " + this.damagingRay + " ";
      local1 += "damagingSound = " + this.damagingSound + " ";
      local1 += "healingBall = " + this.healingBall + " ";
      local1 += "healingRay = " + this.healingRay + " ";
      local1 += "healingSound = " + this.healingSound + " ";
      local1 += "idleSound = " + this.idleSound + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      return local1 + "]";
    }
  }
}
