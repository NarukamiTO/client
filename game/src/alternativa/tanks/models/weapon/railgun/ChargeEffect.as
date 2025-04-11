package alternativa.tanks.models.weapon.railgun {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.engine3d.UVFrame;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.GraphicsEffectDestructionListener;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class ChargeEffect extends PooledObject implements GraphicEffect {
    private static const globalPosition:Vector3 = new Vector3();
    private static const matrix:Matrix4 = new Matrix4();

    protected var sprite:Sprite3D;

    private var framesPerMillisecond:Number;
    private var currFrame:Number;
    private var frames:Vector.<UVFrame>;
    private var numFrames:int;
    private var localMuzzlePosition:Vector3 = new Vector3();
    private var turret:Object3D;
    private var listener:GraphicsEffectDestructionListener;
    private var container:Scene3DContainer;

    public function ChargeEffect(param1:Pool) {
      super(param1);
      this.sprite = new Sprite3D(1,1);
      this.sprite.useShadowMap = false;
      this.sprite.useLight = false;
    }

    public function init(param1:Number, param2:Number, param3:TextureAnimation, param4:Vector3, param5:Object3D, param6:Number, param7:Number, param8:GraphicsEffectDestructionListener) : void {
      this.initSprite(param1,param2,param6,param3.material);
      this.frames = param3.frames;
      this.framesPerMillisecond = 0.001 * param7;
      this.localMuzzlePosition.copy(param4);
      this.localMuzzlePosition.y += 10;
      this.turret = param5;
      this.listener = param8;
      this.numFrames = this.frames.length;
      this.currFrame = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.sprite);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(this.currFrame >= this.numFrames) {
        return false;
      }
      matrix.setMatrix(this.turret.x,this.turret.y,this.turret.z,this.turret.rotationX,this.turret.rotationY,this.turret.rotationZ);
      matrix.transformVector(this.localMuzzlePosition,globalPosition);
      this.sprite.x = globalPosition.x;
      this.sprite.y = globalPosition.y;
      this.sprite.z = globalPosition.z;
      this.setFrame(this.frames[int(this.currFrame)]);
      this.currFrame += this.framesPerMillisecond * param1;
      return true;
    }

    private function setFrame(param1:UVFrame) : void {
      this.sprite.topLeftU = param1.topLeftU;
      this.sprite.topLeftV = param1.topLeftV;
      this.sprite.bottomRightU = param1.bottomRightU;
      this.sprite.bottomRightV = param1.bottomRightV;
    }

    public function destroy() : void {
      this.listener.onGraphicsEffectDestroyed(this);
      this.listener = null;
      this.container.removeChild(this.sprite);
      this.sprite.material = null;
      this.frames = null;
      recycle();
    }

    public function kill() : void {
      this.currFrame = this.numFrames + 1;
    }

    private function initSprite(param1:Number, param2:Number, param3:Number, param4:TextureMaterial) : void {
      this.sprite.width = param1;
      this.sprite.height = param2;
      this.sprite.rotation = param3;
      this.sprite.material = param4;
    }
  }
}
