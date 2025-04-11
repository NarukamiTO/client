package alternativa.tanks.models.tank.ultimate.dictator {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;
  import flash.geom.Vector3D;

  public class DictatorStreamEffect extends PooledObject implements GraphicEffect {
    public static const OFFSET:Number = 150;
    public static const MID:Number = 30 / 60;
    public static const KEY1:Number = 40 / 60;
    public static const KEY2:Number = 60 / 60;
    public static const END:Number = 100 / 60;

    private static const SIZE:Number = 300;
    private static const DX:Number = 15;
    private static const MAX:Number = 4;
    private static const TOP:Number = 800;
    private static const D:Number = 40;
    private static const H:Number = 150;
    private static const vector:Vector3D = new Vector3D();

    private var beam:Mesh;
    private var center:Mesh;
    private var star1:Sprite3D;
    private var star2:Sprite3D;
    private var star3:Sprite3D;
    private var star4:Sprite3D;
    private var origin1:Vector3D;
    private var origin2:Vector3D;
    private var origin3:Vector3D;
    private var origin4:Vector3D;
    private var time:Number;
    private var container:Scene3DContainer;
    private var targetObject:Object3D;
    private var scaleXY:Number;
    private var scaleZ:Number;
    private var timeScale:Number;
    private var zOffset:Number;
    private var offsetVector:Vector3D = new Vector3D();

    public function DictatorStreamEffect(param1:Pool) {
      super(param1);
      this.beam = new Mesh();
      var local2:Vertex = this.beam.addVertex(-SIZE / 2 - DX,0,SIZE,0,0);
      var local3:Vertex = this.beam.addVertex(-SIZE / 2 - DX,0,0,0,1);
      var local4:Vertex = this.beam.addVertex(SIZE / 2 - DX,0,0,1,1);
      var local5:Vertex = this.beam.addVertex(SIZE / 2 - DX,0,SIZE,1,0);
      this.beam.addQuadFace(local2,local3,local4,local5);
      local2 = this.beam.addVertex(-SIZE / 2 + DX,0,SIZE,0,0);
      local3 = this.beam.addVertex(-SIZE / 2 + DX,0,0,0,1);
      local4 = this.beam.addVertex(SIZE / 2 + DX,0,0,1,1);
      local5 = this.beam.addVertex(SIZE / 2 + DX,0,SIZE,1,0);
      this.beam.addQuadFace(local2,local3,local4,local5);
      this.beam.calculateFacesNormals();
      this.beam.calculateBounds();
      this.beam.useLight = false;
      this.beam.useShadowMap = false;
      this.beam.shadowMapAlphaThreshold = 2;
      this.beam.depthMapAlphaThreshold = 2;
      this.beam.blendMode = BlendMode.ADD;
      this.beam.softAttenuation = 150;
      this.center = new Mesh();
      local2 = this.center.addVertex(-SIZE / 2 * 1.4,0,SIZE,0,0);
      local3 = this.center.addVertex(-SIZE / 2 * 1.4,0,0,0,1);
      local4 = this.center.addVertex(SIZE / 2 * 1.4,0,0,1,1);
      local5 = this.center.addVertex(SIZE / 2 * 1.4,0,SIZE,1,0);
      this.center.addQuadFace(local2,local3,local4,local5);
      this.center.calculateFacesNormals();
      this.center.calculateBounds();
      this.center.useLight = false;
      this.center.useShadowMap = false;
      this.center.shadowMapAlphaThreshold = 2;
      this.center.depthMapAlphaThreshold = 2;
      this.center.blendMode = BlendMode.ADD;
      this.center.softAttenuation = 150;
      this.origin1 = new Vector3D(-D,D,0);
      this.origin2 = new Vector3D(-D,-D,H);
      this.origin3 = new Vector3D(D,-D,H + H);
      this.origin4 = new Vector3D(D,D,H + H + H);
      this.star1 = new Sprite3D(100,100);
      this.star1.useLight = false;
      this.star1.useShadowMap = false;
      this.star1.blendMode = BlendMode.ADD;
      this.star1.softAttenuation = 150;
      this.star2 = this.star1.clone() as Sprite3D;
      this.star3 = this.star1.clone() as Sprite3D;
      this.star4 = this.star1.clone() as Sprite3D;
    }

    public function init(param1:TextureMaterial, param2:TextureMaterial, param3:Object3D, param4:Number, param5:Number, param6:Number = 150, param7:Number = 1) : * {
      this.targetObject = param3;
      this.scaleXY = param4;
      this.scaleZ = param5;
      this.timeScale = param7;
      this.zOffset = param6;
      this.offsetVector.x = 0;
      this.offsetVector.y = 0;
      this.offsetVector.z = param6;
      this.beam.setMaterialToAllFaces(param1);
      this.center.setMaterialToAllFaces(param1);
      var local8:Number = Math.max(param4,param5);
      this.star1.material = param2;
      this.star1.scaleX = local8;
      this.star1.scaleY = local8;
      this.star1.scaleZ = local8;
      this.star2.material = param2;
      this.star2.scaleX = local8;
      this.star2.scaleY = local8;
      this.star2.scaleZ = local8;
      this.star3.material = param2;
      this.star3.scaleX = local8;
      this.star3.scaleY = local8;
      this.star3.scaleZ = local8;
      this.star4.material = param2;
      this.star4.scaleX = local8;
      this.star4.scaleY = local8;
      this.star4.scaleZ = local8;
      this.time = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.beam);
      param1.addChild(this.center);
      param1.addChild(this.star1);
      param1.addChild(this.star2);
      param1.addChild(this.star3);
      param1.addChild(this.star4);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local4:Number = NaN;
      this.time += this.timeScale * param1 / 1000;
      var local3:Vector3D = this.targetObject.localToGlobal(this.offsetVector);
      vector.x = param2.x - local3.x;
      vector.y = param2.y - local3.y;
      vector.z = param2.z - local3.z;
      vector.normalize();
      this.beam.x = local3.x + vector.x * OFFSET;
      this.beam.y = local3.y + vector.y * OFFSET;
      this.beam.z = local3.z + vector.z * OFFSET;
      this.beam.rotationZ = Math.atan2(param2.y - local3.y,param2.x - local3.x) + Math.PI / 2;
      this.center.x = this.beam.x;
      this.center.y = this.beam.y;
      this.center.z = this.beam.z;
      this.center.rotationZ = this.beam.rotationZ;
      this.beam.scaleX = this.scaleXY;
      this.beam.scaleY = this.scaleXY;
      this.center.scaleX = this.scaleXY;
      this.center.scaleY = this.scaleXY;
      this.center.scaleZ = this.scaleZ;
      if(this.time <= KEY2) {
        local4 = TOP * this.time / KEY2 * this.scaleZ;
        this.star1.x = local3.x + this.origin1.x * this.scaleXY;
        this.star1.y = local3.y + this.origin1.y * this.scaleXY;
        this.star1.z = local3.z + this.origin1.z * this.scaleZ + local4;
        this.star2.x = local3.x + this.origin2.x * this.scaleXY;
        this.star2.y = local3.y + this.origin2.y * this.scaleXY;
        this.star2.z = local3.z + this.origin2.z * this.scaleZ + local4;
        this.star3.x = local3.x + this.origin3.x * this.scaleXY;
        this.star3.y = local3.y + this.origin3.y * this.scaleXY;
        this.star3.z = local3.z + this.origin3.z * this.scaleZ + local4;
        this.star4.x = local3.x + this.origin4.x * this.scaleXY;
        this.star4.y = local3.y + this.origin4.y * this.scaleXY;
        this.star4.z = local3.z + this.origin4.z * this.scaleZ + local4;
        if(this.time <= MID) {
          this.star1.alpha = this.time / MID;
        } else {
          this.star1.alpha = 1 - (this.time - MID) / (KEY2 - MID);
        }
        this.star2.alpha = this.star1.alpha;
        this.star3.alpha = this.star1.alpha;
        this.star4.alpha = this.star1.alpha;
        this.star1.visible = true;
        this.star2.visible = true;
        this.star3.visible = true;
        this.star3.visible = true;
        this.star4.visible = true;
      } else {
        this.star1.visible = false;
        this.star2.visible = false;
        this.star3.visible = false;
        this.star4.visible = false;
      }
      if(this.time <= KEY1) {
        local4 = this.time / KEY1;
        this.beam.scaleZ = (1 + (MAX - 1) * local4) * this.scaleZ;
        this.beam.alpha = local4;
        this.center.alpha = this.beam.alpha;
        return true;
      }
      if(this.time <= END) {
        if(this.time <= KEY2) {
          this.beam.alpha = 1;
        } else {
          this.beam.alpha = 1 - (this.time - KEY2) / (END - KEY2);
        }
        this.center.alpha = 1 - (this.time - KEY1) / (END - KEY1);
        return true;
      }
      return false;
    }

    public function destroy() : void {
      this.container.removeChild(this.beam);
      this.container.removeChild(this.center);
      this.container.removeChild(this.star1);
      this.container.removeChild(this.star2);
      this.container.removeChild(this.star3);
      this.container.removeChild(this.star4);
      this.beam.setMaterialToAllFaces(null);
      this.center.setMaterialToAllFaces(null);
      this.star1.material = null;
      this.star1.scaleX = 0;
      this.star1.scaleY = 0;
      this.star1.scaleZ = 0;
      this.star2.material = null;
      this.star2.scaleX = 0;
      this.star2.scaleY = 0;
      this.star2.scaleZ = 0;
      this.star3.material = null;
      this.star3.scaleX = 0;
      this.star3.scaleY = 0;
      this.star3.scaleZ = 0;
      this.star4.material = null;
      this.star4.scaleX = 0;
      this.star4.scaleY = 0;
      this.star4.scaleZ = 0;
      this.container = null;
      recycle();
    }

    public function kill() : void {
      this.beam.alpha = 0;
      this.center.alpha = 0;
      this.star1.alpha = 0;
      this.star2.alpha = 0;
      this.star3.alpha = 0;
      this.star4.alpha = 0;
    }
  }
}
