package alternativa.tanks.models.tank.ultimate.hornet {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.geom.Vector3D;
  import flash.utils.getTimer;

  public class RadarEffect extends PooledObject implements GraphicEffect {
    public static const FADE:Number = 0.5;
    public static const OFFSET:Number = 330;
    public static const RINGS_AMOUNT:int = 3;
    public static const PERIOD_MS:Number = 2000;

    private static const TARGET_Z_OFFSET:Number = 50;
    private static const SONAR_SOUND_PERIOD_SEC:Number = 2;
    private static const vector:Vector3D = new Vector3D();
    private static const vector3:Vector3 = new Vector3();

    private var lastPeriodBeepPlayed:int = -1;
    private var container:Scene3DContainer;
    private var target:Object3D;
    private var rings:Vector.<Object3D>;
    private var time:Number;
    private var fadeOutFlag:Boolean;
    private var fadeOutTime:Number;
    private var beepSound:Sound3D;

    public function RadarEffect(param1:Pool, param2:Number) {
      var local3:int = 0;
      this.rings = new Vector.<Object3D>(RINGS_AMOUNT);
      super(param1);
      local3 = 0;
      while(local3 < RINGS_AMOUNT) {
        this.rings[local3] = new Sprite3D(param2,param2);
        this.rings[local3].useLight = false;
        this.rings[local3].useShadowMap = false;
        this.rings[local3].softAttenuation = 200;
        local3++;
      }
    }

    public function init(param1:TextureMaterial, param2:Object3D, param3:Sound3D) : * {
      this.target = param2;
      var local4:int = 0;
      while(local4 < RINGS_AMOUNT) {
        Sprite3D(this.rings[local4]).material = param1;
        local4++;
      }
      this.time = 0;
      this.fadeOutFlag = false;
      this.beepSound = param3;
      this.lastPeriodBeepPlayed = -1;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChildren(this.rings);
    }

    public function fadeOut() : void {
      this.beepSound.stop();
      this.fadeOutFlag = true;
      this.fadeOutTime = 0;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local6:* = undefined;
      var local7:int = 0;
      var local8:int = 0;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local3:Number = param1 / 1000;
      this.time += local3;
      this.playSounds(param2);
      vector.x = param2.x - this.target.x;
      vector.y = param2.y - this.target.y;
      vector.z = param2.z - this.target.z + TARGET_Z_OFFSET;
      vector.normalize();
      var local4:* = this.target.x + vector.x * OFFSET;
      var local5:* = this.target.y + vector.y * OFFSET;
      local6 = this.target.z + vector.z * OFFSET + TARGET_Z_OFFSET;
      local7 = 0;
      while(local7 < RINGS_AMOUNT) {
        local8 = local7 * PERIOD_MS / RINGS_AMOUNT;
        local9 = (getTimer() + local8) % PERIOD_MS / PERIOD_MS;
        this.rings[local7].alpha = local9 > FADE ? (1 - local9) / (1 - FADE) : 1;
        this.rings[local7].scaleX = local9;
        this.rings[local7].scaleY = local9;
        this.rings[local7].scaleZ = local9;
        this.rings[local7].x = local4;
        this.rings[local7].y = local5;
        this.rings[local7].z = local6;
        local7++;
      }
      if(this.fadeOutFlag) {
        this.fadeOutTime += local3;
        local10 = 1 - this.fadeOutTime / FADE;
        if(local10 <= 0) {
          return false;
        }
        local7 = 0;
        while(local7 < RINGS_AMOUNT) {
          this.rings[local7].alpha *= local10;
          local7++;
        }
        return true;
      }
      return true;
    }

    private function playSounds(param1:GameCamera) : void {
      vector3.reset(this.target.x,this.target.y,this.target.z + TARGET_Z_OFFSET);
      var local2:int = Math.floor(this.time / SONAR_SOUND_PERIOD_SEC);
      if(local2 != this.lastPeriodBeepPlayed) {
        this.beepSound.play(0,0);
        this.lastPeriodBeepPlayed = local2;
      }
      this.beepSound.checkVolume(param1.position,vector3,param1.xAxis);
    }

    public function kill() : void {
      var local1:int = 0;
      while(local1 < RINGS_AMOUNT) {
        this.rings[local1].alpha = 0;
        local1++;
      }
    }

    public function destroy() : void {
      this.beepSound.stop();
      this.beepSound = null;
      var local1:int = 0;
      while(local1 < RINGS_AMOUNT) {
        Sprite3D(this.rings[local1]).material = null;
        this.container.removeChild(this.rings[local1]);
        local1++;
      }
      this.container = null;
      this.target = null;
      recycle();
    }
  }
}
