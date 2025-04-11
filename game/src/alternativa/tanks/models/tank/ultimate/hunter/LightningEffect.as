package alternativa.tanks.models.tank.ultimate.hunter {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;
  import flash.geom.Matrix3D;
  import flash.geom.Vector3D;

  public class LightningEffect extends PooledObject implements GraphicEffect {
    public static const MID:Number = 14 / 60;
    public static const END:Number = 50 / 60;
    public static const TAIL:Number = 120 / 60;

    private static const TARGET_Z_OFFSET:int = 20;
    private static const SIZE:Number = 400;
    private static const vector:Vector3D = new Vector3D();
    private static const vector3:Vector3 = new Vector3();

    private var container:Scene3DContainer;
    private var target:Vector3;
    private var lightningSound:Sound3D;
    private var source:Object3D;
    private var meshContainer:Object3DContainer;
    private var mesh:Mesh;
    private var time:Number;
    private var lightingSoundPlayed:Boolean = false;
    private var originOffset:Vector3D = new Vector3D();

    public function LightningEffect(param1:Pool) {
      super(param1);
      this.meshContainer = new Object3DContainer();
      this.mesh = new Mesh();
      var local2:Vertex = this.mesh.addVertex(-SIZE / 2,0,SIZE,0,0);
      var local3:Vertex = this.mesh.addVertex(-SIZE / 2,0,0,0,1);
      var local4:Vertex = this.mesh.addVertex(SIZE / 2,0,0,1,1);
      var local5:Vertex = this.mesh.addVertex(SIZE / 2,0,SIZE,1,0);
      this.mesh.addQuadFace(local2,local3,local4,local5);
      this.mesh.calculateFacesNormals();
      this.mesh.calculateBounds();
      this.mesh.useLight = false;
      this.mesh.useShadowMap = false;
      this.mesh.shadowMapAlphaThreshold = 2;
      this.mesh.depthMapAlphaThreshold = 2;
      this.mesh.blendMode = BlendMode.ADD;
      this.mesh.softAttenuation = 20;
      this.meshContainer.addChild(this.mesh);
    }

    public function init(param1:TextureMaterial, param2:Mesh, param3:Vector3, param4:Sound3D, param5:Number) : void {
      this.source = param2;
      this.target = param3;
      this.lightningSound = param4;
      this.mesh.setMaterialToAllFaces(param1);
      this.originOffset.setTo(0,0,param5);
      this.time = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.meshContainer);
      this.lightingSoundPlayed = false;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = param1 / 1000;
      this.time += local3;
      this.turnToCamera(param2);
      this.playSounds(param2);
      if(this.time <= MID) {
        this.mesh.alpha = this.time / MID;
        return true;
      }
      if(this.time <= END) {
        this.mesh.alpha = 1 - (this.time - MID) / (END - MID);
        return true;
      }
      if(this.time <= TAIL) {
        this.mesh.alpha = 0;
        return true;
      }
      return false;
    }

    private function playSounds(param1:GameCamera) : void {
      vector3.reset(this.target.x,this.target.y,this.target.z);
      if(!this.lightingSoundPlayed) {
        this.lightningSound.play(0,0);
        this.lightningSound.checkVolume(param1.position,vector3,param1.xAxis);
        this.lightingSoundPlayed = true;
      }
    }

    private function turnToCamera(param1:GameCamera) : void {
      var local2:Vector3D = null;
      local2 = this.source.localToGlobal(this.originOffset);
      this.meshContainer.x = local2.x;
      this.meshContainer.y = local2.y;
      this.meshContainer.z = local2.z;
      vector.x = this.target.x - local2.x;
      vector.y = this.target.y - local2.y;
      vector.z = this.target.z + TARGET_Z_OFFSET - local2.z;
      vector.scaleBy(0.9);
      this.mesh.scaleZ = vector.length / SIZE;
      this.meshContainer.rotationX = Math.atan2(vector.z,Math.sqrt(vector.x * vector.x + vector.y * vector.y)) - Math.PI / 2;
      this.meshContainer.rotationY = 0;
      this.meshContainer.rotationZ = -Math.atan2(vector.x,vector.y);
      var local3:Matrix3D = this.meshContainer.concatenatedMatrix;
      local3.invert();
      local3.prepend(param1.concatenatedMatrix);
      var local4:Vector3D = local3.transformVector(new Vector3D());
      this.mesh.rotationZ = Math.atan2(local4.x,-local4.y);
    }

    public function destroy() : void {
      this.container.removeChild(this.meshContainer);
      this.mesh.setMaterialToAllFaces(null);
      this.container = null;
      if(this.lightningSound != null) {
        this.lightningSound.stop();
        this.lightningSound = null;
      }
      recycle();
    }

    public function kill() : void {
      this.mesh.alpha = 0;
    }
  }
}
