package projects.tanks.client.panel.model.battleinvite {
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;

  public class BattleInviteMessage {
    private var _availableSlot:Boolean;
    private var _battleData:BattleInfoData;

    public function BattleInviteMessage(param1:Boolean = false, param2:BattleInfoData = null) {
      super();
      this._availableSlot = param1;
      this._battleData = param2;
    }

    public function get availableSlot() : Boolean {
      return this._availableSlot;
    }

    public function set availableSlot(param1:Boolean) : void {
      this._availableSlot = param1;
    }

    public function get battleData() : BattleInfoData {
      return this._battleData;
    }

    public function set battleData(param1:BattleInfoData) : void {
      this._battleData = param1;
    }

    public function toString() : String {
      var local1:String = "BattleInviteMessage [";
      local1 += "availableSlot = " + this.availableSlot + " ";
      local1 += "battleData = " + this.battleData + " ";
      return local1 + "]";
    }
  }
}
