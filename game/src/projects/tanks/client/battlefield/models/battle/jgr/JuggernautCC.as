package projects.tanks.client.battlefield.models.battle.jgr {
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.type.IGameObject;

  public class JuggernautCC {
    private var _bossHudMarker:TextureResource;
    private var _bossKilledSound:SoundResource;
    private var _bossSpawnedSound:SoundResource;
    private var _currentBoss:IGameObject;

    public function JuggernautCC(param1:TextureResource = null, param2:SoundResource = null, param3:SoundResource = null, param4:IGameObject = null) {
      super();
      this._bossHudMarker = param1;
      this._bossKilledSound = param2;
      this._bossSpawnedSound = param3;
      this._currentBoss = param4;
    }

    public function get bossHudMarker() : TextureResource {
      return this._bossHudMarker;
    }

    public function set bossHudMarker(param1:TextureResource) : void {
      this._bossHudMarker = param1;
    }

    public function get bossKilledSound() : SoundResource {
      return this._bossKilledSound;
    }

    public function set bossKilledSound(param1:SoundResource) : void {
      this._bossKilledSound = param1;
    }

    public function get bossSpawnedSound() : SoundResource {
      return this._bossSpawnedSound;
    }

    public function set bossSpawnedSound(param1:SoundResource) : void {
      this._bossSpawnedSound = param1;
    }

    public function get currentBoss() : IGameObject {
      return this._currentBoss;
    }

    public function set currentBoss(param1:IGameObject) : void {
      this._currentBoss = param1;
    }

    public function toString() : String {
      var local1:String = "JuggernautCC [";
      local1 += "bossHudMarker = " + this.bossHudMarker + " ";
      local1 += "bossKilledSound = " + this.bossKilledSound + " ";
      local1 += "bossSpawnedSound = " + this.bossSpawnedSound + " ";
      local1 += "currentBoss = " + this.currentBoss + " ";
      return local1 + "]";
    }
  }
}
