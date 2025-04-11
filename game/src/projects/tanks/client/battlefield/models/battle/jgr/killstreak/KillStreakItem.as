package projects.tanks.client.battlefield.models.battle.jgr.killstreak {
  import platform.client.fp10.core.resource.types.SoundResource;

  public class KillStreakItem {
    private var _count:int;
    private var _messageToBoss:String;
    private var _messageToVictims:String;
    private var _sound:SoundResource;

    public function KillStreakItem(param1:int = 0, param2:String = null, param3:String = null, param4:SoundResource = null) {
      super();
      this._count = param1;
      this._messageToBoss = param2;
      this._messageToVictims = param3;
      this._sound = param4;
    }

    public function get count() : int {
      return this._count;
    }

    public function set count(param1:int) : void {
      this._count = param1;
    }

    public function get messageToBoss() : String {
      return this._messageToBoss;
    }

    public function set messageToBoss(param1:String) : void {
      this._messageToBoss = param1;
    }

    public function get messageToVictims() : String {
      return this._messageToVictims;
    }

    public function set messageToVictims(param1:String) : void {
      this._messageToVictims = param1;
    }

    public function get sound() : SoundResource {
      return this._sound;
    }

    public function set sound(param1:SoundResource) : void {
      this._sound = param1;
    }

    public function toString() : String {
      var local1:String = "KillStreakItem [";
      local1 += "count = " + this.count + " ";
      local1 += "messageToBoss = " + this.messageToBoss + " ";
      local1 += "messageToVictims = " + this.messageToVictims + " ";
      local1 += "sound = " + this.sound + " ";
      return local1 + "]";
    }
  }
}
