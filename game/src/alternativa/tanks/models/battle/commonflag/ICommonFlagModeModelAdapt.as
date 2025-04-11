package alternativa.tanks.models.battle.commonflag {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class ICommonFlagModeModelAdapt implements ICommonFlagModeModel {
    private var object:IGameObject;
    private var impl:ICommonFlagModeModel;

    public function ICommonFlagModeModelAdapt(param1:IGameObject, param2:ICommonFlagModeModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initFlag(param1:CommonFlag, param2:ClientFlag) : void {
      var flag:CommonFlag = param1;
      var flagData:ClientFlag = param2;
      try {
        Model.object = this.object;
        this.impl.initFlag(flag,flagData);
      }
      finally {
        Model.popObject();
      }
    }

    public function createBasePoint(param1:ClientTeamPoint, param2:Tanks3DSResource) : Object3D {
      var result:Object3D = null;
      var pointData:ClientTeamPoint = param1;
      var pedestal3D:Tanks3DSResource = param2;
      try {
        Model.object = this.object;
        result = this.impl.createBasePoint(pointData,pedestal3D);
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getFlags() : Vector.<ClientFlag> {
      var result:Vector.<ClientFlag> = null;
      try {
        Model.object = this.object;
        result = this.impl.getFlags();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPoints() : Vector.<ClientTeamPoint> {
      var result:Vector.<ClientTeamPoint> = null;
      try {
        Model.object = this.object;
        result = this.impl.getPoints();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getLocalTank() : Tank {
      var result:Tank = null;
      try {
        Model.object = this.object;
        result = this.impl.getLocalTank();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function onFlagTouch(param1:CommonFlag) : void {
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        this.impl.onFlagTouch(flag);
      }
      finally {
        Model.popObject();
      }
    }

    public function onPickupTimeoutPassed(param1:CommonFlag) : void {
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        this.impl.onPickupTimeoutPassed(flag);
      }
      finally {
        Model.popObject();
      }
    }

    public function addMineProtectedZone(param1:Vector3) : void {
      var position:Vector3 = param1;
      try {
        Model.object = this.object;
        this.impl.addMineProtectedZone(position);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
