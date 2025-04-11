package alternativa.tanks.models.statistics {
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClientUserInfoAdapt implements IClientUserInfo {
    private var object:IGameObject;
    private var impl:IClientUserInfo;

    public function IClientUserInfoAdapt(param1:IGameObject, param2:IClientUserInfo) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getShortUserInfo(param1:Long) : ShortUserInfo {
      var result:ShortUserInfo = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        result = this.impl.getShortUserInfo(userId);
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function suspiciousnessChanged(param1:Long, param2:Boolean) : void {
      var userId:Long = param1;
      var suspicious:Boolean = param2;
      try {
        Model.object = this.object;
        this.impl.suspiciousnessChanged(userId,suspicious);
      }
      finally {
        Model.popObject();
      }
    }

    public function rankChanged(param1:Long, param2:int) : void {
      var userId:Long = param1;
      var newRank:int = param2;
      try {
        Model.object = this.object;
        this.impl.rankChanged(userId,newRank);
      }
      finally {
        Model.popObject();
      }
    }

    public function getUsersCount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getUsersCount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isLoaded(param1:Long) : Boolean {
      var result:Boolean = false;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isLoaded(userId));
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
