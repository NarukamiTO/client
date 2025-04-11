package alternativa.tanks.models.weapon.streamweapon {
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.engine3d.UVFrame;
  import alternativa.tanks.sfx.SimplePlane;

  internal class StreamWeaponMuzzlePlane extends SimplePlane {
    private var uvFrames:Vector.<UVFrame>;
    private var numFrames:int;
    private var currFrame:Number;

    public function StreamWeaponMuzzlePlane() {
      super(1,1,0.5,0);
      shadowMapAlphaThreshold = 2;
      depthMapAlphaThreshold = 2;
      useShadowMap = false;
      useLight = false;
    }

    public function init(param1:TextureAnimation) : void {
      setMaterialToAllFaces(param1.material);
      this.uvFrames = param1.frames;
      this.numFrames = this.uvFrames.length;
      this.currFrame = 0;
      this.setFrame(this.uvFrames[0]);
    }

    public function clear() : void {
      setMaterialToAllFaces(null);
      this.uvFrames = null;
      this.numFrames = 0;
    }

    public function update(param1:Number, param2:Number) : void {
      this.currFrame += param1 * param2;
      if(this.currFrame >= this.numFrames) {
        this.currFrame = 0;
      }
      this.setFrame(this.uvFrames[int(this.currFrame)]);
    }

    private function setFrame(param1:UVFrame) : void {
      a.u = param1.topLeftU;
      a.v = param1.topLeftV;
      b.u = param1.topLeftU;
      b.v = param1.bottomRightV;
      c.u = param1.bottomRightU;
      c.v = param1.bottomRightV;
      d.u = param1.bottomRightU;
      d.v = param1.topLeftV;
    }
  }
}
