package projects.tanks.client.tanksservices.model.notifier.battle {
  import projects.tanks.client.tanksservices.model.notifier.AbstractNotifier;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;

  public class BattleNotifierData extends AbstractNotifier {
    private var _battleData:BattleInfoData;

    public function BattleNotifierData(param1:BattleInfoData = null) {
      super();
      this._battleData = param1;
    }

    public function get battleData() : BattleInfoData {
      return this._battleData;
    }

    public function set battleData(param1:BattleInfoData) : void {
      this._battleData = param1;
    }

    override public function toString() : String {
      var local1:String = "BattleNotifierData [";
      local1 += "battleData = " + this.battleData + " ";
      local1 += super.toString();
      return local1 + "]";
    }
  }
}
