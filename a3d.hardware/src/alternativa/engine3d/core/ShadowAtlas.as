package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import alternativa.gfx.core.Device;
  import alternativa.gfx.core.IndexBufferResource;
  import alternativa.gfx.core.ProgramResource;
  import alternativa.gfx.core.RenderTargetTextureResource;
  import alternativa.gfx.core.VertexBufferResource;
  import flash.display3D.Context3DProgramType;
  import flash.display3D.Context3DVertexBufferFormat;
  import flash.utils.ByteArray;

  use namespace alternativa3d;

  public class ShadowAtlas {
    alternativa3d static const sizeLimit:int = 1024;

    private static var blurPrograms:Array = new Array();
    private static var blurVertexBuffer:VertexBufferResource = new VertexBufferResource(Vector.<Number>([-1,1,0,0,0,-1,-1,0,0,1,1,-1,0,1,1,1,1,0,1,0]),5);
    private static var blurIndexBuffer:IndexBufferResource = new IndexBufferResource(Vector.<uint>([0,1,3,2,3,1]));
    private static var blurConst:Vector.<Number> = Vector.<Number>([0,0,0,1,0,0,0,1]);

    alternativa3d var shadows:Vector.<Shadow> = new Vector.<Shadow>();
    alternativa3d var shadowsCount:int = 0;

    private var mapSize:int;
    private var blur:int;
    private var maps:Array = new Array();
    private var map1:RenderTargetTextureResource;
    private var map2:RenderTargetTextureResource;

    public function ShadowAtlas(param1:int, param2:int) {
      super();
      this.mapSize = param1;
      this.blur = param2;
    }

    alternativa3d function renderCasters(param1:Camera3D) : void {
      var local9:Shadow = null;
      var local2:Device = param1.alternativa3d::device;
      var local3:int = alternativa3d::sizeLimit / this.mapSize;
      var local4:int = Math.ceil(this.alternativa3d::shadowsCount / local3);
      var local5:int = this.alternativa3d::shadowsCount > local3 ? local3 : this.alternativa3d::shadowsCount;
      local4 = 1 << Math.ceil(Math.log(local4) / Math.LN2);
      local5 = 1 << Math.ceil(Math.log(local5) / Math.LN2);
      if(local4 > local3) {
        local4 = local3;
        this.alternativa3d::shadowsCount = local4 * local5;
      }
      var local6:int = local4 << 8 | local5;
      this.map1 = this.maps[local6];
      var local7:int = 1 << 16 | local6;
      this.map2 = this.maps[local7];
      if(this.map1 == null) {
        this.map1 = new RenderTargetTextureResource(local5 * this.mapSize,local4 * this.mapSize);
        this.map2 = new RenderTargetTextureResource(local5 * this.mapSize,local4 * this.mapSize);
        this.maps[local6] = this.map1;
        this.maps[local7] = this.map2;
      }
      local2.setRenderToTexture(this.map1,true);
      local2.clear(0,0,0,0,0);
      var local8:int = 0;
      while(local8 < this.alternativa3d::shadowsCount) {
        local9 = this.alternativa3d::shadows[local8];
        local9.alternativa3d::texture = this.map1;
        local9.alternativa3d::textureScaleU = 1 / local5;
        local9.alternativa3d::textureScaleV = 1 / local4;
        local9.alternativa3d::textureOffsetU = local8 % local5 / local5;
        local9.alternativa3d::textureOffsetV = int(local8 / local5) / local4;
        local9.alternativa3d::renderCasters(param1);
        local8++;
      }
    }

    alternativa3d function renderBlur(param1:Camera3D) : void {
      var local2:Device = param1.alternativa3d::device;
      if(this.blur > 0) {
        local2.setVertexBufferAt(0,blurVertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
        local2.setVertexBufferAt(1,blurVertexBuffer,3,Context3DVertexBufferFormat.FLOAT_2);
        blurConst[0] = 1 / this.map1.width;
        blurConst[1] = 1 / this.map1.height;
        blurConst[3] = 1 + this.blur + this.blur;
        blurConst[4] = this.blur / this.map1.width;
        blurConst[5] = this.blur / this.map1.height;
        local2.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,blurConst,2);
        local2.setRenderToTexture(this.map2,false);
        local2.clear(0,0,0,0);
        local2.setProgram(this.getBlurProgram(1,this.blur));
        local2.setTextureAt(0,this.map1);
        local2.drawTriangles(blurIndexBuffer,0,2);
        local2.setRenderToTexture(this.map1,false);
        local2.clear(0,0,0,0);
        local2.setProgram(this.getBlurProgram(2,this.blur));
        local2.setTextureAt(0,this.map2);
        local2.drawTriangles(blurIndexBuffer,0,2);
      }
    }

    alternativa3d function clear() : void {
      var local2:Shadow = null;
      var local1:int = 0;
      while(local1 < this.alternativa3d::shadowsCount) {
        local2 = this.alternativa3d::shadows[local1];
        local2.alternativa3d::texture = null;
        local1++;
      }
      this.alternativa3d::shadows.length = 0;
      this.alternativa3d::shadowsCount = 0;
    }

    private function getBlurProgram(param1:int, param2:int) : ProgramResource {
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local3:int = (param1 << 16) + param2;
      var local4:ProgramResource = blurPrograms[local3];
      if(local4 == null) {
        local5 = new ShadowAtlasVertexShader().agalcode;
        local6 = new ShadowAtlasFragmentShader(param2,param1 == 1).agalcode;
        local4 = new ProgramResource(local5,local6);
        blurPrograms[local3] = local4;
      }
      return local4;
    }
  }
}
