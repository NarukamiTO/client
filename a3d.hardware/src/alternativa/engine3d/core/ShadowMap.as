package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.lights.DirectionalLight;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.gfx.core.BitmapTextureResource;
  import alternativa.gfx.core.Device;
  import alternativa.gfx.core.IndexBufferResource;
  import alternativa.gfx.core.ProgramResource;
  import alternativa.gfx.core.RenderTargetTextureResource;
  import alternativa.gfx.core.VertexBufferResource;
  import flash.display.BitmapData;
  import flash.display3D.Context3DProgramType;
  import flash.display3D.Context3DVertexBufferFormat;
  import flash.geom.Rectangle;
  import flash.utils.ByteArray;

  use namespace alternativa3d;

  public class ShadowMap {
    private static const sizeLimit:int = 2048;
    private static const bigValue:Number = 2048;

    public static const numSamples:int = 6;

    private var programs:Array;
    private var spriteVertexBuffer:VertexBufferResource;
    private var spriteIndexBuffer:IndexBufferResource;

    alternativa3d var transform:Vector.<Number>;
    alternativa3d var params:Vector.<Number>;

    private var coords:Vector.<Number>;
    private var fragment:Vector.<Number>;
    private var alphaTestConst:Vector.<Number>;
    private var scissor:Rectangle;

    alternativa3d var map:RenderTargetTextureResource;
    alternativa3d var noise:BitmapTextureResource;

    private var noiseSize:int = 64;
    private var noiseAngle:Number = 1.0471975511965976;
    private var noiseRadius:Number = 1.3;
    private var noiseRandom:Number = 0.3;

    public var mapSize:int;
    public var nearDistance:Number;
    public var farDistance:Number;
    public var bias:Number = 0;
    public var biasMultiplier:Number = 30;
    public var additionalSpace:Number = 0;
    public var alphaThreshold:Number = 0.1;

    private var defaultLight:DirectionalLight;
    private var boundVertexList:Vertex;
    private var light:DirectionalLight;
    private var dirZ:Number;
    private var planeX:Number;
    private var planeY:Number;
    private var planeSize:Number;
    private var pixel:Number;

    alternativa3d var boundMinX:Number;
    alternativa3d var boundMinY:Number;
    alternativa3d var boundMinZ:Number;
    alternativa3d var boundMaxX:Number;
    alternativa3d var boundMaxY:Number;
    alternativa3d var boundMaxZ:Number;

    public function ShadowMap(param1:int, param2:Number, param3:Number, param4:Number = 0, param5:Number = 0) {
      var local10:int = 0;
      var local11:Number = NaN;
      var local12:int = 0;
      var local13:int = 0;
      var local14:int = 0;
      this.programs = new Array();
      this.spriteVertexBuffer = new VertexBufferResource(Vector.<Number>([0,2,4,6]),1);
      this.spriteIndexBuffer = new IndexBufferResource(Vector.<uint>([0,1,3,1,2,3]));
      this.alternativa3d::transform = Vector.<Number>([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]);
      this.alternativa3d::params = Vector.<Number>([-255 * bigValue,-bigValue,bigValue,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1]);
      this.coords = Vector.<Number>([0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1 / 255,1]);
      this.fragment = Vector.<Number>([1 / 255,0,1,1]);
      this.alphaTestConst = Vector.<Number>([0,0,0,1]);
      this.scissor = new Rectangle();
      this.defaultLight = new DirectionalLight(8355711);
      this.boundVertexList = Vertex.alternativa3d::createList(8);
      super();
      if(param1 > sizeLimit) {
        throw new Error("Value of mapSize too big.");
      }
      var local6:Number = Math.log(param1) / Math.LN2;
      if(local6 != int(local6)) {
        throw new Error("Value of mapSize must be power of 2.");
      }
      this.mapSize = param1;
      this.nearDistance = param2;
      this.farDistance = param3;
      this.bias = param4;
      this.additionalSpace = param5;
      this.defaultLight.rotationX = Math.PI;
      this.alternativa3d::map = new RenderTargetTextureResource(param1,param1);
      var local7:Vector.<uint> = new Vector.<uint>();
      var local8:int = 0;
      var local9:int = 0;
      while(local9 < this.noiseSize) {
        local10 = 0;
        while(local10 < this.noiseSize) {
          local11 = Math.random() * this.noiseAngle;
          local12 = Math.sin(local11) * 255;
          local13 = Math.cos(local11) * 255;
          local14 = (this.noiseRandom + Math.random() * (1 - this.noiseRandom)) * 255;
          local7[local8] = local12 << 16 | local13 << 8 | local14;
          local8++;
          local10++;
        }
        local9++;
      }
      this.alternativa3d::noise = new BitmapTextureResource(new BitmapData(this.noiseSize,this.noiseSize,false,0),false);
      this.alternativa3d::noise.bitmapData.setVector(this.alternativa3d::noise.bitmapData.rect,local7);
    }

    alternativa3d function calculateBounds(param1:Camera3D) : void {
      if(param1.directionalLight != null) {
        this.light = param1.directionalLight;
      } else {
        this.light = this.defaultLight;
      }
      this.light.alternativa3d::composeMatrix();
      this.dirZ = this.light.alternativa3d::mk;
      this.light.alternativa3d::calculateInverseMatrix();
      var local2:Number = Number(this.light.alternativa3d::ima);
      var local3:Number = Number(this.light.alternativa3d::imb);
      var local4:Number = Number(this.light.alternativa3d::imc);
      var local5:Number = Number(this.light.alternativa3d::imd);
      var local6:Number = Number(this.light.alternativa3d::ime);
      var local7:Number = Number(this.light.alternativa3d::imf);
      var local8:Number = Number(this.light.alternativa3d::img);
      var local9:Number = Number(this.light.alternativa3d::imh);
      var local10:Number = Number(this.light.alternativa3d::imi);
      var local11:Number = Number(this.light.alternativa3d::imj);
      var local12:Number = Number(this.light.alternativa3d::imk);
      var local13:Number = Number(this.light.alternativa3d::iml);
      this.light.alternativa3d::ima = local2 * param1.alternativa3d::gma + local3 * param1.alternativa3d::gme + local4 * param1.alternativa3d::gmi;
      this.light.alternativa3d::imb = local2 * param1.alternativa3d::gmb + local3 * param1.alternativa3d::gmf + local4 * param1.alternativa3d::gmj;
      this.light.alternativa3d::imc = local2 * param1.alternativa3d::gmc + local3 * param1.alternativa3d::gmg + local4 * param1.alternativa3d::gmk;
      this.light.alternativa3d::imd = local2 * param1.alternativa3d::gmd + local3 * param1.alternativa3d::gmh + local4 * param1.alternativa3d::gml + local5;
      this.light.alternativa3d::ime = local6 * param1.alternativa3d::gma + local7 * param1.alternativa3d::gme + local8 * param1.alternativa3d::gmi;
      this.light.alternativa3d::imf = local6 * param1.alternativa3d::gmb + local7 * param1.alternativa3d::gmf + local8 * param1.alternativa3d::gmj;
      this.light.alternativa3d::img = local6 * param1.alternativa3d::gmc + local7 * param1.alternativa3d::gmg + local8 * param1.alternativa3d::gmk;
      this.light.alternativa3d::imh = local6 * param1.alternativa3d::gmd + local7 * param1.alternativa3d::gmh + local8 * param1.alternativa3d::gml + local9;
      this.light.alternativa3d::imi = local10 * param1.alternativa3d::gma + local11 * param1.alternativa3d::gme + local12 * param1.alternativa3d::gmi;
      this.light.alternativa3d::imj = local10 * param1.alternativa3d::gmb + local11 * param1.alternativa3d::gmf + local12 * param1.alternativa3d::gmj;
      this.light.alternativa3d::imk = local10 * param1.alternativa3d::gmc + local11 * param1.alternativa3d::gmg + local12 * param1.alternativa3d::gmk;
      this.light.alternativa3d::iml = local10 * param1.alternativa3d::gmd + local11 * param1.alternativa3d::gmh + local12 * param1.alternativa3d::gml + local13;
      var local14:Vertex = this.boundVertexList;
      local14.x = -param1.nearClipping;
      local14.y = -param1.nearClipping;
      local14.z = param1.nearClipping;
      local14 = local14.alternativa3d::next;
      local14.x = -param1.nearClipping;
      local14.y = param1.nearClipping;
      local14.z = param1.nearClipping;
      local14 = local14.alternativa3d::next;
      local14.x = param1.nearClipping;
      local14.y = param1.nearClipping;
      local14.z = param1.nearClipping;
      local14 = local14.alternativa3d::next;
      local14.x = param1.nearClipping;
      local14.y = -param1.nearClipping;
      local14.z = param1.nearClipping;
      local14 = local14.alternativa3d::next;
      local14.x = -this.farDistance;
      local14.y = -this.farDistance;
      local14.z = this.farDistance;
      local14 = local14.alternativa3d::next;
      local14.x = -this.farDistance;
      local14.y = this.farDistance;
      local14.z = this.farDistance;
      local14 = local14.alternativa3d::next;
      local14.x = this.farDistance;
      local14.y = this.farDistance;
      local14.z = this.farDistance;
      local14 = local14.alternativa3d::next;
      local14.x = this.farDistance;
      local14.y = -this.farDistance;
      local14.z = this.farDistance;
      this.light.boundMinX = 1e+22;
      this.light.boundMinY = 1e+22;
      this.light.boundMinZ = 1e+22;
      this.light.boundMaxX = -1e+22;
      this.light.boundMaxY = -1e+22;
      this.light.boundMaxZ = -1e+22;
      local14 = this.boundVertexList;
      while(local14 != null) {
        local14.alternativa3d::cameraX = this.light.alternativa3d::ima * local14.x + this.light.alternativa3d::imb * local14.y + this.light.alternativa3d::imc * local14.z + this.light.alternativa3d::imd;
        local14.alternativa3d::cameraY = this.light.alternativa3d::ime * local14.x + this.light.alternativa3d::imf * local14.y + this.light.alternativa3d::img * local14.z + this.light.alternativa3d::imh;
        local14.alternativa3d::cameraZ = this.light.alternativa3d::imi * local14.x + this.light.alternativa3d::imj * local14.y + this.light.alternativa3d::imk * local14.z + this.light.alternativa3d::iml;
        if(local14.alternativa3d::cameraX < this.light.boundMinX) {
          this.light.boundMinX = local14.alternativa3d::cameraX;
        }
        if(local14.alternativa3d::cameraX > this.light.boundMaxX) {
          this.light.boundMaxX = local14.alternativa3d::cameraX;
        }
        if(local14.alternativa3d::cameraY < this.light.boundMinY) {
          this.light.boundMinY = local14.alternativa3d::cameraY;
        }
        if(local14.alternativa3d::cameraY > this.light.boundMaxY) {
          this.light.boundMaxY = local14.alternativa3d::cameraY;
        }
        if(local14.alternativa3d::cameraZ < this.light.boundMinZ) {
          this.light.boundMinZ = local14.alternativa3d::cameraZ;
        }
        if(local14.alternativa3d::cameraZ > this.light.boundMaxZ) {
          this.light.boundMaxZ = local14.alternativa3d::cameraZ;
        }
        local14 = local14.alternativa3d::next;
      }
      var local15:Vertex = this.boundVertexList;
      var local16:Vertex = this.boundVertexList.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::next;
      var local17:Vertex = this.boundVertexList.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::next;
      var local18:Number = local16.alternativa3d::cameraX - local15.alternativa3d::cameraX;
      var local19:Number = local16.alternativa3d::cameraY - local15.alternativa3d::cameraY;
      var local20:Number = local16.alternativa3d::cameraZ - local15.alternativa3d::cameraZ;
      var local21:Number = local17.alternativa3d::cameraX - local16.alternativa3d::cameraX;
      var local22:Number = local17.alternativa3d::cameraY - local16.alternativa3d::cameraY;
      var local23:Number = local17.alternativa3d::cameraZ - local16.alternativa3d::cameraZ;
      var local24:Number = local18 * local18 + local19 * local19 + local20 * local20;
      var local25:Number = local21 * local21 + local22 * local22 + local23 * local23;
      var local26:int = Math.ceil(this.noiseRadius);
      this.planeSize = local24 > local25 ? Math.sqrt(local24) : Math.sqrt(local25);
      this.pixel = this.planeSize / (this.mapSize - 1 - this.noiseRadius);
      this.planeSize += local26 * this.pixel * 2;
      this.light.boundMinX -= local26 * this.pixel;
      this.light.boundMaxX += local26 * this.pixel;
      this.light.boundMinY -= local26 * this.pixel;
      this.light.boundMaxY += local26 * this.pixel;
      this.light.boundMinZ -= this.additionalSpace;
      local14 = this.boundVertexList;
      local14.x = this.light.boundMinX;
      local14.y = this.light.boundMinY;
      local14.z = this.light.boundMinZ;
      local14 = local14.alternativa3d::next;
      local14.x = this.light.boundMaxX;
      local14.y = this.light.boundMinY;
      local14.z = this.light.boundMinZ;
      local14 = local14.alternativa3d::next;
      local14.x = this.light.boundMinX;
      local14.y = this.light.boundMaxY;
      local14.z = this.light.boundMinZ;
      local14 = local14.alternativa3d::next;
      local14.x = this.light.boundMaxX;
      local14.y = this.light.boundMaxY;
      local14.z = this.light.boundMinZ;
      local14 = local14.alternativa3d::next;
      local14.x = this.light.boundMinX;
      local14.y = this.light.boundMinY;
      local14.z = this.light.boundMaxZ;
      local14 = local14.alternativa3d::next;
      local14.x = this.light.boundMaxX;
      local14.y = this.light.boundMinY;
      local14.z = this.light.boundMaxZ;
      local14 = local14.alternativa3d::next;
      local14.x = this.light.boundMinX;
      local14.y = this.light.boundMaxY;
      local14.z = this.light.boundMaxZ;
      local14 = local14.alternativa3d::next;
      local14.x = this.light.boundMaxX;
      local14.y = this.light.boundMaxY;
      local14.z = this.light.boundMaxZ;
      this.alternativa3d::boundMinX = 1e+22;
      this.alternativa3d::boundMinY = 1e+22;
      this.alternativa3d::boundMinZ = 1e+22;
      this.alternativa3d::boundMaxX = -1e+22;
      this.alternativa3d::boundMaxY = -1e+22;
      this.alternativa3d::boundMaxZ = -1e+22;
      local14 = this.boundVertexList;
      while(local14 != null) {
        local14.alternativa3d::cameraX = this.light.alternativa3d::ma * local14.x + this.light.alternativa3d::mb * local14.y + this.light.alternativa3d::mc * local14.z + this.light.alternativa3d::md;
        local14.alternativa3d::cameraY = this.light.alternativa3d::me * local14.x + this.light.alternativa3d::mf * local14.y + this.light.alternativa3d::mg * local14.z + this.light.alternativa3d::mh;
        local14.alternativa3d::cameraZ = this.light.alternativa3d::mi * local14.x + this.light.alternativa3d::mj * local14.y + this.light.alternativa3d::mk * local14.z + this.light.alternativa3d::ml;
        if(local14.alternativa3d::cameraX < this.alternativa3d::boundMinX) {
          this.alternativa3d::boundMinX = local14.alternativa3d::cameraX;
        }
        if(local14.alternativa3d::cameraX > this.alternativa3d::boundMaxX) {
          this.alternativa3d::boundMaxX = local14.alternativa3d::cameraX;
        }
        if(local14.alternativa3d::cameraY < this.alternativa3d::boundMinY) {
          this.alternativa3d::boundMinY = local14.alternativa3d::cameraY;
        }
        if(local14.alternativa3d::cameraY > this.alternativa3d::boundMaxY) {
          this.alternativa3d::boundMaxY = local14.alternativa3d::cameraY;
        }
        if(local14.alternativa3d::cameraZ < this.alternativa3d::boundMinZ) {
          this.alternativa3d::boundMinZ = local14.alternativa3d::cameraZ;
        }
        if(local14.alternativa3d::cameraZ > this.alternativa3d::boundMaxZ) {
          this.alternativa3d::boundMaxZ = local14.alternativa3d::cameraZ;
        }
        local14 = local14.alternativa3d::next;
      }
    }

    alternativa3d function render(param1:Camera3D, param2:Vector.<Object3D>, param3:int) : void {
      var local12:Object3D = null;
      var local13:VertexBufferResource = null;
      var local14:IndexBufferResource = null;
      var local15:int = 0;
      var local16:Boolean = false;
      var local17:TextureMaterial = null;
      var local18:Sprite3D = null;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local28:Number = NaN;
      var local29:Number = NaN;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Mesh = null;
      var local34:BSP = null;
      var local4:Device = param1.alternativa3d::device;
      this.planeX = Math.floor(this.light.boundMinX / this.pixel) * this.pixel;
      this.planeY = Math.floor(this.light.boundMinY / this.pixel) * this.pixel;
      this.scissor.width = Math.ceil(this.light.boundMaxX / this.pixel) - this.planeX / this.pixel;
      this.scissor.height = Math.ceil(this.light.boundMaxY / this.pixel) - this.planeY / this.pixel;
      var local5:Number = 2 / this.planeSize;
      var local6:Number = -2 / this.planeSize;
      var local7:Number = 255 / (this.light.boundMaxZ - this.light.boundMinZ);
      var local8:Number = -(this.planeX + this.planeSize * 0.5) * local5;
      var local9:Number = -(this.planeY + this.planeSize * 0.5) * local6;
      var local10:Number = -this.light.boundMinZ * local7;
      if(this.mapSize != this.alternativa3d::map.width) {
        this.alternativa3d::map.dispose();
        this.alternativa3d::map = new RenderTargetTextureResource(this.mapSize,this.mapSize);
      }
      local4.setRenderToTexture(this.alternativa3d::map,true);
      local4.clear(1,0,0);
      local4.setScissorRectangle(this.scissor);
      this.alternativa3d::transform[14] = 1 / 255;
      var local11:int = 0;
      while(local11 < param3) {
        local12 = param2[local11];
        local13 = null;
        local14 = null;
        local16 = false;
        if(local12 is Sprite3D) {
          local18 = Sprite3D(local12);
          local17 = TextureMaterial(local18.material);
          local19 = local18.width;
          local20 = local18.height;
          if(local18.autoSize) {
            local31 = local18.bottomRightU - local18.topLeftU;
            local32 = local18.bottomRightV - local18.topLeftV;
            local19 = local17.texture.width * local31;
            local20 = local17.texture.height * local32;
          }
          local21 = Math.tan(Math.asin(-this.dirZ));
          local19 *= local18.scaleX;
          local20 *= local18.scaleY;
          local22 = this.light.alternativa3d::ima * local12.alternativa3d::md + this.light.alternativa3d::imb * local12.alternativa3d::mh + this.light.alternativa3d::imc * local12.alternativa3d::ml + this.light.alternativa3d::imd;
          local23 = this.light.alternativa3d::ime * local12.alternativa3d::md + this.light.alternativa3d::imf * local12.alternativa3d::mh + this.light.alternativa3d::img * local12.alternativa3d::ml + this.light.alternativa3d::imh;
          local24 = this.light.alternativa3d::imi * local12.alternativa3d::md + this.light.alternativa3d::imj * local12.alternativa3d::mh + this.light.alternativa3d::imk * local12.alternativa3d::ml + this.light.alternativa3d::iml;
          local23 += Math.sin(-this.dirZ) * local20 / 4;
          local24 -= Math.cos(-this.dirZ) * local20 / 4;
          local25 = -local19 * local18.originX;
          local26 = -local20 * local18.originY;
          local27 = -local26 / local21;
          local28 = local25 + local19;
          local29 = local26 + local20;
          local30 = -local29 / local21;
          local25 = (local25 + local22) * local5 + local8;
          local26 = (local26 + local23) * local6 + local9;
          local27 = (local27 + local24) * local7 + local10;
          local28 = (local28 + local22) * local5 + local8;
          local29 = (local29 + local23) * local6 + local9;
          local30 = (local30 + local24) * local7 + local10;
          local27 -= this.bias * this.biasMultiplier * local7 / local21;
          local30 -= this.bias * this.biasMultiplier * local7 / local21;
          this.coords[0] = local25;
          this.coords[1] = local26;
          this.coords[2] = local27;
          this.coords[4] = 0;
          this.coords[5] = 0;
          this.coords[8] = local25;
          this.coords[9] = local29;
          this.coords[10] = local30;
          this.coords[12] = 0;
          this.coords[13] = 1;
          this.coords[16] = local28;
          this.coords[17] = local29;
          this.coords[18] = local30;
          this.coords[20] = 1;
          this.coords[21] = 1;
          this.coords[24] = local28;
          this.coords[25] = local26;
          this.coords[26] = local27;
          this.coords[28] = 1;
          this.coords[29] = 0;
          local13 = this.spriteVertexBuffer;
          local14 = this.spriteIndexBuffer;
          local15 = 2;
          local16 = true;
          local4.setProgram(this.getProgram(true,true));
          local4.setVertexBufferAt(0,local13,0,Context3DVertexBufferFormat.FLOAT_1);
          local4.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,this.coords,9,false);
        } else {
          this.alternativa3d::transform[0] = (this.light.alternativa3d::ima * local12.alternativa3d::ma + this.light.alternativa3d::imb * local12.alternativa3d::me + this.light.alternativa3d::imc * local12.alternativa3d::mi) * local5;
          this.alternativa3d::transform[1] = (this.light.alternativa3d::ima * local12.alternativa3d::mb + this.light.alternativa3d::imb * local12.alternativa3d::mf + this.light.alternativa3d::imc * local12.alternativa3d::mj) * local5;
          this.alternativa3d::transform[2] = (this.light.alternativa3d::ima * local12.alternativa3d::mc + this.light.alternativa3d::imb * local12.alternativa3d::mg + this.light.alternativa3d::imc * local12.alternativa3d::mk) * local5;
          this.alternativa3d::transform[3] = (this.light.alternativa3d::ima * local12.alternativa3d::md + this.light.alternativa3d::imb * local12.alternativa3d::mh + this.light.alternativa3d::imc * local12.alternativa3d::ml + this.light.alternativa3d::imd) * local5 + local8;
          this.alternativa3d::transform[4] = (this.light.alternativa3d::ime * local12.alternativa3d::ma + this.light.alternativa3d::imf * local12.alternativa3d::me + this.light.alternativa3d::img * local12.alternativa3d::mi) * local6;
          this.alternativa3d::transform[5] = (this.light.alternativa3d::ime * local12.alternativa3d::mb + this.light.alternativa3d::imf * local12.alternativa3d::mf + this.light.alternativa3d::img * local12.alternativa3d::mj) * local6;
          this.alternativa3d::transform[6] = (this.light.alternativa3d::ime * local12.alternativa3d::mc + this.light.alternativa3d::imf * local12.alternativa3d::mg + this.light.alternativa3d::img * local12.alternativa3d::mk) * local6;
          this.alternativa3d::transform[7] = (this.light.alternativa3d::ime * local12.alternativa3d::md + this.light.alternativa3d::imf * local12.alternativa3d::mh + this.light.alternativa3d::img * local12.alternativa3d::ml + this.light.alternativa3d::imh) * local6 + local9;
          this.alternativa3d::transform[8] = (this.light.alternativa3d::imi * local12.alternativa3d::ma + this.light.alternativa3d::imj * local12.alternativa3d::me + this.light.alternativa3d::imk * local12.alternativa3d::mi) * local7;
          this.alternativa3d::transform[9] = (this.light.alternativa3d::imi * local12.alternativa3d::mb + this.light.alternativa3d::imj * local12.alternativa3d::mf + this.light.alternativa3d::imk * local12.alternativa3d::mj) * local7;
          this.alternativa3d::transform[10] = (this.light.alternativa3d::imi * local12.alternativa3d::mc + this.light.alternativa3d::imj * local12.alternativa3d::mg + this.light.alternativa3d::imk * local12.alternativa3d::mk) * local7;
          this.alternativa3d::transform[11] = (this.light.alternativa3d::imi * local12.alternativa3d::md + this.light.alternativa3d::imj * local12.alternativa3d::mh + this.light.alternativa3d::imk * local12.alternativa3d::ml + this.light.alternativa3d::iml) * local7 + local10;
          if(local12 is Mesh) {
            local33 = Mesh(local12);
            local33.alternativa3d::prepareResources();
            local13 = local33.alternativa3d::vertexBuffer;
            local14 = local33.alternativa3d::indexBuffer;
            local15 = int(local33.alternativa3d::numTriangles);
            local17 = local33.alternativa3d::faceList.material as TextureMaterial;
          } else if(local12 is BSP) {
            local34 = BSP(local12);
            local34.alternativa3d::prepareResources();
            local13 = local34.alternativa3d::vertexBuffer;
            local14 = local34.alternativa3d::indexBuffer;
            local15 = int(local34.alternativa3d::numTriangles);
            local17 = local34.alternativa3d::faces[0].material as TextureMaterial;
          } else {
            local17 = null;
          }
          if(local17 != null && local17.alternativa3d::transparent) {
            local16 = true;
            local4.setProgram(this.getProgram(true,false));
            local4.setVertexBufferAt(1,local13,3,Context3DVertexBufferFormat.FLOAT_2);
          } else {
            local4.setProgram(this.getProgram(false,false));
          }
          local4.setVertexBufferAt(0,local13,0,Context3DVertexBufferFormat.FLOAT_3);
          local4.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,this.alternativa3d::transform,4,false);
        }
        if(local13 != null && local14 != null) {
          local4.setTextureAt(4,null);
          local4.setTextureAt(6,null);
          if(local16) {
            local4.setTextureAt(0,local17.alternativa3d::textureResource);
            this.alphaTestConst[0] = local17.alternativa3d::textureResource.correctionU;
            this.alphaTestConst[1] = local17.alternativa3d::textureResource.correctionV;
            this.alphaTestConst[3] = local12 is Sprite3D ? 0.99 : this.alphaThreshold;
            local4.setProgramConstantsFromVector(Context3DProgramType.VERTEX,10,this.alphaTestConst,1);
          }
          local4.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,this.fragment,1);
          local4.drawTriangles(local14,0,local15);
        }
        if(local16) {
          local4.setTextureAt(0,null);
          local4.setVertexBufferAt(1,null);
        }
        local11++;
      }
      local4.setScissorRectangle(null);
      local5 = 1 / this.planeSize;
      local6 = 1 / this.planeSize;
      local8 = -this.planeX * local5;
      local9 = -this.planeY * local6;
      this.alternativa3d::transform[0] = this.light.alternativa3d::ima * local5;
      this.alternativa3d::transform[1] = this.light.alternativa3d::imb * local5;
      this.alternativa3d::transform[2] = this.light.alternativa3d::imc * local5;
      this.alternativa3d::transform[3] = this.light.alternativa3d::imd * local5 + local8;
      this.alternativa3d::transform[4] = this.light.alternativa3d::ime * local6;
      this.alternativa3d::transform[5] = this.light.alternativa3d::imf * local6;
      this.alternativa3d::transform[6] = this.light.alternativa3d::img * local6;
      this.alternativa3d::transform[7] = this.light.alternativa3d::imh * local6 + local9;
      this.alternativa3d::transform[8] = this.light.alternativa3d::imi * local7;
      this.alternativa3d::transform[9] = this.light.alternativa3d::imj * local7;
      this.alternativa3d::transform[10] = this.light.alternativa3d::imk * local7;
      this.alternativa3d::transform[11] = this.light.alternativa3d::iml * local7 + local10 - this.bias * this.biasMultiplier * local7;
      this.alternativa3d::transform[12] = this.nearDistance;
      this.alternativa3d::transform[13] = this.farDistance - this.nearDistance;
      this.alternativa3d::transform[14] = -local7;
      this.alternativa3d::params[4] = 0;
      this.alternativa3d::params[5] = 0;
      this.alternativa3d::params[6] = this.noiseRadius / this.mapSize;
      this.alternativa3d::params[7] = 1 / numSamples;
      this.alternativa3d::params[8] = param1.view.alternativa3d::_width / this.noiseSize;
      this.alternativa3d::params[9] = param1.view.alternativa3d::_height / this.noiseSize;
      this.alternativa3d::params[11] = param1.directionalLight != null ? param1.directionalLightStrength * param1.shadowMapStrength : 0;
      this.alternativa3d::params[12] = Math.cos(this.noiseAngle);
      this.alternativa3d::params[13] = Math.sin(this.noiseAngle);
      this.alternativa3d::params[16] = -Math.sin(this.noiseAngle);
      this.alternativa3d::params[17] = Math.cos(this.noiseAngle);
    }

    public function dispose() : void {
      this.alternativa3d::map.reset();
      this.alternativa3d::noise.reset();
    }

    private function getProgram(param1:Boolean, param2:Boolean) : ProgramResource {
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local3:int = int(param1) | int(param2) << 1;
      var local4:ProgramResource = this.programs[local3];
      if(local4 == null) {
        local5 = new ShadowMapVertexShader(param1,param2).agalcode;
        local6 = new ShadowMapFragmentShader(param1).agalcode;
        local4 = new ProgramResource(local5,local6);
        this.programs[local3] = local4;
      }
      return local4;
    }
  }
}
