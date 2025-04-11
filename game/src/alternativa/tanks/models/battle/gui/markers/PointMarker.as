package alternativa.tanks.models.battle.gui.markers {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.RayIntersectionData;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.console.variables.ConsoleVarFloat;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleView;
  import alternativa.tanks.battle.scene3d.Renderer;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class PointMarker implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    private static const CON_HIDE_SCALE:ConsoleVarFloat = new ConsoleVarFloat("ph_scale",0.12,0.00001,10);
    private static const CON_FULL_HIDE_SCALE:ConsoleVarFloat = new ConsoleVarFloat("pfh_scale",0.1,0.00001,10);
    private static const m:Matrix4 = new Matrix4();
    private static const m1:Matrix4 = new Matrix4();
    private static const v:Vector3 = new Vector3();
    private static const pointPosition:Vector3 = new Vector3();
    private static const cameraPosition:Vector3 = new Vector3();
    private static const direction:Vector3 = new Vector3();

    private var camera:Camera3D;
    private var marker:PointHudIndicator;
    private var infiniteVisible:Boolean;

    public function PointMarker(param1:Camera3D, param2:BitmapData, param3:PointIndicatorStateProvider, param4:Boolean = false) {
      super();
      this.camera = param1;
      this.infiniteVisible = param4;
      this.marker = new PointHudIndicator(new Bitmap(param2),param3);
      this.marker.visible = false;
      battleService.getBattleView().addOverlayObject(this.marker);
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
      var local13:Number = local2 * param1.scaleZ;
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

    public function show() : void {
      this.marker.visible = true;
    }

    public function render(param1:int, param2:int) : void {
      var local3:Matrix4 = this.calculateProjectionMatrix();
      this.updateMarker(local3);
    }

    private function updateMarker(param1:Matrix4) : void {
      var local6:Number = NaN;
      if(!this.marker.isActive(this.camera)) {
        this.marker.visible = false;
        return;
      }
      this.marker.readPosition3D(v);
      v.transform4(param1);
      this.projectToView(v);
      var local2:Number = 15;
      var local3:Number = this.getMarginY();
      var local4:Boolean = this.isPointInsideViewport(v.x,v.y,local2,local3);
      if(v.z > 0 && local4) {
        local6 = this.getPointAlpha();
        if(local6 == 0) {
          this.marker.visible = false;
          this.marker.alpha = 0;
        } else {
          this.marker.visible = true;
          this.marker.alpha = local6;
        }
      } else {
        this.marker.alpha = 1;
        this.marker.visible = false;
      }
      var local5:BattleView = battleService.getBattleView();
      this.marker.x = int(v.x + local5.getWidth() / 2 - 12);
      this.marker.y = int(v.y + local5.getHeight() / 2 - 12);
    }

    private function getPointAlpha() : Number {
      var local2:Number = NaN;
      var local3:Number = NaN;
      var local4:RayIntersectionData = null;
      this.marker.readPosition3D(pointPosition);
      var local1:Number = getPerspectiveScale(this.camera,pointPosition);
      if(local1 < CON_FULL_HIDE_SCALE.value) {
        return 1;
      }
      cameraPosition.reset(this.camera.x,this.camera.y,this.camera.z);
      direction.diff(pointPosition,cameraPosition);
      local3 = direction.length();
      direction.normalize();
      local4 = battleService.getBattleScene3D().raycast(cameraPosition,direction,battleService.getExcludedObjects3D());
      if(local4 != null && local4.time < local3) {
        local2 = 1;
      } else if(local1 > CON_HIDE_SCALE.value) {
        local2 = 0;
      } else if(this.infiniteVisible) {
        local2 = 1;
      } else {
        local2 = (CON_HIDE_SCALE.value - local1) / (CON_HIDE_SCALE.value - CON_FULL_HIDE_SCALE.value);
      }
      return local2;
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

    private function calculateProjectionMatrix() : Matrix4 {
      var local2:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local1:Number = this.camera.viewSizeX / this.camera.focalLength;
      local2 = this.camera.viewSizeY / this.camera.focalLength;
      var local3:Number = Math.cos(this.camera.rotationX);
      var local4:Number = Math.sin(this.camera.rotationX);
      local5 = Math.cos(this.camera.rotationY);
      local6 = Math.sin(this.camera.rotationY);
      local7 = Math.cos(this.camera.rotationZ);
      var local8:Number = Math.sin(this.camera.rotationZ);
      var local9:Number = local7 * local6;
      var local10:Number = local8 * local6;
      var local11:Number = local5 * this.camera.scaleX;
      var local12:Number = local4 * this.camera.scaleY;
      var local13:Number = local3 * this.camera.scaleY;
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
      while(local16._parent != null) {
        local16 = local16._parent;
        m.append(composeObject3DMatrix(local16));
      }
      m.invert();
      return m;
    }
  }
}
