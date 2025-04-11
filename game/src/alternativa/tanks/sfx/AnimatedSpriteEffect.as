package alternativa.tanks.sfx {
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.AnimatedSprite3D;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.geom.ColorTransform;

  public class AnimatedSpriteEffect extends PooledObject implements GraphicEffect {
    private var sprite:AnimatedSprite3D;
    private var currentFrame:Number;
    private var framesPerMs:Number;
    private var loopsCount:int;
    private var positionProvider:Object3DPositionProvider;
    private var container:Scene3DContainer;

    public function AnimatedSpriteEffect(param1:Pool) {
      super(param1);
      this.sprite = new AnimatedSprite3D(1,1);
    }

    public function init(param1:Number, param2:Number, param3:TextureAnimation, param4:Number, param5:Object3DPositionProvider, param6:Number = 0.5, param7:Number = 0.5, param8:ColorTransform = null, param9:Number = 130, param10:String = "normal") : void {
      this.initSprite(param1,param2,param4,param6,param7,param8,param3,param9,param10);
      param5.initPosition(this.sprite);
      this.framesPerMs = 0.001 * param3.fps;
      this.positionProvider = param5;
      this.currentFrame = 0;
      this.loopsCount = 1;
    }

    public function initLooped(param1:Number, param2:Number, param3:TextureAnimation, param4:Number, param5:Object3DPositionProvider, param6:Number = 0.5, param7:Number = 0.5, param8:ColorTransform = null, param9:Number = 130, param10:String = "normal", param11:int = -1) : void {
      this.init(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
      this.loopsCount = param11;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.sprite);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      this.sprite.setFrameIndex(this.currentFrame);
      this.currentFrame += param1 * this.framesPerMs;
      this.positionProvider.updateObjectPosition(this.sprite,param2,param1);
      if(this.loopsCount > 0 && this.currentFrame >= this.sprite.getNumFrames()) {
        --this.loopsCount;
        if(this.loopsCount == 0) {
          return false;
        }
        this.currentFrame -= this.sprite.getNumFrames();
      }
      return true;
    }

    public function destroy() : void {
      this.container.removeChild(this.sprite);
      this.container = null;
      this.sprite.clear();
      this.positionProvider.destroy();
      this.positionProvider = null;
      recycle();
    }

    public function kill() : void {
      this.loopsCount = 1;
      this.currentFrame = this.sprite.getNumFrames();
    }

    private function initSprite(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:ColorTransform, param7:TextureAnimation, param8:Number, param9:String) : void {
      this.sprite.width = param1;
      this.sprite.height = param2;
      this.sprite.rotation = param3;
      this.sprite.originX = param4;
      this.sprite.originY = param5;
      this.sprite.blendMode = param9;
      this.sprite.colorTransform = param6;
      this.sprite.softAttenuation = param8;
      this.sprite.setAnimationData(param7);
    }
  }
}
