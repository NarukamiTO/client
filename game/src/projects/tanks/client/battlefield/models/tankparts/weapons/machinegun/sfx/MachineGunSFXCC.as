package projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class MachineGunSFXCC {
    private var _chainStartSound:SoundResource;
    private var _crumbsTexture:TextureResource;
    private var _dustTexture:MultiframeTextureResource;
    private var _fireAcrossTexture:MultiframeTextureResource;
    private var _fireAlongTexture:MultiframeTextureResource;
    private var _hitSound:SoundResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _longFailSound:SoundResource;
    private var _shootEndSound:SoundResource;
    private var _shootSound:SoundResource;
    private var _smokeTexture:MultiframeTextureResource;
    private var _sparklesTexture:MultiframeTextureResource;
    private var _tankHitSound:SoundResource;
    private var _tankSparklesTexture:MultiframeTextureResource;
    private var _tracerTexture:TextureResource;
    private var _turbineStartSound:SoundResource;

    public function MachineGunSFXCC(param1:SoundResource = null, param2:TextureResource = null, param3:MultiframeTextureResource = null, param4:MultiframeTextureResource = null, param5:MultiframeTextureResource = null, param6:SoundResource = null, param7:LightingSFXEntity = null, param8:SoundResource = null, param9:SoundResource = null, param10:SoundResource = null, param11:MultiframeTextureResource = null, param12:MultiframeTextureResource = null, param13:SoundResource = null, param14:MultiframeTextureResource = null, param15:TextureResource = null, param16:SoundResource = null) {
      super();
      this._chainStartSound = param1;
      this._crumbsTexture = param2;
      this._dustTexture = param3;
      this._fireAcrossTexture = param4;
      this._fireAlongTexture = param5;
      this._hitSound = param6;
      this._lightingSFXEntity = param7;
      this._longFailSound = param8;
      this._shootEndSound = param9;
      this._shootSound = param10;
      this._smokeTexture = param11;
      this._sparklesTexture = param12;
      this._tankHitSound = param13;
      this._tankSparklesTexture = param14;
      this._tracerTexture = param15;
      this._turbineStartSound = param16;
    }

    public function get chainStartSound() : SoundResource {
      return this._chainStartSound;
    }

    public function set chainStartSound(param1:SoundResource) : void {
      this._chainStartSound = param1;
    }

    public function get crumbsTexture() : TextureResource {
      return this._crumbsTexture;
    }

    public function set crumbsTexture(param1:TextureResource) : void {
      this._crumbsTexture = param1;
    }

    public function get dustTexture() : MultiframeTextureResource {
      return this._dustTexture;
    }

    public function set dustTexture(param1:MultiframeTextureResource) : void {
      this._dustTexture = param1;
    }

    public function get fireAcrossTexture() : MultiframeTextureResource {
      return this._fireAcrossTexture;
    }

    public function set fireAcrossTexture(param1:MultiframeTextureResource) : void {
      this._fireAcrossTexture = param1;
    }

    public function get fireAlongTexture() : MultiframeTextureResource {
      return this._fireAlongTexture;
    }

    public function set fireAlongTexture(param1:MultiframeTextureResource) : void {
      this._fireAlongTexture = param1;
    }

    public function get hitSound() : SoundResource {
      return this._hitSound;
    }

    public function set hitSound(param1:SoundResource) : void {
      this._hitSound = param1;
    }

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function get longFailSound() : SoundResource {
      return this._longFailSound;
    }

    public function set longFailSound(param1:SoundResource) : void {
      this._longFailSound = param1;
    }

    public function get shootEndSound() : SoundResource {
      return this._shootEndSound;
    }

    public function set shootEndSound(param1:SoundResource) : void {
      this._shootEndSound = param1;
    }

    public function get shootSound() : SoundResource {
      return this._shootSound;
    }

    public function set shootSound(param1:SoundResource) : void {
      this._shootSound = param1;
    }

    public function get smokeTexture() : MultiframeTextureResource {
      return this._smokeTexture;
    }

    public function set smokeTexture(param1:MultiframeTextureResource) : void {
      this._smokeTexture = param1;
    }

    public function get sparklesTexture() : MultiframeTextureResource {
      return this._sparklesTexture;
    }

    public function set sparklesTexture(param1:MultiframeTextureResource) : void {
      this._sparklesTexture = param1;
    }

    public function get tankHitSound() : SoundResource {
      return this._tankHitSound;
    }

    public function set tankHitSound(param1:SoundResource) : void {
      this._tankHitSound = param1;
    }

    public function get tankSparklesTexture() : MultiframeTextureResource {
      return this._tankSparklesTexture;
    }

    public function set tankSparklesTexture(param1:MultiframeTextureResource) : void {
      this._tankSparklesTexture = param1;
    }

    public function get tracerTexture() : TextureResource {
      return this._tracerTexture;
    }

    public function set tracerTexture(param1:TextureResource) : void {
      this._tracerTexture = param1;
    }

    public function get turbineStartSound() : SoundResource {
      return this._turbineStartSound;
    }

    public function set turbineStartSound(param1:SoundResource) : void {
      this._turbineStartSound = param1;
    }

    public function toString() : String {
      var local1:String = "MachineGunSFXCC [";
      local1 += "chainStartSound = " + this.chainStartSound + " ";
      local1 += "crumbsTexture = " + this.crumbsTexture + " ";
      local1 += "dustTexture = " + this.dustTexture + " ";
      local1 += "fireAcrossTexture = " + this.fireAcrossTexture + " ";
      local1 += "fireAlongTexture = " + this.fireAlongTexture + " ";
      local1 += "hitSound = " + this.hitSound + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "longFailSound = " + this.longFailSound + " ";
      local1 += "shootEndSound = " + this.shootEndSound + " ";
      local1 += "shootSound = " + this.shootSound + " ";
      local1 += "smokeTexture = " + this.smokeTexture + " ";
      local1 += "sparklesTexture = " + this.sparklesTexture + " ";
      local1 += "tankHitSound = " + this.tankHitSound + " ";
      local1 += "tankSparklesTexture = " + this.tankSparklesTexture + " ";
      local1 += "tracerTexture = " + this.tracerTexture + " ";
      local1 += "turbineStartSound = " + this.turbineStartSound + " ";
      return local1 + "]";
    }
  }
}
