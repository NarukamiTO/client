package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.RayIntersectionData;
  import alternativa.engine3d.core.VG;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.gfx.core.IndexBufferResource;
  import alternativa.gfx.core.VertexBufferResource;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class Mesh extends Object3D {
    public var clipping:int = 2;
    public var sorting:int = 1;
    public var threshold:Number = 0.01;

    alternativa3d var vertexList:Vertex;
    alternativa3d var faceList:Face;
    alternativa3d var vertexBuffer:VertexBufferResource;
    alternativa3d var indexBuffer:IndexBufferResource;
    alternativa3d var numOpaqueTriangles:int;
    alternativa3d var numTriangles:int;

    protected var opaqueMaterials:Vector.<Material> = new Vector.<Material>();
    protected var opaqueBegins:Vector.<int> = new Vector.<int>();
    protected var opaqueNums:Vector.<int> = new Vector.<int>();
    protected var opaqueLength:int = 0;

    private var transparentList:Face;

    public function Mesh() {
      super();
    }

    public static function calculateVerticesNormalsBySmoothingGroupsForMeshList(param1:Vector.<Object3D>, param2:Number = 0) : void {
      var local3:int = 0;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:* = undefined;
      var local8:Mesh = null;
      var local9:Face = null;
      var local10:Vertex = null;
      var local11:Wrapper = null;
      var local16:Object3D = null;
      var local17:Vertex = null;
      var local18:Number = NaN;
      var local19:Face = null;
      var local12:Dictionary = new Dictionary();
      var local13:int = int(param1.length);
      local3 = 0;
      while(local3 < local13) {
        local8 = param1[local3] as Mesh;
        if(local8 != null) {
          local8.alternativa3d::deleteResources();
          local8.alternativa3d::composeMatrix();
          local16 = local8;
          while(local16.alternativa3d::_parent != null) {
            local16 = local16.alternativa3d::_parent;
            local16.alternativa3d::composeMatrix();
            local8.alternativa3d::appendMatrix(local16);
          }
          local10 = local8.alternativa3d::vertexList;
          while(local10 != null) {
            local4 = local10.x;
            local5 = local10.y;
            local6 = local10.z;
            local10.x = local8.alternativa3d::ma * local4 + local8.alternativa3d::mb * local5 + local8.alternativa3d::mc * local6 + local8.alternativa3d::md;
            local10.y = local8.alternativa3d::me * local4 + local8.alternativa3d::mf * local5 + local8.alternativa3d::mg * local6 + local8.alternativa3d::mh;
            local10.z = local8.alternativa3d::mi * local4 + local8.alternativa3d::mj * local5 + local8.alternativa3d::mk * local6 + local8.alternativa3d::ml;
            local10 = local10.alternativa3d::next;
          }
          local8.calculateNormalsAndRemoveDegenerateFaces();
          local9 = local8.alternativa3d::faceList;
          while(local9 != null) {
            if(local9.smoothingGroups > 0) {
              local11 = local9.alternativa3d::wrapper;
              while(local11 != null) {
                local10 = local11.alternativa3d::vertex;
                if(!local12[local10]) {
                  local12[local10] = new Dictionary();
                }
                local12[local10][local9] = true;
                local11 = local11.alternativa3d::next;
              }
            }
            local9 = local9.alternativa3d::next;
          }
        }
        local3++;
      }
      var local14:Vector.<Vertex> = new Vector.<Vertex>();
      var local15:int = 0;
      for(local7 in local12) {
        local14[local15] = local7;
        local15++;
      }
      if(local15 > 0) {
        shareFaces(local14,0,local15,0,param2,new Vector.<int>(),local12);
      }
      local3 = 0;
      while(local3 < local13) {
        local8 = param1[local3] as Mesh;
        if(local8 != null) {
          local8.alternativa3d::vertexList = null;
          local9 = local8.alternativa3d::faceList;
          while(local9 != null) {
            local11 = local9.alternativa3d::wrapper;
            while(local11 != null) {
              local10 = local11.alternativa3d::vertex;
              local17 = new Vertex();
              local17.x = local10.x;
              local17.y = local10.y;
              local17.z = local10.z;
              local17.u = local10.u;
              local17.v = local10.v;
              local17.id = local10.id;
              local17.normalX = local9.alternativa3d::normalX;
              local17.normalY = local9.alternativa3d::normalY;
              local17.normalZ = local9.alternativa3d::normalZ;
              if(local9.smoothingGroups > 0) {
                for(local7 in local12[local10]) {
                  local19 = local7;
                  if(local9 != local19 && (local9.smoothingGroups & local19.smoothingGroups) > 0) {
                    local17.normalX += local19.alternativa3d::normalX;
                    local17.normalY += local19.alternativa3d::normalY;
                    local17.normalZ += local19.alternativa3d::normalZ;
                  }
                }
                local18 = local17.normalX * local17.normalX + local17.normalY * local17.normalY + local17.normalZ * local17.normalZ;
                if(local18 > 0.001) {
                  local18 = 1 / Math.sqrt(local18);
                  local17.normalX *= local18;
                  local17.normalY *= local18;
                  local17.normalZ *= local18;
                }
              }
              local11.alternativa3d::vertex = local17;
              local17.alternativa3d::next = local8.alternativa3d::vertexList;
              local8.alternativa3d::vertexList = local17;
              local11 = local11.alternativa3d::next;
            }
            local9 = local9.alternativa3d::next;
          }
        }
        local3++;
      }
      local3 = 0;
      while(local3 < local13) {
        local8 = param1[local3] as Mesh;
        if(local8 != null) {
          local8.alternativa3d::invertMatrix();
          local10 = local8.alternativa3d::vertexList;
          while(local10 != null) {
            local4 = local10.x;
            local5 = local10.y;
            local6 = local10.z;
            local10.x = local8.alternativa3d::ma * local4 + local8.alternativa3d::mb * local5 + local8.alternativa3d::mc * local6 + local8.alternativa3d::md;
            local10.y = local8.alternativa3d::me * local4 + local8.alternativa3d::mf * local5 + local8.alternativa3d::mg * local6 + local8.alternativa3d::mh;
            local10.z = local8.alternativa3d::mi * local4 + local8.alternativa3d::mj * local5 + local8.alternativa3d::mk * local6 + local8.alternativa3d::ml;
            local4 = local10.normalX;
            local5 = local10.normalY;
            local6 = local10.normalZ;
            local10.normalX = local8.alternativa3d::ma * local4 + local8.alternativa3d::mb * local5 + local8.alternativa3d::mc * local6;
            local10.normalY = local8.alternativa3d::me * local4 + local8.alternativa3d::mf * local5 + local8.alternativa3d::mg * local6;
            local10.normalZ = local8.alternativa3d::mi * local4 + local8.alternativa3d::mj * local5 + local8.alternativa3d::mk * local6;
            local10 = local10.alternativa3d::next;
          }
          local9 = local8.alternativa3d::faceList;
          while(local9 != null) {
            local4 = Number(local9.alternativa3d::normalX);
            local5 = Number(local9.alternativa3d::normalY);
            local6 = Number(local9.alternativa3d::normalZ);
            local9.alternativa3d::normalX = local8.alternativa3d::ma * local4 + local8.alternativa3d::mb * local5 + local8.alternativa3d::mc * local6;
            local9.alternativa3d::normalY = local8.alternativa3d::me * local4 + local8.alternativa3d::mf * local5 + local8.alternativa3d::mg * local6;
            local9.alternativa3d::normalZ = local8.alternativa3d::mi * local4 + local8.alternativa3d::mj * local5 + local8.alternativa3d::mk * local6;
            local9.alternativa3d::offset = local9.alternativa3d::wrapper.alternativa3d::vertex.x * local9.alternativa3d::normalX + local9.alternativa3d::wrapper.alternativa3d::vertex.y * local9.alternativa3d::normalY + local9.alternativa3d::wrapper.alternativa3d::vertex.z * local9.alternativa3d::normalZ;
            local9 = local9.alternativa3d::next;
          }
        }
        local3++;
      }
    }

    private static function shareFaces(param1:Vector.<Vertex>, param2:int, param3:int, param4:int, param5:Number, param6:Vector.<int>, param7:Dictionary) : void {
      var local8:int = 0;
      var local9:int = 0;
      var local10:int = 0;
      var local11:Vertex = null;
      var local13:Vertex = null;
      var local14:int = 0;
      var local15:int = 0;
      var local16:Number = NaN;
      var local17:Vertex = null;
      var local18:Vertex = null;
      var local19:* = undefined;
      switch(param4) {
        case 0:
          local8 = param2;
          while(local8 < param3) {
            local11 = param1[local8];
            local11.alternativa3d::offset = local11.x;
            local8++;
          }
          break;
        case 1:
          local8 = param2;
          while(local8 < param3) {
            local11 = param1[local8];
            local11.alternativa3d::offset = local11.y;
            local8++;
          }
          break;
        case 2:
          local8 = param2;
          while(local8 < param3) {
            local11 = param1[local8];
            local11.alternativa3d::offset = local11.z;
            local8++;
          }
      }
      param6[0] = param2;
      param6[1] = param3 - 1;
      var local12:int = 2;
      while(local12 > 0) {
        local12--;
        local14 = param6[local12];
        local9 = local14;
        local12--;
        local15 = param6[local12];
        local8 = local15;
        local11 = param1[local14 + local15 >> 1];
        local16 = Number(local11.alternativa3d::offset);
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
          param6[local12] = local15;
          local12++;
          param6[local12] = local9;
          local12++;
        }
        if(local8 < local14) {
          param6[local12] = local8;
          local12++;
          param6[local12] = local14;
          local12++;
        }
      }
      local8 = param2;
      local11 = param1[local8];
      local9 = local8 + 1;
      while(local9 <= param3) {
        if(local9 < param3) {
          local13 = param1[local9];
        }
        if(local9 == param3 || local11.alternativa3d::offset - local13.alternativa3d::offset > param5) {
          if(local9 - local8 > 1) {
            if(param4 < 2) {
              shareFaces(param1,local8,local9,param4 + 1,param5,param6,param7);
            } else {
              local10 = local8 + 1;
              while(local10 < local9) {
                local13 = param1[local10];
                for(local19 in param7[local13]) {
                  param7[local11][local19] = true;
                }
                local10++;
              }
              local10 = local8 + 1;
              while(local10 < local9) {
                local13 = param1[local10];
                for(local19 in param7[local11]) {
                  param7[local13][local19] = true;
                }
                local10++;
              }
            }
          }
          if(local9 < param3) {
            local8 = local9;
            local11 = param1[local8];
          }
        }
        local9++;
      }
    }

    public function addVertex(param1:Number, param2:Number, param3:Number, param4:Number = 0, param5:Number = 0, param6:Object = null) : Vertex {
      var local8:Vertex = null;
      this.alternativa3d::deleteResources();
      var local7:Vertex = new Vertex();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      this.alternativa3d::deleteResources();
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
      var local3:Face = null;
      var local4:Wrapper = null;
      var local5:Vertex = null;
      var local8:Vertex = null;
      var local9:* = undefined;
      var local10:Number = NaN;
      var local11:Face = null;
      this.alternativa3d::deleteResources();
      this.calculateNormalsAndRemoveDegenerateFaces();
      var local6:Dictionary = new Dictionary();
      local5 = this.alternativa3d::vertexList;
      while(local5 != null) {
        local6[local5] = new Dictionary();
        local5 = local5.alternativa3d::next;
      }
      local3 = this.alternativa3d::faceList;
      while(local3 != null) {
        local4 = local3.alternativa3d::wrapper;
        while(local4 != null) {
          local5 = local4.alternativa3d::vertex;
          local6[local5][local3] = true;
          local4 = local4.alternativa3d::next;
        }
        local3 = local3.alternativa3d::next;
      }
      var local7:Vector.<Vertex> = this.vertices;
      shareFaces(local7,0,local7.length,0,param2,new Vector.<int>(),local6);
      this.alternativa3d::vertexList = null;
      param1 = Math.cos(param1);
      local3 = this.alternativa3d::faceList;
      while(local3 != null) {
        local4 = local3.alternativa3d::wrapper;
        while(local4 != null) {
          local5 = local4.alternativa3d::vertex;
          local8 = new Vertex();
          local8.x = local5.x;
          local8.y = local5.y;
          local8.z = local5.z;
          local8.u = local5.u;
          local8.v = local5.v;
          local8.id = local5.id;
          local8.normalX = local3.alternativa3d::normalX;
          local8.normalY = local3.alternativa3d::normalY;
          local8.normalZ = local3.alternativa3d::normalZ;
          for(local9 in local6[local5]) {
            local11 = local9;
            if(local3 != local11 && local3.alternativa3d::normalX * local11.alternativa3d::normalX + local3.alternativa3d::normalY * local11.alternativa3d::normalY + local3.alternativa3d::normalZ * local11.alternativa3d::normalZ >= param1) {
              local8.normalX += local11.alternativa3d::normalX;
              local8.normalY += local11.alternativa3d::normalY;
              local8.normalZ += local11.alternativa3d::normalZ;
            }
          }
          local10 = local8.normalX * local8.normalX + local8.normalY * local8.normalY + local8.normalZ * local8.normalZ;
          if(local10 > 0.001) {
            local10 = 1 / Math.sqrt(local10);
            local8.normalX *= local10;
            local8.normalY *= local10;
            local8.normalZ *= local10;
          }
          local4.alternativa3d::vertex = local8;
          local8.alternativa3d::next = this.alternativa3d::vertexList;
          this.alternativa3d::vertexList = local8;
          local4 = local4.alternativa3d::next;
        }
        local3 = local3.alternativa3d::next;
      }
    }

    public function calculateVerticesNormalsBySmoothingGroups(param1:Number = 0) : void {
      var local2:* = undefined;
      var local3:Face = null;
      var local4:Vertex = null;
      var local5:Wrapper = null;
      var local9:Vertex = null;
      var local10:Number = NaN;
      var local11:Face = null;
      this.alternativa3d::deleteResources();
      this.calculateNormalsAndRemoveDegenerateFaces();
      var local6:Dictionary = new Dictionary();
      local3 = this.alternativa3d::faceList;
      while(local3 != null) {
        if(local3.smoothingGroups > 0) {
          local5 = local3.alternativa3d::wrapper;
          while(local5 != null) {
            local4 = local5.alternativa3d::vertex;
            if(!local6[local4]) {
              local6[local4] = new Dictionary();
            }
            local6[local4][local3] = true;
            local5 = local5.alternativa3d::next;
          }
        }
        local3 = local3.alternativa3d::next;
      }
      var local7:Vector.<Vertex> = new Vector.<Vertex>();
      var local8:int = 0;
      for(local2 in local6) {
        local7[local8] = local2;
        local8++;
      }
      if(local8 > 0) {
        shareFaces(local7,0,local8,0,param1,new Vector.<int>(),local6);
      }
      this.alternativa3d::vertexList = null;
      local3 = this.alternativa3d::faceList;
      while(local3 != null) {
        local5 = local3.alternativa3d::wrapper;
        while(local5 != null) {
          local4 = local5.alternativa3d::vertex;
          local9 = new Vertex();
          local9.x = local4.x;
          local9.y = local4.y;
          local9.z = local4.z;
          local9.u = local4.u;
          local9.v = local4.v;
          local9.id = local4.id;
          local9.normalX = local3.alternativa3d::normalX;
          local9.normalY = local3.alternativa3d::normalY;
          local9.normalZ = local3.alternativa3d::normalZ;
          if(local3.smoothingGroups > 0) {
            for(local2 in local6[local4]) {
              local11 = local2;
              if(local3 != local11 && (local3.smoothingGroups & local11.smoothingGroups) > 0) {
                local9.normalX += local11.alternativa3d::normalX;
                local9.normalY += local11.alternativa3d::normalY;
                local9.normalZ += local11.alternativa3d::normalZ;
              }
            }
            local10 = local9.normalX * local9.normalX + local9.normalY * local9.normalY + local9.normalZ * local9.normalZ;
            if(local10 > 0.001) {
              local10 = 1 / Math.sqrt(local10);
              local9.normalX *= local10;
              local9.normalY *= local10;
              local9.normalZ *= local10;
            }
          }
          local5.alternativa3d::vertex = local9;
          local9.alternativa3d::next = this.alternativa3d::vertexList;
          this.alternativa3d::vertexList = local9;
          local5 = local5.alternativa3d::next;
        }
        local3 = local3.alternativa3d::next;
      }
    }

    private function calculateNormalsAndRemoveDegenerateFaces() : void {
      var local2:Face = null;
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
      var local1:Face = this.alternativa3d::faceList;
      this.alternativa3d::faceList = null;
      while(local1 != null) {
        local2 = local1.alternativa3d::next;
        local3 = local1.alternativa3d::wrapper;
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
        local1.alternativa3d::normalX = local12 * local8 - local11 * local9;
        local1.alternativa3d::normalY = local10 * local9 - local12 * local7;
        local1.alternativa3d::normalZ = local11 * local7 - local10 * local8;
        local13 = local1.alternativa3d::normalX * local1.alternativa3d::normalX + local1.alternativa3d::normalY * local1.alternativa3d::normalY + local1.alternativa3d::normalZ * local1.alternativa3d::normalZ;
        if(local13 > 0.001) {
          local13 = 1 / Math.sqrt(local13);
          local1.alternativa3d::normalX *= local13;
          local1.alternativa3d::normalY *= local13;
          local1.alternativa3d::normalZ *= local13;
          local1.alternativa3d::offset = local4.x * local1.alternativa3d::normalX + local4.y * local1.alternativa3d::normalY + local4.z * local1.alternativa3d::normalZ;
          local1.alternativa3d::next = this.alternativa3d::faceList;
          this.alternativa3d::faceList = local1;
        } else {
          local1.alternativa3d::next = null;
        }
        local1 = local2;
      }
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
      this.alternativa3d::deleteResources();
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

    override alternativa3d function draw(param1:Camera3D) : void {
      var local2:Face = null;
      var local4:Vertex = null;
      if(this.alternativa3d::faceList == null) {
        return;
      }
      if(this.clipping == 0) {
        if(Boolean(alternativa3d::culling & 1)) {
          return;
        }
        alternativa3d::culling = 0;
      }
      this.alternativa3d::prepareResources();
      if(alternativa3d::useDepth = !param1.view.alternativa3d::constrained && (param1.softTransparency && param1.softTransparencyStrength > 0 || param1.ssao && param1.ssaoStrength > 0 || param1.deferredLighting && param1.deferredLightingStrength > 0) && alternativa3d::concatenatedAlpha >= depthMapAlphaThreshold) {
        param1.alternativa3d::depthObjects[param1.alternativa3d::depthCount] = this;
        ++param1.alternativa3d::depthCount;
      }
      if(alternativa3d::concatenatedAlpha >= 1 && alternativa3d::concatenatedBlendMode == "normal") {
        this.alternativa3d::addOpaque(param1);
        local2 = this.transparentList;
      } else {
        local2 = this.alternativa3d::faceList;
      }
      alternativa3d::transformConst[0] = alternativa3d::ma;
      alternativa3d::transformConst[1] = alternativa3d::mb;
      alternativa3d::transformConst[2] = alternativa3d::mc;
      alternativa3d::transformConst[3] = alternativa3d::md;
      alternativa3d::transformConst[4] = alternativa3d::me;
      alternativa3d::transformConst[5] = alternativa3d::mf;
      alternativa3d::transformConst[6] = alternativa3d::mg;
      alternativa3d::transformConst[7] = alternativa3d::mh;
      alternativa3d::transformConst[8] = alternativa3d::mi;
      alternativa3d::transformConst[9] = alternativa3d::mj;
      alternativa3d::transformConst[10] = alternativa3d::mk;
      alternativa3d::transformConst[11] = alternativa3d::ml;
      var local3:int = param1.debug ? int(param1.alternativa3d::checkInDebug(this)) : 0;
      if(Boolean(local3 & Debug.BOUNDS)) {
        Debug.alternativa3d::drawBounds(param1,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
      }
      if(local2 == null) {
        return;
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
      local2 = this.alternativa3d::prepareFaces(param1,local2);
      if(local2 == null) {
        return;
      }
      if(alternativa3d::culling > 0) {
        if(this.clipping == 1) {
          local2 = param1.alternativa3d::cull(local2,alternativa3d::culling);
        } else {
          local2 = param1.alternativa3d::clip(local2,alternativa3d::culling);
        }
        if(local2 == null) {
          return;
        }
      }
      if(local2.alternativa3d::processNext != null) {
        if(this.sorting == 1) {
          local2 = param1.alternativa3d::sortByAverageZ(local2);
        } else if(this.sorting == 2) {
          local2 = param1.alternativa3d::sortByDynamicBSP(local2,this.threshold);
        }
      }
      if(Boolean(local3 & Debug.EDGES)) {
        Debug.alternativa3d::drawEdges(param1,local2,16777215);
      }
      this.alternativa3d::drawFaces(param1,local2);
    }

    override alternativa3d function getVG(param1:Camera3D) : VG {
      var local2:Face = null;
      var local4:Vertex = null;
      if(this.alternativa3d::faceList == null) {
        return null;
      }
      if(this.clipping == 0) {
        if(Boolean(alternativa3d::culling & 1)) {
          return null;
        }
        alternativa3d::culling = 0;
      }
      this.alternativa3d::prepareResources();
      if(alternativa3d::useDepth = !param1.view.alternativa3d::constrained && (param1.softTransparency && param1.softTransparencyStrength > 0 || param1.ssao && param1.ssaoStrength > 0 || param1.deferredLighting && param1.deferredLightingStrength > 0) && alternativa3d::concatenatedAlpha >= depthMapAlphaThreshold) {
        param1.alternativa3d::depthObjects[param1.alternativa3d::depthCount] = this;
        ++param1.alternativa3d::depthCount;
      }
      if(alternativa3d::concatenatedAlpha >= 1 && alternativa3d::concatenatedBlendMode == "normal") {
        this.alternativa3d::addOpaque(param1);
        local2 = this.transparentList;
      } else {
        local2 = this.alternativa3d::faceList;
      }
      alternativa3d::transformConst[0] = alternativa3d::ma;
      alternativa3d::transformConst[1] = alternativa3d::mb;
      alternativa3d::transformConst[2] = alternativa3d::mc;
      alternativa3d::transformConst[3] = alternativa3d::md;
      alternativa3d::transformConst[4] = alternativa3d::me;
      alternativa3d::transformConst[5] = alternativa3d::mf;
      alternativa3d::transformConst[6] = alternativa3d::mg;
      alternativa3d::transformConst[7] = alternativa3d::mh;
      alternativa3d::transformConst[8] = alternativa3d::mi;
      alternativa3d::transformConst[9] = alternativa3d::mj;
      alternativa3d::transformConst[10] = alternativa3d::mk;
      alternativa3d::transformConst[11] = alternativa3d::ml;
      var local3:int = param1.debug ? int(param1.alternativa3d::checkInDebug(this)) : 0;
      if(Boolean(local3 & Debug.BOUNDS)) {
        Debug.alternativa3d::drawBounds(param1,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
      }
      if(local2 == null) {
        return null;
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
      local2 = this.alternativa3d::prepareFaces(param1,local2);
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
      return VG.alternativa3d::create(this,local2,this.sorting,local3,false);
    }

    alternativa3d function prepareResources() : void {
      var local1:Vector.<Number> = null;
      var local2:int = 0;
      var local3:int = 0;
      var local4:Vertex = null;
      var local5:int = 0;
      var local6:int = 0;
      var local7:int = 0;
      var local8:Face = null;
      var local9:Face = null;
      var local10:Face = null;
      var local11:Wrapper = null;
      var local12:Dictionary = null;
      var local13:Vector.<uint> = null;
      var local14:int = 0;
      var local15:* = undefined;
      var local16:Face = null;
      if(this.alternativa3d::vertexBuffer == null) {
        local1 = new Vector.<Number>();
        local2 = 0;
        local3 = 0;
        local4 = this.alternativa3d::vertexList;
        while(local4 != null) {
          local1[local2] = local4.x;
          local2++;
          local1[local2] = local4.y;
          local2++;
          local1[local2] = local4.z;
          local2++;
          local1[local2] = local4.u;
          local2++;
          local1[local2] = local4.v;
          local2++;
          local1[local2] = local4.normalX;
          local2++;
          local1[local2] = local4.normalY;
          local2++;
          local1[local2] = local4.normalZ;
          local2++;
          local4.alternativa3d::index = local3;
          local3++;
          local4 = local4.alternativa3d::next;
        }
        if(local3 > 0) {
          this.alternativa3d::vertexBuffer = new VertexBufferResource(local1,8);
        }
        local12 = new Dictionary();
        local8 = this.alternativa3d::faceList;
        while(local8 != null) {
          local9 = local8.alternativa3d::next;
          local8.alternativa3d::next = null;
          if(local8.material != null && (!local8.material.alternativa3d::transparent || local8.material.alphaTestThreshold > 0)) {
            local8.alternativa3d::next = local12[local8.material];
            local12[local8.material] = local8;
          } else {
            if(local10 != null) {
              local10.alternativa3d::next = local8;
            } else {
              this.transparentList = local8;
            }
            local10 = local8;
          }
          local8 = local9;
        }
        this.alternativa3d::faceList = this.transparentList;
        local13 = new Vector.<uint>();
        local14 = 0;
        for(local15 in local12) {
          local16 = local12[local15];
          this.opaqueMaterials[this.opaqueLength] = local16.material;
          this.opaqueBegins[this.opaqueLength] = this.alternativa3d::numTriangles * 3;
          local8 = local16;
          while(local8 != null) {
            local11 = local8.alternativa3d::wrapper;
            local5 = int(local11.alternativa3d::vertex.alternativa3d::index);
            local11 = local11.alternativa3d::next;
            local6 = int(local11.alternativa3d::vertex.alternativa3d::index);
            local11 = local11.alternativa3d::next;
            while(local11 != null) {
              local7 = int(local11.alternativa3d::vertex.alternativa3d::index);
              local13[local14] = local5;
              local14++;
              local13[local14] = local6;
              local14++;
              local13[local14] = local7;
              local14++;
              local6 = local7;
              ++this.alternativa3d::numTriangles;
              local11 = local11.alternativa3d::next;
            }
            if(local8.alternativa3d::next == null) {
              local10 = local8;
            }
            local8 = local8.alternativa3d::next;
          }
          this.opaqueNums[this.opaqueLength] = this.alternativa3d::numTriangles - this.opaqueBegins[this.opaqueLength] / 3;
          ++this.opaqueLength;
          local10.alternativa3d::next = this.alternativa3d::faceList;
          this.alternativa3d::faceList = local16;
        }
        this.alternativa3d::numOpaqueTriangles = this.alternativa3d::numTriangles;
        local8 = this.transparentList;
        while(local8 != null) {
          local11 = local8.alternativa3d::wrapper;
          local5 = int(local11.alternativa3d::vertex.alternativa3d::index);
          local11 = local11.alternativa3d::next;
          local6 = int(local11.alternativa3d::vertex.alternativa3d::index);
          local11 = local11.alternativa3d::next;
          while(local11 != null) {
            local7 = int(local11.alternativa3d::vertex.alternativa3d::index);
            local13[local14] = local5;
            local14++;
            local13[local14] = local6;
            local14++;
            local13[local14] = local7;
            local14++;
            local6 = local7;
            ++this.alternativa3d::numTriangles;
            local11 = local11.alternativa3d::next;
          }
          local8 = local8.alternativa3d::next;
        }
        if(local14 > 0) {
          this.alternativa3d::indexBuffer = new IndexBufferResource(local13);
        }
      }
    }

    alternativa3d function deleteResources() : void {
      if(this.alternativa3d::vertexBuffer != null) {
        this.alternativa3d::vertexBuffer.dispose();
        this.alternativa3d::vertexBuffer = null;
        this.alternativa3d::indexBuffer.dispose();
        this.alternativa3d::indexBuffer = null;
        this.alternativa3d::numTriangles = 0;
        this.alternativa3d::numOpaqueTriangles = 0;
        this.opaqueMaterials.length = 0;
        this.opaqueBegins.length = 0;
        this.opaqueNums.length = 0;
        this.opaqueLength = 0;
        this.transparentList = null;
      }
    }

    alternativa3d function addOpaque(param1:Camera3D) : void {
      var local2:int = 0;
      while(local2 < this.opaqueLength) {
        param1.alternativa3d::addOpaque(this.opaqueMaterials[local2],this.alternativa3d::vertexBuffer,this.alternativa3d::indexBuffer,this.opaqueBegins[local2],this.opaqueNums[local2],this);
        local2++;
      }
    }

    alternativa3d function prepareFaces(param1:Camera3D, param2:Face) : Face {
      var local3:Face = null;
      var local4:Face = null;
      var local5:Face = null;
      var local6:Wrapper = null;
      var local7:Vertex = null;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      local5 = param2;
      while(local5 != null) {
        if(local5.alternativa3d::normalX * alternativa3d::imd + local5.alternativa3d::normalY * alternativa3d::imh + local5.alternativa3d::normalZ * alternativa3d::iml > local5.alternativa3d::offset) {
          local6 = local5.alternativa3d::wrapper;
          while(local6 != null) {
            local7 = local6.alternativa3d::vertex;
            if(local7.alternativa3d::transformId != alternativa3d::transformId) {
              local8 = local7.x;
              local9 = local7.y;
              local10 = local7.z;
              local7.alternativa3d::cameraX = alternativa3d::ma * local8 + alternativa3d::mb * local9 + alternativa3d::mc * local10 + alternativa3d::md;
              local7.alternativa3d::cameraY = alternativa3d::me * local8 + alternativa3d::mf * local9 + alternativa3d::mg * local10 + alternativa3d::mh;
              local7.alternativa3d::cameraZ = alternativa3d::mi * local8 + alternativa3d::mj * local9 + alternativa3d::mk * local10 + alternativa3d::ml;
              local7.alternativa3d::transformId = alternativa3d::transformId;
              local7.alternativa3d::drawId = 0;
            }
            local6 = local6.alternativa3d::next;
          }
          if(local3 != null) {
            local4.alternativa3d::processNext = local5;
          } else {
            local3 = local5;
          }
          local4 = local5;
        }
        local5 = local5.alternativa3d::next;
      }
      if(local4 != null) {
        local4.alternativa3d::processNext = null;
      }
      return local3;
    }

    alternativa3d function drawFaces(param1:Camera3D, param2:Face) : void {
      var local3:Face = null;
      var local4:Face = null;
      var local5:Face = null;
      local5 = param2;
      while(local5 != null) {
        local3 = local5.alternativa3d::processNext;
        if(local3 == null || local3.material != param2.material) {
          local5.alternativa3d::processNext = null;
          if(param2.material != null) {
            param2.alternativa3d::processNegative = local4;
            local4 = param2;
          } else {
            while(param2 != null) {
              local5 = param2.alternativa3d::processNext;
              param2.alternativa3d::processNext = null;
              param2 = local5;
            }
          }
          param2 = local3;
        }
        local5 = local3;
      }
      param2 = local4;
      while(param2 != null) {
        local3 = param2.alternativa3d::processNegative;
        param2.alternativa3d::processNegative = null;
        param1.alternativa3d::addTransparent(param2,this);
        param2 = local3;
      }
    }

    override alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
      var local3:Vertex = null;
      local3 = this.alternativa3d::vertexList;
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
      var local5:Vector.<Object3D> = null;
      var local6:Vector3D = null;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Vertex = null;
      var local10:Vertex = null;
      var local11:Face = null;
      var local12:Mesh = null;
      var local13:Mesh = null;
      var local14:Face = null;
      var local15:Face = null;
      var local16:Face = null;
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
      this.alternativa3d::deleteResources();
      local5 = new Vector.<Object3D>(2);
      local6 = alternativa3d::calculatePlane(param1,param2,param3);
      local7 = local6.w - param4;
      local8 = local6.w + param4;
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
      local11 = this.alternativa3d::faceList;
      this.alternativa3d::faceList = null;
      local12 = this.clone() as Mesh;
      local13 = this.clone() as Mesh;
      local16 = local11;
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
      var local1:Face = null;
      var local2:Wrapper = null;
      var local3:Vertex = null;
      local1 = this.alternativa3d::faceList;
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
