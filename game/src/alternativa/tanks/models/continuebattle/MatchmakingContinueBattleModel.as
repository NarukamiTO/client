package alternativa.tanks.models.continuebattle {
  import alternativa.tanks.service.matchmaking.MatchmakingFormService;
  import projects.tanks.client.battlefield.models.continuebattle.IMatchmakingContinueBattleModelBase;
  import projects.tanks.client.battlefield.models.continuebattle.MatchmakingContinueBattleModelBase;

  [ModelInfo]
  public class MatchmakingContinueBattleModel extends MatchmakingContinueBattleModelBase implements IMatchmakingContinueBattleModelBase, ContinueBattle {
    [Inject]
    public static var matchmakingFormService:MatchmakingFormService;

    public function MatchmakingContinueBattleModel() {
      super();
    }

    public function continueBattle() : void {
      server.continueBattle(matchmakingFormService.getLastRegistrationMode());
    }
  }
}
