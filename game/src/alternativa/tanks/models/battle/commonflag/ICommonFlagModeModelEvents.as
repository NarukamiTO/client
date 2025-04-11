package alternativa.tanks.models.battle.commonflag {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class ICommonFlagModeModelEvents implements ICommonFlagModeModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ICommonFlagModeModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initFlag(param1:CommonFlag, param2:ClientFlag) : void {
      var i:int = 0;
      var m:ICommonFlagModeModel = null;
      var flag:CommonFlag = param1;
      var flagData:ClientFlag = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFlagModeModel(this.impl[i]);
          m.initFlag(flag,flagData);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function createBasePoint(param1:ClientTeamPoint, param2:Tanks3DSResource) : Object3D {
      var result:Object3D = null;
      var i:int = 0;
      var m:ICommonFlagModeModel = null;
      var pointData:ClientTeamPoint = param1;
      var pedestal3D:Tanks3DSResource = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFlagModeModel(this.impl[i]);
          result = m.createBasePoint(pointData,pedestal3D);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getFlags() : Vector.<ClientFlag> {
      var result:Vector.<ClientFlag> = null;
      var i:int = 0;
      var m:ICommonFlagModeModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFlagModeModel(this.impl[i]);
          result = m.getFlags();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPoints() : Vector.<ClientTeamPoint> {
      var result:Vector.<ClientTeamPoint> = null;
      var i:int = 0;
      var m:ICommonFlagModeModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFlagModeModel(this.impl[i]);
          result = m.getPoints();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getLocalTank() : Tank {
      var result:Tank = null;
      var i:int = 0;
      var m:ICommonFlagModeModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFlagModeModel(this.impl[i]);
          result = m.getLocalTank();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function onFlagTouch(param1:CommonFlag) : void {
      var i:int = 0;
      var m:ICommonFlagModeModel = null;
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFlagModeModel(this.impl[i]);
          m.onFlagTouch(flag);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onPickupTimeoutPassed(param1:CommonFlag) : void {
      var i:int = 0;
      var m:ICommonFlagModeModel = null;
      var flag:CommonFlag = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFlagModeModel(this.impl[i]);
          m.onPickupTimeoutPassed(flag);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function addMineProtectedZone(param1:Vector3) : void {
      var i:int = 0;
      var m:ICommonFlagModeModel = null;
      var position:Vector3 = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFlagModeModel(this.impl[i]);
          m.addMineProtectedZone(position);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
