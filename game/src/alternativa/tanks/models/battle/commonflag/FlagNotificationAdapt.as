package alternativa.tanks.models.battle.commonflag {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class FlagNotificationAdapt implements FlagNotification {
    private var object:IGameObject;
    private var impl:FlagNotification;

    public function FlagNotificationAdapt(param1:IGameObject, param2:FlagNotification) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function guiShowFlagDropped(param1:CommonFlag) : void {
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        this.impl.guiShowFlagDropped(flag);
      }
      finally {
        Model.popObject();
      }
    }

    public function guiShowFlagCarried(param1:CommonFlag) : void {
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        this.impl.guiShowFlagCarried(flag);
      }
      finally {
        Model.popObject();
      }
    }

    public function guiShowFlagAtBase(param1:CommonFlag) : void {
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        this.impl.guiShowFlagAtBase(flag);
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagTaken(param1:CommonFlag, param2:Tank) : void {
      var flag:CommonFlag = param1;
      var carrier:Tank = param2;
      try {
        Model.object = this.object;
        this.impl.notifyFlagTaken(flag,carrier);
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagReturned(param1:CommonFlag, param2:IGameObject) : void {
      var flag:CommonFlag = param1;
      var user:IGameObject = param2;
      try {
        Model.object = this.object;
        this.impl.notifyFlagReturned(flag,user);
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagDropped(param1:CommonFlag) : void {
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        this.impl.notifyFlagDropped(flag);
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagThrown(param1:CommonFlag) : void {
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        this.impl.notifyFlagThrown(flag);
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagDelivered(param1:CommonFlag, param2:Tank) : void {
      var flag:CommonFlag = param1;
      var deliverer:Tank = param2;
      try {
        Model.object = this.object;
        this.impl.notifyFlagDelivered(flag,deliverer);
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyFlagFacedOff(param1:CommonFlag) : void {
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        this.impl.notifyFlagFacedOff(flag);
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyReadyToFaceOff() : void {
      try {
        Model.object = this.object;
        this.impl.notifyReadyToFaceOff();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
