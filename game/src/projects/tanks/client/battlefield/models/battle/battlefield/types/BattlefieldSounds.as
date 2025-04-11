package projects.tanks.client.battlefield.models.battle.battlefield.types {
  import platform.client.fp10.core.resource.types.SoundResource;

  public class BattlefieldSounds {
    private var _battleFinishSound:SoundResource;
    private var _killSound:SoundResource;

    public function BattlefieldSounds(param1:SoundResource = null, param2:SoundResource = null) {
      super();
      this._battleFinishSound = param1;
      this._killSound = param2;
    }

    public function get battleFinishSound() : SoundResource {
      return this._battleFinishSound;
    }

    public function set battleFinishSound(param1:SoundResource) : void {
      this._battleFinishSound = param1;
    }

    public function get killSound() : SoundResource {
      return this._killSound;
    }

    public function set killSound(param1:SoundResource) : void {
      this._killSound = param1;
    }

    public function toString() : String {
      var local1:String = "BattlefieldSounds [";
      local1 += "battleFinishSound = " + this.battleFinishSound + " ";
      local1 += "killSound = " + this.killSound + " ";
      return local1 + "]";
    }
  }
}
