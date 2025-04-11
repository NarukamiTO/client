package alternativa.tanks.materials {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureResourcesRegistry;
  import alternativa.gfx.core.IndexBufferResource;
  import alternativa.gfx.core.ProgramResource;
  import alternativa.gfx.core.VertexBufferResource;
  import flash.display.BitmapData;
  import flash.utils.ByteArray;
  import flash.utils.Dictionary;
  import flash.utils.getTimer;

  use namespace alternativa3d;

  public class AnimatedPaintMaterial extends PaintMaterial {
    private var programs:Dictionary = new Dictionary();
    private var lastFrame:int = -1;
    private var fps:int;
    private var numFrames:int;
    private var numFramesX:int;
    private var numFramesY:int;
    private var currentFrame:Number;

    public var scaleX:Number;
    public var scaleY:Number;

    private var time:int;
    private var frameWidth:Number;
    private var frameHeight:Number;

    public function AnimatedPaintMaterial(param1:BitmapData, param2:BitmapData, param3:BitmapData, param4:int, param5:int, param6:int, param7:int, param8:int = 0) {
      super(param1,param2,param3,param8);
      this.numFramesX = param4;
      this.numFramesY = param5;
      this.fps = param6;
      this.numFrames = param7;
      this.currentFrame = 0;
      this.scaleX = param3.width / param1.width;
      this.scaleY = param3.height / param1.height;
      this.frameWidth = 1 / param4;
      this.frameHeight = 1 / param5;
      fragConst = Vector.<Number>([0,0.5,1,2,this.frameWidth,this.frameHeight,0,0]);
    }

    public function update() : void {
      var local1:int = getTimer();
      var local2:int = local1 - this.time;
      this.time = local1;
      this.currentFrame += local2 / 1000 * this.fps;
      this.currentFrame %= this.numFrames;
      if(this.lastFrame == this.currentFrame) {
        return;
      }
      var local3:int = this.currentFrame % this.numFramesX;
      var local4:int = this.currentFrame / this.numFramesY;
      this.lastFrame = this.currentFrame;
      uvTransformConst[0] = this.scaleX;
      uvTransformConst[1] = 0;
      uvTransformConst[2] = local3 * this.frameWidth;
      uvTransformConst[3] = 0;
      uvTransformConst[4] = 0;
      uvTransformConst[5] = this.scaleY;
      uvTransformConst[6] = local4 * this.frameHeight;
      uvTransformConst[7] = 0;
      fragConst[6] = uvTransformConst[2];
      fragConst[7] = uvTransformConst[6];
    }

    override public function set mipMapping(param1:int) : void {
      alternativa3d::_mipMapping = 0;
      alternativa3d::textureResource = TextureResourcesRegistry.getTextureResource(bitmap,param1,repeat,alternativa3d::_hardwareMipMaps);
      spriteSheetResource = TextureResourcesRegistry.getTextureResource(spriteSheetBitmap,false,true,false);
      lightMapResource = TextureResourcesRegistry.getTextureResource(lightMapBitmap,param1,true,false);
    }

    override alternativa3d function drawOpaque(param1:Camera3D, param2:VertexBufferResource, param3:IndexBufferResource, param4:int, param5:int, param6:Object3D) : void {
      this.update();
      super.alternativa3d::drawOpaque(param1,param2,param3,param4,param5,param6);
    }

    override alternativa3d function drawTransparent(param1:Camera3D, param2:VertexBufferResource, param3:IndexBufferResource, param4:int, param5:int, param6:Object3D, param7:Boolean = false) : void {
      super.alternativa3d::drawTransparent(param1,param2,param3,param4,param5,param6,param7);
    }

    override protected function getProgram(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:Boolean, param12:Boolean, param13:Boolean, param14:Boolean, param15:Boolean, param16:Boolean, param17:Boolean, param18:Boolean, param19:Boolean, param20:Boolean, param21:Boolean, param22:Boolean) : ProgramResource {
      var local25:ByteArray = null;
      var local26:ByteArray = null;
      var local23:int = int(param1) | int(param2) << 1 | int(param3) << 2 | int(param4) << 3 | int(param5) << 4 | int(param6) << 5 | int(param7) << 6 | int(param8) << 7 | int(param9) << 8 | int(param10) << 9 | int(param11) << 10 | int(param12) << 11 | int(param13) << 12 | int(param14) << 13 | int(param15) << 14 | int(param16) << 15 | int(param17) << 16 | int(param18) << 17 | int(param19) << 18 | int(param20) << 19 | int(param21) << 20 | int(param22) << 21;
      var local24:ProgramResource = this.programs[local23];
      if(local24 == null) {
        local25 = new PaintVertexShader(!param22,param14 || param11 || param12 || param17,param13,param4,param14,param10,param2,param3,param3,param19).agalcode;
        local26 = new AnimatedPaintFragmentShader(param6,param5,param7,param15,param21,!param1 && !param16 && !param15,param8,param9,param3,param13,param11,param12,param17,param18,param14,param10,param2,param20).agalcode;
        local24 = new ProgramResource(local25,local26);
        this.programs[local23] = local24;
      }
      return local24;
    }
  }
}
