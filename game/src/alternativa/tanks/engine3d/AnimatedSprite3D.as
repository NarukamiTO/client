package alternativa.tanks.engine3d {
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Sprite3D;

  public class AnimatedSprite3D extends Sprite3D {
    public var looped:Boolean;

    private var uvFrames:Vector.<UVFrame>;
    private var numFrames:int;
    private var fps:Number;
    private var currentFrame:Number = 0;

    public function AnimatedSprite3D(param1:Number, param2:Number, param3:Material = null) {
      super(param1,param2,param3);
      useShadowMap = false;
      useLight = false;
    }

    public function setAnimationData(param1:TextureAnimation) : void {
      material = param1.material;
      this.uvFrames = param1.frames;
      this.fps = param1.fps;
      this.numFrames = this.uvFrames.length;
      this.currentFrame = 0;
      this.setFrameIndex(this.currentFrame);
    }

    public function getFps() : Number {
      return this.fps;
    }

    public function getNumFrames() : int {
      return this.numFrames;
    }

    public function clear() : void {
      this.uvFrames = null;
      material = null;
      this.numFrames = 0;
    }

    public function setFrameIndex(param1:int) : void {
      var local2:int = param1 % this.numFrames;
      this.setFrame(this.uvFrames[local2]);
    }

    private function setFrame(param1:UVFrame) : void {
      topLeftU = param1.topLeftU;
      topLeftV = param1.topLeftV;
      bottomRightU = param1.bottomRightU;
      bottomRightV = param1.bottomRightV;
    }

    public function update(param1:Number) : void {
      this.currentFrame += this.fps * param1;
      if(this.currentFrame >= this.numFrames) {
        if(this.looped) {
          this.currentFrame %= this.numFrames;
        } else {
          this.currentFrame = this.numFrames - 1;
        }
      }
      this.setFrame(this.uvFrames[int(this.currentFrame)]);
    }
  }
}
