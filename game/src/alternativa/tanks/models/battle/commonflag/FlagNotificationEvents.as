package alternativa.tanks.models.battle.commonflag {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class FlagNotificationEvents implements FlagNotification {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function FlagNotificationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function guiShowFlagDropped(param1:CommonFlag) : void {
      var i:int = 0;
      var m:FlagNotification = null;
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FlagNotification(this.impl[i]);
          m.guiShowFlagDropped(flag);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function guiShowFlagCarried(param1:CommonFlag) : void {
      var i:int = 0;
      var m:FlagNotification = null;
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FlagNotification(this.impl[i]);
          m.guiShowFlagCarried(flag);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function guiShowFlagAtBase(param1:CommonFlag) : void {
      var i:int = 0;
      var m:FlagNotification = null;
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FlagNotification(this.impl[i]);
          m.guiShowFlagAtBase(flag);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagTaken(param1:CommonFlag, param2:Tank) : void {
      var i:int = 0;
      var m:FlagNotification = null;
      var flag:CommonFlag = param1;
      var carrier:Tank = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FlagNotification(this.impl[i]);
          m.notifyFlagTaken(flag,carrier);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagReturned(param1:CommonFlag, param2:IGameObject) : void {
      var i:int = 0;
      var m:FlagNotification = null;
      var flag:CommonFlag = param1;
      var user:IGameObject = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FlagNotification(this.impl[i]);
          m.notifyFlagReturned(flag,user);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagDropped(param1:CommonFlag) : void {
      var i:int = 0;
      var m:FlagNotification = null;
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FlagNotification(this.impl[i]);
          m.notifyFlagDropped(flag);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagThrown(param1:CommonFlag) : void {
      var i:int = 0;
      var m:FlagNotification = null;
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FlagNotification(this.impl[i]);
          m.notifyFlagThrown(flag);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagDelivered(param1:CommonFlag, param2:Tank) : void {
      var i:int = 0;
      var m:FlagNotification = null;
      var flag:CommonFlag = param1;
      var deliverer:Tank = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FlagNotification(this.impl[i]);
          m.notifyFlagDelivered(flag,deliverer);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagFacedOff(param1:CommonFlag) : void {
      var i:int = 0;
      var m:FlagNotification = null;
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FlagNotification(this.impl[i]);
          m.notifyFlagFacedOff(flag);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyReadyToFaceOff() : void {
      var i:int = 0;
      var m:FlagNotification = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FlagNotification(this.impl[i]);
          m.notifyReadyToFaceOff();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
