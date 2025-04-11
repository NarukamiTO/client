package alternativa.tanks.models.battle.jgr.killstreak {
  import alternativa.tanks.sfx.Sound3D;

  public class KillStreakClientItem {
    private var _messageToBoss:String;
    private var _messageToVictims:String;
    private var _sound:Sound3D;

    public function KillStreakClientItem(param1:String, param2:String, param3:Sound3D) {
      super();
      this._messageToBoss = param1;
      this._messageToVictims = param2;
      this._sound = param3;
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

    public function get sound() : Sound3D {
      return this._sound;
    }

    public function set sound(param1:Sound3D) : void {
      this._sound = param1;
    }
  }
}
