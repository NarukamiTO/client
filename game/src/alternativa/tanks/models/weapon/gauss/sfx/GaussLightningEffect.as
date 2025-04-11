package alternativa.tanks.models.weapon.gauss.sfx {
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;

  public class GaussLightningEffect extends PooledObject implements GraphicEffect {
    private static const TRAIL_LIFE:Number = 7 / 60;
    private static const LIGHTNING_START:Number = 5 / 60;
    private static const LIGHTNING_LIFE:Number = 13 / 60;
    private static const LIGHTNING_WIDENING_RATE:Number = 0.04;
    private static const TRAIL_SIZE:Number = 70;
    private static const LIGHTNING_SIZE:Number = 100;
    private static const UV_SCALE:Number = 1.5;
    private static const FAKE_VALUE:Number = 1;

    private var container:Scene3DContainer;
    private var trail:Mesh = new Mesh();
    private var lightning:Mesh = new Mesh();
    private var lightningVertexA:Vertex;
    private var lightningVertexB:Vertex;
    private var lightningVertexC:Vertex;
    private var lightningVertexD:Vertex;
    private var pointFrom:Vector3 = new Vector3();
    private var direction:Vector3 = new Vector3();
    private var time:Number = 0;

    public function GaussLightningEffect(param1:Pool) {
      super(param1);
      var local2:Vertex = this.trail.addVertex(-TRAIL_SIZE / 2,TRAIL_SIZE,0,0,0);
      var local3:Vertex = this.trail.addVertex(-TRAIL_SIZE / 2,0,0,0,1);
      var local4:Vertex = this.trail.addVertex(TRAIL_SIZE / 2,0,0,1,1);
      var local5:Vertex = this.trail.addVertex(TRAIL_SIZE / 2,TRAIL_SIZE,0,1,0);
      this.trail.addQuadFace(local2,local3,local4,local5);
      this.trail.calculateFacesNormals();
      this.trail.blendMode = BlendMode.ADD;
      this.trail.alpha = 0.6;
      this.lightningVertexA = this.lightning.addVertex(-LIGHTNING_SIZE / 2,0,0,0,0);
      this.lightningVertexB = this.lightning.addVertex(LIGHTNING_SIZE / 2,0,0,1,0);
      this.lightningVertexC = this.lightning.addVertex(LIGHTNING_SIZE / 2,FAKE_VALUE,0,1,FAKE_VALUE);
      this.lightningVertexD = this.lightning.addVertex(-LIGHTNING_SIZE / 2,FAKE_VALUE,0,0,FAKE_VALUE);
      this.lightning.addQuadFace(this.lightningVertexA,this.lightningVertexB,this.lightningVertexC,this.lightningVertexD);
      this.lightning.blendMode = BlendMode.ADD;
    }

    public function init(param1:Vector3, param2:Vector3, param3:TextureMaterial, param4:TextureMaterial) : void {
      this.pointFrom.copy(param1);
      this.direction.diff(param2,param1).normalize();
      var local5:Number = param1.distanceTo(param2);
      this.trail.scaleY = local5 / TRAIL_SIZE;
      this.trail.setMaterialToAllFaces(param3);
      BattleUtils.setObjectPosition3d(this.trail,param1.toVector3d());
      var local6:Number = local5 / LIGHTNING_SIZE / 4 / UV_SCALE;
      this.lightningVertexC.v = local6;
      this.lightningVertexD.v = local6;
      this.lightningVertexC.y = local5;
      this.lightningVertexD.y = local5;
      this.lightning.calculateFacesNormals();
      this.lightning.setMaterialToAllFaces(param4);
      BattleUtils.setObjectPosition3d(this.lightning,param1.toVector3d());
      this.time = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.trail);
      param1.addChild(this.lightning);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = NaN;
      if(this.time < TRAIL_LIFE) {
        this.trail.visible = true;
        SFXUtils.alignObjectPlaneToView(this.trail,this.pointFrom,this.direction,param2.position);
      } else {
        this.trail.visible = false;
      }
      if(this.time < LIGHTNING_START) {
        this.lightning.visible = false;
      } else if(this.time < LIGHTNING_LIFE) {
        SFXUtils.alignObjectPlaneToView(this.lightning,this.pointFrom,this.direction,param2.position);
        local3 = (this.time - LIGHTNING_START) / (LIGHTNING_LIFE - LIGHTNING_START);
        this.lightning.alpha = 1 - local3;
        this.lightning.scaleX = 1 + LIGHTNING_WIDENING_RATE * local3;
        this.lightning.visible = true;
      }
      this.time += param1 * 0.001;
      return this.time < LIGHTNING_LIFE;
    }

    public function destroy() : void {
      if(this.container != null) {
        this.container.removeChild(this.trail);
        this.container.removeChild(this.lightning);
        this.container = null;
        recycle();
      }
    }

    public function kill() : void {
    }
  }
}
