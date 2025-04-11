package alternativa.engine3d.loaders {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.FillMaterial;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import flash.geom.Matrix;
  import flash.geom.Vector3D;
  import flash.utils.ByteArray;
  import flash.utils.Endian;

  use namespace alternativa3d;

  public class Parser3DS {
    private static const CHUNK_MAIN:int = 19789;
    private static const CHUNK_VERSION:int = 2;
    private static const CHUNK_SCENE:int = 15677;
    private static const CHUNK_ANIMATION:int = 45056;
    private static const CHUNK_OBJECT:int = 16384;
    private static const CHUNK_TRIMESH:int = 16640;
    private static const CHUNK_VERTICES:int = 16656;
    private static const CHUNK_FACES:int = 16672;
    private static const CHUNK_FACESMATERIAL:int = 16688;
    private static const CHUNK_FACESSMOOTH:int = 16720;
    private static const CHUNK_MAPPINGCOORDS:int = 16704;
    private static const CHUNK_TRANSFORMATION:int = 16736;
    private static const CHUNK_MATERIAL:int = 45055;

    private var data:ByteArray;
    private var objectDatas:Object;
    private var animationDatas:Array;
    private var materialDatas:Object;

    public var objects:Vector.<Object3D>;
    public var parents:Vector.<Object3D>;
    public var materials:Vector.<Material>;
    public var textureMaterials:Vector.<TextureMaterial>;

    public function Parser3DS() {
      super();
    }

    public function getObjectByName(param1:String) : Object3D {
      var local2:Object3D = null;
      for each(local2 in this.objects) {
        if(local2.name == param1) {
          return local2;
        }
      }
      return null;
    }

    public function parse(param1:ByteArray, param2:String = "", param3:Number = 1) : void {
      if(param1.bytesAvailable < 6) {
        return;
      }
      this.data = param1;
      param1.endian = Endian.LITTLE_ENDIAN;
      this.parse3DSChunk(param1.position,param1.bytesAvailable);
      this.objects = new Vector.<Object3D>();
      this.parents = new Vector.<Object3D>();
      this.materials = new Vector.<Material>();
      this.textureMaterials = new Vector.<TextureMaterial>();
      this.buildContent(param2,param3);
      param1 = null;
      this.objectDatas = null;
      this.animationDatas = null;
      this.materialDatas = null;
    }

    private function readChunkInfo(param1:int) : ChunkInfo {
      this.data.position = param1;
      var local2:ChunkInfo = new ChunkInfo();
      local2.id = this.data.readUnsignedShort();
      local2.size = this.data.readUnsignedInt();
      local2.dataSize = local2.size - 6;
      local2.dataPosition = this.data.position;
      local2.nextChunkPosition = param1 + local2.size;
      return local2;
    }

    private function parse3DSChunk(param1:int, param2:int) : void {
      if(param2 < 6) {
        return;
      }
      var local3:ChunkInfo = this.readChunkInfo(param1);
      this.data.position = param1;
      switch(local3.id) {
        case CHUNK_MAIN:
          this.parseMainChunk(local3.dataPosition,local3.dataSize);
      }
      this.parse3DSChunk(local3.nextChunkPosition,param2 - local3.size);
    }

    private function parseMainChunk(param1:int, param2:int) : void {
      if(param2 < 6) {
        return;
      }
      var local3:ChunkInfo = this.readChunkInfo(param1);
      switch(local3.id) {
        case CHUNK_VERSION:
          break;
        case CHUNK_SCENE:
          this.parse3DChunk(local3.dataPosition,local3.dataSize);
          break;
        case CHUNK_ANIMATION:
          this.parseAnimationChunk(local3.dataPosition,local3.dataSize);
      }
      this.parseMainChunk(local3.nextChunkPosition,param2 - local3.size);
    }

    private function parse3DChunk(param1:int, param2:int) : void {
      var local3:ChunkInfo = null;
      var local4:MaterialData = null;
      while(param2 >= 6) {
        local3 = this.readChunkInfo(param1);
        switch(local3.id) {
          case CHUNK_MATERIAL:
            local4 = new MaterialData();
            this.parseMaterialChunk(local4,local3.dataPosition,local3.dataSize);
            break;
          case CHUNK_OBJECT:
            this.parseObject(local3);
            break;
        }
        param1 = local3.nextChunkPosition;
        param2 -= local3.size;
      }
    }

    private function parseObject(param1:ChunkInfo) : void {
      if(this.objectDatas == null) {
        this.objectDatas = new Object();
      }
      var local2:ObjectData = new ObjectData();
      local2.name = this.getString(param1.dataPosition);
      this.objectDatas[local2.name] = local2;
      var local3:int = local2.name.length + 1;
      this.parseObjectChunk(local2,param1.dataPosition + local3,param1.dataSize - local3);
    }

    private function parseObjectChunk(param1:ObjectData, param2:int, param3:int) : void {
      if(param3 < 6) {
        return;
      }
      var local4:ChunkInfo = this.readChunkInfo(param2);
      switch(local4.id) {
        case CHUNK_TRIMESH:
          this.parseMeshChunk(param1,local4.dataPosition,local4.dataSize);
          break;
        case 17920:
        case 18176:
      }
      this.parseObjectChunk(param1,local4.nextChunkPosition,param3 - local4.size);
    }

    private function parseMeshChunk(param1:ObjectData, param2:int, param3:int) : void {
      if(param3 < 6) {
        return;
      }
      var local4:ChunkInfo = this.readChunkInfo(param2);
      switch(local4.id) {
        case CHUNK_VERTICES:
          this.parseVertices(param1);
          break;
        case CHUNK_MAPPINGCOORDS:
          this.parseUVs(param1);
          break;
        case CHUNK_TRANSFORMATION:
          this.parseMatrix(param1);
          break;
        case CHUNK_FACES:
          this.parseFaces(param1,local4);
      }
      this.parseMeshChunk(param1,local4.nextChunkPosition,param3 - local4.size);
    }

    private function parseVertices(param1:ObjectData) : void {
      var local2:int = int(this.data.readUnsignedShort());
      param1.vertices = new Vector.<Number>();
      var local3:int = 0;
      var local4:int = 0;
      while(local3 < local2) {
        var local5:* = local4++;
        param1.vertices[local5] = this.data.readFloat();
        var local6:* = local4++;
        param1.vertices[local6] = this.data.readFloat();
        var local7:* = local4++;
        param1.vertices[local7] = this.data.readFloat();
        local3++;
      }
    }

    private function parseUVs(param1:ObjectData) : void {
      var local2:int = int(this.data.readUnsignedShort());
      param1.uvs = new Vector.<Number>();
      var local3:int = 0;
      var local4:int = 0;
      while(local3 < local2) {
        var local5:* = local4++;
        param1.uvs[local5] = this.data.readFloat();
        var local6:* = local4++;
        param1.uvs[local6] = this.data.readFloat();
        local3++;
      }
    }

    private function parseMatrix(param1:ObjectData) : void {
      param1.a = this.data.readFloat();
      param1.e = this.data.readFloat();
      param1.i = this.data.readFloat();
      param1.b = this.data.readFloat();
      param1.f = this.data.readFloat();
      param1.j = this.data.readFloat();
      param1.c = this.data.readFloat();
      param1.g = this.data.readFloat();
      param1.k = this.data.readFloat();
      param1.d = this.data.readFloat();
      param1.h = this.data.readFloat();
      param1.l = this.data.readFloat();
    }

    private function parseFaces(param1:ObjectData, param2:ChunkInfo) : void {
      var local3:int = int(this.data.readUnsignedShort());
      param1.faces = new Vector.<int>(local3 * 3);
      param1.smoothingGroups = new Vector.<uint>(local3);
      var local4:int = 0;
      var local5:int = 0;
      while(local4 < local3) {
        var local7:* = local5++;
        param1.faces[local7] = this.data.readUnsignedShort();
        var local8:* = local5++;
        param1.faces[local8] = this.data.readUnsignedShort();
        var local9:* = local5++;
        param1.faces[local9] = this.data.readUnsignedShort();
        this.data.position += 2;
        local4++;
      }
      var local6:int = 2 + 8 * local3;
      this.parseFacesChunk(param1,param2.dataPosition + local6,param2.dataSize - local6);
    }

    private function parseFacesChunk(param1:ObjectData, param2:int, param3:int) : void {
      if(param3 < 6) {
        return;
      }
      var local4:ChunkInfo = this.readChunkInfo(param2);
      switch(local4.id) {
        case CHUNK_FACESMATERIAL:
          this.parseSurface(param1);
          break;
        case CHUNK_FACESSMOOTH:
          this.parseSmoothingGroups(param1);
      }
      this.parseFacesChunk(param1,local4.nextChunkPosition,param3 - local4.size);
    }

    private function parseSurface(param1:ObjectData) : void {
      if(param1.surfaces == null) {
        param1.surfaces = new Object();
      }
      var local2:Vector.<int> = new Vector.<int>();
      param1.surfaces[this.getString(this.data.position)] = local2;
      var local3:int = int(this.data.readUnsignedShort());
      var local4:int = 0;
      while(local4 < local3) {
        local2[local4] = this.data.readUnsignedShort();
        local4++;
      }
    }

    private function parseSmoothingGroups(param1:ObjectData) : void {
      var local2:int = param1.faces.length / 3;
      var local3:int = 0;
      while(local3 < local2) {
        param1.smoothingGroups[local3] = this.data.readUnsignedInt();
        local3++;
      }
    }

    private function parseAnimationChunk(param1:int, param2:int) : void {
      var local3:ChunkInfo = null;
      var local4:AnimationData = null;
      while(param2 >= 6) {
        local3 = this.readChunkInfo(param1);
        switch(local3.id) {
          case 45057:
          case 45058:
          case 45059:
          case 45060:
          case 45061:
          case 45062:
          case 45063:
            if(this.animationDatas == null) {
              this.animationDatas = new Array();
            }
            local4 = new AnimationData();
            this.animationDatas.push(local4);
            this.parseObjectAnimationChunk(local4,local3.dataPosition,local3.dataSize);
            break;
          case 45064:
            break;
        }
        param1 = local3.nextChunkPosition;
        param2 -= local3.size;
      }
    }

    private function parseObjectAnimationChunk(param1:AnimationData, param2:int, param3:int) : void {
      if(param3 < 6) {
        return;
      }
      var local4:ChunkInfo = this.readChunkInfo(param2);
      switch(local4.id) {
        case 45072:
          param1.objectName = this.getString(this.data.position);
          this.data.position += 4;
          param1.parentIndex = this.data.readUnsignedShort();
          break;
        case 45073:
          param1.objectName = this.getString(this.data.position);
          break;
        case 45075:
          param1.pivot = new Vector3D(this.data.readFloat(),this.data.readFloat(),this.data.readFloat());
          break;
        case 45088:
          this.data.position += 20;
          param1.position = new Vector3D(this.data.readFloat(),this.data.readFloat(),this.data.readFloat());
          break;
        case 45089:
          this.data.position += 20;
          param1.rotation = this.getRotationFrom3DSAngleAxis(this.data.readFloat(),this.data.readFloat(),this.data.readFloat(),this.data.readFloat());
          break;
        case 45090:
          this.data.position += 20;
          param1.scale = new Vector3D(this.data.readFloat(),this.data.readFloat(),this.data.readFloat());
      }
      this.parseObjectAnimationChunk(param1,local4.nextChunkPosition,param3 - local4.size);
    }

    private function parseMaterialChunk(param1:MaterialData, param2:int, param3:int) : void {
      if(param3 < 6) {
        return;
      }
      var local4:ChunkInfo = this.readChunkInfo(param2);
      switch(local4.id) {
        case 40960:
          this.parseMaterialName(param1);
          break;
        case 40976:
          break;
        case 40992:
          this.data.position = local4.dataPosition + 6;
          param1.color = (this.data.readUnsignedByte() << 16) + (this.data.readUnsignedByte() << 8) + this.data.readUnsignedByte();
          break;
        case 41008:
          break;
        case 41024:
          this.data.position = local4.dataPosition + 6;
          param1.glossiness = this.data.readUnsignedShort();
          break;
        case 41025:
          this.data.position = local4.dataPosition + 6;
          param1.specular = this.data.readUnsignedShort();
          break;
        case 41040:
          this.data.position = local4.dataPosition + 6;
          param1.transparency = this.data.readUnsignedShort();
          break;
        case 41472:
          param1.diffuseMap = new MapData();
          this.parseMapChunk(param1.name,param1.diffuseMap,local4.dataPosition,local4.dataSize);
          break;
        case 41786:
          break;
        case 41488:
          param1.opacityMap = new MapData();
          this.parseMapChunk(param1.name,param1.opacityMap,local4.dataPosition,local4.dataSize);
          break;
        case 41520:
        case 41788:
        case 41476:
        case 41789:
        case 41504:
      }
      this.parseMaterialChunk(param1,local4.nextChunkPosition,param3 - local4.size);
    }

    private function parseMaterialName(param1:MaterialData) : void {
      if(this.materialDatas == null) {
        this.materialDatas = new Object();
      }
      param1.name = this.getString(this.data.position);
      this.materialDatas[param1.name] = param1;
    }

    private function parseMapChunk(param1:String, param2:MapData, param3:int, param4:int) : void {
      if(param4 < 6) {
        return;
      }
      var local5:ChunkInfo = this.readChunkInfo(param3);
      switch(local5.id) {
        case 41728:
          param2.filename = this.getString(local5.dataPosition).toLowerCase();
          break;
        case 41809:
          break;
        case 41812:
          param2.scaleU = this.data.readFloat();
          break;
        case 41814:
          param2.scaleV = this.data.readFloat();
          break;
        case 41816:
          param2.offsetU = this.data.readFloat();
          break;
        case 41818:
          param2.offsetV = this.data.readFloat();
          break;
        case 41820:
          param2.rotation = this.data.readFloat();
      }
      this.parseMapChunk(param1,param2,local5.nextChunkPosition,param4 - local5.size);
    }

    private function buildContent(param1:String, param2:Number) : void {
      var local3:String = null;
      var local4:String = null;
      var local5:ObjectData = null;
      var local6:Object3D = null;
      var local7:MaterialData = null;
      var local8:MapData = null;
      var local9:Matrix = null;
      var local10:Number = NaN;
      var local11:TextureMaterial = null;
      var local12:FillMaterial = null;
      var local13:int = 0;
      var local14:int = 0;
      var local15:AnimationData = null;
      var local16:int = 0;
      var local17:int = 0;
      var local18:AnimationData = null;
      var local19:ObjectData = null;
      var local20:String = null;
      for(local3 in this.materialDatas) {
        local7 = this.materialDatas[local3];
        local8 = local7.diffuseMap;
        if(local8 != null) {
          local9 = new Matrix();
          local10 = local8.rotation * Math.PI / 180;
          local9.translate(-local8.offsetU,local8.offsetV);
          local9.translate(-0.5,-0.5);
          local9.rotate(-local10);
          local9.scale(local8.scaleU,local8.scaleV);
          local9.translate(0.5,0.5);
          local7.matrix = local9;
          local11 = new TextureMaterial();
          local11.name = local3;
          local11.diffuseMapURL = param1 + local8.filename;
          local11.opacityMapURL = local7.opacityMap != null ? param1 + local7.opacityMap.filename : null;
          local7.material = local11;
          local11.name = local7.name;
          this.textureMaterials.push(local11);
        } else {
          local12 = new FillMaterial(local7.color);
          local7.material = local12;
          local12.name = local7.name;
        }
        this.materials.push(local7.material);
      }
      if(this.animationDatas != null) {
        if(this.objectDatas != null) {
          local14 = int(this.animationDatas.length);
          local13 = 0;
          while(local13 < local14) {
            local15 = this.animationDatas[local13];
            local4 = local15.objectName;
            local5 = this.objectDatas[local4];
            if(local5 != null) {
              local16 = local13 + 1;
              local17 = 1;
              while(local16 < local14) {
                local18 = this.animationDatas[local16];
                if(!local18.isInstance && local4 == local18.objectName) {
                  local19 = new ObjectData();
                  local20 = local4 + local17++;
                  local19.name = local20;
                  this.objectDatas[local20] = local19;
                  local18.objectName = local20;
                  local19.vertices = local5.vertices;
                  local19.uvs = local5.uvs;
                  local19.faces = local5.faces;
                  local19.smoothingGroups = local5.smoothingGroups;
                  local19.surfaces = local5.surfaces;
                  local19.a = local5.a;
                  local19.b = local5.b;
                  local19.c = local5.c;
                  local19.d = local5.d;
                  local19.e = local5.e;
                  local19.f = local5.f;
                  local19.g = local5.g;
                  local19.h = local5.h;
                  local19.i = local5.i;
                  local19.j = local5.j;
                  local19.k = local5.k;
                  local19.l = local5.l;
                }
                local16++;
              }
            }
            if(local5 != null && local5.vertices != null) {
              local6 = new Mesh();
              this.buildMesh(local6 as Mesh,local5,local15,param2);
            } else {
              local6 = new Object3D();
            }
            local6.name = local4;
            local15.object = local6;
            if(local15.position != null) {
              local6.x = local15.position.x * param2;
              local6.y = local15.position.y * param2;
              local6.z = local15.position.z * param2;
            }
            if(local15.rotation != null) {
              local6.rotationX = local15.rotation.x;
              local6.rotationY = local15.rotation.y;
              local6.rotationZ = local15.rotation.z;
            }
            if(local15.scale != null) {
              local6.scaleX = local15.scale.x;
              local6.scaleY = local15.scale.y;
              local6.scaleZ = local15.scale.z;
            }
            local13++;
          }
          local13 = 0;
          while(local13 < local14) {
            local15 = this.animationDatas[local13];
            this.objects.push(local15.object);
            this.parents.push(local15.parentIndex == 65535 ? null : AnimationData(this.animationDatas[local15.parentIndex]).object);
            local13++;
          }
        }
      } else {
        for(local4 in this.objectDatas) {
          local5 = this.objectDatas[local4];
          if(local5.vertices != null) {
            local6 = new Mesh();
            local6.name = local4;
            this.buildMesh(local6 as Mesh,local5,null,param2);
            this.objects.push(local6);
            this.parents.push(null);
          }
        }
      }
    }

    private function buildMesh(param1:Mesh, param2:ObjectData, param3:AnimationData, param4:Number) : void {
      var local9:int = 0;
      var local10:int = 0;
      var local11:Face = null;
      var local12:Vertex = null;
      var local14:int = 0;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local28:Boolean = false;
      var local29:Number = NaN;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Face = null;
      var local33:String = null;
      var local34:Vector.<int> = null;
      var local35:MaterialData = null;
      var local36:Material = null;
      var local37:Wrapper = null;
      var local38:Number = NaN;
      var local39:Number = NaN;
      var local5:Vector.<Vertex> = new Vector.<Vertex>();
      var local6:Vector.<Face> = new Vector.<Face>();
      var local7:int = 0;
      var local8:int = 0;
      var local13:Boolean = false;
      if(param3 != null) {
        local15 = param2.a;
        local16 = param2.b;
        local17 = param2.c;
        local18 = param2.d;
        local19 = param2.e;
        local20 = param2.f;
        local21 = param2.g;
        local22 = param2.h;
        local23 = param2.i;
        local24 = param2.j;
        local25 = param2.k;
        local26 = param2.l;
        local27 = 1 / (-local17 * local20 * local23 + local16 * local21 * local23 + local17 * local19 * local24 - local15 * local21 * local24 - local16 * local19 * local25 + local15 * local20 * local25);
        param2.a = (-local21 * local24 + local20 * local25) * local27;
        param2.b = (local17 * local24 - local16 * local25) * local27;
        param2.c = (-local17 * local20 + local16 * local21) * local27;
        param2.d = (local18 * local21 * local24 - local17 * local22 * local24 - local18 * local20 * local25 + local16 * local22 * local25 + local17 * local20 * local26 - local16 * local21 * local26) * local27;
        param2.e = (local21 * local23 - local19 * local25) * local27;
        param2.f = (-local17 * local23 + local15 * local25) * local27;
        param2.g = (local17 * local19 - local15 * local21) * local27;
        param2.h = (local17 * local22 * local23 - local18 * local21 * local23 + local18 * local19 * local25 - local15 * local22 * local25 - local17 * local19 * local26 + local15 * local21 * local26) * local27;
        param2.i = (-local20 * local23 + local19 * local24) * local27;
        param2.j = (local16 * local23 - local15 * local24) * local27;
        param2.k = (-local16 * local19 + local15 * local20) * local27;
        param2.l = (local18 * local20 * local23 - local16 * local22 * local23 - local18 * local19 * local24 + local15 * local22 * local24 + local16 * local19 * local26 - local15 * local20 * local26) * local27;
        if(param3.pivot != null) {
          param2.d -= param3.pivot.x;
          param2.h -= param3.pivot.y;
          param2.l -= param3.pivot.z;
        }
        local13 = true;
      }
      if(param2.vertices != null) {
        local28 = param2.uvs != null && param2.uvs.length > 0;
        local9 = 0;
        local10 = 0;
        local14 = int(param2.vertices.length);
        while(local9 < local14) {
          local12 = new Vertex();
          if(local13) {
            local29 = param2.vertices[local9++];
            local30 = param2.vertices[local9++];
            local31 = param2.vertices[local9++];
            local12.x = param2.a * local29 + param2.b * local30 + param2.c * local31 + param2.d;
            local12.y = param2.e * local29 + param2.f * local30 + param2.g * local31 + param2.h;
            local12.z = param2.i * local29 + param2.j * local30 + param2.k * local31 + param2.l;
          } else {
            local12.x = param2.vertices[local9++];
            local12.y = param2.vertices[local9++];
            local12.z = param2.vertices[local9++];
          }
          local12.x *= param4;
          local12.y *= param4;
          local12.z *= param4;
          if(local28) {
            local12.u = param2.uvs[local10++];
            local12.v = 1 - param2.uvs[local10++];
          }
          local12.alternativa3d::transformId = -1;
          var local40:* = local7++;
          local5[local40] = local12;
          local12.alternativa3d::next = param1.alternativa3d::vertexList;
          param1.alternativa3d::vertexList = local12;
        }
      }
      if(param2.faces != null) {
        local9 = 0;
        local10 = 0;
        local14 = int(param2.faces.length);
        while(local9 < local14) {
          local11 = new Face();
          local11.alternativa3d::wrapper = new Wrapper();
          local11.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
          local11.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
          local11.alternativa3d::wrapper.alternativa3d::vertex = local5[param2.faces[local9++]];
          local11.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = local5[param2.faces[local9++]];
          local11.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local5[param2.faces[local9++]];
          local11.smoothingGroups = param2.smoothingGroups[local10++];
          local40 = local8++;
          local6[local40] = local11;
          if(local32 != null) {
            local32.alternativa3d::next = local11;
          } else {
            param1.alternativa3d::faceList = local11;
          }
          local32 = local11;
        }
      }
      if(param2.surfaces != null) {
        for(local33 in param2.surfaces) {
          local34 = param2.surfaces[local33];
          local35 = this.materialDatas[local33];
          local36 = local35.material;
          local9 = 0;
          while(local9 < local34.length) {
            local11 = local6[local34[local9]];
            local11.material = local36;
            if(local35.matrix != null) {
              local37 = local11.alternativa3d::wrapper;
              while(local37 != null) {
                local12 = local37.alternativa3d::vertex;
                if(local12.alternativa3d::transformId < 0) {
                  local38 = local12.u;
                  local39 = local12.v;
                  local12.u = local35.matrix.a * local38 + local35.matrix.b * local39 + local35.matrix.tx;
                  local12.v = local35.matrix.c * local38 + local35.matrix.d * local39 + local35.matrix.ty;
                  local12.alternativa3d::transformId = 0;
                }
                local37 = local37.alternativa3d::next;
              }
            }
            local9++;
          }
        }
      }
      param1.calculateFacesNormals(true);
      param1.calculateBounds();
    }

    private function getString(param1:int) : String {
      var local2:int = 0;
      this.data.position = param1;
      var local3:String = "";
      while(true) {
        local2 = this.data.readByte();
        if(local2 == 0) {
          break;
        }
        local3 += String.fromCharCode(local2);
      }
      return local3;
    }

    private function getRotationFrom3DSAngleAxis(param1:Number, param2:Number, param3:Number, param4:Number) : Vector3D {
      var local10:Number = NaN;
      var local5:Vector3D = new Vector3D();
      var local6:Number = Math.sin(param1);
      var local7:Number = Math.cos(param1);
      var local8:Number = 1 - local7;
      var local9:Number = param2 * param4 * local8 + param3 * local6;
      if(local9 >= 1) {
        local10 = param1 / 2;
        local5.z = -2 * Math.atan2(param2 * Math.sin(local10),Math.cos(local10));
        local5.y = -Math.PI / 2;
        local5.x = 0;
        return local5;
      }
      if(local9 <= -1) {
        local10 = param1 / 2;
        local5.z = 2 * Math.atan2(param2 * Math.sin(local10),Math.cos(local10));
        local5.y = Math.PI / 2;
        local5.x = 0;
        return local5;
      }
      local5.z = -Math.atan2(param4 * local6 - param2 * param3 * local8,1 - (param4 * param4 + param3 * param3) * local8);
      local5.y = -Math.asin(param2 * param4 * local8 + param3 * local6);
      local5.x = -Math.atan2(param2 * local6 - param4 * param3 * local8,1 - (param2 * param2 + param3 * param3) * local8);
      return local5;
    }
  }
}

