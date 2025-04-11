package alternativa.tanks.models.tank.gearscore {
  import alternativa.tanks.models.tank.ITankModel;
  import projects.tanks.client.battlefield.models.tankparts.gearscore.BattleGearScoreCC;
  import projects.tanks.client.battlefield.models.tankparts.gearscore.BattleGearScoreModelBase;
  import projects.tanks.client.battlefield.models.tankparts.gearscore.IBattleGearScoreModelBase;

  [ModelInfo]
  public class BattleGearScoreModel extends BattleGearScoreModelBase implements IBattleGearScoreModelBase, GearScoreInfo {
    public function BattleGearScoreModel() {
      super();
    }

    public function getScore() : int {
      return getInitParam().score;
    }

    public function setGearScore(param1:int) : void {
      putInitParams(new BattleGearScoreCC(param1));
      ITankModel(object.adapt(ITankModel)).getTitle().updateInfo();
    }
  }
}
