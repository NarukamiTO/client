package alternativa.tanks.view.battleinfo {
  import alternativa.tanks.view.battleinfo.renderer.BattleInfoUserListRenderer;
  import alternativa.types.Long;
  import fl.controls.List;
  import fl.data.DataProvider;
  import forms.Styles;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
  import utils.ScrollStyleUtils;

  public class BattleInfoUserList extends List {
    public var usersCount:int;

    public function BattleInfoUserList() {
      super();
      rowHeight = 20;
      setStyle(Styles.CELL_RENDERER,BattleInfoUserListRenderer);
      focusEnabled = false;
      ScrollStyleUtils.setGreenStyle(this);
    }

    public function update(param1:int, param2:Vector.<BattleInfoUser>) : void {
      var local3:BattleInfoUser = null;
      var local4:int = 0;
      var local5:int = 0;
      dataProvider = new DataProvider();
      this.usersCount = param2.length;
      for each(local3 in param2) {
        this.addUserSlot(local3);
      }
      this.sortUsersByScore();
      local4 = param1 - this.usersCount;
      local5 = 0;
      while(local5 < local4) {
        this.addEmptySlot();
        local5++;
      }
    }

    public function addUser(param1:BattleInfoUser) : void {
      this.addUserSlot(param1,this.getFreeIndex());
      ++this.usersCount;
    }

    public function removeUser(param1:Long) : void {
      var local2:int = this.getIndexById(param1);
      dataProvider.removeItemAt(local2);
      this.addEmptySlot();
      --this.usersCount;
    }

    public function updateUserScore(param1:Long, param2:int) : void {
      this.getUserById(param1).score = String(param2);
      this.sortUsersByScore();
    }

    public function updateUserSuspiciousState(param1:Long, param2:Boolean) : void {
      this.getUserById(param1).suspicious = param2;
    }

    public function getTeamClanId() : Long {
      if(dataProvider.length > 0) {
        return dataProvider.getItemAt(0).clanId;
      }
      return null;
    }

    private function sortUsersByScore() : void {
      dataProvider.sortOn(["score"],[Array.DESCENDING | Array.NUMERIC]);
    }

    private function addUserSlot(param1:BattleInfoUser, param2:int = -1) : void {
      var local3:Object = {};
      local3.id = param1.user;
      local3.suspicious = param1.suspicious;
      local3.score = param1.score;
      local3.clanId = param1.clanId;
      if(param2 > -1) {
        dataProvider.replaceItemAt(local3,param2);
      } else {
        dataProvider.addItem(local3);
      }
    }

    private function addEmptySlot() : void {
      var local1:Object = {};
      local1.score = -1;
      local1.id = null;
      dataProvider.addItem(local1);
    }

    private function getIndexById(param1:Long) : int {
      var local2:Object = null;
      var local3:int = 0;
      while(local3 < dataProvider.length) {
        local2 = dataProvider.getItemAt(local3);
        if(local2.id == param1) {
          return local3;
        }
        local3++;
      }
      return -1;
    }

    private function getUserById(param1:Long) : Object {
      var local2:Object = null;
      var local3:int = 0;
      while(local3 < dataProvider.length) {
        local2 = dataProvider.getItemAt(local3);
        if(local2.id == param1) {
          return local2;
        }
        local3++;
      }
      return null;
    }

    private function getFreeIndex() : uint {
      return this.usersCount;
    }
  }
}
