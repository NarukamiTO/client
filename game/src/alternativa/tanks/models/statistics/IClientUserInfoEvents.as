package alternativa.tanks.models.statistics {
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClientUserInfoEvents implements IClientUserInfo {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IClientUserInfoEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getShortUserInfo(param1:Long) : ShortUserInfo {
      var result:ShortUserInfo = null;
      var i:int = 0;
      var m:IClientUserInfo = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClientUserInfo(this.impl[i]);
          result = m.getShortUserInfo(userId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function suspiciousnessChanged(param1:Long, param2:Boolean) : void {
      var i:int = 0;
      var m:IClientUserInfo = null;
      var userId:Long = param1;
      var suspicious:Boolean = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClientUserInfo(this.impl[i]);
          m.suspiciousnessChanged(userId,suspicious);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function rankChanged(param1:Long, param2:int) : void {
      var i:int = 0;
      var m:IClientUserInfo = null;
      var userId:Long = param1;
      var newRank:int = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClientUserInfo(this.impl[i]);
          m.rankChanged(userId,newRank);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getUsersCount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IClientUserInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClientUserInfo(this.impl[i]);
          result = int(m.getUsersCount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isLoaded(param1:Long) : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IClientUserInfo = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClientUserInfo(this.impl[i]);
          result = Boolean(m.isLoaded(userId));
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
