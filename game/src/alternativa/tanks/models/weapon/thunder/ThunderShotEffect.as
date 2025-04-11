package alternativa.tanks.models.weapon.thunder {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.FillMaterial;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Matrix3;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;

  public class ThunderShotEffect extends PooledObject implements GraphicEffect {
    public static const SPRITE_SIZE_1:Number = 120;

    private static const SPRITE_SIZE_2:Number = 99.75;
    private static const SPRITE_SIZE_3:Number = 79.5;
    private static const speed1:Number = 500;
    private static const speed2:Number = 1000;
    private static const speed3:Number = 1500;
    private static const raySpeed1:Number = 1500;
    private static const raySpeed2:Number = 2500;
    private static const raySpeed3:Number = 1300;
    private static const basePoint:Vector3 = new Vector3();
    private static const direction:Vector3 = new Vector3();
    private static const axis:Vector3 = new Vector3();
    private static const eulerAngles:Vector3 = new Vector3();
    private static const rayMaterial:FillMaterial = new FillMaterial(4294753806);
    private static const turretMatrix:Matrix4 = new Matrix4();
    private static const trailMatrix:Matrix3 = new Matrix3();
    private static const trailMatrix2:Matrix3 = new Matrix3();

    private var turret:Object3D;
    private var localMuzzlePoint:Vector3;
    private var sprite1:Sprite3D;
    private var sprite2:Sprite3D;
    private var sprite3:Sprite3D;
    private var ray1:Trail;
    private var ray2:Trail;
    private var ray3:Trail;
    private var distance1:Number = 40;
    private var distance2:Number = 75;
    private var distance3:Number = 80;
    private var rayDistance1:Number = 0;
    private var rayDistance2:Number = 0;
    private var rayDistance3:Number = 0;
    private var angle1:Number;
    private var angle2:Number;
    private var angle3:Number;
    private var timeToLive:int;
    private var container:Scene3DContainer;

    public function ThunderShotEffect(param1:Pool) {
      super(param1);
      this.createParticles();
    }

    private static function setRayMatrix(param1:Mesh, param2:Number, param3:Vector3, param4:Vector3, param5:Number, param6:Number, param7:Number) : void {
      trailMatrix.fromAxisAngle(Vector3.Y_AXIS,param2);
      if(param4.y < -0.99999 || param4.y > 0.99999) {
        axis.x = 0;
        axis.y = 0;
        axis.z = 1;
        param2 = param4.y < 0 ? Math.PI : 0;
      } else {
        axis.x = param4.z;
        axis.y = 0;
        axis.z = -param4.x;
        axis.normalize();
        param2 = Math.acos(param4.y);
      }
      trailMatrix2.fromAxisAngle(axis,param2);
      trailMatrix.append(trailMatrix2);
      trailMatrix.getEulerAngles(eulerAngles);
      param1.rotationX = eulerAngles.x;
      param1.rotationY = eulerAngles.y;
      param1.rotationZ = eulerAngles.z;
      param1.x = param3.x + param4.x * param5 + param6 * trailMatrix.m00 + param7 * trailMatrix.m02;
      param1.y = param3.y + param4.y * param5 + param6 * trailMatrix.m10 + param7 * trailMatrix.m12;
      param1.z = param3.z + param4.z * param5 + param6 * trailMatrix.m20 + param7 * trailMatrix.m22;
    }

    private static function createSprite(param1:Number) : Sprite3D {
      var local2:Sprite3D = null;
      local2 = new Sprite3D(param1,param1);
      local2.rotation = 2 * Math.PI * Math.random();
      local2.blendMode = BlendMode.SCREEN;
      local2.useShadowMap = false;
      local2.useLight = false;
      return local2;
    }

    private static function setSpritePosition(param1:Sprite3D, param2:Vector3, param3:Vector3, param4:Number) : void {
      param1.x = param2.x + param3.x * param4;
      param1.y = param2.y + param3.y * param4;
      param1.z = param2.z + param3.z * param4;
    }

    public function init(param1:Object3D, param2:Vector3, param3:Material) : void {
      this.turret = param1;
      this.localMuzzlePoint = param2;
      this.sprite1.material = param3;
      this.sprite2.material = param3;
      this.sprite3.material = param3;
      this.timeToLive = 50;
      this.distance1 = 40;
      this.distance2 = 75;
      this.distance3 = 80;
      this.rayDistance1 = 0;
      this.rayDistance2 = 0;
      this.rayDistance3 = 0;
      this.angle1 = Math.random() * 2 * Math.PI;
      this.angle2 = Math.random() * 2 * Math.PI;
      this.angle3 = Math.random() * 2 * Math.PI;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.sprite1);
      param1.addChild(this.sprite2);
      param1.addChild(this.sprite3);
      param1.addChild(this.ray1);
      param1.addChild(this.ray2);
      param1.addChild(this.ray3);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(this.timeToLive < 0) {
        return false;
      }
      turretMatrix.setMatrix(this.turret.x,this.turret.y,this.turret.z,this.turret.rotationX,this.turret.rotationY,this.turret.rotationZ);
      turretMatrix.transformVector(this.localMuzzlePoint,basePoint);
      direction.x = turretMatrix.m01;
      direction.y = turretMatrix.m11;
      direction.z = turretMatrix.m21;
      var local3:Number = 0.001 * param1;
      this.rayDistance1 += local3 * raySpeed1;
      this.rayDistance2 += local3 * raySpeed2;
      this.rayDistance3 += local3 * raySpeed3;
      setSpritePosition(this.sprite1,basePoint,direction,this.distance1);
      setSpritePosition(this.sprite2,basePoint,direction,this.distance2);
      setSpritePosition(this.sprite3,basePoint,direction,this.distance3);
      setRayMatrix(this.ray1,this.angle1,basePoint,direction,this.rayDistance1,0,10);
      setRayMatrix(this.ray2,this.angle2,basePoint,direction,this.rayDistance2,-7,0);
      setRayMatrix(this.ray3,this.angle3,basePoint,direction,this.rayDistance3,7,0);
      this.distance1 += local3 * speed1;
      this.distance2 += local3 * speed2;
      this.distance3 += local3 * speed3;
      this.timeToLive -= param1;
      return true;
    }

    public function destroy() : void {
      this.container.removeChild(this.sprite1);
      this.container.removeChild(this.sprite2);
      this.container.removeChild(this.sprite3);
      this.container.removeChild(this.ray1);
      this.container.removeChild(this.ray3);
      this.container.removeChild(this.ray2);
      this.container = null;
      recycle();
    }

    public function kill() : void {
      this.timeToLive = -1;
    }

    private function createParticles() : void {
      this.sprite1 = createSprite(SPRITE_SIZE_1);
      this.sprite2 = createSprite(SPRITE_SIZE_2);
      this.sprite3 = createSprite(SPRITE_SIZE_3);
      this.ray1 = new Trail(0.8,rayMaterial);
      this.ray2 = new Trail(0.75,rayMaterial);
      this.ray3 = new Trail(0.82,rayMaterial);
    }
  }
}
