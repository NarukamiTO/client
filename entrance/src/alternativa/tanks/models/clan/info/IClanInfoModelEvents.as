package alternativa.tanks.models.clan.info {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public class IClanInfoModelEvents implements IClanInfoModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IClanInfoModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getClanName() : String {
      var result:String = null;
      var i:int = 0;
      var m:IClanInfoModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanInfoModel(this.impl[i]);
          result = m.getClanName();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getClanTag() : String {
      var result:String = null;
      var i:int = 0;
      var m:IClanInfoModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanInfoModel(this.impl[i]);
          result = m.getClanTag();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDescription() : String {
      var result:String = null;
      var i:int = 0;
      var m:IClanInfoModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanInfoModel(this.impl[i]);
          result = m.getDescription();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getClanFlag() : ClanFlag {
      var result:ClanFlag = null;
      var i:int = 0;
      var m:IClanInfoModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanInfoModel(this.impl[i]);
          result = m.getClanFlag();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getRankIndexForAddClan() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IClanInfoModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanInfoModel(this.impl[i]);
          result = int(m.getRankIndexForAddClan());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function incomingRequestEnabled() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IClanInfoModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanInfoModel(this.impl[i]);
          result = Boolean(m.incomingRequestEnabled());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCreatorId() : Long {
      var result:Long = null;
      var i:int = 0;
      var m:IClanInfoModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanInfoModel(this.impl[i]);
          result = m.getCreatorId();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCreateTime() : Long {
      var result:Long = null;
      var i:int = 0;
      var m:IClanInfoModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanInfoModel(this.impl[i]);
          result = m.getCreateTime();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getUsersCount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IClanInfoModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanInfoModel(this.impl[i]);
          result = int(m.getUsersCount());
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