import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.materials.Material;
import flash.geom.Matrix;
import flash.geom.Vector3D;
class MaterialData {
  public var name:String;
  public var color:int;
  public var specular:int;
  public var glossiness:int;
  public var transparency:int;
  public var diffuseMap:MapData;
  public var opacityMap:MapData;
  public var matrix:Matrix;
  public var material:Material;

  public function MaterialData() {
    super();
  }
}

class MapData {
  public var filename:String;
  public var scaleU:Number = 1;
  public var scaleV:Number = 1;
  public var offsetU:Number = 0;
  public var offsetV:Number = 0;
  public var rotation:Number = 0;

  public function MapData() {
    super();
  }
}

class ObjectData {
  public var name:String;
  public var vertices:Vector.<Number>;
  public var uvs:Vector.<Number>;
  public var faces:Vector.<int>;
  public var smoothingGroups:Vector.<uint>;
  public var surfaces:Object;
  public var a:Number;
  public var b:Number;
  public var c:Number;
  public var d:Number;
  public var e:Number;
  public var f:Number;
  public var g:Number;
  public var h:Number;
  public var i:Number;
  public var j:Number;
  public var k:Number;
  public var l:Number;

  public function ObjectData() {
    super();
  }
}

class AnimationData {
  public var objectName:String;
  public var object:Object3D;
  public var parentIndex:int;
  public var pivot:Vector3D;
  public var position:Vector3D;
  public var rotation:Vector3D;
  public var scale:Vector3D;
  public var isInstance:Boolean;

  public function AnimationData() {
    super();
  }
}

class ChunkInfo {
  public var id:int;
  public var size:int;
  public var dataSize:int;
  public var dataPosition:int;
  public var nextChunkPosition:int;

  public function ChunkInfo() {
    super();
  }
}
