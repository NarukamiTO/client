package alternativa.tanks.models.tank.ultimate.hornet.radar {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.RayIntersectionData;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleView;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.models.battle.gui.markers.PointHudIndicator;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.models.tank.bosstate.IBossState;
  import flash.display.Bitmap;
  import flash.utils.Dictionary;
  import projects.tanks.client.battlefield.models.ultimate.effects.hornet.radar.BattleUltimateRadarCC;
  import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class BattleRadarHudIndicators implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var localTankInfoService:LocalTankInfoService;

    private static const m:Matrix4 = new Matrix4();
    private static const m1:Matrix4 = new Matrix4();
    private static const v:Vector3 = new Vector3();
    private static const pointPosition:Vector3 = new Vector3();
    private static const cameraPosition:Vector3 = new Vector3();
    private static const direction:Vector3 = new Vector3();
    private static const exclusionDict:Dictionary = new Dictionary();

    private var markers:Array = [];
    private var markersMap:Dictionary = new Dictionary();
    private var camera:Camera3D;
    private var battleUltimateRadarCC:BattleUltimateRadarCC;

    public function BattleRadarHudIndicators(param1:BattleUltimateRadarCC) {
      super();
      this.camera = battleService.getBattleScene3D().getCamera();
      this.battleUltimateRadarCC = param1;
    }

    private static function composeObject3DMatrix(param1:Object3D) : Matrix4 {
      var local6:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local13:Number = NaN;
      var local2:Number = Math.cos(param1.rotationX);
      var local3:Number = Math.sin(param1.rotationX);
      var local4:Number = Math.cos(param1.rotationY);
      var local5:Number = Math.sin(param1.rotationY);
      local6 = Math.cos(param1.rotationZ);
      var local7:Number = Math.sin(param1.rotationZ);
      var local8:Number = local6 * local5;
      local9 = local7 * local5;
      local10 = local4 * param1.scaleX;
      local11 = local3 * param1.scaleY;
      var local12:Number = local2 * param1.scaleY;
      local13 = local2 * param1.scaleZ;
      var local14:Number = local3 * param1.scaleZ;
      m1.m00 = local6 * local10;
      m1.m01 = local8 * local11 - local7 * local12;
      m1.m02 = local8 * local13 + local7 * local14;
      m1.m03 = param1.x;
      m1.m10 = local7 * local10;
      m1.m11 = local9 * local11 + local6 * local12;
      m1.m12 = local9 * local13 - local6 * local14;
      m1.m13 = param1.y;
      m1.m20 = -local5 * param1.scaleX;
      m1.m21 = local4 * local11;
      m1.m22 = local4 * local13;
      m1.m23 = param1.z;
      return m1;
    }

    public function addTankMarker(param1:Tank) : void {
      var local2:PointHudIndicator = null;
      if(this.markersMap[param1] == null) {
        local2 = this.createMarker(param1);
        local2.visible = false;
        this.markers.push(local2);
        this.markersMap[param1] = local2;
        battleService.getBattleView().addOverlayObject(local2);
      }
    }

    private function createMarker(param1:Tank) : PointHudIndicator {
      return new PointHudIndicator(this.getIndicatorBitmap(param1),param1);
    }

    public function removeTankMarker(param1:Tank) : void {
      var local3:int = 0;
      var local2:PointHudIndicator = this.markersMap[param1];
      if(local2 != null) {
        delete this.markersMap[param1];
        battleService.getBattleView().removeOverlayObject(local2);
        local3 = int(this.markers.indexOf(local2));
        if(local3 >= 0) {
          this.markers.splice(local3,1);
        }
      }
    }

    private function getIndicatorBitmap(param1:Tank) : Bitmap {
      switch(param1.teamType) {
        case BattleTeam.RED:
          return new Bitmap(this.battleUltimateRadarCC.redTankMarker.data);
        case BattleTeam.BLUE:
          return new Bitmap(this.battleUltimateRadarCC.blueTankMarker.data);
        case BattleTeam.NONE:
      }
      return new Bitmap(this.battleUltimateRadarCC.neutralTankMarker.data);
    }

    public function render(param1:int, param2:int) : void {
      var local4:* = undefined;
      var local5:PointHudIndicator = null;
      var local3:Matrix4 = this.calculateProjectionMatrix();
      for(local4 in this.markersMap) {
        local5 = this.markersMap[local4];
        this.updateMarker(local3,local5,local4);
      }
      this.sortChildren();
    }

    private function sortChildren() : void {
      var local1:PointHudIndicator = null;
      this.markers.sortOn("zindex",Array.DESCENDING | Array.NUMERIC);
      for each(local1 in this.markers) {
        battleService.getBattleView().addOverlayObject(local1);
      }
    }

    private function updateMarker(param1:Matrix4, param2:PointHudIndicator, param3:Tank) : void {
      var local8:Number = NaN;
      if(!param2.isActive(this.camera) || this.getBossRelationRole(param3) == BossRelationRole.BOSS) {
        param2.visible = false;
        return;
      }
      param2.readPosition3D(v);
      v.transform4(param1);
      this.projectToView(v);
      var local4:Number = 15;
      var local5:Number = this.getMarginY();
      var local6:Boolean = this.isPointInsideViewport(v.x,v.y,local4,local5);
      if(v.z > 0 && local6) {
        local8 = this.getPointAlpha(param2,param3);
        if(local8 == 0) {
          param2.visible = false;
          param2.alpha = 0;
        } else {
          param2.visible = true;
          param2.alpha = local8;
        }
      } else {
        param2.alpha = 1;
        param2.visible = false;
      }
      var local7:BattleView = battleService.getBattleView();
      param2.x = int(v.x + local7.getWidth() / 2 - 12);
      param2.y = int(v.y + local7.getHeight() / 2 - 12);
      param2.zindex = this.getDistanceToCamera(param2);
    }

    private function getBossRelationRole(param1:Tank) : BossRelationRole {
      return IBossState(param1.getUser().adapt(IBossState)).role();
    }

    private function getDistanceToCamera(param1:PointHudIndicator) : Number {
      param1.readPosition3D(pointPosition);
      cameraPosition.reset(this.camera.x,this.camera.y,this.camera.z);
      direction.diff(pointPosition,cameraPosition);
      return direction.length();
    }

    private function getPointAlpha(param1:PointHudIndicator, param2:Tank) : Number {
      var local4:RayIntersectionData = null;
      param1.readPosition3D(pointPosition);
      cameraPosition.reset(this.camera.x,this.camera.y,this.camera.z);
      direction.diff(pointPosition,cameraPosition);
      direction.normalize();
      var local3:Number = pointPosition.distanceTo(cameraPosition);
      this.fillExclusionDict(param2);
      if(local3 > this.battleUltimateRadarCC.farMarkerDistance) {
        return 1;
      }
      local4 = battleService.getBattleScene3D().raycast(cameraPosition,direction,exclusionDict);
      if(local4 != null && local4.time < local3) {
        return 1;
      }
      if(local3 < this.battleUltimateRadarCC.nearMarkerDistance) {
        return 0;
      }
      return (local3 - this.battleUltimateRadarCC.nearMarkerDistance) / (this.battleUltimateRadarCC.farMarkerDistance - this.battleUltimateRadarCC.nearMarkerDistance);
    }

    private function fillExclusionDict(param1:Tank) : void {
      var local2:Object = null;
      for(local2 in exclusionDict) {
        delete exclusionDict[local2];
      }
      for(local2 in battleService.getExcludedObjects3D()) {
        exclusionDict[local2] = 1;
      }
      exclusionDict[param1.getTurret3D()] = 1;
      exclusionDict[param1.getHullMesh()] = 1;
      if(localTankInfoService.isLocalTankLoaded()) {
        exclusionDict[localTankInfoService.getLocalTank().getHullMesh()] = 1;
        exclusionDict[localTankInfoService.getLocalTank().getTurret3D()] = 1;
      }
    }

    private function getMarginY() : int {
      switch(battleService.getBattleView().getScreenSize()) {
        case BattleView.MAX_SCREEN_SIZE:
          return 70;
        case BattleView.MAX_SCREEN_SIZE - 1:
          return 40;
        default:
          return 15;
      }
    }

    private function isPointInsideViewport(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean {
      var local5:BattleView = battleService.getBattleView();
      var local6:Number = local5.getWidth() / 2 - param3;
      var local7:Number = local5.getHeight() / 2 - param4;
      return param1 >= -local6 && param1 <= local6 && param2 >= -local7 && param2 <= local7;
    }

    private function projectToView(param1:Vector3) : void {
      var local2:Number = NaN;
      var local3:Number = NaN;
      if(param1.z > 0.001) {
        param1.x = param1.x * this.camera.viewSizeX / param1.z;
        param1.y = param1.y * this.camera.viewSizeY / param1.z;
      } else if(param1.z < -0.001) {
        param1.x = -param1.x * this.camera.viewSizeX / param1.z;
        param1.y = -param1.y * this.camera.viewSizeY / param1.z;
      } else {
        local2 = Number(battleService.getBattleView().getDiagonalSquared());
        local3 = Math.sqrt(param1.x * param1.x + param1.y * param1.y);
        param1.x *= local2 / local3;
        param1.y *= local2 / local3;
      }
    }

    private function calculateProjectionMatrix() : Matrix4 {
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local1:Number = this.camera.viewSizeX / this.camera.focalLength;
      var local2:Number = this.camera.viewSizeY / this.camera.focalLength;
      var local3:Number = Math.cos(this.camera.rotationX);
      var local4:Number = Math.sin(this.camera.rotationX);
      var local5:Number = Math.cos(this.camera.rotationY);
      var local6:Number = Math.sin(this.camera.rotationY);
      var local7:Number = Math.cos(this.camera.rotationZ);
      var local8:Number = Math.sin(this.camera.rotationZ);
      var local9:Number = local7 * local6;
      var local10:Number = local8 * local6;
      var local11:Number = local5 * this.camera.scaleX;
      var local12:Number = local4 * this.camera.scaleY;
      local13 = local3 * this.camera.scaleY;
      local14 = local3 * this.camera.scaleZ;
      local15 = local4 * this.camera.scaleZ;
      m.m00 = local7 * local11 * local1;
      m.m01 = (local9 * local12 - local8 * local13) * local2;
      m.m02 = local9 * local14 + local8 * local15;
      m.m03 = this.camera.x;
      m.m10 = local8 * local11 * local1;
      m.m11 = (local10 * local12 + local7 * local13) * local2;
      m.m12 = local10 * local14 - local7 * local15;
      m.m13 = this.camera.y;
      m.m20 = -local6 * this.camera.scaleX * local1;
      m.m21 = local5 * local12 * local2;
      m.m22 = local5 * local14;
      m.m23 = this.camera.z;
      var local16:Object3D = this.camera;
      while(local16.parent != null) {
        local16 = local16.parent;
        m.append(composeObject3DMatrix(local16));
      }
      m.invert();
      return m;
    }
  }
}
