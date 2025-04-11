package alternativa.tanks.models.battle.assault {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.RayIntersectionData;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleView;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.models.battle.commonflag.Flag;
  import alternativa.tanks.models.battle.ctf.*;
  import alternativa.tanks.models.battle.gui.markers.PointHudIndicator;
  import flash.utils.Dictionary;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class AssaultHudIndicators implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    private static var emptyBase:Class = AssaultHudIndicators_emptyBase;
    private static var flagAssault:Class = AssaultHudIndicators_flagAssault;

    private static const m:Matrix4 = new Matrix4();
    private static const m1:Matrix4 = new Matrix4();
    private static const v:Vector3 = new Vector3();
    private static const pointPosition:Vector3 = new Vector3();
    private static const cameraPosition:Vector3 = new Vector3();
    private static const direction:Vector3 = new Vector3();
    private static const NEAR_MARKER_DISTANCE:Number = 6600;
    private static const FAR_MARKER_DISTANCE:Number = 7000;

    private var redMarkers:Dictionary = new Dictionary();
    private var redBaseMarkers:Dictionary = new Dictionary();
    private var markers:Array = [];
    private var camera:Camera3D;
    private var localTeam:BattleTeam;

    public function AssaultHudIndicators() {
      super();
      this.camera = battleService.getBattleScene3D().getCamera();
    }

    private static function getPerspectiveScale(param1:Camera3D, param2:Vector3) : Number {
      var local3:Number = Math.cos(param1.rotationX);
      var local4:Number = Math.sin(param1.rotationX);
      var local5:Number = Math.cos(param1.rotationY);
      var local6:Number = Math.sin(param1.rotationY);
      var local7:Number = Math.cos(param1.rotationZ);
      var local8:Number = Math.sin(param1.rotationZ);
      var local9:Number = local7 * local6 * local3 + local8 * local4;
      var local10:Number = -local7 * local4 + local6 * local8 * local3;
      var local11:Number = local5 * local3;
      var local12:Number = -local9 * param1.x - local10 * param1.y - local11 * param1.z;
      var local13:Number = param1.view.width * 0.5;
      var local14:Number = param1.view.height * 0.5;
      var local15:Number = Math.sqrt(local13 * local13 + local14 * local14) / Math.tan(param1.fov * 0.5);
      var local16:Number = local9 * param2.x + local10 * param2.y + local11 * param2.z + local12;
      return local15 / local16;
    }

    private static function composeObject3DMatrix(param1:Object3D) : Matrix4 {
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local2:Number = Math.cos(param1.rotationX);
      var local3:Number = Math.sin(param1.rotationX);
      var local4:Number = Math.cos(param1.rotationY);
      var local5:Number = Math.sin(param1.rotationY);
      var local6:Number = Math.cos(param1.rotationZ);
      var local7:Number = Math.sin(param1.rotationZ);
      var local8:Number = local6 * local5;
      var local9:Number = local7 * local5;
      var local10:Number = local4 * param1.scaleX;
      var local11:Number = local3 * param1.scaleY;
      var local12:Number = local2 * param1.scaleY;
      local13 = local2 * param1.scaleZ;
      local14 = local3 * param1.scaleZ;
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

    public function addRedFlag(param1:int, param2:Flag) : void {
      var local3:PointHudIndicator = new PointHudIndicator(new flagAssault(),param2,null,new flagAssault());
      this.redMarkers[param1] = local3;
      battleService.getBattleView().addOverlayObject(local3);
      this.markers.push(local3);
    }

    public function addRedBase(param1:int, param2:Object3D) : void {
      var local3:PointHudIndicator = this.redMarkers[param1];
      var local4:PointHudIndicator = new PointHudIndicator(new emptyBase(),new BaseIndicatorStateProvider(new Vector3(param2.x,param2.y,param2.z),local3));
      local4.visibleToBlue = false;
      this.redBaseMarkers[param1] = local4;
      battleService.getBattleView().addOverlayObject(local4);
      this.markers.push(local4);
    }

    public function setLocalTeam(param1:BattleTeam) : void {
      this.localTeam = param1;
    }

    public function setFlagState(param1:int, param2:int) : void {
      this.redMarkers[param1].setState(param2);
    }

    public function render(param1:int, param2:int) : void {
      var local4:PointHudIndicator = null;
      var local5:PointHudIndicator = null;
      var local3:Matrix4 = this.calculateProjectionMatrix();
      for each(local4 in this.redBaseMarkers) {
        this.updateMarker(local3,local4);
      }
      for each(local5 in this.redMarkers) {
        this.updateMarker(local3,local5);
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

    private function updateMarker(param1:Matrix4, param2:PointHudIndicator) : void {
      var local7:Number = NaN;
      if(!param2.isActive(this.camera) || !param2.visibleFor(this.localTeam)) {
        param2.visible = false;
        return;
      }
      param2.readPosition3D(v);
      v.transform4(param1);
      this.projectToView(v);
      var local3:Number = 15;
      var local4:Number = this.getMarginY();
      var local5:Boolean = this.isPointInsideViewport(v.x,v.y,local3,local4);
      if(v.z > 0 && local5) {
        local7 = this.getPointAlpha(param2);
        if(local7 == 0) {
          param2.visible = false;
          param2.alpha = 0;
        } else {
          param2.visible = true;
          param2.alpha = local7;
        }
      } else {
        param2.alpha = 1;
        param2.visible = false;
      }
      var local6:BattleView = battleService.getBattleView();
      param2.x = int(v.x + local6.getWidth() / 2 - 12);
      param2.y = int(v.y + local6.getHeight() / 2 - 12);
      param2.zindex = this.getDistanceToCamera(param2);
    }

    private function getDistanceToCamera(param1:PointHudIndicator) : Number {
      param1.readPosition3D(pointPosition);
      cameraPosition.reset(this.camera.x,this.camera.y,this.camera.z);
      direction.diff(pointPosition,cameraPosition);
      return direction.length();
    }

    private function getPointAlpha(param1:PointHudIndicator) : Number {
      var local2:Number = NaN;
      param1.readPosition3D(pointPosition);
      cameraPosition.reset(this.camera.x,this.camera.y,this.camera.z);
      direction.diff(pointPosition,cameraPosition);
      var local3:Number = direction.length();
      direction.normalize();
      var local4:RayIntersectionData = battleService.getBattleScene3D().raycast(cameraPosition,direction,battleService.getExcludedObjects3D());
      var local5:Number = pointPosition.distanceTo(cameraPosition);
      if(local5 < NEAR_MARKER_DISTANCE) {
        local2 = 0;
      } else if(local5 > FAR_MARKER_DISTANCE) {
        local2 = 1;
      } else {
        local2 = (local5 - NEAR_MARKER_DISTANCE) / (FAR_MARKER_DISTANCE - NEAR_MARKER_DISTANCE);
      }
      return local2;
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
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local10:Number = NaN;
      var local12:Number = NaN;
      var local14:Number = NaN;
      var local1:Number = this.camera.viewSizeX / this.camera.focalLength;
      var local2:Number = this.camera.viewSizeY / this.camera.focalLength;
      var local3:Number = Math.cos(this.camera.rotationX);
      var local4:Number = Math.sin(this.camera.rotationX);
      local5 = Math.cos(this.camera.rotationY);
      local6 = Math.sin(this.camera.rotationY);
      local7 = Math.cos(this.camera.rotationZ);
      local8 = Math.sin(this.camera.rotationZ);
      var local9:Number = local7 * local6;
      local10 = local8 * local6;
      var local11:Number = local5 * this.camera.scaleX;
      local12 = local4 * this.camera.scaleY;
      var local13:Number = local3 * this.camera.scaleY;
      local14 = local3 * this.camera.scaleZ;
      var local15:Number = local4 * this.camera.scaleZ;
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
