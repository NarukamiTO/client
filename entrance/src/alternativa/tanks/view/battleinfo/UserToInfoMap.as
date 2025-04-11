package alternativa.tanks.view.battleinfo {
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;

  public class UserToInfoMap {
    private var dictionary:* = new Dictionary();

    public function UserToInfoMap() {
      super();
    }

    public function put(param1:BattleInfoUser) : void {
      this.dictionary[param1.user] = param1;
    }

    public function get(param1:Long) : BattleInfoUser {
      return BattleInfoUser(this.dictionary[param1]);
    }

    public function remove(param1:Long) : void {
      delete this.dictionary[param1];
    }

    public function resetScore() : * {
      var local1:BattleInfoUser = null;
      for each(local1 in this.dictionary) {
        local1.score = 0;
      }
    }
  }
}
