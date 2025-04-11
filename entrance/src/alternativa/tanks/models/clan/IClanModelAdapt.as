package alternativa.tanks.models.clan {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanModelAdapt implements IClanModel {
    private var object:IGameObject;
    private var impl:IClanModel;

    public function IClanModelAdapt(param1:IGameObject, param2:IClanModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function leaveClan() : void {
      try {
        Model.object = this.object;
        this.impl.leaveClan();
      }
      finally {
        Model.popObject();
      }
    }

    public function addClanMember(param1:Long) : void {
      var userId:Long = param1;
      try {
        Model.object = this.object;
        this.impl.addClanMember(userId);
      }
      finally {
        Model.popObject();
      }
    }

    public function excludeClanMember(param1:Long) : void {
      var userId:Long = param1;
      try {
        Model.object = this.object;
        this.impl.excludeClanMember(userId);
      }
      finally {
        Model.popObject();
      }
    }

    public function rejectRequest(param1:Long) : void {
      var userId:Long = param1;
      try {
        Model.object = this.object;
        this.impl.rejectRequest(userId);
      }
      finally {
        Model.popObject();
      }
    }

    public function acceptRequest(param1:Long) : void {
      var userId:Long = param1;
      try {
        Model.object = this.object;
        this.impl.acceptRequest(userId);
      }
      finally {
        Model.popObject();
      }
    }

    public function rejectAllRequests() : void {
      try {
        Model.object = this.object;
        this.impl.rejectAllRequests();
      }
      finally {
        Model.popObject();
      }
    }

    public function inviteByUid(param1:String) : void {
      var uid:String = param1;
      try {
        Model.object = this.object;
        this.impl.inviteByUid(uid);
      }
      finally {
        Model.popObject();
      }
    }

    public function revokeRequest(param1:Long) : void {
      var userId:Long = param1;
      try {
        Model.object = this.object;
        this.impl.revokeRequest(userId);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
