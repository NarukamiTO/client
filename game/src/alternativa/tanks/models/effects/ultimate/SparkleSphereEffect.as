package alternativa.tanks.models.effects.ultimate {
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.primitives.GeoSphere;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.geom.ColorTransform;
  import flash.geom.Vector3D;

  public class SparkleSphereEffect extends PooledObject implements GraphicEffect {
    private static const directionsMany:Vector.<Vector3D> = calculateDirections(2);
    private static const directionsFew:Vector.<Vector3D> = calculateDirections(1);
    private static const increaseTime:Number = 0.333;

    private var directions:Vector.<Vector3D>;
    private var sparklesCount:int;
    private var targetMesh:Mesh;
    private var isConsumer:Boolean;
    private var radius:Number;
    private var delay:Number;
    private var addScale:Number;
    private var sparkles:Vector.<SparkleEffect>;
    private var time:Number;
    private var container:Scene3DContainer;
    private var decreaseTime:Number = 1;

    public function SparkleSphereEffect(param1:Pool) {
      super(param1);
      this.sparkles = new Vector.<SparkleEffect>();
      var local2:int = 0;
      while(local2 < directionsMany.length) {
        this.sparkles.push(new SparkleEffect());
        local2++;
      }
    }

    private static function calculateDirections(param1:int) : Vector.<Vector3D> {
      var local2:int = 0;
      var local6:Vertex = null;
      var local7:Vector3D = null;
      var local8:int = 0;
      var local9:Vector3D = null;
      var local3:Vector.<Vector3D> = new Vector.<Vector3D>();
      var local4:GeoSphere = new GeoSphere(100,param1);
      var local5:Vector.<Vertex> = local4.vertices;
      for each(local6 in local5) {
        local8 = int(local3.length);
        local2 = 0;
        while(local2 < local8) {
          local9 = local3[local2];
          if(Math.abs(local9.x - local6.x) < 0.1 && Math.abs(local9.y - local6.y) < 0.1 && Math.abs(local9.z - local6.z) < 0.1) {
            break;
          }
          local2++;
        }
        if(local2 == local8) {
          local3.push(new Vector3D(local6.x,local6.y,local6.z));
        }
      }
      for each(local7 in local3) {
        local7.normalize();
      }
      return local3;
    }

    public function init(param1:TextureMaterial, param2:Mesh, param3:Boolean, param4:ColorTransform) : void {
      var local6:SparkleEffect = null;
      this.time = 0;
      this.targetMesh = param2;
      this.isConsumer = param3;
      this.radius = param3 ? 300 : 700;
      this.delay = param3 ? 0.1 : 0;
      this.decreaseTime = param3 ? 1 / 2 : 1;
      this.addScale = param3 ? 0 : 0.5;
      this.directions = param3 ? directionsFew : directionsMany;
      this.sparklesCount = param3 ? int(directionsFew.length) : int(directionsMany.length);
      var local5:int = 0;
      while(local5 < directionsMany.length) {
        this.sparkles[local5].colorTransform = param4;
        this.sparkles[local5].visible = local5 < this.sparklesCount;
        local5++;
      }
      for each(local6 in this.sparkles) {
        local6.init(param1);
      }
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      var local2:int = 0;
      while(local2 < this.sparkles.length) {
        param1.addChild(this.sparkles[local2]);
        local2++;
      }
      this.container = param1;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:int = 0;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:SparkleEffect = null;
      var local7:Vector3D = null;
      var local8:Number = 100;
      this.time += param1 / 1000;
      if(this.time <= this.delay) {
        local3 = 0;
        while(local3 < this.sparklesCount) {
          local6 = this.sparkles[local3];
          local6.visible = false;
          local3++;
        }
        return true;
      }
      if(this.time <= this.delay + increaseTime) {
        local4 = (this.time - this.delay) / increaseTime;
        local4 = Math.pow(local4,0.25);
        local5 = 1 + local4 * this.addScale;
        local3 = 0;
        while(local3 < this.sparklesCount) {
          local6 = this.sparkles[local3];
          local7 = this.directions[local3];
          local6.visible = true;
          local6.x = this.targetMesh.x + local7.x * this.radius * local4;
          local6.y = this.targetMesh.y + local7.y * this.radius * local4;
          local6.z = this.targetMesh.z + local7.z * this.radius * local4 + local8;
          local6.scaleX = local5;
          local6.scaleY = local5;
          local6.scaleZ = local5;
          local6.alpha = local4;
          local3++;
        }
        return true;
      }
      if(this.time <= this.delay + increaseTime + this.decreaseTime) {
        local4 = 1 - (this.time - this.delay - increaseTime) / this.decreaseTime;
        local4 = Math.pow(local4,0.3);
        local5 = 1 + local4 * this.addScale;
        local3 = 0;
        while(local3 < this.sparklesCount) {
          local6 = this.sparkles[local3];
          local7 = this.directions[local3];
          local6.visible = true;
          local6.x = this.targetMesh.x + local7.x * this.radius * local4;
          local6.y = this.targetMesh.y + local7.y * this.radius * local4;
          local6.z = this.targetMesh.z + local7.z * this.radius * local4 + local8;
          local6.scaleX = local5;
          local6.scaleY = local5;
          local6.scaleZ = local5;
          local6.alpha = local4;
          local3++;
        }
        return true;
      }
      return false;
    }

    public function destroy() : void {
      var local1:int = 0;
      while(local1 < this.sparkles.length) {
        this.container.removeChild(this.sparkles[local1]);
        local1++;
      }
      this.container = null;
      this.targetMesh = null;
      this.sparkles = null;
    }

    public function kill() : void {
      this.destroy();
    }
  }
}
