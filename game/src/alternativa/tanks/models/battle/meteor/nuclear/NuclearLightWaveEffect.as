package alternativa.tanks.models.battle.meteor.nuclear {
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;

  public class NuclearLightWaveEffect extends PooledObject implements GraphicEffect {
    private var container:Scene3DContainer = null;
    private var wave:Mesh = new Mesh();
    private var time:Number = 0;
    private var epicenter:Vector3 = new Vector3();

    public function NuclearLightWaveEffect(param1:Pool) {
      super(param1);
    }

    public function init(param1:Vector3, param2:TextureMaterial) : void {
      this.epicenter.copy(param1);
      var local3:Number = 2000;
      var local4:Vertex = this.wave.addVertex(-local3,local3,0,0,0);
      var local5:Vertex = this.wave.addVertex(-local3,-local3,0,0,1);
      var local6:Vertex = this.wave.addVertex(local3,-local3,0,1,1);
      var local7:Vertex = this.wave.addVertex(local3,local3,0,1,0);
      this.wave.addQuadFace(local4,local5,local6,local7,param2);
      this.wave.addQuadFace(local4,local7,local6,local5,param2);
      this.wave.calculateFacesNormals();
      this.wave.calculateBounds();
      this.wave.useLight = false;
      this.wave.useShadowMap = false;
      this.wave.shadowMapAlphaThreshold = 2;
      this.wave.depthMapAlphaThreshold = 2;
      this.wave.blendMode = BlendMode.ADD;
      this.wave.softAttenuation = 80;
      this.wave.scaleX = 1;
      this.wave.scaleY = 1;
      this.wave.scaleZ = 1;
      this.time = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.wave);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = param1 / 1000;
      this.time += local3;
      this.wave.x = this.epicenter.x;
      this.wave.y = this.epicenter.y;
      this.wave.z = this.epicenter.z + 80;
      var local4:Number = NuclearBangEffect.KEY1 / 3;
      var local5:Number = 10 / 60;
      var local6:Number = 20 / 60;
      if(this.time <= local4) {
        this.wave.alpha = this.time / local5;
        this.wave.visible = true;
      } else if(this.time <= local6) {
        this.wave.alpha = 1 - (this.time - local5) / (local6 - local5);
        this.wave.visible = true;
      } else {
        this.wave.visible = false;
      }
      var local7:Number = local3 * 6;
      this.wave.scaleX += local7;
      this.wave.scaleY += local7;
      return this.wave.visible;
    }

    public function destroy() : void {
      if(this.container != null) {
        this.container.removeChild(this.wave);
        this.container = null;
      }
      this.wave.setMaterialToAllFaces(null);
      recycle();
    }

    public function kill() : void {
      this.destroy();
    }
  }
}
