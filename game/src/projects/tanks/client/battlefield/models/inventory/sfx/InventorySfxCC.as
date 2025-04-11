package projects.tanks.client.battlefield.models.inventory.sfx {
  import platform.client.fp10.core.resource.types.SoundResource;

  public class InventorySfxCC {
    private var _daOffSound:SoundResource;
    private var _daOnSound:SoundResource;
    private var _ddOffSound:SoundResource;
    private var _ddOnSound:SoundResource;
    private var _healingSound:SoundResource;
    private var _nitroOffSound:SoundResource;
    private var _nitroOnSound:SoundResource;
    private var _notReadySound:SoundResource;
    private var _readySound:SoundResource;

    public function InventorySfxCC(param1:SoundResource = null, param2:SoundResource = null, param3:SoundResource = null, param4:SoundResource = null, param5:SoundResource = null, param6:SoundResource = null, param7:SoundResource = null, param8:SoundResource = null, param9:SoundResource = null) {
      super();
      this._daOffSound = param1;
      this._daOnSound = param2;
      this._ddOffSound = param3;
      this._ddOnSound = param4;
      this._healingSound = param5;
      this._nitroOffSound = param6;
      this._nitroOnSound = param7;
      this._notReadySound = param8;
      this._readySound = param9;
    }

    public function get daOffSound() : SoundResource {
      return this._daOffSound;
    }

    public function set daOffSound(param1:SoundResource) : void {
      this._daOffSound = param1;
    }

    public function get daOnSound() : SoundResource {
      return this._daOnSound;
    }

    public function set daOnSound(param1:SoundResource) : void {
      this._daOnSound = param1;
    }

    public function get ddOffSound() : SoundResource {
      return this._ddOffSound;
    }

    public function set ddOffSound(param1:SoundResource) : void {
      this._ddOffSound = param1;
    }

    public function get ddOnSound() : SoundResource {
      return this._ddOnSound;
    }

    public function set ddOnSound(param1:SoundResource) : void {
      this._ddOnSound = param1;
    }

    public function get healingSound() : SoundResource {
      return this._healingSound;
    }

    public function set healingSound(param1:SoundResource) : void {
      this._healingSound = param1;
    }

    public function get nitroOffSound() : SoundResource {
      return this._nitroOffSound;
    }

    public function set nitroOffSound(param1:SoundResource) : void {
      this._nitroOffSound = param1;
    }

    public function get nitroOnSound() : SoundResource {
      return this._nitroOnSound;
    }

    public function set nitroOnSound(param1:SoundResource) : void {
      this._nitroOnSound = param1;
    }

    public function get notReadySound() : SoundResource {
      return this._notReadySound;
    }

    public function set notReadySound(param1:SoundResource) : void {
      this._notReadySound = param1;
    }

    public function get readySound() : SoundResource {
      return this._readySound;
    }

    public function set readySound(param1:SoundResource) : void {
      this._readySound = param1;
    }

    public function toString() : String {
      var local1:String = "InventorySfxCC [";
      local1 += "daOffSound = " + this.daOffSound + " ";
      local1 += "daOnSound = " + this.daOnSound + " ";
      local1 += "ddOffSound = " + this.ddOffSound + " ";
      local1 += "ddOnSound = " + this.ddOnSound + " ";
      local1 += "healingSound = " + this.healingSound + " ";
      local1 += "nitroOffSound = " + this.nitroOffSound + " ";
      local1 += "nitroOnSound = " + this.nitroOnSound + " ";
      local1 += "notReadySound = " + this.notReadySound + " ";
      local1 += "readySound = " + this.readySound + " ";
      return local1 + "]";
    }
  }
}
