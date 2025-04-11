package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.lights.DirectionalLight;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.gfx.agal.FragmentShader;
  import alternativa.gfx.agal.Shader;
  import alternativa.gfx.core.Device;
  import alternativa.gfx.core.IndexBufferResource;
  import alternativa.gfx.core.ProgramResource;
  import alternativa.gfx.core.TextureResource;
  import alternativa.gfx.core.VertexBufferResource;
  import flash.display3D.Context3DProgramType;
  import flash.display3D.Context3DVertexBufferFormat;
  import flash.geom.Vector3D;
  import flash.utils.ByteArray;

  use namespace alternativa3d;

  public class Shadow {
    private static var casterProgram:ProgramResource;
    private static var volumeProgram:ProgramResource;
    private static var casterConst:Vector.<Number> = Vector.<Number>([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0]);
    private static var volumeVertexBuffer:VertexBufferResource = new VertexBufferResource(Vector.<Number>([0,0,0,0,1,0,1,1,0,1,0,0,0,0,1,0,1,1,1,1,1,1,0,1]),3);
    private static var volumeIndexBuffer:IndexBufferResource = new IndexBufferResource(Vector.<uint>([0,1,3,2,3,1,7,6,4,5,4,6,4,5,0,1,0,5,3,2,7,6,7,2,0,3,4,7,4,3,5,6,1,2,1,6]));
    private static var volumeTransformConst:Vector.<Number> = new Vector.<Number>(20);
    private static var volumeFragmentConst:Vector.<Number> = Vector.<Number>([1,0,1,0.5]);
    private static var receiverPrograms:Array = new Array();

    public var mapSize:int;
    public var blur:int;
    public var attenuation:Number;
    public var nearDistance:Number;
    public var farDistance:Number;
    public var color:int;
    public var alpha:Number;
    public var direction:Vector3D = new Vector3D(0,0,-1);
    public var offset:Number = 0;
    public var backFadeRange:Number = 0;

    private var casters:Vector.<Mesh> = new Vector.<Mesh>();
    private var castersCount:int = 0;

    alternativa3d var receiversBuffers:Vector.<int> = new Vector.<int>();
    alternativa3d var receiversFirstIndexes:Vector.<int> = new Vector.<int>();
    alternativa3d var receiversNumsTriangles:Vector.<int> = new Vector.<int>();
    alternativa3d var receiversCount:int = 0;

    private var dir:Vector3D = new Vector3D();
    private var light:DirectionalLight = new DirectionalLight(0);
    private var boundVertexList:Vertex = Vertex.alternativa3d::createList(8);
    private var planeX:Number;
    private var planeY:Number;
    private var planeSize:Number;
    private var minZ:Number;

    alternativa3d var boundMinX:Number;
    alternativa3d var boundMinY:Number;
    alternativa3d var boundMinZ:Number;
    alternativa3d var boundMaxX:Number;
    alternativa3d var boundMaxY:Number;
    alternativa3d var boundMaxZ:Number;
    alternativa3d var cameraInside:Boolean;

    private var transformConst:Vector.<Number> = new Vector.<Number>(12);
    private var uvConst:Vector.<Number> = Vector.<Number>([0,0,0,1,0,0,0,1]);
    private var colorConst:Vector.<Number> = new Vector.<Number>(12);
    private var clampConst:Vector.<Number> = Vector.<Number>([0,0,0,1]);

    alternativa3d var texture:TextureResource;
    alternativa3d var textureScaleU:Number;
    alternativa3d var textureScaleV:Number;
    alternativa3d var textureOffsetU:Number;
    alternativa3d var textureOffsetV:Number;

    public function Shadow(param1:int, param2:int, param3:Number, param4:Number, param5:Number, param6:int = 0, param7:Number = 1) {
      super();
      if(param1 > ShadowAtlas.alternativa3d::sizeLimit) {
        throw new Error("Value of mapSize too big.");
      }
      var local8:Number = Math.log(param1) / Math.LN2;
      if(local8 != int(local8)) {
        throw new Error("Value of mapSize must be power of 2.");
      }
      this.mapSize = param1;
      this.blur = param2;
      this.attenuation = param3;
      this.nearDistance = param4;
      this.farDistance = param5;
      this.color = param6;
      this.alpha = param7;
    }

    alternativa3d static function getCasterProgram() : ProgramResource {
      var local2:ByteArray = null;
      var local3:FragmentShader = null;
      var local1:ProgramResource = casterProgram;
      if(local1 == null) {
        local2 = new ShadowCasterVertexShader().agalcode;
        local3 = new FragmentShader();
        local3.mov(FragmentShader.oc,Shader.v0);
        local1 = new ProgramResource(local2,local3.agalcode);
        casterProgram = local1;
      }
      return local1;
    }

    public function addCaster(param1:Mesh) : void {
      this.casters[this.castersCount] = param1;
      ++this.castersCount;
    }

    public function removeCaster(param1:Mesh) : void {
      var local2:int = 0;
      while(local2 < this.castersCount) {
        if(this.casters[local2] == param1) {
          --this.castersCount;
          while(local2 < this.castersCount) {
            this.casters[local2] = this.casters[int(local2 + 1)];
            local2++;
          }
          this.casters.length = this.castersCount;
          break;
        }
        local2++;
      }
    }

    public function removeAllCasters() : void {
      this.castersCount = 0;
      this.casters.length = 0;
    }

    alternativa3d function checkVisibility(param1:Camera3D) : Boolean {
      var local24:Object3D = null;
      var local25:Object3D = null;
      var local26:Vertex = null;
      var local27:Number = NaN;
      if(this.castersCount == 0) {
        return false;
      }
      if(this.direction != null) {
        this.dir.x = this.direction.x;
        this.dir.y = this.direction.y;
        this.dir.z = this.direction.z;
        this.dir.normalize();
      } else {
        this.dir.x = 0;
        this.dir.y = 0;
        this.dir.z = -1;
      }
      this.light.rotationX = Math.atan2(this.dir.z,Math.sqrt(this.dir.x * this.dir.x + this.dir.y * this.dir.y)) - Math.PI / 2;
      this.light.rotationY = 0;
      this.light.rotationZ = -Math.atan2(this.dir.x,this.dir.y);
      this.light.alternativa3d::composeMatrix();
      var local2:Number = Number(this.light.alternativa3d::ma);
      var local3:Number = Number(this.light.alternativa3d::mb);
      var local4:Number = Number(this.light.alternativa3d::mc);
      var local5:Number = Number(this.light.alternativa3d::md);
      var local6:Number = Number(this.light.alternativa3d::me);
      var local7:Number = Number(this.light.alternativa3d::mf);
      var local8:Number = Number(this.light.alternativa3d::mg);
      var local9:Number = Number(this.light.alternativa3d::mh);
      var local10:Number = Number(this.light.alternativa3d::mi);
      var local11:Number = Number(this.light.alternativa3d::mj);
      var local12:Number = Number(this.light.alternativa3d::mk);
      var local13:Number = Number(this.light.alternativa3d::ml);
      this.light.alternativa3d::invertMatrix();
      this.light.alternativa3d::ima = this.light.alternativa3d::ma;
      this.light.alternativa3d::imb = this.light.alternativa3d::mb;
      this.light.alternativa3d::imc = this.light.alternativa3d::mc;
      this.light.alternativa3d::imd = this.light.alternativa3d::md;
      this.light.alternativa3d::ime = this.light.alternativa3d::me;
      this.light.alternativa3d::imf = this.light.alternativa3d::mf;
      this.light.alternativa3d::img = this.light.alternativa3d::mg;
      this.light.alternativa3d::imh = this.light.alternativa3d::mh;
      this.light.alternativa3d::imi = this.light.alternativa3d::mi;
      this.light.alternativa3d::imj = this.light.alternativa3d::mj;
      this.light.alternativa3d::imk = this.light.alternativa3d::mk;
      this.light.alternativa3d::iml = this.light.alternativa3d::ml;
      this.light.boundMinX = 1e+22;
      this.light.boundMinY = 1e+22;
      this.light.boundMinZ = 1e+22;
      this.light.boundMaxX = -1e+22;
      this.light.boundMaxY = -1e+22;
      this.light.boundMaxZ = -1e+22;
      var local14:int = 0;
      while(local14 < this.castersCount) {
        local24 = this.casters[local14];
        local24.alternativa3d::composeMatrix();
        local25 = local24.alternativa3d::_parent;
        while(local25 != null) {
          Object3D.alternativa3d::tA.alternativa3d::composeMatrixFromSource(local25);
          local24.alternativa3d::appendMatrix(Object3D.alternativa3d::tA);
          local25 = local25.alternativa3d::_parent;
        }
        local24.alternativa3d::appendMatrix(this.light);
        local26 = this.boundVertexList;
        local26.x = local24.boundMinX;
        local26.y = local24.boundMinY;
        local26.z = local24.boundMinZ;
        local26 = local26.alternativa3d::next;
        local26.x = local24.boundMaxX;
        local26.y = local24.boundMinY;
        local26.z = local24.boundMinZ;
        local26 = local26.alternativa3d::next;
        local26.x = local24.boundMinX;
        local26.y = local24.boundMaxY;
        local26.z = local24.boundMinZ;
        local26 = local26.alternativa3d::next;
        local26.x = local24.boundMaxX;
        local26.y = local24.boundMaxY;
        local26.z = local24.boundMinZ;
        local26 = local26.alternativa3d::next;
        local26.x = local24.boundMinX;
        local26.y = local24.boundMinY;
        local26.z = local24.boundMaxZ;
        local26 = local26.alternativa3d::next;
        local26.x = local24.boundMaxX;
        local26.y = local24.boundMinY;
        local26.z = local24.boundMaxZ;
        local26 = local26.alternativa3d::next;
        local26.x = local24.boundMinX;
        local26.y = local24.boundMaxY;
        local26.z = local24.boundMaxZ;
        local26 = local26.alternativa3d::next;
        local26.x = local24.boundMaxX;
        local26.y = local24.boundMaxY;
        local26.z = local24.boundMaxZ;
        local26 = this.boundVertexList;
        while(local26 != null) {
          local26.alternativa3d::cameraX = local24.alternativa3d::ma * local26.x + local24.alternativa3d::mb * local26.y + local24.alternativa3d::mc * local26.z + local24.alternativa3d::md;
          local26.alternativa3d::cameraY = local24.alternativa3d::me * local26.x + local24.alternativa3d::mf * local26.y + local24.alternativa3d::mg * local26.z + local24.alternativa3d::mh;
          local26.alternativa3d::cameraZ = local24.alternativa3d::mi * local26.x + local24.alternativa3d::mj * local26.y + local24.alternativa3d::mk * local26.z + local24.alternativa3d::ml;
          if(local26.alternativa3d::cameraX < this.light.boundMinX) {
            this.light.boundMinX = local26.alternativa3d::cameraX;
          }
          if(local26.alternativa3d::cameraX > this.light.boundMaxX) {
            this.light.boundMaxX = local26.alternativa3d::cameraX;
          }
          if(local26.alternativa3d::cameraY < this.light.boundMinY) {
            this.light.boundMinY = local26.alternativa3d::cameraY;
          }
          if(local26.alternativa3d::cameraY > this.light.boundMaxY) {
            this.light.boundMaxY = local26.alternativa3d::cameraY;
          }
          if(local26.alternativa3d::cameraZ < this.light.boundMinZ) {
            this.light.boundMinZ = local26.alternativa3d::cameraZ;
          }
          if(local26.alternativa3d::cameraZ > this.light.boundMaxZ) {
            this.light.boundMaxZ = local26.alternativa3d::cameraZ;
          }
          local26 = local26.alternativa3d::next;
        }
        local14++;
      }
      var local15:int = this.mapSize - 1 - 1 - this.blur - this.blur;
      var local16:Number = this.light.boundMaxX - this.light.boundMinX;
      var local17:Number = this.light.boundMaxY - this.light.boundMinY;
      var local18:Number = local16 > local17 ? local16 : local17;
      var local19:Number = local18 / local15;
      var local20:Number = (1 + this.blur) * local19;
      var local21:Number = (1 + this.blur) * local19;
      if(local16 > local17) {
        local21 += (Math.ceil((local17 - 0.01) / (local19 + local19)) * (local19 + local19) - local17) * 0.5;
      } else {
        local20 += (Math.ceil((local16 - 0.01) / (local19 + local19)) * (local19 + local19) - local16) * 0.5;
      }
      this.light.boundMinX -= local20;
      this.light.boundMaxX += local20;
      this.light.boundMinY -= local21;
      this.light.boundMaxY += local21;
      this.light.boundMinZ += this.offset;
      this.light.boundMaxZ += this.attenuation;
      this.planeSize = local18 * this.mapSize / local15;
      if(local16 > local17) {
        this.planeX = this.light.boundMinX;
        this.planeY = this.light.boundMinY - (this.light.boundMaxX - this.light.boundMinX - (this.light.boundMaxY - this.light.boundMinY)) * 0.5;
      } else {
        this.planeX = this.light.boundMinX - (this.light.boundMaxY - this.light.boundMinY - (this.light.boundMaxX - this.light.boundMinX)) * 0.5;
        this.planeY = this.light.boundMinY;
      }
      var local22:Number = param1.farClipping;
      param1.farClipping = this.farDistance * param1.shadowsDistanceMultiplier;
      this.light.alternativa3d::ma = local2;
      this.light.alternativa3d::mb = local3;
      this.light.alternativa3d::mc = local4;
      this.light.alternativa3d::md = local5;
      this.light.alternativa3d::me = local6;
      this.light.alternativa3d::mf = local7;
      this.light.alternativa3d::mg = local8;
      this.light.alternativa3d::mh = local9;
      this.light.alternativa3d::mi = local10;
      this.light.alternativa3d::mj = local11;
      this.light.alternativa3d::mk = local12;
      this.light.alternativa3d::ml = local13;
      this.light.alternativa3d::appendMatrix(param1);
      var local23:Boolean = this.cullingInCamera(param1);
      param1.farClipping = local22;
      if(local23) {
        if(param1.debug && Boolean(param1.alternativa3d::checkInDebug(this.light) & Debug.BOUNDS)) {
          Debug.alternativa3d::drawBounds(param1,this.light,this.light.boundMinX,this.light.boundMinY,this.light.boundMinZ,this.light.boundMaxX,this.light.boundMaxY,this.light.boundMaxZ,16711935);
        }
        this.alternativa3d::boundMinX = 1e+22;
        this.alternativa3d::boundMinY = 1e+22;
        this.alternativa3d::boundMinZ = 1e+22;
        this.alternativa3d::boundMaxX = -1e+22;
        this.alternativa3d::boundMaxY = -1e+22;
        this.alternativa3d::boundMaxZ = -1e+22;
        local26 = this.boundVertexList;
        while(local26 != null) {
          local26.alternativa3d::cameraX = local2 * local26.x + local3 * local26.y + local4 * local26.z + local5;
          local26.alternativa3d::cameraY = local6 * local26.x + local7 * local26.y + local8 * local26.z + local9;
          local26.alternativa3d::cameraZ = local10 * local26.x + local11 * local26.y + local12 * local26.z + local13;
          if(local26.alternativa3d::cameraX < this.alternativa3d::boundMinX) {
            this.alternativa3d::boundMinX = local26.alternativa3d::cameraX;
          }
          if(local26.alternativa3d::cameraX > this.alternativa3d::boundMaxX) {
            this.alternativa3d::boundMaxX = local26.alternativa3d::cameraX;
          }
          if(local26.alternativa3d::cameraY < this.alternativa3d::boundMinY) {
            this.alternativa3d::boundMinY = local26.alternativa3d::cameraY;
          }
          if(local26.alternativa3d::cameraY > this.alternativa3d::boundMaxY) {
            this.alternativa3d::boundMaxY = local26.alternativa3d::cameraY;
          }
          if(local26.alternativa3d::cameraZ < this.alternativa3d::boundMinZ) {
            this.alternativa3d::boundMinZ = local26.alternativa3d::cameraZ;
          }
          if(local26.alternativa3d::cameraZ > this.alternativa3d::boundMaxZ) {
            this.alternativa3d::boundMaxZ = local26.alternativa3d::cameraZ;
          }
          local26 = local26.alternativa3d::next;
        }
        this.alternativa3d::cameraInside = false;
        if(this.minZ <= param1.nearClipping) {
          local27 = this.light.alternativa3d::ima * param1.alternativa3d::gmd + this.light.alternativa3d::imb * param1.alternativa3d::gmh + this.light.alternativa3d::imc * param1.alternativa3d::gml + this.light.alternativa3d::imd;
          if(local27 - param1.nearClipping <= this.light.boundMaxX && local27 + param1.nearClipping >= this.light.boundMinX) {
            local27 = this.light.alternativa3d::ime * param1.alternativa3d::gmd + this.light.alternativa3d::imf * param1.alternativa3d::gmh + this.light.alternativa3d::img * param1.alternativa3d::gml + this.light.alternativa3d::imh;
            if(local27 - param1.nearClipping <= this.light.boundMaxY && local27 + param1.nearClipping >= this.light.boundMinY) {
              local27 = this.light.alternativa3d::imi * param1.alternativa3d::gmd + this.light.alternativa3d::imj * param1.alternativa3d::gmh + this.light.alternativa3d::imk * param1.alternativa3d::gml + this.light.alternativa3d::iml;
              if(local27 - param1.nearClipping <= this.light.boundMaxZ && local27 + param1.nearClipping >= this.light.boundMinZ) {
                this.alternativa3d::cameraInside = true;
              }
            }
          }
        }
      }
      return local23;
    }

    alternativa3d function renderCasters(param1:Camera3D) : void {
      var local10:Mesh = null;
      var local2:Device = param1.alternativa3d::device;
      var local3:Number = 2 / this.planeSize;
      var local4:Number = -2 / this.planeSize;
      var local5:Number = 1 / (this.light.boundMaxZ - this.attenuation - (this.light.boundMinZ - this.offset));
      var local6:Number = -(this.light.boundMinZ - this.offset) * local5;
      var local7:Number = (this.light.boundMinX + this.light.boundMaxX) * 0.5;
      var local8:Number = (this.light.boundMinY + this.light.boundMaxY) * 0.5;
      var local9:int = 0;
      while(local9 < this.castersCount) {
        local10 = this.casters[local9];
        local10.alternativa3d::prepareResources();
        casterConst[0] = local10.alternativa3d::ma * local3;
        casterConst[1] = local10.alternativa3d::mb * local3;
        casterConst[2] = local10.alternativa3d::mc * local3;
        casterConst[3] = (local10.alternativa3d::md - local7) * local3;
        casterConst[4] = local10.alternativa3d::me * local4;
        casterConst[5] = local10.alternativa3d::mf * local4;
        casterConst[6] = local10.alternativa3d::mg * local4;
        casterConst[7] = (local10.alternativa3d::mh - local8) * local4;
        casterConst[8] = local10.alternativa3d::mi * local5;
        casterConst[9] = local10.alternativa3d::mj * local5;
        casterConst[10] = local10.alternativa3d::mk * local5;
        casterConst[11] = local10.alternativa3d::ml * local5 + local6;
        casterConst[12] = this.alternativa3d::textureScaleU;
        casterConst[13] = this.alternativa3d::textureScaleV;
        casterConst[16] = 2 * this.alternativa3d::textureOffsetU - 1 + this.alternativa3d::textureScaleU;
        casterConst[17] = -(2 * this.alternativa3d::textureOffsetV - 1 + this.alternativa3d::textureScaleV);
        local2.setVertexBufferAt(0,local10.alternativa3d::vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
        local2.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,casterConst,5,false);
        local2.drawTriangles(local10.alternativa3d::indexBuffer,0,local10.alternativa3d::numTriangles);
        local9++;
      }
      this.clampConst[0] = this.alternativa3d::textureOffsetU;
      this.clampConst[1] = this.alternativa3d::textureOffsetV;
      this.clampConst[2] = this.alternativa3d::textureOffsetU + this.alternativa3d::textureScaleU;
      this.clampConst[3] = this.alternativa3d::textureOffsetV + this.alternativa3d::textureScaleV;
    }

    alternativa3d function renderVolume(param1:Camera3D) : void {
      var local2:Device = param1.alternativa3d::device;
      volumeTransformConst[0] = this.light.alternativa3d::ma;
      volumeTransformConst[1] = this.light.alternativa3d::mb;
      volumeTransformConst[2] = this.light.alternativa3d::mc;
      volumeTransformConst[3] = this.light.alternativa3d::md;
      volumeTransformConst[4] = this.light.alternativa3d::me;
      volumeTransformConst[5] = this.light.alternativa3d::mf;
      volumeTransformConst[6] = this.light.alternativa3d::mg;
      volumeTransformConst[7] = this.light.alternativa3d::mh;
      volumeTransformConst[8] = this.light.alternativa3d::mi;
      volumeTransformConst[9] = this.light.alternativa3d::mj;
      volumeTransformConst[10] = this.light.alternativa3d::mk;
      volumeTransformConst[11] = this.light.alternativa3d::ml;
      volumeTransformConst[12] = this.light.boundMaxX - this.light.boundMinX;
      volumeTransformConst[13] = this.light.boundMaxY - this.light.boundMinY;
      volumeTransformConst[14] = this.light.boundMaxZ - this.light.boundMinZ;
      volumeTransformConst[15] = 1;
      volumeTransformConst[16] = this.light.boundMinX;
      volumeTransformConst[17] = this.light.boundMinY;
      volumeTransformConst[18] = this.light.boundMinZ;
      volumeTransformConst[19] = 1;
      local2.setProgram(this.getVolumeProgram());
      local2.setVertexBufferAt(0,volumeVertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
      local2.setProgramConstantsFromVector(Context3DProgramType.VERTEX,11,volumeTransformConst,5,false);
      local2.setProgramConstantsFromVector(Context3DProgramType.VERTEX,16,param1.alternativa3d::projection,1);
      local2.setProgramConstantsFromVector(Context3DProgramType.VERTEX,17,param1.alternativa3d::correction,1);
      local2.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,13,volumeFragmentConst,1);
      local2.drawTriangles(volumeIndexBuffer,0,12);
    }

    alternativa3d function renderReceivers(param1:Camera3D) : void {
      var local21:int = 0;
      var local2:Device = param1.alternativa3d::device;
      var local3:Number = this.light.boundMinZ - this.offset;
      var local4:Number = this.light.boundMaxZ - this.attenuation - local3;
      var local5:Number = this.light.alternativa3d::ima / this.planeSize;
      var local6:Number = this.light.alternativa3d::imb / this.planeSize;
      var local7:Number = this.light.alternativa3d::imc / this.planeSize;
      var local8:Number = (this.light.alternativa3d::imd - this.planeX) / this.planeSize;
      var local9:Number = this.light.alternativa3d::ime / this.planeSize;
      var local10:Number = this.light.alternativa3d::imf / this.planeSize;
      var local11:Number = this.light.alternativa3d::img / this.planeSize;
      var local12:Number = (this.light.alternativa3d::imh - this.planeY) / this.planeSize;
      var local13:Number = this.light.alternativa3d::imi / local4;
      var local14:Number = this.light.alternativa3d::imj / local4;
      var local15:Number = this.light.alternativa3d::imk / local4;
      var local16:Number = (this.light.alternativa3d::iml - local3) / local4;
      this.transformConst[0] = local5 * param1.alternativa3d::gma + local6 * param1.alternativa3d::gme + local7 * param1.alternativa3d::gmi;
      this.transformConst[1] = local5 * param1.alternativa3d::gmb + local6 * param1.alternativa3d::gmf + local7 * param1.alternativa3d::gmj;
      this.transformConst[2] = local5 * param1.alternativa3d::gmc + local6 * param1.alternativa3d::gmg + local7 * param1.alternativa3d::gmk;
      this.transformConst[3] = local5 * param1.alternativa3d::gmd + local6 * param1.alternativa3d::gmh + local7 * param1.alternativa3d::gml + local8;
      this.transformConst[4] = local9 * param1.alternativa3d::gma + local10 * param1.alternativa3d::gme + local11 * param1.alternativa3d::gmi;
      this.transformConst[5] = local9 * param1.alternativa3d::gmb + local10 * param1.alternativa3d::gmf + local11 * param1.alternativa3d::gmj;
      this.transformConst[6] = local9 * param1.alternativa3d::gmc + local10 * param1.alternativa3d::gmg + local11 * param1.alternativa3d::gmk;
      this.transformConst[7] = local9 * param1.alternativa3d::gmd + local10 * param1.alternativa3d::gmh + local11 * param1.alternativa3d::gml + local12;
      this.transformConst[8] = local13 * param1.alternativa3d::gma + local14 * param1.alternativa3d::gme + local15 * param1.alternativa3d::gmi;
      this.transformConst[9] = local13 * param1.alternativa3d::gmb + local14 * param1.alternativa3d::gmf + local15 * param1.alternativa3d::gmj;
      this.transformConst[10] = local13 * param1.alternativa3d::gmc + local14 * param1.alternativa3d::gmg + local15 * param1.alternativa3d::gmk;
      this.transformConst[11] = local13 * param1.alternativa3d::gmd + local14 * param1.alternativa3d::gmh + local15 * param1.alternativa3d::gml + local16;
      this.uvConst[0] = this.alternativa3d::textureScaleU;
      this.uvConst[1] = this.alternativa3d::textureScaleV;
      this.uvConst[4] = this.alternativa3d::textureOffsetU;
      this.uvConst[5] = this.alternativa3d::textureOffsetV;
      var local17:Number = this.nearDistance * param1.shadowsDistanceMultiplier;
      var local18:Number = this.farDistance * param1.shadowsDistanceMultiplier;
      var local19:Number = 1 - (this.minZ - local17) / (local18 - local17);
      if(local19 < 0) {
        local19 = 0;
      }
      if(local19 > 1) {
        local19 = 1;
      }
      this.colorConst[0] = 0;
      this.colorConst[1] = 256;
      this.colorConst[2] = 1;
      this.colorConst[3] = this.attenuation / local4;
      this.colorConst[4] = 0;
      this.colorConst[5] = this.backFadeRange / local4;
      this.colorConst[6] = this.offset / local4;
      this.colorConst[7] = 1;
      this.colorConst[8] = (this.color >> 16 & 0xFF) / 255;
      this.colorConst[9] = (this.color >> 8 & 0xFF) / 255;
      this.colorConst[10] = (this.color & 0xFF) / 255;
      this.colorConst[11] = this.alpha * local19 * param1.shadowsStrength;
      local2.setProgram(this.getReceiverProgram(param1.view.alternativa3d::quality,this.alternativa3d::cameraInside,param1.view.alternativa3d::correction));
      local2.setProgramConstantsFromVector(Context3DProgramType.VERTEX,11,param1.alternativa3d::transform,3);
      local2.setProgramConstantsFromVector(Context3DProgramType.VERTEX,14,param1.alternativa3d::projection,1);
      local2.setProgramConstantsFromVector(Context3DProgramType.VERTEX,15,this.transformConst,3);
      local2.setProgramConstantsFromVector(Context3DProgramType.VERTEX,18,param1.alternativa3d::correction,1);
      local2.setProgramConstantsFromVector(Context3DProgramType.VERTEX,19,this.uvConst,2);
      local2.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,13,this.colorConst,3);
      local2.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,16,this.clampConst,1);
      var local20:int = 0;
      while(local20 < this.alternativa3d::receiversCount) {
        local21 = this.alternativa3d::receiversBuffers[local20];
        local2.setVertexBufferAt(0,param1.alternativa3d::receiversVertexBuffers[local21],0,Context3DVertexBufferFormat.FLOAT_3);
        local2.drawTriangles(param1.alternativa3d::receiversIndexBuffers[local21],this.alternativa3d::receiversFirstIndexes[local20],this.alternativa3d::receiversNumsTriangles[local20]);
        ++param1.alternativa3d::numShadows;
        local20++;
      }
      this.alternativa3d::receiversCount = 0;
    }

    private function getVolumeProgram() : ProgramResource {
      var local2:ByteArray = null;
      var local3:FragmentShader = null;
      var local1:ProgramResource = volumeProgram;
      if(local1 == null) {
        local2 = new ShadowVolumeVertexShader().agalcode;
        local3 = new FragmentShader();
        local3.mov(FragmentShader.oc,FragmentShader.fc[13]);
        local1 = new ProgramResource(local2,local3.agalcode);
        volumeProgram = local1;
      }
      return local1;
    }

    private function getReceiverProgram(param1:Boolean, param2:Boolean, param3:Boolean) : ProgramResource {
      var local6:ByteArray = null;
      var local7:ByteArray = null;
      var local4:int = int(param1) | int(param2) << 1 | int(param3) << 2;
      var local5:ProgramResource = receiverPrograms[local4];
      if(local5 == null) {
        local6 = new ShadowReceiverVertexShader(param3).agalcode;
        local7 = new ShadowReceiverFragmentShader(param1,param2).agalcode;
        local5 = new ProgramResource(local6,local7);
        receiverPrograms[local4] = local5;
      }
      return local5;
    }

    private function cullingInCamera(param1:Camera3D) : Boolean {
      var local3:Boolean = false;
      var local4:Boolean = false;
      var local2:Vertex = this.boundVertexList;
      local2.x = this.light.boundMinX;
      local2.y = this.light.boundMinY;
      local2.z = this.light.boundMinZ;
      local2 = local2.alternativa3d::next;
      local2.x = this.light.boundMaxX;
      local2.y = this.light.boundMinY;
      local2.z = this.light.boundMinZ;
      local2 = local2.alternativa3d::next;
      local2.x = this.light.boundMinX;
      local2.y = this.light.boundMaxY;
      local2.z = this.light.boundMinZ;
      local2 = local2.alternativa3d::next;
      local2.x = this.light.boundMaxX;
      local2.y = this.light.boundMaxY;
      local2.z = this.light.boundMinZ;
      local2 = local2.alternativa3d::next;
      local2.x = this.light.boundMinX;
      local2.y = this.light.boundMinY;
      local2.z = this.light.boundMaxZ;
      local2 = local2.alternativa3d::next;
      local2.x = this.light.boundMaxX;
      local2.y = this.light.boundMinY;
      local2.z = this.light.boundMaxZ;
      local2 = local2.alternativa3d::next;
      local2.x = this.light.boundMinX;
      local2.y = this.light.boundMaxY;
      local2.z = this.light.boundMaxZ;
      local2 = local2.alternativa3d::next;
      local2.x = this.light.boundMaxX;
      local2.y = this.light.boundMaxY;
      local2.z = this.light.boundMaxZ;
      this.minZ = 1e+22;
      local2 = this.boundVertexList;
      while(local2 != null) {
        local2.alternativa3d::cameraX = this.light.alternativa3d::ma * local2.x + this.light.alternativa3d::mb * local2.y + this.light.alternativa3d::mc * local2.z + this.light.alternativa3d::md;
        local2.alternativa3d::cameraY = this.light.alternativa3d::me * local2.x + this.light.alternativa3d::mf * local2.y + this.light.alternativa3d::mg * local2.z + this.light.alternativa3d::mh;
        local2.alternativa3d::cameraZ = this.light.alternativa3d::mi * local2.x + this.light.alternativa3d::mj * local2.y + this.light.alternativa3d::mk * local2.z + this.light.alternativa3d::ml;
        if(local2.alternativa3d::cameraZ < this.minZ) {
          this.minZ = local2.alternativa3d::cameraZ;
        }
        local2 = local2.alternativa3d::next;
      }
      var local5:Number = param1.nearClipping;
      local2 = this.boundVertexList;
      local3 = false;
      local4 = false;
      while(local2 != null) {
        if(local2.alternativa3d::cameraZ > local5) {
          local3 = true;
          if(local4) {
            break;
          }
        } else {
          local4 = true;
          if(local3) {
            break;
          }
        }
        local2 = local2.alternativa3d::next;
      }
      if(local4 && !local3) {
        return false;
      }
      var local6:Number = param1.farClipping;
      local2 = this.boundVertexList;
      local3 = false;
      local4 = false;
      while(local2 != null) {
        if(local2.alternativa3d::cameraZ < local6) {
          local3 = true;
          if(local4) {
            break;
          }
        } else {
          local4 = true;
          if(local3) {
            break;
          }
        }
        local2 = local2.alternativa3d::next;
      }
      if(local4 && !local3) {
        return false;
      }
      local2 = this.boundVertexList;
      local3 = false;
      local4 = false;
      while(local2 != null) {
        if(-local2.alternativa3d::cameraX < local2.alternativa3d::cameraZ) {
          local3 = true;
          if(local4) {
            break;
          }
        } else {
          local4 = true;
          if(local3) {
            break;
          }
        }
        local2 = local2.alternativa3d::next;
      }
      if(local4 && !local3) {
        return false;
      }
      local2 = this.boundVertexList;
      local3 = false;
      local4 = false;
      while(local2 != null) {
        if(local2.alternativa3d::cameraX < local2.alternativa3d::cameraZ) {
          local3 = true;
          if(local4) {
            break;
          }
        } else {
          local4 = true;
          if(local3) {
            break;
          }
        }
        local2 = local2.alternativa3d::next;
      }
      if(local4 && !local3) {
        return false;
      }
      local2 = this.boundVertexList;
      local3 = false;
      local4 = false;
      while(local2 != null) {
        if(-local2.alternativa3d::cameraY < local2.alternativa3d::cameraZ) {
          local3 = true;
          if(local4) {
            break;
          }
        } else {
          local4 = true;
          if(local3) {
            break;
          }
        }
        local2 = local2.alternativa3d::next;
      }
      if(local4 && !local3) {
        return false;
      }
      local2 = this.boundVertexList;
      local3 = false;
      local4 = false;
      while(local2 != null) {
        if(local2.alternativa3d::cameraY < local2.alternativa3d::cameraZ) {
          local3 = true;
          if(local4) {
            break;
          }
        } else {
          local4 = true;
          if(local3) {
            break;
          }
        }
        local2 = local2.alternativa3d::next;
      }
      if(local4 && !local3) {
        return false;
      }
      return true;
    }
  }
}
