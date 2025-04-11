package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.RayIntersectionData;
  import alternativa.engine3d.core.VG;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import flash.geom.Matrix3D;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class Mesh extends Object3D {
    public var clipping:int = 2;
    public var sorting:int = 1;
    public var threshold:Number = 0.01;

    alternativa3d var vertexList:Vertex;
    alternativa3d var faceList:Face;

    public function Mesh() {
      super();
    }

    public static function calculateVerticesNormalsBySmoothingGroupsForMeshList(param1:Vector.<Object3D>, param2:Number = 0) : void {
    }

    public function updateUVsBuffer() : void {
    }

    public function addVertex(param1:Number, param2:Number, param3:Number, param4:Number = 0, param5:Number = 0, param6:Object = null) : Vertex {
      var local7:Vertex = null;
      var local8:Vertex = null;
      local7 = new Vertex();
      local7.x = param1;
      local7.y = param2;
      local7.z = param3;
      local7.u = param4;
      local7.v = param5;
      local7.id = param6;
      if(this.alternativa3d::vertexList != null) {
        local8 = this.alternativa3d::vertexList;
        while(local8.alternativa3d::next != null) {
          local8 = local8.alternativa3d::next;
        }
        local8.alternativa3d::next = local7;
      } else {
        this.alternativa3d::vertexList = local7;
      }
      return local7;
    }

    public function removeVertex(param1:Vertex) : Vertex {
      var local3:Vertex = null;
      var local5:Face = null;
      var local6:Face = null;
      var local7:Wrapper = null;
      if(param1 == null) {
        throw new TypeError("Parameter vertex must be non-null.");
      }
      var local2:Vertex = this.alternativa3d::vertexList;
      while(local2 != null) {
        if(local2 == param1) {
          if(local3 != null) {
            local3.alternativa3d::next = local2.alternativa3d::next;
          } else {
            this.alternativa3d::vertexList = local2.alternativa3d::next;
          }
          local2.alternativa3d::next = null;
          break;
        }
        local3 = local2;
        local2 = local2.alternativa3d::next;
      }
      if(local2 == null) {
        throw new ArgumentError("Vertex not found.");
      }
      var local4:Face = this.alternativa3d::faceList;
      while(local4 != null) {
        local6 = local4.alternativa3d::next;
        local7 = local4.alternativa3d::wrapper;
        while(local7 != null) {
          if(local7.alternativa3d::vertex == local2) {
            break;
          }
          local7 = local7.alternativa3d::next;
        }
        if(local7 != null) {
          if(local5 != null) {
            local5.alternativa3d::next = local6;
          } else {
            this.alternativa3d::faceList = local6;
          }
          local4.alternativa3d::next = null;
        } else {
          local5 = local4;
        }
        local4 = local6;
      }
      return local2;
    }

    public function removeVertexById(param1:Object) : Vertex {
      var local3:Vertex = null;
      var local5:Face = null;
      var local6:Face = null;
      var local7:Wrapper = null;
      if(param1 == null) {
        throw new TypeError("Parameter id must be non-null.");
      }
      var local2:Vertex = this.alternativa3d::vertexList;
      while(local2 != null) {
        if(local2.id == param1) {
          if(local3 != null) {
            local3.alternativa3d::next = local2.alternativa3d::next;
          } else {
            this.alternativa3d::vertexList = local2.alternativa3d::next;
          }
          local2.alternativa3d::next = null;
          break;
        }
        local3 = local2;
        local2 = local2.alternativa3d::next;
      }
      if(local2 == null) {
        throw new ArgumentError("Vertex not found.");
      }
      var local4:Face = this.alternativa3d::faceList;
      while(local4 != null) {
        local6 = local4.alternativa3d::next;
        local7 = local4.alternativa3d::wrapper;
        while(local7 != null) {
          if(local7.alternativa3d::vertex == local2) {
            break;
          }
          local7 = local7.alternativa3d::next;
        }
        if(local7 != null) {
          if(local5 != null) {
            local5.alternativa3d::next = local6;
          } else {
            this.alternativa3d::faceList = local6;
          }
          local4.alternativa3d::next = null;
        } else {
          local5 = local4;
        }
        local4 = local6;
      }
      return local2;
    }

    public function containsVertex(param1:Vertex) : Boolean {
      if(param1 == null) {
        throw new TypeError("Parameter vertex must be non-null.");
      }
      var local2:Vertex = this.alternativa3d::vertexList;
      while(local2 != null) {
        if(local2 == param1) {
          return true;
        }
        local2 = local2.alternativa3d::next;
      }
      return false;
    }

    public function containsVertexWithId(param1:Object) : Boolean {
      if(param1 == null) {
        throw new TypeError("Parameter id must be non-null.");
      }
      var local2:Vertex = this.alternativa3d::vertexList;
      while(local2 != null) {
        if(local2.id == param1) {
          return true;
        }
        local2 = local2.alternativa3d::next;
      }
      return false;
    }

    public function getVertexById(param1:Object) : Vertex {
      if(param1 == null) {
        throw new TypeError("Parameter id must be non-null.");
      }
      var local2:Vertex = this.alternativa3d::vertexList;
      while(local2 != null) {
        if(local2.id == param1) {
          return local2;
        }
        local2 = local2.alternativa3d::next;
      }
      return null;
    }

    public function addFace(param1:Vector.<Vertex>, param2:Material = null, param3:Object = null) : Face {
      var local8:Wrapper = null;
      var local9:Vertex = null;
      var local10:Face = null;
      if(param1 == null) {
        throw new TypeError("Parameter vertices must be non-null.");
      }
      var local4:int = int(param1.length);
      if(local4 < 3) {
        throw new ArgumentError(local4 + " vertices not enough.");
      }
      var local5:Face = new Face();
      local5.material = param2;
      local5.id = param3;
      var local6:Wrapper = null;
      var local7:int = 0;
      while(local7 < local4) {
        local8 = new Wrapper();
        local9 = param1[local7];
        if(local9 == null) {
          throw new ArgumentError("Null vertex in vector.");
        }
        if(!this.containsVertex(local9)) {
          throw new ArgumentError("Vertex not found.");
        }
        local8.alternativa3d::vertex = local9;
        if(local6 != null) {
          local6.alternativa3d::next = local8;
        } else {
          local5.alternativa3d::wrapper = local8;
        }
        local6 = local8;
        local7++;
      }
      if(this.alternativa3d::faceList != null) {
        local10 = this.alternativa3d::faceList;
        while(local10.alternativa3d::next != null) {
          local10 = local10.alternativa3d::next;
        }
        local10.alternativa3d::next = local5;
      } else {
        this.alternativa3d::faceList = local5;
      }
      return local5;
    }

    public function addFaceByIds(param1:Array, param2:Material = null, param3:Object = null) : Face {
      var local8:Wrapper = null;
      var local9:Vertex = null;
      var local10:Face = null;
      if(param1 == null) {
        throw new TypeError("Parameter vertices must be non-null.");
      }
      var local4:int = int(param1.length);
      if(local4 < 3) {
        throw new ArgumentError(local4 + " vertices not enough.");
      }
      var local5:Face = new Face();
      local5.material = param2;
      local5.id = param3;
      var local6:Wrapper = null;
      var local7:int = 0;
      while(local7 < local4) {
        local8 = new Wrapper();
        local9 = this.getVertexById(param1[local7]);
        if(local9 == null) {
          throw new ArgumentError("Vertex not found.");
        }
        local8.alternativa3d::vertex = local9;
        if(local6 != null) {
          local6.alternativa3d::next = local8;
        } else {
          local5.alternativa3d::wrapper = local8;
        }
        local6 = local8;
        local7++;
      }
      if(this.alternativa3d::faceList != null) {
        local10 = this.alternativa3d::faceList;
        while(local10.alternativa3d::next != null) {
          local10 = local10.alternativa3d::next;
        }
        local10.alternativa3d::next = local5;
      } else {
        this.alternativa3d::faceList = local5;
      }
      return local5;
    }

    public function addTriFace(param1:Vertex, param2:Vertex, param3:Vertex, param4:Material = null, param5:Object = null) : Face {
      var local7:Face = null;
      if(param1 == null) {
        throw new TypeError("Parameter v1 must be non-null.");
      }
      if(param2 == null) {
        throw new TypeError("Parameter v2 must be non-null.");
      }
      if(param3 == null) {
        throw new TypeError("Parameter v3 must be non-null.");
      }
      if(!this.containsVertex(param1)) {
        throw new ArgumentError("Vertex not found.");
      }
      if(!this.containsVertex(param2)) {
        throw new ArgumentError("Vertex not found.");
      }
      if(!this.containsVertex(param3)) {
        throw new ArgumentError("Vertex not found.");
      }
      var local6:Face = new Face();
      local6.material = param4;
      local6.id = param5;
      local6.alternativa3d::wrapper = new Wrapper();
      local6.alternativa3d::wrapper.alternativa3d::vertex = param1;
      local6.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
      local6.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = param2;
      local6.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
      local6.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = param3;
      if(this.alternativa3d::faceList != null) {
        local7 = this.alternativa3d::faceList;
        while(local7.alternativa3d::next != null) {
          local7 = local7.alternativa3d::next;
        }
        local7.alternativa3d::next = local6;
      } else {
        this.alternativa3d::faceList = local6;
      }
      return local6;
    }

    public function addQuadFace(param1:Vertex, param2:Vertex, param3:Vertex, param4:Vertex, param5:Material = null, param6:Object = null) : Face {
      var local8:Face = null;
      if(param1 == null) {
        throw new TypeError("Parameter v1 must be non-null.");
      }
      if(param2 == null) {
        throw new TypeError("Parameter v2 must be non-null.");
      }
      if(param3 == null) {
        throw new TypeError("Parameter v3 must be non-null.");
      }
      if(param4 == null) {
        throw new TypeError("Parameter v4 must be non-null.");
      }
      if(!this.containsVertex(param1)) {
        throw new ArgumentError("Vertex not found.");
      }
      if(!this.containsVertex(param2)) {
        throw new ArgumentError("Vertex not found.");
      }
      if(!this.containsVertex(param3)) {
        throw new ArgumentError("Vertex not found.");
      }
      if(!this.containsVertex(param4)) {
        throw new ArgumentError("Vertex not found.");
      }
      var local7:Face = new Face();
      local7.material = param5;
      local7.id = param6;
      local7.alternativa3d::wrapper = new Wrapper();
      local7.alternativa3d::wrapper.alternativa3d::vertex = param1;
      local7.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
      local7.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = param2;
      local7.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
      local7.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = param3;
      local7.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next = new Wrapper();
      local7.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = param4;
      if(this.alternativa3d::faceList != null) {
        local8 = this.alternativa3d::faceList;
        while(local8.alternativa3d::next != null) {
          local8 = local8.alternativa3d::next;
        }
        local8.alternativa3d::next = local7;
      } else {
        this.alternativa3d::faceList = local7;
      }
      return local7;
    }

    public function removeFace(param1:Face) : Face {
      var local3:Face = null;
      if(param1 == null) {
        throw new TypeError("Parameter face must be non-null.");
      }
      var local2:Face = this.alternativa3d::faceList;
      while(local2 != null) {
        if(local2 == param1) {
          if(local3 != null) {
            local3.alternativa3d::next = local2.alternativa3d::next;
          } else {
            this.alternativa3d::faceList = local2.alternativa3d::next;
          }
          local2.alternativa3d::next = null;
          break;
        }
        local3 = local2;
        local2 = local2.alternativa3d::next;
      }
      if(local2 == null) {
        throw new ArgumentError("Face not found.");
      }
      return local2;
    }

    public function removeFaceById(param1:Object) : Face {
      var local3:Face = null;
      if(param1 == null) {
        throw new TypeError("Parameter id must be non-null.");
      }
      var local2:Face = this.alternativa3d::faceList;
      while(local2 != null) {
        if(local2.id == param1) {
          if(local3 != null) {
            local3.alternativa3d::next = local2.alternativa3d::next;
          } else {
            this.alternativa3d::faceList = local2.alternativa3d::next;
          }
          local2.alternativa3d::next = null;
          break;
        }
        local3 = local2;
        local2 = local2.alternativa3d::next;
      }
      if(local2 == null) {
        throw new ArgumentError("Face not found.");
      }
      return local2;
    }

    public function containsFace(param1:Face) : Boolean {
      if(param1 == null) {
        throw new TypeError("Parameter face must be non-null.");
      }
      var local2:Face = this.alternativa3d::faceList;
      while(local2 != null) {
        if(local2 == param1) {
          return true;
        }
        local2 = local2.alternativa3d::next;
      }
      return false;
    }

    public function containsFaceWithId(param1:Object) : Boolean {
      if(param1 == null) {
        throw new TypeError("Parameter id must be non-null.");
      }
      var local2:Face = this.alternativa3d::faceList;
      while(local2 != null) {
        if(local2.id == param1) {
          return true;
        }
        local2 = local2.alternativa3d::next;
      }
      return false;
    }

    public function getFaceById(param1:Object) : Face {
      if(param1 == null) {
        throw new TypeError("Parameter id must be non-null.");
      }
      var local2:Face = this.alternativa3d::faceList;
      while(local2 != null) {
        if(local2.id == param1) {
          return local2;
        }
        local2 = local2.alternativa3d::next;
      }
      return null;
    }

    public function addVerticesAndFaces(param1:Vector.<Number>, param2:Vector.<Number>, param3:Vector.<int>, param4:Boolean = false, param5:Material = null) : void {
      var local6:int = 0;
      var local7:int = 0;
      var local8:int = 0;
      var local11:Vertex = null;
      var local13:Face = null;
      var local14:Face = null;
      var local15:Wrapper = null;
      var local16:int = 0;
      var local17:int = 0;
      var local18:Vertex = null;
      var local19:Wrapper = null;
      if(param1 == null) {
        throw new TypeError("Parameter vertices must be non-null.");
      }
      if(param2 == null) {
        throw new TypeError("Parameter uvs must be non-null.");
      }
      if(param3 == null) {
        throw new TypeError("Parameter indices must be non-null.");
      }
      var local9:int = param1.length / 3;
      if(local9 != param2.length / 2) {
        throw new ArgumentError("Vertices count and uvs count doesn\'t match.");
      }
      var local10:int = int(param3.length);
      if(!param4 && Boolean(local10 % 3)) {
        throw new ArgumentError("Incorrect indices.");
      }
      local6 = 0;
      local8 = 0;
      while(local6 < local10) {
        if(local6 == local8) {
          local17 = param4 ? param3[local6] : 3;
          if(local17 < 3) {
            throw new ArgumentError(local17 + " vertices not enough.");
          }
          local8 = param4 ? local17 + ++local6 : local6 + local17;
          if(local8 > local10) {
            throw new ArgumentError("Incorrect indices.");
          }
        }
        local16 = param3[local6];
        if(local16 < 0 || local16 >= local9) {
          throw new RangeError("Index is out of bounds.");
        }
        local6++;
      }
      if(this.alternativa3d::vertexList != null) {
        local11 = this.alternativa3d::vertexList;
        while(local11.alternativa3d::next != null) {
          local11 = local11.alternativa3d::next;
        }
      }
      var local12:Vector.<Vertex> = new Vector.<Vertex>(local9);
      local6 = 0;
      local7 = 0;
      local8 = 0;
      while(local6 < local9) {
        local18 = new Vertex();
        local18.x = param1[local7];
        local7++;
        local18.y = param1[local7];
        local7++;
        local18.z = param1[local7];
        local7++;
        local18.u = param2[local8];
        local8++;
        local18.v = param2[local8];
        local8++;
        local12[local6] = local18;
        if(local11 != null) {
          local11.alternativa3d::next = local18;
        } else {
          this.alternativa3d::vertexList = local18;
        }
        local11 = local18;
        local6++;
      }
      if(this.alternativa3d::faceList != null) {
        local13 = this.alternativa3d::faceList;
        while(local13.alternativa3d::next != null) {
          local13 = local13.alternativa3d::next;
        }
      }
      local6 = 0;
      local8 = 0;
      while(local6 < local10) {
        if(local6 == local8) {
          local8 = param4 ? param3[local6] + ++local6 : local6 + 3;
          local15 = null;
          local14 = new Face();
          local14.material = param5;
          if(local13 != null) {
            local13.alternativa3d::next = local14;
          } else {
            this.alternativa3d::faceList = local14;
          }
          local13 = local14;
        }
        local19 = new Wrapper();
        local19.alternativa3d::vertex = local12[param3[local6]];
        if(local15 != null) {
          local15.alternativa3d::next = local19;
        } else {
          local14.alternativa3d::wrapper = local19;
        }
        local15 = local19;
        local6++;
      }
    }

    public function get vertices() : Vector.<Vertex> {
      var local1:Vector.<Vertex> = new Vector.<Vertex>();
      var local2:int = 0;
      var local3:Vertex = this.alternativa3d::vertexList;
      while(local3 != null) {
        local1[local2] = local3;
        local2++;
        local3 = local3.alternativa3d::next;
      }
      return local1;
    }

    public function get faces() : Vector.<Face> {
      var local1:Vector.<Face> = new Vector.<Face>();
      var local2:int = 0;
      var local3:Face = this.alternativa3d::faceList;
      while(local3 != null) {
        local1[local2] = local3;
        local2++;
        local3 = local3.alternativa3d::next;
      }
      return local1;
    }

    public function weldVertices(param1:Number = 0, param2:Number = 0) : void {
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local9:Wrapper = null;
      var local5:Vector.<Vertex> = new Vector.<Vertex>();
      var local6:int = 0;
      local3 = this.alternativa3d::vertexList;
      while(local3 != null) {
        local4 = local3.alternativa3d::next;
        local3.alternativa3d::next = null;
        local5[local6] = local3;
        local6++;
        local3 = local4;
      }
      this.alternativa3d::vertexList = null;
      this.group(local5,0,local6,0,param1,param2,new Vector.<int>());
      var local7:Face = this.alternativa3d::faceList;
      while(local7 != null) {
        local9 = local7.alternativa3d::wrapper;
        while(local9 != null) {
          if(local9.alternativa3d::vertex.alternativa3d::value != null) {
            local9.alternativa3d::vertex = local9.alternativa3d::vertex.alternativa3d::value;
          }
          local9 = local9.alternativa3d::next;
        }
        local7 = local7.alternativa3d::next;
      }
      var local8:int = 0;
      while(local8 < local6) {
        local3 = local5[local8];
        if(local3.alternativa3d::value == null) {
          local3.alternativa3d::next = this.alternativa3d::vertexList;
          this.alternativa3d::vertexList = local3;
        }
        local8++;
      }
    }

    alternativa3d function prepareResources() : void {
    }

    alternativa3d function addOpaque(param1:Camera3D) : void {
    }

    alternativa3d function deleteResources() : void {
    }

    public function weldFaces(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Boolean = false) : void {
      var local5:int = 0;
      var local6:int = 0;
      var local7:* = undefined;
      var local8:Face = null;
      var local9:Face = null;
      var local10:Face = null;
      var local11:Wrapper = null;
      var local12:Wrapper = null;
      var local13:Wrapper = null;
      var local14:Wrapper = null;
      var local15:Wrapper = null;
      var local16:Wrapper = null;
      var local17:Wrapper = null;
      var local18:Wrapper = null;
      var local19:Vertex = null;
      var local20:Vertex = null;
      var local21:Vertex = null;
      var local22:Vertex = null;
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
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local35:Number = NaN;
      var local36:Number = NaN;
      var local37:Dictionary = null;
      var local44:int = 0;
      var local45:Number = NaN;
      var local46:Number = NaN;
      var local47:Number = NaN;
      var local48:Number = NaN;
      var local49:Number = NaN;
      var local50:Number = NaN;
      var local51:Number = NaN;
      var local52:Number = NaN;
      var local53:Number = NaN;
      var local54:Number = NaN;
      var local55:Number = NaN;
      var local56:Number = NaN;
      var local57:Number = NaN;
      var local58:Number = NaN;
      var local59:Number = NaN;
      var local60:Number = NaN;
      var local61:Number = NaN;
      var local62:Number = NaN;
      var local63:Number = NaN;
      var local64:Boolean = false;
      var local65:Face = null;
      var local38:Number = 0.001;
      param1 = Math.cos(param1) - local38;
      param2 += local38;
      param3 = Math.cos(Math.PI - param3) - local38;
      var local39:Dictionary = new Dictionary();
      var local40:Dictionary = new Dictionary();
      local9 = this.alternativa3d::faceList;
      while(local9 != null) {
        local10 = local9.alternativa3d::next;
        local9.alternativa3d::next = null;
        local20 = local9.alternativa3d::wrapper.alternativa3d::vertex;
        local21 = local9.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex;
        local22 = local9.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex;
        local23 = local21.x - local20.x;
        local24 = local21.y - local20.y;
        local25 = local21.z - local20.z;
        local28 = local22.x - local20.x;
        local29 = local22.y - local20.y;
        local30 = local22.z - local20.z;
        local33 = local30 * local24 - local29 * local25;
        local34 = local28 * local25 - local30 * local23;
        local35 = local29 * local23 - local28 * local24;
        local36 = local33 * local33 + local34 * local34 + local35 * local35;
        if(local36 > local38) {
          local36 = 1 / Math.sqrt(local36);
          local33 *= local36;
          local34 *= local36;
          local35 *= local36;
          local9.alternativa3d::normalX = local33;
          local9.alternativa3d::normalY = local34;
          local9.alternativa3d::normalZ = local35;
          local9.alternativa3d::offset = local20.x * local33 + local20.y * local34 + local20.z * local35;
          local39[local9] = true;
          local15 = local9.alternativa3d::wrapper;
          while(local15 != null) {
            local19 = local15.alternativa3d::vertex;
            local37 = local40[local19];
            if(local37 == null) {
              local37 = new Dictionary();
              local40[local19] = local37;
            }
            local37[local9] = true;
            local15 = local15.alternativa3d::next;
          }
        }
        local9 = local10;
      }
      this.alternativa3d::faceList = null;
      var local41:Vector.<Face> = new Vector.<Face>();
      var local42:Dictionary = new Dictionary();
      var local43:Dictionary = new Dictionary();
      while(true) {
        local9 = null;
        var local66:int = 0;
        var local67:* = local39;
        for(local7 in local67) {
          local9 = local7;
          delete local39[local7];
        }
        if(local9 == null) {
          break;
        }
        local44 = 0;
        local41[local44] = local9;
        local44++;
        local20 = local9.alternativa3d::wrapper.alternativa3d::vertex;
        local21 = local9.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex;
        local22 = local9.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex;
        local23 = local21.x - local20.x;
        local24 = local21.y - local20.y;
        local25 = local21.z - local20.z;
        local26 = local21.u - local20.u;
        local27 = local21.v - local20.v;
        local28 = local22.x - local20.x;
        local29 = local22.y - local20.y;
        local30 = local22.z - local20.z;
        local31 = local22.u - local20.u;
        local32 = local22.v - local20.v;
        local33 = Number(local9.alternativa3d::normalX);
        local34 = Number(local9.alternativa3d::normalY);
        local35 = Number(local9.alternativa3d::normalZ);
        local45 = -local33 * local29 * local25 + local28 * local34 * local25 + local33 * local24 * local30 - local23 * local34 * local30 - local28 * local24 * local35 + local23 * local29 * local35;
        local46 = (-local34 * local30 + local29 * local35) / local45;
        local47 = (local33 * local30 - local28 * local35) / local45;
        local48 = (-local33 * local29 + local28 * local34) / local45;
        local49 = (local20.x * local34 * local30 - local33 * local20.y * local30 - local20.x * local29 * local35 + local28 * local20.y * local35 + local33 * local29 * local20.z - local28 * local34 * local20.z) / local45;
        local50 = (local34 * local25 - local24 * local35) / local45;
        local51 = (-local33 * local25 + local23 * local35) / local45;
        local52 = (local33 * local24 - local23 * local34) / local45;
        local53 = (local33 * local20.y * local25 - local20.x * local34 * local25 + local20.x * local24 * local35 - local23 * local20.y * local35 - local33 * local24 * local20.z + local23 * local34 * local20.z) / local45;
        local54 = local26 * local46 + local31 * local50;
        local55 = local26 * local47 + local31 * local51;
        local56 = local26 * local48 + local31 * local52;
        local57 = local26 * local49 + local31 * local53 + local20.u;
        local58 = local27 * local46 + local32 * local50;
        local59 = local27 * local47 + local32 * local51;
        local60 = local27 * local48 + local32 * local52;
        local61 = local27 * local49 + local32 * local53 + local20.v;
        for(local7 in local43) {
          delete local43[local7];
        }
        local5 = 0;
        while(local5 < local44) {
          local9 = local41[local5];
          for(local7 in local42) {
            delete local42[local7];
          }
          local13 = local9.alternativa3d::wrapper;
          while(local13 != null) {
            for(local7 in local40[local13.alternativa3d::vertex]) {
              if(Boolean(local39[local7]) && !local43[local7]) {
                local42[local7] = true;
              }
            }
            local13 = local13.alternativa3d::next;
          }
          for(local7 in local42) {
            local8 = local7;
            if(local33 * local8.alternativa3d::normalX + local34 * local8.alternativa3d::normalY + local35 * local8.alternativa3d::normalZ >= param1) {
              local14 = local8.alternativa3d::wrapper;
              while(local14 != null) {
                local19 = local14.alternativa3d::vertex;
                local62 = local54 * local19.x + local55 * local19.y + local56 * local19.z + local57 - local19.u;
                local63 = local58 * local19.x + local59 * local19.y + local60 * local19.z + local61 - local19.v;
                if(local62 > param2 || local62 < -param2 || local63 > param2 || local63 < -param2) {
                  break;
                }
                local14 = local14.alternativa3d::next;
              }
              if(local14 == null) {
                local13 = local9.alternativa3d::wrapper;
                while(local13 != null) {
                  local15 = local13.alternativa3d::next != null ? local13.alternativa3d::next : local9.alternativa3d::wrapper;
                  local14 = local8.alternativa3d::wrapper;
                  while(local14 != null) {
                    local16 = local14.alternativa3d::next != null ? local14.alternativa3d::next : local8.alternativa3d::wrapper;
                    if(local13.alternativa3d::vertex == local16.alternativa3d::vertex && local15.alternativa3d::vertex == local14.alternativa3d::vertex) {
                      break;
                    }
                    local14 = local14.alternativa3d::next;
                  }
                  if(local14 != null) {
                    break;
                  }
                  local13 = local13.alternativa3d::next;
                }
                if(local13 != null) {
                  local41[local44] = local8;
                  local44++;
                  delete local39[local8];
                }
              } else {
                local43[local8] = true;
              }
            } else {
              local43[local8] = true;
            }
          }
          local5++;
        }
        if(local44 == 1) {
          local9 = local41[0];
          local9.alternativa3d::next = this.alternativa3d::faceList;
          this.alternativa3d::faceList = local9;
        } else {
          while(true) {
            local64 = false;
            local5 = 0;
            while(local5 < local44 - 1) {
              local9 = local41[local5];
              if(local9 != null) {
                local6 = 1;
                for(; local6 < local44; local6++) {
                  local8 = local41[local6];
                  if(local8 != null) {
                    local13 = local9.alternativa3d::wrapper;
                    while(local13 != null) {
                      local15 = local13.alternativa3d::next != null ? local13.alternativa3d::next : local9.alternativa3d::wrapper;
                      local14 = local8.alternativa3d::wrapper;
                      while(local14 != null) {
                        local16 = local14.alternativa3d::next != null ? local14.alternativa3d::next : local8.alternativa3d::wrapper;
                        if(local13.alternativa3d::vertex == local16.alternativa3d::vertex && local15.alternativa3d::vertex == local14.alternativa3d::vertex) {
                          break;
                        }
                        local14 = local14.alternativa3d::next;
                      }
                      if(local14 != null) {
                        break;
                      }
                      local13 = local13.alternativa3d::next;
                    }
                    if(local13 != null) {
                      while(true) {
                        local17 = local15.alternativa3d::next != null ? local15.alternativa3d::next : local9.alternativa3d::wrapper;
                        local12 = local8.alternativa3d::wrapper;
                        while(local12.alternativa3d::next != local14 && local12.alternativa3d::next != null) {
                          local12 = local12.alternativa3d::next;
                        }
                        if(local17.alternativa3d::vertex != local12.alternativa3d::vertex) {
                          break;
                        }
                        local15 = local17;
                        local14 = local12;
                      }
                      while(true) {
                        local11 = local9.alternativa3d::wrapper;
                        while(local11.alternativa3d::next != local13 && local11.alternativa3d::next != null) {
                          local11 = local11.alternativa3d::next;
                        }
                        local18 = local16.alternativa3d::next != null ? local16.alternativa3d::next : local8.alternativa3d::wrapper;
                        if(local11.alternativa3d::vertex != local18.alternativa3d::vertex) {
                          break;
                        }
                        local13 = local11;
                        local16 = local18;
                      }
                      local20 = local13.alternativa3d::vertex;
                      local21 = local18.alternativa3d::vertex;
                      local22 = local11.alternativa3d::vertex;
                      local23 = local21.x - local20.x;
                      local24 = local21.y - local20.y;
                      local25 = local21.z - local20.z;
                      local28 = local22.x - local20.x;
                      local29 = local22.y - local20.y;
                      local30 = local22.z - local20.z;
                      local33 = local30 * local24 - local29 * local25;
                      local34 = local28 * local25 - local30 * local23;
                      local35 = local29 * local23 - local28 * local24;
                      if(local33 < local38 && local33 > -local38 && local34 < local38 && local34 > -local38 && local35 < local38 && local35 > -local38) {
                        if(local23 * local28 + local24 * local29 + local25 * local30 > 0) {
                          continue;
                        }
                      } else if(local9.alternativa3d::normalX * local33 + local9.alternativa3d::normalY * local34 + local9.alternativa3d::normalZ * local35 < 0) {
                        continue;
                      }
                      local36 = 1 / Math.sqrt(local23 * local23 + local24 * local24 + local25 * local25);
                      local23 *= local36;
                      local24 *= local36;
                      local25 *= local36;
                      local36 = 1 / Math.sqrt(local28 * local28 + local29 * local29 + local30 * local30);
                      local28 *= local36;
                      local29 *= local36;
                      local30 *= local36;
                      if(local23 * local28 + local24 * local29 + local25 * local30 >= param3) {
                        local20 = local14.alternativa3d::vertex;
                        local21 = local17.alternativa3d::vertex;
                        local22 = local12.alternativa3d::vertex;
                        local23 = local21.x - local20.x;
                        local24 = local21.y - local20.y;
                        local25 = local21.z - local20.z;
                        local28 = local22.x - local20.x;
                        local29 = local22.y - local20.y;
                        local30 = local22.z - local20.z;
                        local33 = local30 * local24 - local29 * local25;
                        local34 = local28 * local25 - local30 * local23;
                        local35 = local29 * local23 - local28 * local24;
                        if(local33 < local38 && local33 > -local38 && local34 < local38 && local34 > -local38 && local35 < local38 && local35 > -local38) {
                          if(local23 * local28 + local24 * local29 + local25 * local30 > 0) {
                            continue;
                          }
                        } else if(local9.alternativa3d::normalX * local33 + local9.alternativa3d::normalY * local34 + local9.alternativa3d::normalZ * local35 < 0) {
                          continue;
                        }
                        local36 = 1 / Math.sqrt(local23 * local23 + local24 * local24 + local25 * local25);
                        local23 *= local36;
                        local24 *= local36;
                        local25 *= local36;
                        local36 = 1 / Math.sqrt(local28 * local28 + local29 * local29 + local30 * local30);
                        local28 *= local36;
                        local29 *= local36;
                        local30 *= local36;
                        if(local23 * local28 + local24 * local29 + local25 * local30 >= param3) {
                          local64 = true;
                          local65 = new Face();
                          local65.material = local9.material;
                          local65.smoothingGroups = local9.smoothingGroups;
                          local65.alternativa3d::normalX = local9.alternativa3d::normalX;
                          local65.alternativa3d::normalY = local9.alternativa3d::normalY;
                          local65.alternativa3d::normalZ = local9.alternativa3d::normalZ;
                          local65.alternativa3d::offset = local9.alternativa3d::offset;
                          local65.id = local9.id;
                          local17 = null;
                          while(local15 != local13) {
                            local18 = new Wrapper();
                            local18.alternativa3d::vertex = local15.alternativa3d::vertex;
                            if(local17 != null) {
                              local17.alternativa3d::next = local18;
                            } else {
                              local65.alternativa3d::wrapper = local18;
                            }
                            local17 = local18;
                            local15 = local15.alternativa3d::next != null ? local15.alternativa3d::next : local9.alternativa3d::wrapper;
                          }
                          while(local16 != local14) {
                            local18 = new Wrapper();
                            local18.alternativa3d::vertex = local16.alternativa3d::vertex;
                            if(local17 != null) {
                              local17.alternativa3d::next = local18;
                            } else {
                              local65.alternativa3d::wrapper = local18;
                            }
                            local17 = local18;
                            local16 = local16.alternativa3d::next != null ? local16.alternativa3d::next : local8.alternativa3d::wrapper;
                          }
                          local41[local5] = local65;
                          local41[local6] = null;
                          local9 = local65;
                          if(param4) {
                            break;
                          }
                        }
                      }
                    }
                  }
                }
              }
              local5++;
            }
            if(!local64) {
              break;
            }
          }
          local5 = 0;
          while(local5 < local44) {
            local9 = local41[local5];
            if(local9 != null) {
              local9.alternativa3d::calculateBestSequenceAndNormal();
              local9.alternativa3d::next = this.alternativa3d::faceList;
              this.alternativa3d::faceList = local9;
            }
            local5++;
          }
        }
      }
    }

    private function group(param1:Vector.<Vertex>, param2:int, param3:int, param4:int, param5:Number, param6:Number, param7:Vector.<int>) : void {
      var local8:int = 0;
      var local9:int = 0;
      var local10:Vertex = null;
      var local11:Number = NaN;
      var local13:Vertex = null;
      var local14:int = 0;
      var local15:int = 0;
      var local16:Number = NaN;
      var local17:Vertex = null;
      var local18:Vertex = null;
      switch(param4) {
        case 0:
          local8 = param2;
          while(local8 < param3) {
            local10 = param1[local8];
            local10.alternativa3d::offset = local10.x;
            local8++;
          }
          local11 = param5;
          break;
        case 1:
          local8 = param2;
          while(local8 < param3) {
            local10 = param1[local8];
            local10.alternativa3d::offset = local10.y;
            local8++;
          }
          local11 = param5;
          break;
        case 2:
          local8 = param2;
          while(local8 < param3) {
            local10 = param1[local8];
            local10.alternativa3d::offset = local10.z;
            local8++;
          }
          local11 = param5;
          break;
        case 3:
          local8 = param2;
          while(local8 < param3) {
            local10 = param1[local8];
            local10.alternativa3d::offset = local10.u;
            local8++;
          }
          local11 = param6;
          break;
        case 4:
          local8 = param2;
          while(local8 < param3) {
            local10 = param1[local8];
            local10.alternativa3d::offset = local10.v;
            local8++;
          }
          local11 = param6;
      }
      param7[0] = param2;
      param7[1] = param3 - 1;
      var local12:int = 2;
      while(local12 > 0) {
        local12--;
        local14 = param7[local12];
        local9 = local14;
        local12--;
        local15 = param7[local12];
        local8 = local15;
        local10 = param1[local14 + local15 >> 1];
        local16 = Number(local10.alternativa3d::offset);
        while(local8 <= local9) {
          local17 = param1[local8];
          while(local17.alternativa3d::offset > local16) {
            local8++;
            local17 = param1[local8];
          }
          local18 = param1[local9];
          while(local18.alternativa3d::offset < local16) {
            local9--;
            local18 = param1[local9];
          }
          if(local8 <= local9) {
            param1[local8] = local18;
            param1[local9] = local17;
            local8++;
            local9--;
          }
        }
        if(local15 < local9) {
          param7[local12] = local15;
          local12++;
          param7[local12] = local9;
          local12++;
        }
        if(local8 < local14) {
          param7[local12] = local8;
          local12++;
          param7[local12] = local14;
          local12++;
        }
      }
      local8 = param2;
      local10 = param1[local8];
      local9 = local8 + 1;
      while(local9 <= param3) {
        if(local9 < param3) {
          local13 = param1[local9];
        }
        if(local9 == param3 || local10.alternativa3d::offset - local13.alternativa3d::offset > local11) {
          if(param4 < 4 && local9 - local8 > 1) {
            this.group(param1,local8,local9,param4 + 1,param5,param6,param7);
          }
          if(local9 < param3) {
            local8 = local9;
            local10 = param1[local8];
          }
        } else if(param4 == 4) {
          local13.alternativa3d::value = local10;
        }
        local9++;
      }
    }

    public function setMaterialToAllFaces(param1:Material) : void {
      var local2:Face = this.alternativa3d::faceList;
      while(local2 != null) {
        local2.material = param1;
        local2 = local2.alternativa3d::next;
      }
    }

    public function calculateFacesNormals(param1:Boolean = true) : void {
      var local3:Wrapper = null;
      var local4:Vertex = null;
      var local5:Vertex = null;
      var local6:Vertex = null;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local2:Face = this.alternativa3d::faceList;
      while(local2 != null) {
        local3 = local2.alternativa3d::wrapper;
        local4 = local3.alternativa3d::vertex;
        local3 = local3.alternativa3d::next;
        local5 = local3.alternativa3d::vertex;
        local3 = local3.alternativa3d::next;
        local6 = local3.alternativa3d::vertex;
        local7 = local5.x - local4.x;
        local8 = local5.y - local4.y;
        local9 = local5.z - local4.z;
        local10 = local6.x - local4.x;
        local11 = local6.y - local4.y;
        local12 = local6.z - local4.z;
        local13 = local12 * local8 - local11 * local9;
        local14 = local10 * local9 - local12 * local7;
        local15 = local11 * local7 - local10 * local8;
        if(param1) {
          local16 = local13 * local13 + local14 * local14 + local15 * local15;
          if(local16 > 0.001) {
            local16 = 1 / Math.sqrt(local16);
            local13 *= local16;
            local14 *= local16;
            local15 *= local16;
          }
        }
        local2.alternativa3d::normalX = local13;
        local2.alternativa3d::normalY = local14;
        local2.alternativa3d::normalZ = local15;
        local2.alternativa3d::offset = local4.x * local13 + local4.y * local14 + local4.z * local15;
        local2 = local2.alternativa3d::next;
      }
    }

    public function calculateVerticesNormals(param1:Boolean = false, param2:Number = 0) : void {
      var local3:Vertex = null;
      var local4:Number = NaN;
      var local6:Wrapper = null;
      var local7:Vertex = null;
      var local8:Vertex = null;
      var local9:Vertex = null;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Vector.<Vertex> = null;
      local3 = this.alternativa3d::vertexList;
      while(local3 != null) {
        local3.normalX = 0;
        local3.normalY = 0;
        local3.normalZ = 0;
        local3 = local3.alternativa3d::next;
      }
      var local5:Face = this.alternativa3d::faceList;
      while(local5 != null) {
        local6 = local5.alternativa3d::wrapper;
        local7 = local6.alternativa3d::vertex;
        local6 = local6.alternativa3d::next;
        local8 = local6.alternativa3d::vertex;
        local6 = local6.alternativa3d::next;
        local9 = local6.alternativa3d::vertex;
        local10 = local8.x - local7.x;
        local11 = local8.y - local7.y;
        local12 = local8.z - local7.z;
        local13 = local9.x - local7.x;
        local14 = local9.y - local7.y;
        local15 = local9.z - local7.z;
        local16 = local15 * local11 - local14 * local12;
        local17 = local13 * local12 - local15 * local10;
        local18 = local14 * local10 - local13 * local11;
        local4 = local16 * local16 + local17 * local17 + local18 * local18;
        if(local4 > 0.001) {
          local4 = 1 / Math.sqrt(local4);
          local16 *= local4;
          local17 *= local4;
          local18 *= local4;
        }
        local6 = local5.alternativa3d::wrapper;
        while(local6 != null) {
          local3 = local6.alternativa3d::vertex;
          local3.normalX += local16;
          local3.normalY += local17;
          local3.normalZ += local18;
          local6 = local6.alternativa3d::next;
        }
        local5 = local5.alternativa3d::next;
      }
      if(param1) {
        local19 = this.vertices;
        this.alternativa3d::weldNormals(local19,0,local19.length,0,param2,new Vector.<int>());
      }
      local3 = this.alternativa3d::vertexList;
      while(local3 != null) {
        local4 = local3.normalX * local3.normalX + local3.normalY * local3.normalY + local3.normalZ * local3.normalZ;
        if(local4 > 0.001) {
          local4 = 1 / Math.sqrt(local4);
          local3.normalX *= local4;
          local3.normalY *= local4;
          local3.normalZ *= local4;
        }
        local3 = local3.alternativa3d::next;
      }
    }

    alternativa3d function weldNormals(param1:Vector.<Vertex>, param2:int, param3:int, param4:int, param5:Number, param6:Vector.<int>) : void {
      var local7:int = 0;
      var local8:int = 0;
      var local9:int = 0;
      var local10:Vertex = null;
      var local12:Vertex = null;
      var local13:int = 0;
      var local14:int = 0;
      var local15:Number = NaN;
      var local16:Vertex = null;
      var local17:Vertex = null;
      switch(param4) {
        case 0:
          local7 = param2;
          while(local7 < param3) {
            local10 = param1[local7];
            local10.alternativa3d::offset = local10.x;
            local7++;
          }
          break;
        case 1:
          local7 = param2;
          while(local7 < param3) {
            local10 = param1[local7];
            local10.alternativa3d::offset = local10.y;
            local7++;
          }
          break;
        case 2:
          local7 = param2;
          while(local7 < param3) {
            local10 = param1[local7];
            local10.alternativa3d::offset = local10.z;
            local7++;
          }
      }
      param6[0] = param2;
      param6[1] = param3 - 1;
      var local11:int = 2;
      while(local11 > 0) {
        local11--;
        local13 = param6[local11];
        local8 = local13;
        local11--;
        local14 = param6[local11];
        local7 = local14;
        local10 = param1[local13 + local14 >> 1];
        local15 = Number(local10.alternativa3d::offset);
        while(local7 <= local8) {
          local16 = param1[local7];
          while(local16.alternativa3d::offset > local15) {
            local7++;
            local16 = param1[local7];
          }
          local17 = param1[local8];
          while(local17.alternativa3d::offset < local15) {
            local8--;
            local17 = param1[local8];
          }
          if(local7 <= local8) {
            param1[local7] = local17;
            param1[local8] = local16;
            local7++;
            local8--;
          }
        }
        if(local14 < local8) {
          param6[local11] = local14;
          local11++;
          param6[local11] = local8;
          local11++;
        }
        if(local7 < local13) {
          param6[local11] = local7;
          local11++;
          param6[local11] = local13;
          local11++;
        }
      }
      local7 = param2;
      local10 = param1[local7];
      local8 = local7 + 1;
      while(local8 <= param3) {
        if(local8 < param3) {
          local12 = param1[local8];
        }
        if(local8 == param3 || local10.alternativa3d::offset - local12.alternativa3d::offset > param5) {
          if(local8 - local7 > 1) {
            if(param4 < 2) {
              this.alternativa3d::weldNormals(param1,local7,local8,param4 + 1,param5,param6);
            } else {
              local9 = local7 + 1;
              while(local9 < local8) {
                local12 = param1[local9];
                local10.normalX += local12.normalX;
                local10.normalY += local12.normalY;
                local10.normalZ += local12.normalZ;
                local9++;
              }
              local9 = local7 + 1;
              while(local9 < local8) {
                local12 = param1[local9];
                local12.normalX = local10.normalX;
                local12.normalY = local10.normalY;
                local12.normalZ = local10.normalZ;
                local9++;
              }
            }
          }
          if(local8 < param3) {
            local7 = local8;
            local10 = param1[local7];
          }
        }
        local8++;
      }
    }

    public function calculateVerticesNormalsByAngle(param1:Number, param2:Number = 0) : void {
    }

    public function calculateVerticesNormalsBySmoothingGroups(param1:Number = 0) : void {
    }

    public function optimizeForDynamicBSP(param1:int = 1) : void {
      var local3:Face = null;
      var local5:Face = null;
      var local6:Face = null;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:int = 0;
      var local14:Face = null;
      var local15:Wrapper = null;
      var local16:Vertex = null;
      var local17:Vertex = null;
      var local18:Vertex = null;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Boolean = false;
      var local23:Boolean = false;
      var local24:Vertex = null;
      var local25:Number = NaN;
      var local2:Face = this.alternativa3d::faceList;
      var local4:int = 0;
      while(local4 < param1) {
        local5 = null;
        local6 = local2;
        while(local6 != null) {
          local7 = Number(local6.alternativa3d::normalX);
          local8 = Number(local6.alternativa3d::normalY);
          local9 = Number(local6.alternativa3d::normalZ);
          local10 = Number(local6.alternativa3d::offset);
          local11 = local10 - this.threshold;
          local12 = local10 + this.threshold;
          local13 = 0;
          local14 = local2;
          while(local14 != null) {
            if(local14 != local6) {
              local15 = local14.alternativa3d::wrapper;
              local16 = local15.alternativa3d::vertex;
              local15 = local15.alternativa3d::next;
              local17 = local15.alternativa3d::vertex;
              local15 = local15.alternativa3d::next;
              local18 = local15.alternativa3d::vertex;
              local15 = local15.alternativa3d::next;
              local19 = local16.x * local7 + local16.y * local8 + local16.z * local9;
              local20 = local17.x * local7 + local17.y * local8 + local17.z * local9;
              local21 = local18.x * local7 + local18.y * local8 + local18.z * local9;
              local22 = local19 < local11 || local20 < local11 || local21 < local11;
              local23 = local19 > local12 || local20 > local12 || local21 > local12;
              while(local15 != null) {
                local24 = local15.alternativa3d::vertex;
                local25 = local24.x * local7 + local24.y * local8 + local24.z * local9;
                if(local25 < local11) {
                  local22 = true;
                  if(local23) {
                    break;
                  }
                } else if(local25 > local12) {
                  local23 = true;
                  if(local22) {
                    break;
                  }
                }
                local15 = local15.alternativa3d::next;
              }
              if(local23 && local22) {
                local13++;
                if(local13 > local4) {
                  break;
                }
              }
            }
            local14 = local14.alternativa3d::next;
          }
          if(local14 == null) {
            if(local5 != null) {
              local5.alternativa3d::next = local6.alternativa3d::next;
            } else {
              local2 = local6.alternativa3d::next;
            }
            if(local3 != null) {
              local3.alternativa3d::next = local6;
            } else {
              this.alternativa3d::faceList = local6;
            }
            local3 = local6;
          } else {
            local5 = local6;
          }
          local6 = local6.alternativa3d::next;
        }
        if(local2 == null) {
          break;
        }
        local4++;
      }
      if(local3 != null) {
        local3.alternativa3d::next = local2;
      }
    }

    override public function calculateResolution(param1:int, param2:int, param3:int = 1, param4:Matrix3D = null) : Number {
      var local5:Object3D = null;
      var local11:Wrapper = null;
      var local12:Vertex = null;
      var local13:Vertex = null;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      if(param4 != null) {
        local5 = new Object3D();
        local5.matrix = param4;
        local5.alternativa3d::composeMatrix();
      }
      var local6:Number = 1e+22;
      var local7:Number = 0;
      var local8:Number = 0;
      var local9:int = 0;
      var local10:Face = this.alternativa3d::faceList;
      while(local10 != null) {
        local11 = local10.alternativa3d::wrapper;
        while(local11 != null) {
          local12 = local11.alternativa3d::vertex;
          local13 = local11.alternativa3d::next != null ? local11.alternativa3d::next.alternativa3d::vertex : local10.alternativa3d::wrapper.alternativa3d::vertex;
          local14 = local5 != null ? local5.alternativa3d::ma * (local13.x - local12.x) + local5.alternativa3d::mb * (local13.y - local12.y) + local5.alternativa3d::mc * (local13.z - local12.z) : local13.x - local12.x;
          local15 = local5 != null ? local5.alternativa3d::me * (local13.x - local12.x) + local5.alternativa3d::mf * (local13.y - local12.y) + local5.alternativa3d::mg * (local13.z - local12.z) : local13.y - local12.y;
          local16 = local5 != null ? local5.alternativa3d::mi * (local13.x - local12.x) + local5.alternativa3d::mj * (local13.y - local12.y) + local5.alternativa3d::mk * (local13.z - local12.z) : local13.z - local12.z;
          local17 = (local13.u - local12.u) * param1;
          local18 = (local13.v - local12.v) * param2;
          local19 = local14 * local14 + local15 * local15 + local16 * local16;
          local20 = local17 * local17 + local18 * local18;
          if(local19 > 0.001 && local20 > 0.001) {
            local21 = Math.sqrt(local19 / local20);
            if(local21 < local6) {
              local6 = local21;
            }
            if(local21 > local7) {
              local7 = local21;
            }
            local8 += local21;
            local9++;
            if(param3 == 0) {
              break;
            }
          }
          local11 = local11.alternativa3d::next;
        }
        local10 = local10.alternativa3d::next;
      }
      if(local9 == 0) {
        return 1;
      }
      return param3 < 2 ? local8 / local9 : (param3 == 2 ? local6 : local7);
    }

    override public function intersectRay(param1:Vector3D, param2:Vector3D, param3:Dictionary = null, param4:Camera3D = null) : RayIntersectionData {
      var local11:Vector3D = null;
      var local12:Face = null;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Wrapper = null;
      var local25:Vertex = null;
      var local26:Vertex = null;
      var local27:Number = NaN;
      var local28:Number = NaN;
      var local29:Number = NaN;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:RayIntersectionData = null;
      if(param3 != null && Boolean(param3[this])) {
        return null;
      }
      if(!alternativa3d::boundIntersectRay(param1,param2,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
        return null;
      }
      var local5:Number = param1.x;
      var local6:Number = param1.y;
      var local7:Number = param1.z;
      var local8:Number = param2.x;
      var local9:Number = param2.y;
      var local10:Number = param2.z;
      var local13:Number = 1e+22;
      var local14:Face = this.alternativa3d::faceList;
      while(local14 != null) {
        local15 = Number(local14.alternativa3d::normalX);
        local16 = Number(local14.alternativa3d::normalY);
        local17 = Number(local14.alternativa3d::normalZ);
        local18 = local8 * local15 + local9 * local16 + local10 * local17;
        if(local18 < 0) {
          local19 = local5 * local15 + local6 * local16 + local7 * local17 - local14.alternativa3d::offset;
          if(local19 > 0) {
            local20 = -local19 / local18;
            if(local11 == null || local20 < local13) {
              local21 = local5 + local8 * local20;
              local22 = local6 + local9 * local20;
              local23 = local7 + local10 * local20;
              local24 = local14.alternativa3d::wrapper;
              while(local24 != null) {
                local25 = local24.alternativa3d::vertex;
                local26 = local24.alternativa3d::next != null ? local24.alternativa3d::next.alternativa3d::vertex : local14.alternativa3d::wrapper.alternativa3d::vertex;
                local27 = local26.x - local25.x;
                local28 = local26.y - local25.y;
                local29 = local26.z - local25.z;
                local30 = local21 - local25.x;
                local31 = local22 - local25.y;
                local32 = local23 - local25.z;
                if((local32 * local28 - local31 * local29) * local15 + (local30 * local29 - local32 * local27) * local16 + (local31 * local27 - local30 * local28) * local17 < 0) {
                  break;
                }
                local24 = local24.alternativa3d::next;
              }
              if(local24 == null) {
                if(local20 < local13) {
                  local13 = local20;
                  if(local11 == null) {
                    local11 = new Vector3D();
                  }
                  local11.x = local21;
                  local11.y = local22;
                  local11.z = local23;
                  local12 = local14;
                }
              }
            }
          }
        }
        local14 = local14.alternativa3d::next;
      }
      if(local11 != null) {
        local33 = new RayIntersectionData();
        local33.object = this;
        local33.face = local12;
        local33.point = local11;
        local33.uv = local12.getUV(local11);
        local33.time = local13;
        return local33;
      }
      return null;
    }

    override alternativa3d function checkIntersection(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Dictionary) : Boolean {
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Wrapper = null;
      var local20:Vertex = null;
      var local21:Vertex = null;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local9:Face = this.alternativa3d::faceList;
      while(true) {
        if(local9 == null) {
          return false;
        }
        local10 = Number(local9.alternativa3d::normalX);
        local11 = Number(local9.alternativa3d::normalY);
        local12 = Number(local9.alternativa3d::normalZ);
        local13 = param4 * local10 + param5 * local11 + param6 * local12;
        if(local13 < 0) {
          local14 = param1 * local10 + param2 * local11 + param3 * local12 - local9.alternativa3d::offset;
          if(local14 > 0) {
            local15 = -local14 / local13;
            if(local15 < param7) {
              local16 = param1 + param4 * local15;
              local17 = param2 + param5 * local15;
              local18 = param3 + param6 * local15;
              local19 = local9.alternativa3d::wrapper;
              while(local19 != null) {
                local20 = local19.alternativa3d::vertex;
                local21 = local19.alternativa3d::next != null ? local19.alternativa3d::next.alternativa3d::vertex : local9.alternativa3d::wrapper.alternativa3d::vertex;
                local22 = local21.x - local20.x;
                local23 = local21.y - local20.y;
                local24 = local21.z - local20.z;
                local25 = local16 - local20.x;
                local26 = local17 - local20.y;
                local27 = local18 - local20.z;
                if((local27 * local23 - local26 * local24) * local10 + (local25 * local24 - local27 * local22) * local11 + (local26 * local22 - local25 * local23) * local12 < 0) {
                  break;
                }
                local19 = local19.alternativa3d::next;
              }
              if(local19 == null) {
                break;
              }
            }
          }
        }
        local9 = local9.alternativa3d::next;
      }
      return true;
    }

    override alternativa3d function collectPlanes(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:Vector3D, param6:Vector.<Face>, param7:Dictionary = null) : void {
      var local9:Vertex = null;
      var local11:Number = NaN;
      var local12:Wrapper = null;
      if(param7 != null && Boolean(param7[this])) {
        return;
      }
      var local8:Vector3D = alternativa3d::calculateSphere(param1,param2,param3,param4,param5);
      if(!alternativa3d::boundIntersectSphere(local8,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
        return;
      }
      if(alternativa3d::transformId > 500000000) {
        alternativa3d::transformId = 0;
        local9 = this.alternativa3d::vertexList;
        while(local9 != null) {
          local9.alternativa3d::transformId = 0;
          local9 = local9.alternativa3d::next;
        }
      }
      ++alternativa3d::transformId;
      var local10:Face = this.alternativa3d::faceList;
      while(local10 != null) {
        local11 = local8.x * local10.alternativa3d::normalX + local8.y * local10.alternativa3d::normalY + local8.z * local10.alternativa3d::normalZ - local10.alternativa3d::offset;
        if(local11 < local8.w && local11 > -local8.w) {
          local12 = local10.alternativa3d::wrapper;
          while(local12 != null) {
            local9 = local12.alternativa3d::vertex;
            if(local9.alternativa3d::transformId != alternativa3d::transformId) {
              local9.alternativa3d::cameraX = alternativa3d::ma * local9.x + alternativa3d::mb * local9.y + alternativa3d::mc * local9.z + alternativa3d::md;
              local9.alternativa3d::cameraY = alternativa3d::me * local9.x + alternativa3d::mf * local9.y + alternativa3d::mg * local9.z + alternativa3d::mh;
              local9.alternativa3d::cameraZ = alternativa3d::mi * local9.x + alternativa3d::mj * local9.y + alternativa3d::mk * local9.z + alternativa3d::ml;
              local9.alternativa3d::transformId = alternativa3d::transformId;
            }
            local12 = local12.alternativa3d::next;
          }
          param6.push(local10);
        }
        local10 = local10.alternativa3d::next;
      }
    }

    override public function clone() : Object3D {
      var local1:Mesh = new Mesh();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local5:Face = null;
      var local7:Vertex = null;
      var local8:Face = null;
      var local9:Wrapper = null;
      var local10:Wrapper = null;
      var local11:Wrapper = null;
      super.clonePropertiesFrom(param1);
      var local2:Mesh = param1 as Mesh;
      this.clipping = local2.clipping;
      this.sorting = local2.sorting;
      this.threshold = local2.threshold;
      local3 = local2.alternativa3d::vertexList;
      while(local3 != null) {
        local7 = new Vertex();
        local7.x = local3.x;
        local7.y = local3.y;
        local7.z = local3.z;
        local7.u = local3.u;
        local7.v = local3.v;
        local7.normalX = local3.normalX;
        local7.normalY = local3.normalY;
        local7.normalZ = local3.normalZ;
        local7.alternativa3d::offset = local3.alternativa3d::offset;
        local7.id = local3.id;
        local3.alternativa3d::value = local7;
        if(local4 != null) {
          local4.alternativa3d::next = local7;
        } else {
          this.alternativa3d::vertexList = local7;
        }
        local4 = local7;
        local3 = local3.alternativa3d::next;
      }
      var local6:Face = local2.alternativa3d::faceList;
      while(local6 != null) {
        local8 = new Face();
        local8.material = local6.material;
        local8.smoothingGroups = local6.smoothingGroups;
        local8.id = local6.id;
        local8.alternativa3d::normalX = local6.alternativa3d::normalX;
        local8.alternativa3d::normalY = local6.alternativa3d::normalY;
        local8.alternativa3d::normalZ = local6.alternativa3d::normalZ;
        local8.alternativa3d::offset = local6.alternativa3d::offset;
        local9 = null;
        local10 = local6.alternativa3d::wrapper;
        while(local10 != null) {
          local11 = new Wrapper();
          local11.alternativa3d::vertex = local10.alternativa3d::vertex.alternativa3d::value;
          if(local9 != null) {
            local9.alternativa3d::next = local11;
          } else {
            local8.alternativa3d::wrapper = local11;
          }
          local9 = local11;
          local10 = local10.alternativa3d::next;
        }
        if(local5 != null) {
          local5.alternativa3d::next = local8;
        } else {
          this.alternativa3d::faceList = local8;
        }
        local5 = local8;
        local6 = local6.alternativa3d::next;
      }
      local3 = local2.alternativa3d::vertexList;
      while(local3 != null) {
        local3.alternativa3d::value = null;
        local3 = local3.alternativa3d::next;
      }
    }

    override alternativa3d function draw(param1:Camera3D, param2:Canvas) : void {
      var local4:Vertex = null;
      var local5:int = 0;
      if(this.alternativa3d::faceList == null) {
        return;
      }
      if(this.clipping == 0) {
        if(Boolean(alternativa3d::culling & 1)) {
          return;
        }
        alternativa3d::culling = 0;
      }
      if(alternativa3d::transformId > 500000000) {
        alternativa3d::transformId = 0;
        local4 = this.alternativa3d::vertexList;
        while(local4 != null) {
          local4.alternativa3d::transformId = 0;
          local4 = local4.alternativa3d::next;
        }
      }
      ++alternativa3d::transformId;
      alternativa3d::calculateInverseMatrix();
      var local3:Face = this.alternativa3d::prepareFaces(param1);
      if(local3 == null) {
        return;
      }
      if(alternativa3d::culling > 0) {
        if(this.clipping == 1) {
          local3 = param1.alternativa3d::cull(local3,alternativa3d::culling);
        } else {
          local3 = param1.alternativa3d::clip(local3,alternativa3d::culling);
        }
        if(local3 == null) {
          return;
        }
      }
      if(local3.alternativa3d::processNext != null) {
        if(this.sorting == 1) {
          local3 = param1.alternativa3d::sortByAverageZ(local3);
        } else if(this.sorting == 2) {
          local3 = param1.alternativa3d::sortByDynamicBSP(local3,this.threshold);
        }
      }
      if(param1.debug) {
        local5 = int(param1.alternativa3d::checkInDebug(this));
        if(local5 > 0) {
          this.alternativa3d::drawDebug(param1,param2.alternativa3d::getChildCanvas(true,false),local3,local5);
        }
      }
      this.alternativa3d::drawFaces(param1,param2.alternativa3d::getChildCanvas(true,false,this,alpha,blendMode,colorTransform,filters),local3);
    }

    override alternativa3d function getVG(param1:Camera3D) : VG {
      var local3:Vertex = null;
      if(this.alternativa3d::faceList == null) {
        return null;
      }
      if(alternativa3d::transformId > 500000000) {
        alternativa3d::transformId = 0;
        local3 = this.alternativa3d::vertexList;
        while(local3 != null) {
          local3.alternativa3d::transformId = 0;
          local3 = local3.alternativa3d::next;
        }
      }
      ++alternativa3d::transformId;
      if(this.clipping == 0) {
        if(Boolean(alternativa3d::culling & 1)) {
          return null;
        }
        alternativa3d::culling = 0;
      }
      alternativa3d::calculateInverseMatrix();
      var local2:Face = this.alternativa3d::prepareFaces(param1);
      if(local2 == null) {
        return null;
      }
      if(alternativa3d::culling > 0) {
        if(this.clipping == 1) {
          local2 = param1.alternativa3d::cull(local2,alternativa3d::culling);
        } else {
          local2 = param1.alternativa3d::clip(local2,alternativa3d::culling);
        }
        if(local2 == null) {
          return null;
        }
      }
      return VG.alternativa3d::create(this,local2,this.sorting,param1.debug ? int(param1.alternativa3d::checkInDebug(this)) : 0,false);
    }

    alternativa3d function prepareFaces(param1:Camera3D) : Face {
      var local2:Face = null;
      var local3:Face = null;
      var local5:Wrapper = null;
      var local6:Vertex = null;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local4:Face = this.alternativa3d::faceList;
      while(local4 != null) {
        if(local4.alternativa3d::normalX * alternativa3d::imd + local4.alternativa3d::normalY * alternativa3d::imh + local4.alternativa3d::normalZ * alternativa3d::iml > local4.alternativa3d::offset) {
          local5 = local4.alternativa3d::wrapper;
          while(local5 != null) {
            local6 = local5.alternativa3d::vertex;
            if(local6.alternativa3d::transformId != alternativa3d::transformId) {
              local7 = local6.x;
              local8 = local6.y;
              local9 = local6.z;
              local6.alternativa3d::cameraX = alternativa3d::ma * local7 + alternativa3d::mb * local8 + alternativa3d::mc * local9 + alternativa3d::md;
              local6.alternativa3d::cameraY = alternativa3d::me * local7 + alternativa3d::mf * local8 + alternativa3d::mg * local9 + alternativa3d::mh;
              local6.alternativa3d::cameraZ = alternativa3d::mi * local7 + alternativa3d::mj * local8 + alternativa3d::mk * local9 + alternativa3d::ml;
              local6.alternativa3d::transformId = alternativa3d::transformId;
              local6.alternativa3d::drawId = 0;
            }
            local5 = local5.alternativa3d::next;
          }
          if(local2 != null) {
            local3.alternativa3d::processNext = local4;
          } else {
            local2 = local4;
          }
          local3 = local4;
        }
        local4 = local4.alternativa3d::next;
      }
      if(local3 != null) {
        local3.alternativa3d::processNext = null;
      }
      return local2;
    }

    alternativa3d function drawDebug(param1:Camera3D, param2:Canvas, param3:Face, param4:int) : void {
      if(Boolean(param4 & Debug.EDGES)) {
        Debug.alternativa3d::drawEdges(param1,param2,param3,16777215);
      }
      if(Boolean(param4 & Debug.BOUNDS)) {
        Debug.alternativa3d::drawBounds(param1,param2,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
      }
    }

    alternativa3d function drawFaces(param1:Camera3D, param2:Canvas, param3:Face) : void {
      var local5:Face = null;
      var local4:Face = param3;
      while(local4 != null) {
        local5 = local4.alternativa3d::processNext;
        if(local5 == null || local5.material != param3.material) {
          local4.alternativa3d::processNext = null;
          if(param3.material != null) {
            param3.material.alternativa3d::draw(param1,param2,param3,alternativa3d::ml);
          } else {
            while(param3 != null) {
              local4 = param3.alternativa3d::processNext;
              param3.alternativa3d::processNext = null;
              param3 = local4;
            }
          }
          param3 = local5;
        }
        local4 = local5;
      }
    }

    override alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
      var local3:Vertex = this.alternativa3d::vertexList;
      while(local3 != null) {
        if(param2 != null) {
          local3.alternativa3d::cameraX = param2.alternativa3d::ma * local3.x + param2.alternativa3d::mb * local3.y + param2.alternativa3d::mc * local3.z + param2.alternativa3d::md;
          local3.alternativa3d::cameraY = param2.alternativa3d::me * local3.x + param2.alternativa3d::mf * local3.y + param2.alternativa3d::mg * local3.z + param2.alternativa3d::mh;
          local3.alternativa3d::cameraZ = param2.alternativa3d::mi * local3.x + param2.alternativa3d::mj * local3.y + param2.alternativa3d::mk * local3.z + param2.alternativa3d::ml;
        } else {
          local3.alternativa3d::cameraX = local3.x;
          local3.alternativa3d::cameraY = local3.y;
          local3.alternativa3d::cameraZ = local3.z;
        }
        if(local3.alternativa3d::cameraX < param1.boundMinX) {
          param1.boundMinX = local3.alternativa3d::cameraX;
        }
        if(local3.alternativa3d::cameraX > param1.boundMaxX) {
          param1.boundMaxX = local3.alternativa3d::cameraX;
        }
        if(local3.alternativa3d::cameraY < param1.boundMinY) {
          param1.boundMinY = local3.alternativa3d::cameraY;
        }
        if(local3.alternativa3d::cameraY > param1.boundMaxY) {
          param1.boundMaxY = local3.alternativa3d::cameraY;
        }
        if(local3.alternativa3d::cameraZ < param1.boundMinZ) {
          param1.boundMinZ = local3.alternativa3d::cameraZ;
        }
        if(local3.alternativa3d::cameraZ > param1.boundMaxZ) {
          param1.boundMaxZ = local3.alternativa3d::cameraZ;
        }
        local3 = local3.alternativa3d::next;
      }
    }

    override alternativa3d function split(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Number) : Vector.<Object3D> {
      var local9:Vertex = null;
      var local10:Vertex = null;
      var local14:Face = null;
      var local15:Face = null;
      var local17:Face = null;
      var local18:Wrapper = null;
      var local19:Vertex = null;
      var local20:Vertex = null;
      var local21:Vertex = null;
      var local22:Boolean = false;
      var local23:Boolean = false;
      var local24:Face = null;
      var local25:Face = null;
      var local26:Wrapper = null;
      var local27:Wrapper = null;
      var local28:Wrapper = null;
      var local29:Number = NaN;
      var local30:Vertex = null;
      var local5:Vector.<Object3D> = new Vector.<Object3D>(2);
      var local6:Vector3D = alternativa3d::calculatePlane(param1,param2,param3);
      var local7:Number = local6.w - param4;
      var local8:Number = local6.w + param4;
      local9 = this.alternativa3d::vertexList;
      while(local9 != null) {
        local10 = local9.alternativa3d::next;
        local9.alternativa3d::next = null;
        local9.alternativa3d::offset = local9.x * local6.x + local9.y * local6.y + local9.z * local6.z;
        if(local9.alternativa3d::offset >= local7 && local9.alternativa3d::offset <= local8) {
          local9.alternativa3d::value = new Vertex();
          local9.alternativa3d::value.x = local9.x;
          local9.alternativa3d::value.y = local9.y;
          local9.alternativa3d::value.z = local9.z;
          local9.alternativa3d::value.u = local9.u;
          local9.alternativa3d::value.v = local9.v;
          local9.alternativa3d::value.normalX = local9.normalX;
          local9.alternativa3d::value.normalY = local9.normalY;
          local9.alternativa3d::value.normalZ = local9.normalZ;
        }
        local9.alternativa3d::transformId = 0;
        local9 = local10;
      }
      this.alternativa3d::vertexList = null;
      var local11:Face = this.alternativa3d::faceList;
      this.alternativa3d::faceList = null;
      var local12:Mesh = this.clone() as Mesh;
      var local13:Mesh = this.clone() as Mesh;
      var local16:Face = local11;
      while(local16 != null) {
        local17 = local16.alternativa3d::next;
        local18 = local16.alternativa3d::wrapper;
        local19 = local18.alternativa3d::vertex;
        local18 = local18.alternativa3d::next;
        local20 = local18.alternativa3d::vertex;
        local18 = local18.alternativa3d::next;
        local21 = local18.alternativa3d::vertex;
        local22 = local19.alternativa3d::offset < local7 || local20.alternativa3d::offset < local7 || local21.alternativa3d::offset < local7;
        local23 = local19.alternativa3d::offset > local8 || local20.alternativa3d::offset > local8 || local21.alternativa3d::offset > local8;
        local18 = local18.alternativa3d::next;
        while(local18 != null) {
          local9 = local18.alternativa3d::vertex;
          if(local9.alternativa3d::offset < local7) {
            local22 = true;
          } else if(local9.alternativa3d::offset > local8) {
            local23 = true;
          }
          local18 = local18.alternativa3d::next;
        }
        if(!local22) {
          if(local15 != null) {
            local15.alternativa3d::next = local16;
          } else {
            local13.alternativa3d::faceList = local16;
          }
          local15 = local16;
        } else if(!local23) {
          if(local14 != null) {
            local14.alternativa3d::next = local16;
          } else {
            local12.alternativa3d::faceList = local16;
          }
          local14 = local16;
          local18 = local16.alternativa3d::wrapper;
          while(local18 != null) {
            if(local18.alternativa3d::vertex.alternativa3d::value != null) {
              local18.alternativa3d::vertex = local18.alternativa3d::vertex.alternativa3d::value;
            }
            local18 = local18.alternativa3d::next;
          }
        } else {
          local24 = new Face();
          local25 = new Face();
          local26 = null;
          local27 = null;
          local18 = local16.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
          while(local18.alternativa3d::next != null) {
            local18 = local18.alternativa3d::next;
          }
          local19 = local18.alternativa3d::vertex;
          local18 = local16.alternativa3d::wrapper;
          while(local18 != null) {
            local20 = local18.alternativa3d::vertex;
            if(local19.alternativa3d::offset < local7 && local20.alternativa3d::offset > local8 || local19.alternativa3d::offset > local8 && local20.alternativa3d::offset < local7) {
              local29 = (local6.w - local19.alternativa3d::offset) / (local20.alternativa3d::offset - local19.alternativa3d::offset);
              local9 = new Vertex();
              local9.x = local19.x + (local20.x - local19.x) * local29;
              local9.y = local19.y + (local20.y - local19.y) * local29;
              local9.z = local19.z + (local20.z - local19.z) * local29;
              local9.u = local19.u + (local20.u - local19.u) * local29;
              local9.v = local19.v + (local20.v - local19.v) * local29;
              local9.normalX = local19.normalX + (local20.normalX - local19.normalX) * local29;
              local9.normalY = local19.normalY + (local20.normalY - local19.normalY) * local29;
              local9.normalZ = local19.normalZ + (local20.normalZ - local19.normalZ) * local29;
              local28 = new Wrapper();
              local28.alternativa3d::vertex = local9;
              if(local26 != null) {
                local26.alternativa3d::next = local28;
              } else {
                local24.alternativa3d::wrapper = local28;
              }
              local26 = local28;
              local30 = new Vertex();
              local30.x = local9.x;
              local30.y = local9.y;
              local30.z = local9.z;
              local30.u = local9.u;
              local30.v = local9.v;
              local30.normalX = local9.normalX;
              local30.normalY = local9.normalY;
              local30.normalZ = local9.normalZ;
              local28 = new Wrapper();
              local28.alternativa3d::vertex = local30;
              if(local27 != null) {
                local27.alternativa3d::next = local28;
              } else {
                local25.alternativa3d::wrapper = local28;
              }
              local27 = local28;
            }
            if(local20.alternativa3d::offset < local7) {
              local28 = local18.alternativa3d::create();
              local28.alternativa3d::vertex = local20;
              if(local26 != null) {
                local26.alternativa3d::next = local28;
              } else {
                local24.alternativa3d::wrapper = local28;
              }
              local26 = local28;
            } else if(local20.alternativa3d::offset > local8) {
              local28 = local18.alternativa3d::create();
              local28.alternativa3d::vertex = local20;
              if(local27 != null) {
                local27.alternativa3d::next = local28;
              } else {
                local25.alternativa3d::wrapper = local28;
              }
              local27 = local28;
            } else {
              local28 = local18.alternativa3d::create();
              local28.alternativa3d::vertex = local20.alternativa3d::value;
              if(local26 != null) {
                local26.alternativa3d::next = local28;
              } else {
                local24.alternativa3d::wrapper = local28;
              }
              local26 = local28;
              local28 = local18.alternativa3d::create();
              local28.alternativa3d::vertex = local20;
              if(local27 != null) {
                local27.alternativa3d::next = local28;
              } else {
                local25.alternativa3d::wrapper = local28;
              }
              local27 = local28;
            }
            local19 = local20;
            local18 = local18.alternativa3d::next;
          }
          local24.material = local16.material;
          local24.alternativa3d::calculateBestSequenceAndNormal();
          if(local14 != null) {
            local14.alternativa3d::next = local24;
          } else {
            local12.alternativa3d::faceList = local24;
          }
          local14 = local24;
          local25.material = local16.material;
          local25.alternativa3d::calculateBestSequenceAndNormal();
          if(local15 != null) {
            local15.alternativa3d::next = local25;
          } else {
            local13.alternativa3d::faceList = local25;
          }
          local15 = local25;
        }
        local16 = local17;
      }
      if(local14 != null) {
        local14.alternativa3d::next = null;
        ++local12.alternativa3d::transformId;
        local12.collectVertices();
        local12.calculateBounds();
        local5[0] = local12;
      }
      if(local15 != null) {
        local15.alternativa3d::next = null;
        ++local13.alternativa3d::transformId;
        local13.collectVertices();
        local13.calculateBounds();
        local5[1] = local13;
      }
      return local5;
    }

    private function collectVertices() : void {
      var local2:Wrapper = null;
      var local3:Vertex = null;
      var local1:Face = this.alternativa3d::faceList;
      while(local1 != null) {
        local2 = local1.alternativa3d::wrapper;
        while(local2 != null) {
          local3 = local2.alternativa3d::vertex;
          if(local3.alternativa3d::transformId != alternativa3d::transformId) {
            local3.alternativa3d::next = this.alternativa3d::vertexList;
            this.alternativa3d::vertexList = local3;
            local3.alternativa3d::transformId = alternativa3d::transformId;
            local3.alternativa3d::value = null;
          }
          local2 = local2.alternativa3d::next;
        }
        local1 = local1.alternativa3d::next;
      }
    }
  }
}
