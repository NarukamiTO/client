package projects.tanks.client.battlefield.models.battle.pointbased.ctf {
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CaptureTheFlagCC {
    private var _blueFlagSprite:TextureResource;
    private var _bluePedestalModel:Tanks3DSResource;
    private var _redFlagSprite:TextureResource;
    private var _redPedestalModel:Tanks3DSResource;
    private var _sounds:CaptureTheFlagSoundFX;

    public function CaptureTheFlagCC(param1:TextureResource = null, param2:Tanks3DSResource = null, param3:TextureResource = null, param4:Tanks3DSResource = null, param5:CaptureTheFlagSoundFX = null) {
      super();
      this._blueFlagSprite = param1;
      this._bluePedestalModel = param2;
      this._redFlagSprite = param3;
      this._redPedestalModel = param4;
      this._sounds = param5;
    }

    public function get blueFlagSprite() : TextureResource {
      return this._blueFlagSprite;
    }

    public function set blueFlagSprite(param1:TextureResource) : void {
      this._blueFlagSprite = param1;
    }

    public function get bluePedestalModel() : Tanks3DSResource {
      return this._bluePedestalModel;
    }

    public function set bluePedestalModel(param1:Tanks3DSResource) : void {
      this._bluePedestalModel = param1;
    }

    public function get redFlagSprite() : TextureResource {
      return this._redFlagSprite;
    }

    public function set redFlagSprite(param1:TextureResource) : void {
      this._redFlagSprite = param1;
    }

    public function get redPedestalModel() : Tanks3DSResource {
      return this._redPedestalModel;
    }

    public function set redPedestalModel(param1:Tanks3DSResource) : void {
      this._redPedestalModel = param1;
    }

    public function get sounds() : CaptureTheFlagSoundFX {
      return this._sounds;
    }

    public function set sounds(param1:CaptureTheFlagSoundFX) : void {
      this._sounds = param1;
    }

    public function toString() : String {
      var local1:String = "CaptureTheFlagCC [";
      local1 += "blueFlagSprite = " + this.blueFlagSprite + " ";
      local1 += "bluePedestalModel = " + this.bluePedestalModel + " ";
      local1 += "redFlagSprite = " + this.redFlagSprite + " ";
      local1 += "redPedestalModel = " + this.redPedestalModel + " ";
      local1 += "sounds = " + this.sounds + " ";
      return local1 + "]";
    }
  }
}
