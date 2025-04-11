package projects.tanks.client.battlefield.models.tankparts.armor.common {
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class HullCommonCC {
    private var _deadColoring:TextureResource;
    private var _deathSound:SoundResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _mass:Number;
    private var _stunEffectTexture:TextureResource;
    private var _stunSound:SoundResource;
    private var _ultimateHudIndicator:TextureResource;
    private var _ultimateIconIndex:int;

    public function HullCommonCC(param1:TextureResource = null, param2:SoundResource = null, param3:LightingSFXEntity = null, param4:Number = 0, param5:TextureResource = null, param6:SoundResource = null, param7:TextureResource = null, param8:int = 0) {
      super();
      this._deadColoring = param1;
      this._deathSound = param2;
      this._lightingSFXEntity = param3;
      this._mass = param4;
      this._stunEffectTexture = param5;
      this._stunSound = param6;
      this._ultimateHudIndicator = param7;
      this._ultimateIconIndex = param8;
    }

    public function get deadColoring() : TextureResource {
      return this._deadColoring;
    }

    public function set deadColoring(param1:TextureResource) : void {
      this._deadColoring = param1;
    }

    public function get deathSound() : SoundResource {
      return this._deathSound;
    }

    public function set deathSound(param1:SoundResource) : void {
      this._deathSound = param1;
    }

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function get mass() : Number {
      return this._mass;
    }

    public function set mass(param1:Number) : void {
      this._mass = param1;
    }

    public function get stunEffectTexture() : TextureResource {
      return this._stunEffectTexture;
    }

    public function set stunEffectTexture(param1:TextureResource) : void {
      this._stunEffectTexture = param1;
    }

    public function get stunSound() : SoundResource {
      return this._stunSound;
    }

    public function set stunSound(param1:SoundResource) : void {
      this._stunSound = param1;
    }

    public function get ultimateHudIndicator() : TextureResource {
      return this._ultimateHudIndicator;
    }

    public function set ultimateHudIndicator(param1:TextureResource) : void {
      this._ultimateHudIndicator = param1;
    }

    public function get ultimateIconIndex() : int {
      return this._ultimateIconIndex;
    }

    public function set ultimateIconIndex(param1:int) : void {
      this._ultimateIconIndex = param1;
    }

    public function toString() : String {
      var local1:String = "HullCommonCC [";
      local1 += "deadColoring = " + this.deadColoring + " ";
      local1 += "deathSound = " + this.deathSound + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "mass = " + this.mass + " ";
      local1 += "stunEffectTexture = " + this.stunEffectTexture + " ";
      local1 += "stunSound = " + this.stunSound + " ";
      local1 += "ultimateHudIndicator = " + this.ultimateHudIndicator + " ";
      local1 += "ultimateIconIndex = " + this.ultimateIconIndex + " ";
      return local1 + "]";
    }
  }
}
