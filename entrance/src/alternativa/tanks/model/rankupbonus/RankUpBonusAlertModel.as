package alternativa.tanks.model.rankupbonus {
  import alternativa.tanks.gui.alerts.RankUpBonusAlert;
  import projects.tanks.client.panel.model.rankupbonus.alert.IRankUpBonusAlertPanelModelBase;
  import projects.tanks.client.panel.model.rankupbonus.alert.RankUpBonusAlertItem;
  import projects.tanks.client.panel.model.rankupbonus.alert.RankUpBonusAlertPanelModelBase;

  [ModelInfo]
  public class RankUpBonusAlertModel extends RankUpBonusAlertPanelModelBase implements IRankUpBonusAlertPanelModelBase {
    public function RankUpBonusAlertModel() {
      super();
    }

    public function showAlert(param1:RankUpBonusAlertItem) : void {
      new RankUpBonusAlert(param1.accruedBonusCrystals,param1.alertPictureUrl);
    }
  }
}
