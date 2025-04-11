package alternativa.tanks.models.weapon.artillery.sfx {
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.AnimatedSprite3D;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;

  public class ArtilleryFlame extends PooledObject implements GraphicEffect {
    [Inject]
    public static var battleService:BattleService;

    private const LIFE_TIME:Number = 1;

    private var flame:Sprite3D;
    private var smoke1:AnimatedSprite3D;
    private var smoke2:AnimatedSprite3D;
    private var container:Scene3DContainer;
    private var time:Number;
    private var origin:Vector3;
    private var direction:Vector3;
    private var front:Boolean;
    private var stream:Mesh;

    public function ArtilleryFlame(param1:Pool) {
      super(param1);
      this.flame = new Sprite3D(300,300);
      this.smoke1 = new AnimatedSprite3D(300,300);
      this.smoke2 = new AnimatedSprite3D(300,300);
      this.stream = new Mesh();
    }

    public function init(param1:Vector3, param2:Vector3, param3:ArtillerySfxData, param4:Boolean = false) : void {
      this.origin = param1.clone();
      this.direction = param2.clone();
      this.front = param4;
      this.flame.material = param3.flame;
      this.flame.rotation = Math.random() * Math.PI * 2;
      this.flame.blendMode = BlendMode.ADD;
      this.createSmoke(param3.smoke);
      this.createStream(param3.stream);
      this.time = param4 ? -3 / 60 : 0;
      battleService.addGraphicEffect(this);
    }

    private function createStream(param1:TextureMaterial) : void {
      var local2:Vertex = null;
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local5:Vertex = null;
      if(this.stream.faces.length == 0) {
        local2 = this.stream.addVertex(-40,320,0,0,0);
        local3 = this.stream.addVertex(-40,0,0,0,1);
        local4 = this.stream.addVertex(40,0,0,1,1);
        local5 = this.stream.addVertex(40,320,0,1,0);
        this.stream.addQuadFace(local2,local3,local4,local5,param1);
        this.stream.addQuadFace(local5,local4,local3,local2,param1);
        this.stream.calculateFacesNormals();
        this.stream.calculateBounds();
        this.stream.alpha = 0.5;
        this.stream.blendMode = BlendMode.ADD;
      }
    }

    private function createSmoke(param1:TextureAnimation) : void {
      this.smoke1.setAnimationData(param1);
      this.smoke2.setAnimationData(param1);
      this.smoke1.rotation = Math.random() * Math.PI * 2;
      this.smoke2.rotation = Math.random() * Math.PI * 2;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.flame);
      param1.addChild(this.smoke1);
      param1.addChild(this.smoke2);
      param1.addChild(this.stream);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      this.time += param1 / 1000;
      if(this.time > this.LIFE_TIME) {
        this.container.removeChild(this.flame);
        this.container.removeChild(this.smoke1);
        this.container.removeChild(this.smoke2);
        this.container.removeChild(this.stream);
        this.container = null;
        return false;
      }
      var local7:Number = 2 / 60;
      var local8:Number = 6 / 60;
      if(this.front && this.time >= local7 && this.time < local8) {
        local3 = (this.time - local7) / (local8 - local7);
        local5 = 200 * local3;
        this.stream.x = this.origin.x + this.direction.x * local5;
        this.stream.y = this.origin.y + this.direction.y * local5;
        this.stream.z = this.origin.z + this.direction.z * local5;
        this.stream.scaleY = 1 + local3;
        this.stream.rotationX = Math.atan2(this.direction.z,Math.sqrt(this.direction.x * this.direction.x + this.direction.y * this.direction.y));
        this.stream.rotationY = 0;
        this.stream.rotationZ = -Math.atan2(this.direction.x,this.direction.y);
        this.stream.visible = true;
      } else {
        this.stream.visible = false;
      }
      var local9:Number = 0;
      var local10:Number = 4 / 60;
      var local11:Number = 12 / 60;
      var local12:Number = 0.4;
      var local13:Number = 0.8;
      var local14:Number = 1.8;
      var local15:Number = 20;
      var local16:Number = 170;
      var local17:Number = 300;
      var local18:Number = 0.24;
      var local19:Number = 1;
      var local20:Number = 0;
      if(this.time < local9) {
        this.flame.visible = false;
      } else if(this.time < local11) {
        if(this.time <= local10) {
          local3 = this.time / local10;
          local4 = local12 + (local13 - local12) * local3;
          local5 = local15 + (local16 - local15) * local3;
          local6 = local18 + (local19 - local18) * local3;
        } else {
          local3 = (this.time - local10) / (local11 - local10);
          local4 = local13 + (local14 - local13) * local3;
          local5 = local16 + (local17 - local16) * local3;
          local6 = local19 + (local20 - local19) * local3;
        }
        this.flame.scaleX = local4;
        this.flame.scaleY = local4;
        this.flame.scaleZ = local4;
        this.flame.x = this.origin.x + this.direction.x * local5;
        this.flame.y = this.origin.y + this.direction.y * local5;
        this.flame.z = this.origin.z + this.direction.z * local5;
        this.flame.alpha = local6;
        this.flame.visible = true;
      } else {
        this.flame.visible = false;
      }
      var local21:Number = 50 / 60;
      if(this.time < local9) {
        this.smoke1.visible = false;
        this.smoke2.visible = false;
      } else if(this.time < local21) {
        local3 = this.time / local21;
        local3 = Math.pow(local3,1 / 3);
        local4 = local12 + (local14 - local12) * local3;
        local5 = 350 * local3;
        local6 = 1 - local3;
        this.smoke1.scaleX = local4;
        this.smoke1.scaleY = local4;
        this.smoke1.scaleZ = local4;
        this.smoke1.x = this.origin.x + this.direction.x * local5;
        this.smoke1.y = this.origin.y + this.direction.y * local5;
        this.smoke1.z = this.origin.z + this.direction.z * local5;
        this.smoke1.alpha = local6;
        this.smoke1.visible = true;
        this.smoke1.update(param1);
        local4 = local12 + (local14 * 0.7 - local12) * local3;
        local5 = 210 * local3;
        local6 = 1 - local3;
        this.smoke2.scaleX = local4;
        this.smoke2.scaleY = local4;
        this.smoke2.scaleZ = local4;
        this.smoke2.x = this.origin.x + this.direction.x * local5;
        this.smoke2.y = this.origin.y + this.direction.y * local5;
        this.smoke2.z = this.origin.z + this.direction.z * local5;
        this.smoke2.alpha = local6;
        this.smoke2.visible = true;
        this.smoke2.update(param1);
      } else {
        this.smoke1.visible = false;
        this.smoke2.visible = false;
      }
      this.smoke2.update(param1);
      return true;
    }

    public function destroy() : void {
      if(Boolean(this.container)) {
        this.container.removeChild(this.flame);
        this.container.removeChild(this.smoke1);
        this.container.removeChild(this.smoke2);
        this.container.removeChild(this.stream);
      }
      this.container = null;
      this.flame.material = null;
      this.smoke1.material = null;
      this.smoke2.material = null;
      recycle();
    }

    public function kill() : void {
      this.flame.alpha = 0;
      this.smoke1.alpha = 0;
      this.smoke2.alpha = 0;
    }
  }
}
