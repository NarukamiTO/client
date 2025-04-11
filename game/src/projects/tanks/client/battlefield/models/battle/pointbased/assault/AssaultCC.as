package projects.tanks.client.battlefield.models.battle.pointbased.assault {
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class AssaultCC {
    private var _flagPedestalModel:Tanks3DSResource;
    private var _flagSprite:TextureResource;
    private var _pointBigMarker:TextureResource;
    private var _pointPedestalModel:Tanks3DSResource;
    private var _pointSmallMarker:TextureResource;
    private var _sounds:AssaultSoundFX;

    public function AssaultCC(param1:Tanks3DSResource = null, param2:TextureResource = null, param3:TextureResource = null, param4:Tanks3DSResource = null, param5:TextureResource = null, param6:AssaultSoundFX = null) {
      super();
      this._flagPedestalModel = param1;
      this._flagSprite = param2;
      this._pointBigMarker = param3;
      this._pointPedestalModel = param4;
      this._pointSmallMarker = param5;
      this._sounds = param6;
    }

    public function get flagPedestalModel() : Tanks3DSResource {
      return this._flagPedestalModel;
    }

    public function set flagPedestalModel(param1:Tanks3DSResource) : void {
      this._flagPedestalModel = param1;
    }

    public function get flagSprite() : TextureResource {
      return this._flagSprite;
    }

    public function set flagSprite(param1:TextureResource) : void {
      this._flagSprite = param1;
    }

    public function get pointBigMarker() : TextureResource {
      return this._pointBigMarker;
    }

    public function set pointBigMarker(param1:TextureResource) : void {
      this._pointBigMarker = param1;
    }

    public function get pointPedestalModel() : Tanks3DSResource {
      return this._pointPedestalModel;
    }

    public function set pointPedestalModel(param1:Tanks3DSResource) : void {
      this._pointPedestalModel = param1;
    }

    public function get pointSmallMarker() : TextureResource {
      return this._pointSmallMarker;
    }

    public function set pointSmallMarker(param1:TextureResource) : void {
      this._pointSmallMarker = param1;
    }

    public function get sounds() : AssaultSoundFX {
      return this._sounds;
    }

    public function set sounds(param1:AssaultSoundFX) : void {
      this._sounds = param1;
    }

    public function toString() : String {
      var local1:String = "AssaultCC [";
      local1 += "flagPedestalModel = " + this.flagPedestalModel + " ";
      local1 += "flagSprite = " + this.flagSprite + " ";
      local1 += "pointBigMarker = " + this.pointBigMarker + " ";
      local1 += "pointPedestalModel = " + this.pointPedestalModel + " ";
      local1 += "pointSmallMarker = " + this.pointSmallMarker + " ";
      local1 += "sounds = " + this.sounds + " ";
      return local1 + "]";
    }
  }
}
