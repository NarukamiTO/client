package alternativa.tanks.model.battle {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class BattleEntranceAdapt implements BattleEntrance {
    private var object:IGameObject;
    private var impl:BattleEntrance;

    public function BattleEntranceAdapt(param1:IGameObject, param2:BattleEntrance) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function fight(param1:BattleTeam = null) : void {
      var team:BattleTeam = param1;
      try {
        Model.object = this.object;
        this.impl.fight(team);
      }
      finally {
        Model.popObject();
      }
    }

    public function enterAsSpectator() : void {
      try {
        Model.object = this.object;
        this.impl.enterAsSpectator();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
