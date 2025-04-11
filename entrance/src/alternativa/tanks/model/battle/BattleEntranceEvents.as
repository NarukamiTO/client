package alternativa.tanks.model.battle {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class BattleEntranceEvents implements BattleEntrance {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BattleEntranceEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function fight(param1:BattleTeam = null) : void {
      var i:int = 0;
      var m:BattleEntrance = null;
      var team:BattleTeam = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleEntrance(this.impl[i]);
          m.fight(team);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function enterAsSpectator() : void {
      var i:int = 0;
      var m:BattleEntrance = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleEntrance(this.impl[i]);
          m.enterAsSpectator();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
