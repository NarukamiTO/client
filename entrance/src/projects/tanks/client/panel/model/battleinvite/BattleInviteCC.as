package projects.tanks.client.panel.model.battleinvite {
  import platform.client.fp10.core.resource.types.SoundResource;

  public class BattleInviteCC {
    private var _soundNotification:SoundResource;

    public function BattleInviteCC(param1:SoundResource = null) {
      super();
      this._soundNotification = param1;
    }

    public function get soundNotification() : SoundResource {
      return this._soundNotification;
    }

    public function set soundNotification(param1:SoundResource) : void {
      this._soundNotification = param1;
    }

    public function toString() : String {
      var local1:String = "BattleInviteCC [";
      local1 += "soundNotification = " + this.soundNotification + " ";
      return local1 + "]";
    }
  }
}
