package alternativa.tanks.models.clan.info {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public class IClanInfoModelAdapt implements IClanInfoModel {
    private var object:IGameObject;
    private var impl:IClanInfoModel;

    public function IClanInfoModelAdapt(param1:IGameObject, param2:IClanInfoModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getClanName() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getClanName();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getClanTag() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getClanTag();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDescription() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getDescription();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getClanFlag() : ClanFlag {
      var result:ClanFlag = null;
      try {
        Model.object = this.object;
        result = this.impl.getClanFlag();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getRankIndexForAddClan() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getRankIndexForAddClan());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function incomingRequestEnabled() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.incomingRequestEnabled());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCreatorId() : Long {
      var result:Long = null;
      try {
        Model.object = this.object;
        result = this.impl.getCreatorId();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCreateTime() : Long {
      var result:Long = null;
      try {
        Model.object = this.object;
        result = this.impl.getCreateTime();
      }
      finally {
        Model.popObject();
      }
      return result;
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
  }
}
