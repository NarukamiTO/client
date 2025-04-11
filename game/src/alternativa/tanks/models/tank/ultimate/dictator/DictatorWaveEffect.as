package alternativa.tanks.models.tank.ultimate.dictator {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;
  import flash.geom.Vector3D;

  public class DictatorWaveEffect extends PooledObject implements GraphicEffect {
    public static const MID:Number = 30 / 60;
    public static const END:Number = 60 / 60;

    private static const SIZE:Number = 800;
    private static const MIN:Number = 0.3;
    private static const Z_OFFSET:int = 80;
    private static const offsetVector:Vector3D = new Vector3D(0,0,Z_OFFSET);

    private var mesh:Mesh = new Mesh();
    private var target:Object3D;
    private var container:Scene3DContainer;
    private var time:Number;

    public function DictatorWaveEffect(param1:Pool) {
      super(param1);
      this.mesh = new Mesh();
      var local2:Vertex = this.mesh.addVertex(-SIZE,SIZE,0,0,0);
      var local3:Vertex = this.mesh.addVertex(-SIZE,-SIZE,0,0,1);
      var local4:Vertex = this.mesh.addVertex(SIZE,-SIZE,0,1,1);
      var local5:Vertex = this.mesh.addVertex(SIZE,SIZE,0,1,0);
      this.mesh.addQuadFace(local2,local3,local4,local5);
      this.mesh.addQuadFace(local2,local5,local4,local3);
      this.mesh.calculateFacesNormals();
      this.mesh.calculateBounds();
      this.mesh.useLight = false;
      this.mesh.useShadowMap = false;
      this.mesh.shadowMapAlphaThreshold = 2;
      this.mesh.depthMapAlphaThreshold = 2;
      this.mesh.blendMode = BlendMode.ADD;
      this.mesh.softAttenuation = 80;
    }

    public function init(param1:TextureMaterial, param2:Object3D) : void {
      this.target = param2;
      this.mesh.setMaterialToAllFaces(param1);
      this.time = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.mesh);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      this.time += param1 / 1000;
      var local3:Vector3D = this.target.localToGlobal(offsetVector);
      this.mesh.x = local3.x;
      this.mesh.y = local3.y;
      this.mesh.z = local3.z;
      var local4:Number = MIN + (1 - MIN) * this.time / END;
      if(this.time <= MID) {
        this.mesh.scaleX = local4;
        this.mesh.scaleY = local4;
        this.mesh.alpha = this.time / MID;
        return true;
      }
      if(this.time <= END) {
        this.mesh.scaleX = local4;
        this.mesh.scaleY = local4;
        this.mesh.alpha = 1 - (this.time - MID) / (END - MID);
        return true;
      }
      return false;
    }

    public function destroy() : void {
      this.container.removeChild(this.mesh);
      this.mesh.setMaterialToAllFaces(null);
      recycle();
    }

    public function kill() : void {
      this.mesh.alpha = 0;
    }
  }
}
