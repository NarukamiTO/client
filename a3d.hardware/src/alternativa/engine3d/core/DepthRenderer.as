package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.engine3d.lights.SpotLight;
  import alternativa.engine3d.lights.TubeLight;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.gfx.core.BitmapTextureResource;
  import alternativa.gfx.core.Device;
  import alternativa.gfx.core.IndexBufferResource;
  import alternativa.gfx.core.ProgramResource;
  import alternativa.gfx.core.RenderTargetTextureResource;
  import alternativa.gfx.core.VertexBufferResource;
  import flash.display.BitmapData;
  import flash.display3D.Context3DBlendFactor;
  import flash.display3D.Context3DProgramType;
  import flash.display3D.Context3DVertexBufferFormat;
  import flash.geom.Rectangle;
  import flash.utils.ByteArray;

  use namespace alternativa3d;

  public class DepthRenderer {
    private static const limit2const:int = 62;
    private static const limit5const:int = 24;

    private var depthPrograms:Array;
    private var correction:Vector.<Number>;
    private var depthFragment:Vector.<Number>;
    private var alphaTestConst:Vector.<Number>;
    private var ssaoProgram:ProgramResource;
    private var ssaoVertexBuffer:VertexBufferResource;
    private var ssaoIndexBuffer:IndexBufferResource;
    private var ssaoVertex:Vector.<Number>;
    private var ssaoFragment:Vector.<Number>;
    private var blurProgram:ProgramResource;
    private var blurFragment:Vector.<Number>;
    private var omniProgram:ProgramResource;
    private var spotProgram:ProgramResource;
    private var tubeProgram:ProgramResource;
    private var lightConst:Vector.<Number>;
    private var lightVertexBuffer:VertexBufferResource;
    private var lightIndexBuffer:IndexBufferResource;

    alternativa3d var depthBuffer:RenderTargetTextureResource;
    alternativa3d var lightBuffer:RenderTargetTextureResource;

    private var temporaryBuffer:RenderTargetTextureResource;
    private var scissor:Rectangle;
    private var table:BitmapTextureResource;
    private var noise:BitmapTextureResource;
    private var bias:Number = 0.1;
    private var tableSize:int = 128;
    private var noiseSize:int = 4;
    private var blurSamples:int = 16;
    private var intensity:Number = 2.5;
    private var noiseRandom:Number = 0.2;
    private var samples:int = 6;
    private var noiseAngle:Number;

    alternativa3d var correctionX:Number;
    alternativa3d var correctionY:Number;

    public function DepthRenderer() {
      var local1:int = 0;
      var local2:int = 0;
      var local11:int = 0;
      var local12:int = 0;
      var local13:int = 0;
      var local14:int = 0;
      var local15:int = 0;
      var local16:int = 0;
      var local17:int = 0;
      var local18:int = 0;
      var local19:int = 0;
      var local20:int = 0;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:int = 0;
      var local26:int = 0;
      var local27:int = 0;
      this.depthPrograms = new Array();
      this.correction = Vector.<Number>([0,0,0,1,0,0,0,1,0,0,0,0.5]);
      this.depthFragment = Vector.<Number>([1 / 255,0,0,1,0.5,0.5,0,1]);
      this.alphaTestConst = Vector.<Number>([0,0,0,1]);
      this.ssaoVertexBuffer = new VertexBufferResource(Vector.<Number>([-1,1,0,0,0,-1,-1,0,0,1,1,-1,0,1,1,1,1,0,1,0]),5);
      this.ssaoIndexBuffer = new IndexBufferResource(Vector.<uint>([0,1,3,2,3,1]));
      this.ssaoVertex = Vector.<Number>([0,0,0,1,0,0,0,1,1,1,0,1]);
      this.ssaoFragment = Vector.<Number>([0,0,0,Math.PI * 2,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,0,0,0,0,1,0,0,Math.PI * 2,Math.PI * 2]);
      this.blurFragment = Vector.<Number>([0,0,0,1,0,0,0,1]);
      this.lightConst = new Vector.<Number>();
      this.scissor = new Rectangle();
      this.noiseAngle = Math.PI * 2 / this.samples;
      super();
      var local3:int = 0;
      var local4:int = 0;
      var local5:Vector.<Number> = new Vector.<Number>();
      var local6:Vector.<uint> = new Vector.<uint>();
      local1 = 0;
      while(local1 < limit2const) {
        local11 = 4 + local1 * 2;
        local12 = 4 + local1 * 5;
        local13 = local1 * 8;
        local5[local3] = -1;
        local3++;
        local5[local3] = 1;
        local3++;
        local5[local3] = -1;
        local3++;
        local5[local3] = local11;
        local3++;
        local5[local3] = local12;
        local3++;
        local14 = local13 + 1;
        local5[local3] = 1;
        local3++;
        local5[local3] = 1;
        local3++;
        local5[local3] = -1;
        local3++;
        local5[local3] = local11;
        local3++;
        local5[local3] = local12;
        local3++;
        local15 = local14 + 1;
        local5[local3] = 1;
        local3++;
        local5[local3] = 1;
        local3++;
        local5[local3] = 1;
        local3++;
        local5[local3] = local11;
        local3++;
        local5[local3] = local12;
        local3++;
        local16 = local15 + 1;
        local5[local3] = -1;
        local3++;
        local5[local3] = 1;
        local3++;
        local5[local3] = 1;
        local3++;
        local5[local3] = local11;
        local3++;
        local5[local3] = local12;
        local3++;
        local17 = local16 + 1;
        local5[local3] = -1;
        local3++;
        local5[local3] = -1;
        local3++;
        local5[local3] = -1;
        local3++;
        local5[local3] = local11;
        local3++;
        local5[local3] = local12;
        local3++;
        local18 = local17 + 1;
        local5[local3] = 1;
        local3++;
        local5[local3] = -1;
        local3++;
        local5[local3] = -1;
        local3++;
        local5[local3] = local11;
        local3++;
        local5[local3] = local12;
        local3++;
        local19 = local18 + 1;
        local5[local3] = 1;
        local3++;
        local5[local3] = -1;
        local3++;
        local5[local3] = 1;
        local3++;
        local5[local3] = local11;
        local3++;
        local5[local3] = local12;
        local3++;
        local20 = local19 + 1;
        local5[local3] = -1;
        local3++;
        local5[local3] = -1;
        local3++;
        local5[local3] = 1;
        local3++;
        local5[local3] = local11;
        local3++;
        local5[local3] = local12;
        local3++;
        local6[local4] = local13;
        local4++;
        local6[local4] = local17;
        local4++;
        local6[local4] = local14;
        local4++;
        local6[local4] = local14;
        local4++;
        local6[local4] = local17;
        local4++;
        local6[local4] = local18;
        local4++;
        local6[local4] = local14;
        local4++;
        local6[local4] = local18;
        local4++;
        local6[local4] = local19;
        local4++;
        local6[local4] = local14;
        local4++;
        local6[local4] = local19;
        local4++;
        local6[local4] = local15;
        local4++;
        local6[local4] = local17;
        local4++;
        local6[local4] = local19;
        local4++;
        local6[local4] = local18;
        local4++;
        local6[local4] = local17;
        local4++;
        local6[local4] = local20;
        local4++;
        local6[local4] = local19;
        local4++;
        local6[local4] = local15;
        local4++;
        local6[local4] = local19;
        local4++;
        local6[local4] = local20;
        local4++;
        local6[local4] = local15;
        local4++;
        local6[local4] = local20;
        local4++;
        local6[local4] = local16;
        local4++;
        local6[local4] = local13;
        local4++;
        local6[local4] = local16;
        local4++;
        local6[local4] = local20;
        local4++;
        local6[local4] = local13;
        local4++;
        local6[local4] = local20;
        local4++;
        local6[local4] = local17;
        local4++;
        local6[local4] = local13;
        local4++;
        local6[local4] = local14;
        local4++;
        local6[local4] = local15;
        local4++;
        local6[local4] = local13;
        local4++;
        local6[local4] = local15;
        local4++;
        local6[local4] = local16;
        local4++;
        local1++;
      }
      this.lightVertexBuffer = new VertexBufferResource(local5,5);
      this.lightIndexBuffer = new IndexBufferResource(local6);
      var local7:Vector.<uint> = new Vector.<uint>();
      var local8:int = 0;
      var local9:Number = Math.PI * 2;
      var local10:int = this.tableSize - 1;
      local1 = 0;
      while(local1 < this.tableSize) {
        local21 = (local1 / local10 - 0.5) * 2;
        local2 = 0;
        while(local2 < this.tableSize) {
          local22 = (local2 / local10 - 0.5) * 2;
          local23 = Math.atan2(local21,local22);
          if(local23 < 0) {
            local23 += local9;
          }
          local7[local8] = Math.round(255 * local23 / local9);
          local8++;
          local2++;
        }
        local1++;
      }
      this.table = new BitmapTextureResource(new BitmapData(this.tableSize,this.tableSize,false,0),false);
      this.table.bitmapData.setVector(this.table.bitmapData.rect,local7);
      local7 = new Vector.<uint>();
      local8 = 0;
      local1 = 0;
      while(local1 < this.noiseSize) {
        local2 = 0;
        while(local2 < this.noiseSize) {
          local24 = Math.random() * this.noiseAngle;
          local25 = Math.sin(local24) * 255;
          local26 = Math.cos(local24) * 255;
          local27 = (this.noiseRandom + Math.random() * (1 - this.noiseRandom)) * 255;
          local7[local8] = local25 << 16 | local26 << 8 | local27;
          local8++;
          local2++;
        }
        local1++;
      }
      this.noise = new BitmapTextureResource(new BitmapData(this.noiseSize,this.noiseSize,false,0),false);
      this.noise.bitmapData.setVector(this.noise.bitmapData.rect,local7);
      this.alternativa3d::depthBuffer = new RenderTargetTextureResource(1,1);
      this.temporaryBuffer = new RenderTargetTextureResource(1,1);
      this.alternativa3d::lightBuffer = new RenderTargetTextureResource(1,1);
    }

    alternativa3d function render(param1:Camera3D, param2:Number, param3:Number, param4:Number, param5:Boolean, param6:Boolean, param7:Number, param8:Vector.<Object3D>, param9:int) : void {
      var local10:int = 0;
      var local14:Object3D = null;
      var local15:VertexBufferResource = null;
      var local16:IndexBufferResource = null;
      var local17:int = 0;
      var local18:TextureMaterial = null;
      var local19:Mesh = null;
      var local20:BSP = null;
      var local21:int = 0;
      var local22:int = 0;
      var local23:OmniLight = null;
      var local24:SpotLight = null;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:TubeLight = null;
      var local11:Device = param1.alternativa3d::device;
      if(param2 > 2048) {
        param2 = 2048;
      }
      if(param3 > 2048) {
        param3 = 2048;
      }
      if(param4 > 1) {
        param4 = 1;
      }
      param2 = Math.round(param2 * param4);
      param3 = Math.round(param3 * param4);
      if(param2 < 1) {
        param2 = 1;
      }
      if(param3 < 1) {
        param3 = 1;
      }
      this.scissor.width = param2;
      this.scissor.height = param3;
      var local12:int = 1 << Math.ceil(Math.log(param2) / Math.LN2);
      var local13:int = 1 << Math.ceil(Math.log(param3) / Math.LN2);
      if(local12 != this.alternativa3d::depthBuffer.width || local13 != this.alternativa3d::depthBuffer.height) {
        this.alternativa3d::depthBuffer.dispose();
        this.alternativa3d::depthBuffer = new RenderTargetTextureResource(local12,local13);
        this.temporaryBuffer.dispose();
        this.temporaryBuffer = new RenderTargetTextureResource(local12,local13);
        this.alternativa3d::lightBuffer.dispose();
        this.alternativa3d::lightBuffer = new RenderTargetTextureResource(local12,local13);
      }
      if(!param5) {
        this.noise.reset();
        this.temporaryBuffer.reset();
        this.ssaoVertexBuffer.reset();
        this.ssaoIndexBuffer.reset();
      }
      if(!param6) {
        this.alternativa3d::lightBuffer.reset();
        this.lightVertexBuffer.reset();
        this.lightIndexBuffer.reset();
      }
      if(!param5 && !param6) {
        this.table.reset();
      }
      this.alternativa3d::correctionX = param2 / this.alternativa3d::depthBuffer.width;
      this.alternativa3d::correctionY = param3 / this.alternativa3d::depthBuffer.height;
      local11.setRenderToTexture(this.alternativa3d::depthBuffer,true);
      local11.clear(1,0,0.25,1);
      local11.setScissorRectangle(this.scissor);
      this.correction[0] = this.alternativa3d::correctionX;
      this.correction[1] = this.alternativa3d::correctionY;
      this.correction[2] = 255 / param1.farClipping;
      this.correction[4] = 1 - this.alternativa3d::correctionX;
      this.correction[5] = 1 - this.alternativa3d::correctionY;
      this.correction[8] = param1.alternativa3d::correctionX;
      this.correction[9] = param1.alternativa3d::correctionY;
      local11.setProgramConstantsFromVector(Context3DProgramType.VERTEX,3,param1.alternativa3d::projection,1,false);
      local11.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,this.correction,3,false);
      if(param5 || param6) {
        local11.setTextureAt(0,this.table);
      }
      local10 = 0;
      while(local10 < param9) {
        local14 = param8[local10];
        if(local14 is Mesh) {
          local19 = Mesh(local14);
          local15 = local19.alternativa3d::vertexBuffer;
          local16 = local19.alternativa3d::indexBuffer;
          local17 = int(local19.alternativa3d::numTriangles);
          local18 = local19.alternativa3d::faceList.material as TextureMaterial;
        } else if(local14 is BSP) {
          local20 = BSP(local14);
          local15 = local20.alternativa3d::vertexBuffer;
          local16 = local20.alternativa3d::indexBuffer;
          local17 = int(local20.alternativa3d::numTriangles);
          local18 = local20.alternativa3d::faces[0].material as TextureMaterial;
        }
        if(local18 != null && local18.alphaTestThreshold > 0 && Boolean(local18.alternativa3d::transparent)) {
          local11.setProgram(this.getDepthProgram(param5 || param6,true,param1.view.alternativa3d::quality,local18.repeat,local18.alternativa3d::_mipMapping > 0,false,false));
          local11.setVertexBufferAt(2,local15,3,Context3DVertexBufferFormat.FLOAT_2);
          local11.setTextureAt(1,local18.alternativa3d::textureResource);
          this.alphaTestConst[0] = local18.alternativa3d::textureResource.correctionU;
          this.alphaTestConst[1] = local18.alternativa3d::textureResource.correctionV;
          this.alphaTestConst[3] = local18.alphaTestThreshold;
          local11.setProgramConstantsFromVector(Context3DProgramType.VERTEX,7,this.alphaTestConst,1);
        } else {
          local11.setProgram(this.getDepthProgram(param5 || param6,false));
        }
        local11.setVertexBufferAt(0,local15,0,Context3DVertexBufferFormat.FLOAT_3);
        local11.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,local14.alternativa3d::transformConst,3,false);
        local11.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,this.depthFragment,2);
        if(param5 || param6) {
          local11.setVertexBufferAt(1,local15,5,Context3DVertexBufferFormat.FLOAT_3);
        }
        local11.drawTriangles(local16,0,local17);
        local11.setTextureAt(1,null);
        local11.setVertexBufferAt(2,null);
        local10++;
      }
      if(param6) {
        local11.setRenderToTexture(this.alternativa3d::lightBuffer,false);
        local11.clear(param7,param7,param7,0);
        local11.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ONE);
        local11.setTextureAt(0,this.alternativa3d::depthBuffer);
        local11.setVertexBufferAt(0,this.lightVertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
        local11.setVertexBufferAt(1,this.lightVertexBuffer,3,Context3DVertexBufferFormat.FLOAT_2);
        local11.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,param1.alternativa3d::projection,1,false);
        local11.setProgramConstantsFromVector(Context3DProgramType.VERTEX,1,this.correction,3,false);
        this.ssaoFragment[0] = param1.farClipping;
        this.ssaoFragment[1] = param1.farClipping / 255;
        this.ssaoFragment[4] = 2 / this.alternativa3d::correctionX;
        this.ssaoFragment[5] = 2 / this.alternativa3d::correctionY;
        this.ssaoFragment[6] = 0;
        this.ssaoFragment[8] = 1;
        this.ssaoFragment[9] = 1;
        this.ssaoFragment[10] = 0.5;
        this.ssaoFragment[12] = param1.alternativa3d::correctionX;
        this.ssaoFragment[13] = param1.alternativa3d::correctionY;
        this.ssaoFragment[16] = 0.5;
        this.ssaoFragment[17] = 0.5;
        local11.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,this.ssaoFragment,7,false);
        local11.setProgram(this.getOmniProgram());
        local21 = 0;
        local22 = 0;
        local10 = 0;
        while(local10 < param1.alternativa3d::omniesCount) {
          local23 = param1.alternativa3d::omnies[local10];
          this.lightConst[local21] = local23.alternativa3d::cmd * param1.alternativa3d::correctionX;
          local21++;
          this.lightConst[local21] = local23.alternativa3d::cmh * param1.alternativa3d::correctionY;
          local21++;
          this.lightConst[local21] = local23.alternativa3d::cml;
          local21++;
          this.lightConst[local21] = local23.attenuationEnd;
          local21++;
          this.lightConst[local21] = local23.intensity * param1.deferredLightingStrength * (local23.color >> 16 & 0xFF) / 255;
          local21++;
          this.lightConst[local21] = local23.intensity * param1.deferredLightingStrength * (local23.color >> 8 & 0xFF) / 255;
          local21++;
          this.lightConst[local21] = local23.intensity * param1.deferredLightingStrength * (local23.color & 0xFF) / 255;
          local21++;
          this.lightConst[local21] = 1 / (local23.attenuationEnd - local23.attenuationBegin);
          local21++;
          local22++;
          if(local22 == limit2const || local10 == param1.alternativa3d::omniesCount - 1) {
            local11.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,this.lightConst,local22 * 2,false);
            local11.drawTriangles(this.lightIndexBuffer,0,local22 * 6 * 2);
            local22 = 0;
            local21 = 0;
          }
          local10++;
        }
        local11.setProgram(this.getSpotProgram());
        local21 = 0;
        local22 = 0;
        local10 = 0;
        while(local10 < param1.alternativa3d::spotsCount) {
          local24 = param1.alternativa3d::spots[local10];
          local25 = Math.cos(local24.hotspot * 0.5);
          local26 = Math.cos(local24.falloff * 0.5);
          this.lightConst[local21] = local24.alternativa3d::cma;
          local21++;
          this.lightConst[local21] = local24.alternativa3d::cmb;
          local21++;
          this.lightConst[local21] = local24.alternativa3d::cmc;
          local21++;
          this.lightConst[local21] = local24.alternativa3d::cmd;
          local21++;
          this.lightConst[local21] = local24.alternativa3d::cme;
          local21++;
          this.lightConst[local21] = local24.alternativa3d::cmf;
          local21++;
          this.lightConst[local21] = local24.alternativa3d::cmg;
          local21++;
          this.lightConst[local21] = local24.alternativa3d::cmh;
          local21++;
          this.lightConst[local21] = local24.alternativa3d::cmi;
          local21++;
          this.lightConst[local21] = local24.alternativa3d::cmj;
          local21++;
          this.lightConst[local21] = local24.alternativa3d::cmk;
          local21++;
          this.lightConst[local21] = local24.alternativa3d::cml;
          local21++;
          this.lightConst[local21] = local24.attenuationEnd;
          local21++;
          this.lightConst[local21] = 1 / (local24.attenuationEnd - local24.attenuationBegin);
          local21++;
          this.lightConst[local21] = local26;
          local21++;
          this.lightConst[local21] = 1 / (local25 - local26);
          local21++;
          this.lightConst[local21] = local24.intensity * param1.deferredLightingStrength * (local24.color >> 16 & 0xFF) / 255;
          local21++;
          this.lightConst[local21] = local24.intensity * param1.deferredLightingStrength * (local24.color >> 8 & 0xFF) / 255;
          local21++;
          this.lightConst[local21] = local24.intensity * param1.deferredLightingStrength * (local24.color & 0xFF) / 255;
          local21++;
          this.lightConst[local21] = Math.sin(local24.falloff * 0.5) * local24.attenuationEnd;
          local21++;
          local22++;
          if(local22 == limit5const || local10 == param1.alternativa3d::spotsCount - 1) {
            local11.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,this.lightConst,local22 * 5,false);
            local11.drawTriangles(this.lightIndexBuffer,0,local22 * 6 * 2);
            local22 = 0;
            local21 = 0;
          }
          local10++;
        }
        local11.setProgram(this.getTubeProgram());
        local21 = 0;
        local22 = 0;
        local10 = 0;
        while(local10 < param1.alternativa3d::tubesCount) {
          local27 = param1.alternativa3d::tubes[local10];
          this.lightConst[local21] = local27.alternativa3d::cma;
          local21++;
          this.lightConst[local21] = local27.alternativa3d::cmb;
          local21++;
          this.lightConst[local21] = local27.alternativa3d::cmc;
          local21++;
          this.lightConst[local21] = local27.alternativa3d::cmd;
          local21++;
          this.lightConst[local21] = local27.alternativa3d::cme;
          local21++;
          this.lightConst[local21] = local27.alternativa3d::cmf;
          local21++;
          this.lightConst[local21] = local27.alternativa3d::cmg;
          local21++;
          this.lightConst[local21] = local27.alternativa3d::cmh;
          local21++;
          this.lightConst[local21] = local27.alternativa3d::cmi;
          local21++;
          this.lightConst[local21] = local27.alternativa3d::cmj;
          local21++;
          this.lightConst[local21] = local27.alternativa3d::cmk;
          local21++;
          this.lightConst[local21] = local27.alternativa3d::cml;
          local21++;
          this.lightConst[local21] = local27.attenuationEnd;
          local21++;
          this.lightConst[local21] = 1 / (local27.attenuationEnd - local27.attenuationBegin);
          local21++;
          this.lightConst[local21] = local27.length * 0.5 + local27.falloff;
          local21++;
          this.lightConst[local21] = 1 / local27.falloff;
          local21++;
          this.lightConst[local21] = local27.intensity * param1.deferredLightingStrength * (local27.color >> 16 & 0xFF) / 255;
          local21++;
          this.lightConst[local21] = local27.intensity * param1.deferredLightingStrength * (local27.color >> 8 & 0xFF) / 255;
          local21++;
          this.lightConst[local21] = local27.intensity * param1.deferredLightingStrength * (local27.color & 0xFF) / 255;
          local21++;
          this.lightConst[local21] = local27.length * 0.5;
          local21++;
          local22++;
          if(local22 == limit5const || local10 == param1.alternativa3d::tubesCount - 1) {
            local11.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,this.lightConst,local22 * 5,false);
            local11.drawTriangles(this.lightIndexBuffer,0,local22 * 6 * 2);
            local22 = 0;
            local21 = 0;
          }
          local10++;
        }
        local11.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ZERO);
      }
      if(param5) {
        local11.setRenderToTexture(this.temporaryBuffer,false);
        local11.clear(0,0,0,0);
        local11.setProgram(this.getSSAOProgram());
        local11.setTextureAt(0,this.alternativa3d::depthBuffer);
        local11.setTextureAt(1,this.noise);
        local11.setVertexBufferAt(0,this.ssaoVertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
        local11.setVertexBufferAt(1,this.ssaoVertexBuffer,3,Context3DVertexBufferFormat.FLOAT_2);
        this.ssaoVertex[0] = local12 / this.noiseSize;
        this.ssaoVertex[1] = local13 / this.noiseSize;
        this.ssaoVertex[4] = 2 / this.alternativa3d::correctionX;
        this.ssaoVertex[5] = 2 / this.alternativa3d::correctionY;
        local11.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,this.ssaoVertex,3,false);
        this.ssaoFragment[0] = param1.farClipping;
        this.ssaoFragment[1] = param1.farClipping / 255;
        this.ssaoFragment[4] = 2 / this.alternativa3d::correctionX;
        this.ssaoFragment[5] = 2 / this.alternativa3d::correctionY;
        this.ssaoFragment[6] = param1.ssaoRadius;
        this.ssaoFragment[8] = 1;
        this.ssaoFragment[9] = 1;
        this.ssaoFragment[10] = this.bias;
        this.ssaoFragment[11] = this.intensity * 1 / this.samples;
        this.ssaoFragment[12] = param1.alternativa3d::correctionX;
        this.ssaoFragment[13] = param1.alternativa3d::correctionY;
        this.ssaoFragment[15] = 1 / param1.ssaoRange;
        this.ssaoFragment[16] = Math.cos(this.noiseAngle);
        this.ssaoFragment[17] = Math.sin(this.noiseAngle);
        this.ssaoFragment[20] = -Math.sin(this.noiseAngle);
        this.ssaoFragment[21] = Math.cos(this.noiseAngle);
        this.ssaoFragment[24] = this.alternativa3d::correctionX - 1 / local12;
        this.ssaoFragment[25] = this.alternativa3d::correctionY - 1 / local13;
        local11.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,this.ssaoFragment,7,false);
        local11.drawTriangles(this.ssaoIndexBuffer,0,2);
        local11.setTextureAt(1,null);
        local11.setRenderToTexture(this.alternativa3d::depthBuffer,false);
        local11.clear(0,0,0,0);
        local11.setProgram(this.getBlurProgram());
        local11.setTextureAt(0,this.temporaryBuffer);
        this.blurFragment[0] = 1 / local12;
        this.blurFragment[1] = 1 / local13;
        this.blurFragment[3] = 1 / this.blurSamples;
        this.blurFragment[4] = this.alternativa3d::correctionX - 1 / local12;
        this.blurFragment[5] = this.alternativa3d::correctionY - 1 / local13;
        local11.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,this.blurFragment,2,false);
        local11.drawTriangles(this.ssaoIndexBuffer,0,2);
      }
      local11.setVertexBufferAt(1,null);
      local11.setTextureAt(0,null);
      local11.setScissorRectangle(null);
    }

    alternativa3d function resetResources() : void {
      this.noise.reset();
      this.table.reset();
      this.alternativa3d::depthBuffer.reset();
      this.temporaryBuffer.reset();
      this.alternativa3d::lightBuffer.reset();
      this.ssaoVertexBuffer.reset();
      this.ssaoIndexBuffer.reset();
      this.lightVertexBuffer.reset();
      this.lightIndexBuffer.reset();
    }

    private function getDepthProgram(param1:Boolean, param2:Boolean, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false) : ProgramResource {
      var local10:ByteArray = null;
      var local11:ByteArray = null;
      var local8:int = int(param1) | int(param2) << 1 | int(param3) << 2 | int(param4) << 3 | int(param5) << 4 | int(param6) << 5 | int(param7) << 6;
      var local9:ProgramResource = this.depthPrograms[local8];
      if(local9 == null) {
        local10 = new DepthRendererDepthVertexShader(param1,param2).agalcode;
        local11 = new DepthRendererDepthFragmentShader(param1,param2,param3,param4,param5).agalcode;
        local9 = new ProgramResource(local10,local11);
        this.depthPrograms[local8] = local9;
      }
      return local9;
    }

    private function getSSAOProgram() : ProgramResource {
      var local2:ByteArray = null;
      var local3:ByteArray = null;
      var local1:ProgramResource = this.ssaoProgram;
      if(local1 == null) {
        local2 = new DepthRendererSSAOVertexShader().agalcode;
        local3 = new DepthRendererSSAOFragmentShader(this.samples).agalcode;
        local1 = new ProgramResource(local2,local3);
        this.ssaoProgram = local1;
      }
      return local1;
    }

    private function getBlurProgram() : ProgramResource {
      var local2:ByteArray = null;
      var local3:ByteArray = null;
      var local1:ProgramResource = this.blurProgram;
      if(local1 == null) {
        local2 = new DepthRendererBlurVertexShader().agalcode;
        local3 = new DepthRendererBlurFragmentShader().agalcode;
        local1 = new ProgramResource(local2,local3);
        this.blurProgram = local1;
      }
      return local1;
    }

    private function getOmniProgram() : ProgramResource {
      var local2:ByteArray = null;
      var local3:ByteArray = null;
      var local1:ProgramResource = this.omniProgram;
      if(local1 == null) {
        local2 = new DepthRendererLightVertexShader(0).agalcode;
        local3 = new DepthRendererLightFragmentShader(0).agalcode;
        local1 = new ProgramResource(local2,local3);
        this.omniProgram = local1;
      }
      return local1;
    }

    private function getSpotProgram() : ProgramResource {
      var local2:ByteArray = null;
      var local3:ByteArray = null;
      var local1:ProgramResource = this.spotProgram;
      if(local1 == null) {
        local2 = new DepthRendererLightVertexShader(1).agalcode;
        local3 = new DepthRendererLightFragmentShader(1).agalcode;
        local1 = new ProgramResource(local2,local3);
        this.spotProgram = local1;
      }
      return local1;
    }

    private function getTubeProgram() : ProgramResource {
      var local2:ByteArray = null;
      var local3:ByteArray = null;
      var local1:ProgramResource = this.tubeProgram;
      if(local1 == null) {
        local2 = new DepthRendererLightVertexShader(2).agalcode;
        local3 = new DepthRendererLightFragmentShader(2).agalcode;
        local1 = new ProgramResource(local2,local3);
        this.tubeProgram = local1;
      }
      return local1;
    }
  }
}
