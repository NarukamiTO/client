package alternativa.tanks.models.clan {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanModelEvents implements IClanModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IClanModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function leaveClan() : void {
      var i:int = 0;
      var m:IClanModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanModel(this.impl[i]);
          m.leaveClan();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function addClanMember(param1:Long) : void {
      var i:int = 0;
      var m:IClanModel = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanModel(this.impl[i]);
          m.addClanMember(userId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function excludeClanMember(param1:Long) : void {
      var i:int = 0;
      var m:IClanModel = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanModel(this.impl[i]);
          m.excludeClanMember(userId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function rejectRequest(param1:Long) : void {
      var i:int = 0;
      var m:IClanModel = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanModel(this.impl[i]);
          m.rejectRequest(userId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function acceptRequest(param1:Long) : void {
      var i:int = 0;
      var m:IClanModel = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanModel(this.impl[i]);
          m.acceptRequest(userId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function rejectAllRequests() : void {
      var i:int = 0;
      var m:IClanModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanModel(this.impl[i]);
          m.rejectAllRequests();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function inviteByUid(param1:String) : void {
      var i:int = 0;
      var m:IClanModel = null;
      var uid:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanModel(this.impl[i]);
          m.inviteByUid(uid);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function revokeRequest(param1:Long) : void {
      var i:int = 0;
      var m:IClanModel = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanModel(this.impl[i]);
          m.revokeRequest(userId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
