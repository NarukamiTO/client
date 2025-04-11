package alternativa.tanks.models.bonus.bonuslight {
  import alternativa.tanks.models.teamlight.TeamLightColor;
  import projects.tanks.client.battlefield.models.bonus.bonuslight.BonusLightCC;
  import projects.tanks.client.battlefield.models.bonus.bonuslight.BonusLightModelBase;
  import projects.tanks.client.battlefield.models.bonus.bonuslight.IBonusLightModelBase;

  [ModelInfo]
  public class BonusLightModel extends BonusLightModelBase implements IBonusLightModelBase, IBonusLight {
    public function BonusLightModel() {
      super();
    }

    public function getBonusLight() : BonusLight {
      var local1:BonusLightCC = getInitParam();
      return new BonusLight(new TeamLightColor(uint(local1.lightColor),local1.intensity),local1.attenuationBegin,local1.attenuationEnd);
    }
  }
}
