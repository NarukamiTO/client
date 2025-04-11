package alternativa.tanks.model.garage.rankupsupplybonus {
  import alternativa.tanks.gui.RankUpSupplyBonusAlert;
  import projects.tanks.client.panel.model.garage.rankupsupplybonus.IRankUpSupplyBonusModelBase;
  import projects.tanks.client.panel.model.garage.rankupsupplybonus.RankUpSupplyBonusInfo;
  import projects.tanks.client.panel.model.garage.rankupsupplybonus.RankUpSupplyBonusModelBase;

  [ModelInfo]
  public class RankUpSupplyBonusModel extends RankUpSupplyBonusModelBase implements IRankUpSupplyBonusModelBase {
    public function RankUpSupplyBonusModel() {
      super();
    }

    public function showRankUpSupplyBonusAlerts(param1:Vector.<RankUpSupplyBonusInfo>) : void {
      var local2:RankUpSupplyBonusInfo = null;
      for each(local2 in param1) {
        new RankUpSupplyBonusAlert(local2);
      }
    }
  }
}
