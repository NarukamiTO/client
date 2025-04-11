package alternativa.tanks.controllers {
  import alternativa.tanks.controllers.battlelist.BattleListItemParams;
  import alternativa.types.Long;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;

  public class BattleSelectVectorUtil {
    public function BattleSelectVectorUtil() {
      super();
    }

    public static function getUsersById(param1:Vector.<BattleInfoUser>, param2:Long) : BattleInfoUser {
      var local3:BattleInfoUser = null;
      var local4:int = int(param1.length);
      var local5:int = 0;
      while(local5 < local4) {
        if(param1[local5].user == param2) {
          local3 = param1[local5];
          break;
        }
        local5++;
      }
      return local3;
    }

    public static function deleteElementInUsersVector(param1:Vector.<BattleInfoUser>, param2:Long) : void {
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        if(param1[local4].user == param2) {
          while(local4 + 1 < local3) {
            param1[local4] = param1[local4 + 1];
            local4++;
          }
          param1.pop();
          break;
        }
        local4++;
      }
    }

    public static function deleteElementInLongsVector(param1:Vector.<Long>, param2:Long) : void {
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        if(param1[local4] == param2) {
          param1[local4] = param1[local3 - 1];
          param1.pop();
          break;
        }
        local4++;
      }
    }

    public static function deleteElementInVector(param1:Vector.<BattleListItemParams>, param2:Long) : void {
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        if(param1[local4].id == param2) {
          param1[local4] = param1[local3 - 1];
          param1.pop();
          break;
        }
        local4++;
      }
    }

    public static function deleteElementInArray(param1:Array, param2:Long) : void {
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        if(param1[local4].id == param2) {
          param1[local4] = param1[local3 - 1];
          param1.pop();
          break;
        }
        local4++;
      }
    }

    public static function findElementInVector(param1:Vector.<BattleListItemParams>, param2:Long) : BattleListItemParams {
      var local3:BattleListItemParams = null;
      var local4:int = int(param1.length);
      var local5:int = 0;
      while(local5 < local4) {
        if(param1[local5].id == param2) {
          local3 = param1[local5];
          break;
        }
        local5++;
      }
      return local3;
    }

    public static function containsElementInVector(param1:Vector.<Long>, param2:Long) : Boolean {
      var local3:Long = null;
      var local4:int = int(param1.length);
      var local5:int = 0;
      while(local5 < local4) {
        if(param1[local5] == param2) {
          return true;
        }
        local5++;
      }
      return false;
    }
  }
}
