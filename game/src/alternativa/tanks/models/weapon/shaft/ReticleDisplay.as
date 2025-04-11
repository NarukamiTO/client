package alternativa.tanks.models.weapon.shaft {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.BattleView;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.weapon.laser.LaserPointerEffect;
  import alternativa.tanks.utils.Colorizer;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class ReticleDisplay extends Sprite {
    [Inject]
    public static var battleService:BattleService;

    private static var color2LaserSpotBitmap:Dictionary = new Dictionary();

    private var _reticle:Bitmap;
    private var laserSpot:Bitmap;
    private var laserSpotColor:uint;

    public function ReticleDisplay(param1:TextureResource, param2:uint) {
      super();
      this.laserSpotColor = param2;
      this.createReticleBitmap(param1);
      this.laserSpot = this.getLaserSpotBitmap(param2);
      addChild(this._reticle);
      addChild(this.laserSpot);
      this.laserSpot.x = (this._reticle.width - this.laserSpot.width) / 2;
      this.laserSpot.y = (this._reticle.height - this.laserSpot.height) / 2;
      mouseEnabled = false;
    }

    public function setLaserPointerScale(param1:Number) : void {
      this.laserSpot.width = LaserPointerEffect.spotTexture.width * param1;
      this.laserSpot.height = LaserPointerEffect.spotTexture.height * param1;
      this.laserSpot.x = (this._reticle.width - this.laserSpot.width) / 2;
      this.laserSpot.y = (this._reticle.height - this.laserSpot.height) / 2;
    }

    public function changeLaserSpotColor(param1:uint) : void {
      var local2:Bitmap = null;
      if(this.laserSpotColor != param1) {
        local2 = this.getLaserSpotBitmap(param1);
        addChild(local2);
        local2.x = this.laserSpot.x;
        local2.y = this.laserSpot.y;
        local2.width = this.laserSpot.width;
        local2.height = this.laserSpot.height;
        removeChild(this.laserSpot);
        this.laserSpot = local2;
        this.laserSpotColor = param1;
      }
    }

    private function createReticleBitmap(param1:TextureResource) : void {
      var local2:BitmapData = param1.data;
      this._reticle = new Bitmap(local2);
    }

    private function getLaserSpotBitmap(param1:uint) : Bitmap {
      var local2:Bitmap = color2LaserSpotBitmap[param1];
      if(local2 == null) {
        local2 = this.createLaserSpotBitmap(param1);
        color2LaserSpotBitmap[param1] = local2;
      }
      return local2;
    }

    private function createLaserSpotBitmap(param1:uint) : Bitmap {
      var local2:BitmapData = Colorizer.colorize(LaserPointerEffect.spotTexture,param1,0.75);
      var local3:Bitmap = new Bitmap(local2);
      local3.smoothing = true;
      return local3;
    }

    public function centerOnScreen() : void {
      if(stage != null) {
        x = stage.stageWidth - width >> 1;
        y = stage.stageHeight - height >> 1;
      }
    }

    public function updatePositon(param1:Vector3) : void {
      var local12:BattleView = null;
      var local2:GameCamera = battleService.getBattleScene3D().getCamera();
      var local3:Number = Number(local2.focalLength);
      var local4:Number = Number(local2.viewSizeX);
      var local5:Number = Number(local2.viewSizeY);
      var local6:Number = Math.atan((local5 + height / 2) / local3);
      var local7:Number = Math.atan((local4 + width / 2) / local3);
      var local8:Matrix3 = BattleUtils.tmpMatrix3;
      local8.setRotationMatrixForObject3D(local2);
      var local9:Vector3 = BattleUtils.tmpVector;
      local8.transformVectorInverse(param1,local9);
      var local10:Number = Math.atan2(local9.x,local9.z);
      var local11:Number = Math.atan2(local9.y,local9.z);
      visible = Math.abs(local11) <= local6 && Math.abs(local10) <= local7;
      if(visible) {
        local12 = battleService.getBattleView();
        x = local12.getX() + Math.tan(local10) * local3 + local4 - width / 2;
        y = local12.getY() + Math.tan(local11) * local3 + local5 - height / 2;
      }
    }
  }
}
