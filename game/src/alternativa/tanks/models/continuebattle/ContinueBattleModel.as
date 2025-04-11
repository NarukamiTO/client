package alternativa.tanks.models.continuebattle {
  import projects.tanks.client.battlefield.models.continuebattle.ContinueBattleModelBase;
  import projects.tanks.client.battlefield.models.continuebattle.IContinueBattleModelBase;

  [ModelInfo]
  public class ContinueBattleModel extends ContinueBattleModelBase implements IContinueBattleModelBase, ContinueBattle {
    public function ContinueBattleModel() {
      super();
    }

    public function continueBattle() : void {
      server.continueBattle();
    }
  }
}
