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

  public class BSP extends Object3D {
    public var clipping:int = 2;
    public var threshold:Number = 0.01;
    public var splitAnalysis:Boolean = true;

    alternativa3d var vertexList:Vertex;

    private var root:Node;

    alternativa3d var faces:Vector.<Face> = new Vector.<Face>();

    public function BSP() {
      super();
    }

    public function createTree(param1:Mesh, param2:Boolean = false) : void {
      this.destroyTree();
      if(!param2) {
        param1 = param1.clone() as Mesh;
      }
      var local3:Face = param1.alternativa3d::faceList;
      this.alternativa3d::vertexList = param1.alternativa3d::vertexList;
      param1.alternativa3d::faceList = null;
      param1.alternativa3d::vertexList = null;
      var local4:Vertex = this.alternativa3d::vertexList;
      while(local4 != null) {
        local4.alternativa3d::transformId = 0;
        local4.id = null;
        local4 = local4.alternativa3d::next;
      }
      var local5:int = 0;
      var local6:Face = local3;
      while(local6 != null) {
        local6.alternativa3d::calculateBestSequenceAndNormal();
        local6.id = null;
        this.alternativa3d::faces[local5] = local6;
        local5++;
        local6 = local6.alternativa3d::next;
      }
      if(local3 != null) {
        this.root = this.createNode(local3);
      }
      calculateBounds();
    }

    public function destroyTree() : void {
      this.alternativa3d::vertexList = null;
      if(this.root != null) {
        this.destroyNode(this.root);
        this.root = null;
      }
      this.alternativa3d::faces.length = 0;
    }

    public function setMaterialToAllFaces(param1:Material) : void {
      var local4:Face = null;
      var local2:int = int(this.alternativa3d::faces.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = this.alternativa3d::faces[local3];
        local4.material = param1;
        local3++;
      }
      if(this.root != null) {
        this.setMaterialToNode(this.root,param1);
      }
    }

    override public function calculateResolution(param1:int, param2:int, param3:int = 1, param4:Matrix3D = null) : Number {
      var local6:Object3D = null;
      var local12:Face = null;
      var local13:Wrapper = null;
      var local14:Vertex = null;
      var local15:Vertex = null;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local5:int = int(this.alternativa3d::faces.length);
      if(param4 != null) {
        local6 = new Object3D();
        local6.matrix = param4;
        local6.alternativa3d::composeMatrix();
      }
      var local7:Number = 1e+22;
      var local8:Number = 0;
      var local9:Number = 0;
      var local10:int = 0;
      var local11:int = 0;
      while(local11 < local5) {
        local12 = this.alternativa3d::faces[local11];
        local13 = local12.alternativa3d::wrapper;
        while(local13 != null) {
          local14 = local13.alternativa3d::vertex;
          local15 = local13.alternativa3d::next != null ? local13.alternativa3d::next.alternativa3d::vertex : local12.alternativa3d::wrapper.alternativa3d::vertex;
          local16 = local6 != null ? local6.alternativa3d::ma * (local15.x - local14.x) + local6.alternativa3d::mb * (local15.y - local14.y) + local6.alternativa3d::mc * (local15.z - local14.z) : local15.x - local14.x;
          local17 = local6 != null ? local6.alternativa3d::me * (local15.x - local14.x) + local6.alternativa3d::mf * (local15.y - local14.y) + local6.alternativa3d::mg * (local15.z - local14.z) : local15.y - local14.y;
          local18 = local6 != null ? local6.alternativa3d::mi * (local15.x - local14.x) + local6.alternativa3d::mj * (local15.y - local14.y) + local6.alternativa3d::mk * (local15.z - local14.z) : local15.z - local14.z;
          local19 = (local15.u - local14.u) * param1;
          local20 = (local15.v - local14.v) * param2;
          local21 = local16 * local16 + local17 * local17 + local18 * local18;
          local22 = local19 * local19 + local20 * local20;
          if(local21 > 0.001 && local22 > 0.001) {
            local23 = Math.sqrt(local21 / local22);
            if(local23 < local7) {
              local7 = local23;
            }
            if(local23 > local8) {
              local8 = local23;
            }
            local9 += local23;
            local10++;
            if(param3 == 0) {
              break;
            }
          }
          local13 = local13.alternativa3d::next;
        }
        local11++;
      }
      if(local10 == 0) {
        return 1;
      }
      return param3 < 2 ? local9 / local10 : (param3 == 2 ? local7 : local8);
    }

    override public function intersectRay(param1:Vector3D, param2:Vector3D, param3:Dictionary = null, param4:Camera3D = null) : RayIntersectionData {
      if(param3 != null && param3[this] || this.root == null) {
        return null;
      }
      if(!alternativa3d::boundIntersectRay(param1,param2,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
        return null;
      }
      return this.intersectRayNode(this.root,param1.x,param1.y,param1.z,param2.x,param2.y,param2.z);
    }

    private function intersectRayNode(param1:Node, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : RayIntersectionData {
      var local8:RayIntersectionData = null;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Face = null;
      var local19:Wrapper = null;
      var local20:Vertex = null;
      var local21:Vertex = null;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local9:Number = param1.normalX;
      var local10:Number = param1.normalY;
      var local11:Number = param1.normalZ;
      var local12:Number = local9 * param2 + local10 * param3 + local11 * param4 - param1.offset;
      if(local12 > 0) {
        if(param1.positive != null) {
          local8 = this.intersectRayNode(param1.positive,param2,param3,param4,param5,param6,param7);
          if(local8 != null) {
            return local8;
          }
        }
        local13 = param5 * local9 + param6 * local10 + param7 * local11;
        if(local13 < 0) {
          local14 = -local12 / local13;
          local15 = param2 + param5 * local14;
          local16 = param3 + param6 * local14;
          local17 = param4 + param7 * local14;
          local18 = param1.faceList;
          while(true) {
            if(local18 != null) {
              local19 = local18.alternativa3d::wrapper;
              while(local19 != null) {
                local20 = local19.alternativa3d::vertex;
                local21 = local19.alternativa3d::next != null ? local19.alternativa3d::next.alternativa3d::vertex : local18.alternativa3d::wrapper.alternativa3d::vertex;
                local22 = local21.x - local20.x;
                local23 = local21.y - local20.y;
                local24 = local21.z - local20.z;
                local25 = local15 - local20.x;
                local26 = local16 - local20.y;
                local27 = local17 - local20.z;
                if((local27 * local23 - local26 * local24) * local9 + (local25 * local24 - local27 * local22) * local10 + (local26 * local22 - local25 * local23) * local11 < 0) {
                  break;
                }
                local19 = local19.alternativa3d::next;
              }
              if(local19 == null) {
                break;
              }
              local18 = local18.alternativa3d::next;
              continue;
            }
            if(param1.negative != null) {
              return this.intersectRayNode(param1.negative,param2,param3,param4,param5,param6,param7);
            }
          }
          local8 = new RayIntersectionData();
          local8.object = this;
          local8.face = local18;
          local8.point = new Vector3D(local15,local16,local17);
          local8.uv = local18.getUV(local8.point);
          local8.time = local14;
          return local8;
        }
      } else {
        if(param1.negative != null) {
          local8 = this.intersectRayNode(param1.negative,param2,param3,param4,param5,param6,param7);
          if(local8 != null) {
            return local8;
          }
        }
        if(param1.positive != null && param5 * local9 + param6 * local10 + param7 * local11 > 0) {
          return this.intersectRayNode(param1.positive,param2,param3,param4,param5,param6,param7);
        }
      }
      return null;
    }

    override alternativa3d function checkIntersection(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Dictionary) : Boolean {
      return this.root != null ? this.checkIntersectionNode(this.root,param1,param2,param3,param4,param5,param6,param7) : false;
    }

    private function checkIntersectionNode(param1:Node, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Boolean {
      var local9:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Face = null;
      var local19:Wrapper = null;
      var local20:Vertex = null;
      var local21:Vertex = null;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local10:Number = param1.normalX;
      var local11:Number = param1.normalY;
      var local12:Number = param1.normalZ;
      var local13:Number = local10 * param2 + local11 * param3 + local12 * param4 - param1.offset;
      if(local13 > 0) {
        local9 = param5 * local10 + param6 * local11 + param7 * local12;
        if(local9 < 0) {
          local14 = -local13 / local9;
          if(local14 < param8) {
            local15 = param2 + param5 * local14;
            local16 = param3 + param6 * local14;
            local17 = param4 + param7 * local14;
            local18 = param1.faceList;
            while(true) {
              if(local18 != null) {
                local19 = local18.alternativa3d::wrapper;
                while(local19 != null) {
                  local20 = local19.alternativa3d::vertex;
                  local21 = local19.alternativa3d::next != null ? local19.alternativa3d::next.alternativa3d::vertex : local18.alternativa3d::wrapper.alternativa3d::vertex;
                  local22 = local21.x - local20.x;
                  local23 = local21.y - local20.y;
                  local24 = local21.z - local20.z;
                  local25 = local15 - local20.x;
                  local26 = local16 - local20.y;
                  local27 = local17 - local20.z;
                  if((local27 * local23 - local26 * local24) * local10 + (local25 * local24 - local27 * local22) * local11 + (local26 * local22 - local25 * local23) * local12 < 0) {
                    break;
                  }
                  local19 = local19.alternativa3d::next;
                }
                if(local19 == null) {
                  break;
                }
                local18 = local18.alternativa3d::next;
                continue;
              }
              if(param1.negative != null && this.checkIntersectionNode(param1.negative,param2,param3,param4,param5,param6,param7,param8)) {
                return true;
              }
            }
            return true;
          }
        }
        return param1.positive != null && this.checkIntersectionNode(param1.positive,param2,param3,param4,param5,param6,param7,param8);
      }
      if(param1.negative != null && this.checkIntersectionNode(param1.negative,param2,param3,param4,param5,param6,param7,param8)) {
        return true;
      }
      if(param1.positive != null) {
        local9 = param5 * local10 + param6 * local11 + param7 * local12;
        return local9 > 0 && -local13 / local9 < param8 && this.checkIntersectionNode(param1.positive,param2,param3,param4,param5,param6,param7,param8);
      }
      return false;
    }

    override alternativa3d function collectPlanes(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:Vector3D, param6:Vector.<Face>, param7:Dictionary = null) : void {
      if(param7 != null && param7[this] || this.root == null) {
        return;
      }
      var local8:Vector3D = alternativa3d::calculateSphere(param1,param2,param3,param4,param5);
      if(!alternativa3d::boundIntersectSphere(local8,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
        return;
      }
      this.collectPlanesNode(this.root,local8,param6);
    }

    private function collectPlanesNode(param1:Node, param2:Vector3D, param3:Vector.<Face>) : void {
      var local5:Face = null;
      var local6:Wrapper = null;
      var local7:Vertex = null;
      var local4:Number = param1.normalX * param2.x + param1.normalY * param2.y + param1.normalZ * param2.z - param1.offset;
      if(local4 >= param2.w) {
        if(param1.positive != null) {
          this.collectPlanesNode(param1.positive,param2,param3);
        }
      } else if(local4 <= -param2.w) {
        if(param1.negative != null) {
          this.collectPlanesNode(param1.negative,param2,param3);
        }
      } else {
        local5 = param1.faceList;
        while(local5 != null) {
          local6 = local5.alternativa3d::wrapper;
          while(local6 != null) {
            local7 = local6.alternativa3d::vertex;
            local7.alternativa3d::cameraX = alternativa3d::ma * local7.x + alternativa3d::mb * local7.y + alternativa3d::mc * local7.z + alternativa3d::md;
            local7.alternativa3d::cameraY = alternativa3d::me * local7.x + alternativa3d::mf * local7.y + alternativa3d::mg * local7.z + alternativa3d::mh;
            local7.alternativa3d::cameraZ = alternativa3d::mi * local7.x + alternativa3d::mj * local7.y + alternativa3d::mk * local7.z + alternativa3d::ml;
            local6 = local6.alternativa3d::next;
          }
          param3.push(local5);
          local5 = local5.alternativa3d::next;
        }
        if(param1.positive != null) {
          this.collectPlanesNode(param1.positive,param2,param3);
        }
        if(param1.negative != null) {
          this.collectPlanesNode(param1.negative,param2,param3);
        }
      }
    }

    override public function clone() : Object3D {
      var local1:BSP = new BSP();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local8:Vertex = null;
      var local9:Face = null;
      var local10:Face = null;
      var local11:Wrapper = null;
      var local12:Wrapper = null;
      var local13:Wrapper = null;
      super.clonePropertiesFrom(param1);
      var local2:BSP = param1 as BSP;
      this.clipping = local2.clipping;
      this.threshold = local2.threshold;
      this.splitAnalysis = local2.splitAnalysis;
      local3 = local2.alternativa3d::vertexList;
      while(local3 != null) {
        local8 = new Vertex();
        local8.x = local3.x;
        local8.y = local3.y;
        local8.z = local3.z;
        local8.u = local3.u;
        local8.v = local3.v;
        local8.normalX = local3.normalX;
        local8.normalY = local3.normalY;
        local8.normalZ = local3.normalZ;
        local3.alternativa3d::value = local8;
        if(local4 != null) {
          local4.alternativa3d::next = local8;
        } else {
          this.alternativa3d::vertexList = local8;
        }
        local4 = local8;
        local3 = local3.alternativa3d::next;
      }
      var local5:Dictionary = new Dictionary();
      var local6:int = int(local2.alternativa3d::faces.length);
      var local7:int = 0;
      while(local7 < local6) {
        local9 = local2.alternativa3d::faces[local7];
        local10 = new Face();
        local10.material = local9.material;
        local10.smoothingGroups = local9.smoothingGroups;
        local10.alternativa3d::normalX = local9.alternativa3d::normalX;
        local10.alternativa3d::normalY = local9.alternativa3d::normalY;
        local10.alternativa3d::normalZ = local9.alternativa3d::normalZ;
        local10.alternativa3d::offset = local9.alternativa3d::offset;
        local11 = null;
        local12 = local9.alternativa3d::wrapper;
        while(local12 != null) {
          local13 = new Wrapper();
          local13.alternativa3d::vertex = local12.alternativa3d::vertex.alternativa3d::value;
          if(local11 != null) {
            local11.alternativa3d::next = local13;
          } else {
            local10.alternativa3d::wrapper = local13;
          }
          local11 = local13;
          local12 = local12.alternativa3d::next;
        }
        this.alternativa3d::faces[local7] = local10;
        local5[local9] = local10;
        local7++;
      }
      if(local2.root != null) {
        this.root = local2.cloneNode(local2.root,local5);
      }
      local3 = local2.alternativa3d::vertexList;
      while(local3 != null) {
        local3.alternativa3d::value = null;
        local3 = local3.alternativa3d::next;
      }
    }

    private function cloneNode(param1:Node, param2:Dictionary) : Node {
      var local4:Face = null;
      var local6:Face = null;
      var local7:Wrapper = null;
      var local8:Wrapper = null;
      var local9:Wrapper = null;
      var local3:Node = new Node();
      var local5:Face = param1.faceList;
      while(local5 != null) {
        local6 = param2[local5];
        if(local6 == null) {
          local6 = new Face();
          local6.material = local5.material;
          local6.alternativa3d::normalX = local5.alternativa3d::normalX;
          local6.alternativa3d::normalY = local5.alternativa3d::normalY;
          local6.alternativa3d::normalZ = local5.alternativa3d::normalZ;
          local6.alternativa3d::offset = local5.alternativa3d::offset;
          local7 = null;
          local8 = local5.alternativa3d::wrapper;
          while(local8 != null) {
            local9 = new Wrapper();
            local9.alternativa3d::vertex = local8.alternativa3d::vertex.alternativa3d::value;
            if(local7 != null) {
              local7.alternativa3d::next = local9;
            } else {
              local6.alternativa3d::wrapper = local9;
            }
            local7 = local9;
            local8 = local8.alternativa3d::next;
          }
        }
        if(local3.faceList != null) {
          local4.alternativa3d::next = local6;
        } else {
          local3.faceList = local6;
        }
        local4 = local6;
        local5 = local5.alternativa3d::next;
      }
      local3.normalX = param1.normalX;
      local3.normalY = param1.normalY;
      local3.normalZ = param1.normalZ;
      local3.offset = param1.offset;
      if(param1.negative != null) {
        local3.negative = this.cloneNode(param1.negative,param2);
      }
      if(param1.positive != null) {
        local3.positive = this.cloneNode(param1.positive,param2);
      }
      return local3;
    }

    private function setMaterialToNode(param1:Node, param2:Material) : void {
      var local3:Face = param1.faceList;
      while(local3 != null) {
        local3.material = param2;
        local3 = local3.alternativa3d::next;
      }
      if(param1.negative != null) {
        this.setMaterialToNode(param1.negative,param2);
      }
      if(param1.positive != null) {
        this.setMaterialToNode(param1.positive,param2);
      }
    }

    override alternativa3d function draw(param1:Camera3D, param2:Canvas) : void {
      var local4:Canvas = null;
      var local5:int = 0;
      var local7:Vertex = null;
      var local8:Face = null;
      if(this.root == null) {
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
        local7 = this.alternativa3d::vertexList;
        while(local7 != null) {
          local7.alternativa3d::transformId = 0;
          local7 = local7.alternativa3d::next;
        }
      }
      ++alternativa3d::transformId;
      alternativa3d::calculateInverseMatrix();
      var local3:Face = this.collectNode(this.root);
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
      if(param1.debug && (local5 = int(param1.alternativa3d::checkInDebug(this))) > 0) {
        local4 = param2.alternativa3d::getChildCanvas(true,false);
        if(Boolean(local5 & Debug.EDGES)) {
          Debug.alternativa3d::drawEdges(param1,local4,local3,16777215);
        }
        if(Boolean(local5 & Debug.BOUNDS)) {
          Debug.alternativa3d::drawBounds(param1,local4,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
        }
      }
      local4 = param2.alternativa3d::getChildCanvas(true,false,this,alpha,blendMode,colorTransform,filters);
      var local6:Face = local3;
      while(local6 != null) {
        local8 = local6.alternativa3d::processNext;
        if(local8 == null || local8.material != local3.material) {
          local6.alternativa3d::processNext = null;
          if(local3.material != null) {
            local3.material.alternativa3d::draw(param1,local4,local3,alternativa3d::ml);
          } else {
            while(local3 != null) {
              local6 = local3.alternativa3d::processNext;
              local3.alternativa3d::processNext = null;
              local3 = local6;
            }
          }
          local3 = local8;
        }
        local6 = local8;
      }
    }

    override alternativa3d function getVG(param1:Camera3D) : VG {
      var local3:Vertex = null;
      if(this.root == null) {
        return null;
      }
      if(this.clipping == 0) {
        if(Boolean(alternativa3d::culling & 1)) {
          return null;
        }
        alternativa3d::culling = 0;
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
      alternativa3d::calculateInverseMatrix();
      var local2:Face = this.prepareNode(this.root,alternativa3d::culling,param1);
      if(local2 != null) {
        return VG.alternativa3d::create(this,local2,3,param1.debug ? int(param1.alternativa3d::checkInDebug(this)) : 0,false);
      }
      return null;
    }

    private function collectNode(param1:Node, param2:Face = null) : Face {
      var local3:Face = null;
      var local4:Wrapper = null;
      var local5:Vertex = null;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      if(param1.normalX * alternativa3d::imd + param1.normalY * alternativa3d::imh + param1.normalZ * alternativa3d::iml > param1.offset) {
        if(param1.positive != null) {
          param2 = this.collectNode(param1.positive,param2);
        }
        local3 = param1.faceList;
        while(local3 != null) {
          local4 = local3.alternativa3d::wrapper;
          while(local4 != null) {
            local5 = local4.alternativa3d::vertex;
            if(local5.alternativa3d::transformId != alternativa3d::transformId) {
              local6 = local5.x;
              local7 = local5.y;
              local8 = local5.z;
              local5.alternativa3d::cameraX = alternativa3d::ma * local6 + alternativa3d::mb * local7 + alternativa3d::mc * local8 + alternativa3d::md;
              local5.alternativa3d::cameraY = alternativa3d::me * local6 + alternativa3d::mf * local7 + alternativa3d::mg * local8 + alternativa3d::mh;
              local5.alternativa3d::cameraZ = alternativa3d::mi * local6 + alternativa3d::mj * local7 + alternativa3d::mk * local8 + alternativa3d::ml;
              local5.alternativa3d::transformId = alternativa3d::transformId;
              local5.alternativa3d::drawId = 0;
            }
            local4 = local4.alternativa3d::next;
          }
          local3.alternativa3d::processNext = param2;
          param2 = local3;
          local3 = local3.alternativa3d::next;
        }
        if(param1.negative != null) {
          param2 = this.collectNode(param1.negative,param2);
        }
      } else {
        if(param1.negative != null) {
          param2 = this.collectNode(param1.negative,param2);
        }
        if(param1.positive != null) {
          param2 = this.collectNode(param1.positive,param2);
        }
      }
      return param2;
    }

    private function prepareNode(param1:Node, param2:int, param3:Camera3D) : Face {
      var local4:Face = null;
      var local5:Wrapper = null;
      var local8:Face = null;
      var local9:Vertex = null;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Vertex = null;
      var local14:Vertex = null;
      var local15:Vertex = null;
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
      if(alternativa3d::imd * param1.normalX + alternativa3d::imh * param1.normalY + alternativa3d::iml * param1.normalZ > param1.offset) {
        local4 = param1.faceList;
        local8 = local4;
        while(local8 != null) {
          local5 = local8.alternativa3d::wrapper;
          while(local5 != null) {
            local9 = local5.alternativa3d::vertex;
            if(local9.alternativa3d::transformId != alternativa3d::transformId) {
              local10 = local9.x;
              local11 = local9.y;
              local12 = local9.z;
              local9.alternativa3d::cameraX = alternativa3d::ma * local10 + alternativa3d::mb * local11 + alternativa3d::mc * local12 + alternativa3d::md;
              local9.alternativa3d::cameraY = alternativa3d::me * local10 + alternativa3d::mf * local11 + alternativa3d::mg * local12 + alternativa3d::mh;
              local9.alternativa3d::cameraZ = alternativa3d::mi * local10 + alternativa3d::mj * local11 + alternativa3d::mk * local12 + alternativa3d::ml;
              local9.alternativa3d::transformId = alternativa3d::transformId;
              local9.alternativa3d::drawId = 0;
            }
            local5 = local5.alternativa3d::next;
          }
          local8.alternativa3d::processNext = local8.alternativa3d::next;
          local8 = local8.alternativa3d::next;
        }
        if(param2 > 0) {
          if(this.clipping == 1) {
            local4 = param3.alternativa3d::cull(local4,param2);
          } else {
            local4 = param3.alternativa3d::clip(local4,param2);
          }
        }
      }
      var local6:Face = param1.negative != null ? this.prepareNode(param1.negative,param2,param3) : null;
      var local7:Face = param1.positive != null ? this.prepareNode(param1.positive,param2,param3) : null;
      if(local4 != null || local6 != null && local7 != null) {
        if(local4 == null) {
          local4 = param1.faceList.alternativa3d::create();
          param3.alternativa3d::lastFace.alternativa3d::next = local4;
          param3.alternativa3d::lastFace = local4;
        }
        local5 = param1.faceList.alternativa3d::wrapper;
        local13 = local5.alternativa3d::vertex;
        local5 = local5.alternativa3d::next;
        local14 = local5.alternativa3d::vertex;
        local5 = local5.alternativa3d::next;
        local15 = local5.alternativa3d::vertex;
        if(local13.alternativa3d::transformId != alternativa3d::transformId) {
          local13.alternativa3d::cameraX = alternativa3d::ma * local13.x + alternativa3d::mb * local13.y + alternativa3d::mc * local13.z + alternativa3d::md;
          local13.alternativa3d::cameraY = alternativa3d::me * local13.x + alternativa3d::mf * local13.y + alternativa3d::mg * local13.z + alternativa3d::mh;
          local13.alternativa3d::cameraZ = alternativa3d::mi * local13.x + alternativa3d::mj * local13.y + alternativa3d::mk * local13.z + alternativa3d::ml;
          local13.alternativa3d::transformId = alternativa3d::transformId;
          local13.alternativa3d::drawId = 0;
        }
        if(local14.alternativa3d::transformId != alternativa3d::transformId) {
          local14.alternativa3d::cameraX = alternativa3d::ma * local14.x + alternativa3d::mb * local14.y + alternativa3d::mc * local14.z + alternativa3d::md;
          local14.alternativa3d::cameraY = alternativa3d::me * local14.x + alternativa3d::mf * local14.y + alternativa3d::mg * local14.z + alternativa3d::mh;
          local14.alternativa3d::cameraZ = alternativa3d::mi * local14.x + alternativa3d::mj * local14.y + alternativa3d::mk * local14.z + alternativa3d::ml;
          local14.alternativa3d::transformId = alternativa3d::transformId;
          local14.alternativa3d::drawId = 0;
        }
        if(local15.alternativa3d::transformId != alternativa3d::transformId) {
          local15.alternativa3d::cameraX = alternativa3d::ma * local15.x + alternativa3d::mb * local15.y + alternativa3d::mc * local15.z + alternativa3d::md;
          local15.alternativa3d::cameraY = alternativa3d::me * local15.x + alternativa3d::mf * local15.y + alternativa3d::mg * local15.z + alternativa3d::mh;
          local15.alternativa3d::cameraZ = alternativa3d::mi * local15.x + alternativa3d::mj * local15.y + alternativa3d::mk * local15.z + alternativa3d::ml;
          local15.alternativa3d::transformId = alternativa3d::transformId;
          local15.alternativa3d::drawId = 0;
        }
        local16 = local14.alternativa3d::cameraX - local13.alternativa3d::cameraX;
        local17 = local14.alternativa3d::cameraY - local13.alternativa3d::cameraY;
        local18 = local14.alternativa3d::cameraZ - local13.alternativa3d::cameraZ;
        local19 = local15.alternativa3d::cameraX - local13.alternativa3d::cameraX;
        local20 = local15.alternativa3d::cameraY - local13.alternativa3d::cameraY;
        local21 = local15.alternativa3d::cameraZ - local13.alternativa3d::cameraZ;
        local22 = local21 * local17 - local20 * local18;
        local23 = local19 * local18 - local21 * local16;
        local24 = local20 * local16 - local19 * local17;
        local25 = local22 * local22 + local23 * local23 + local24 * local24;
        if(local25 > 0) {
          local25 = 1 / Math.sqrt(length);
          local22 *= local25;
          local23 *= local25;
          local24 *= local25;
        }
        local4.alternativa3d::normalX = local22;
        local4.alternativa3d::normalY = local23;
        local4.alternativa3d::normalZ = local24;
        local4.alternativa3d::offset = local13.alternativa3d::cameraX * local22 + local13.alternativa3d::cameraY * local23 + local13.alternativa3d::cameraZ * local24;
        local4.alternativa3d::processNegative = local6;
        local4.alternativa3d::processPositive = local7;
      } else {
        local4 = local6 != null ? local6 : local7;
      }
      return local4;
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
      var local16:Face = null;
      var local17:Face = null;
      var local22:Face = null;
      var local23:Face = null;
      var local24:Wrapper = null;
      var local25:Vertex = null;
      var local26:Vertex = null;
      var local27:Vertex = null;
      var local28:Boolean = false;
      var local29:Boolean = false;
      var local30:Face = null;
      var local31:Face = null;
      var local32:Wrapper = null;
      var local33:Wrapper = null;
      var local34:Wrapper = null;
      var local35:Number = NaN;
      var local36:Vertex = null;
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
      if(this.root != null) {
        this.destroyNode(this.root);
        this.root = null;
      }
      var local11:Vector.<Face> = this.alternativa3d::faces;
      this.alternativa3d::faces = new Vector.<Face>();
      var local12:BSP = this.clone() as BSP;
      var local13:BSP = this.clone() as BSP;
      var local18:int = 0;
      var local19:int = 0;
      var local20:int = int(local11.length);
      var local21:int = 0;
      while(local21 < local20) {
        local22 = local11[local21];
        local23 = local22.alternativa3d::next;
        local24 = local22.alternativa3d::wrapper;
        local25 = local24.alternativa3d::vertex;
        local24 = local24.alternativa3d::next;
        local26 = local24.alternativa3d::vertex;
        local24 = local24.alternativa3d::next;
        local27 = local24.alternativa3d::vertex;
        local28 = local25.alternativa3d::offset < local7 || local26.alternativa3d::offset < local7 || local27.alternativa3d::offset < local7;
        local29 = local25.alternativa3d::offset > local8 || local26.alternativa3d::offset > local8 || local27.alternativa3d::offset > local8;
        local24 = local24.alternativa3d::next;
        while(local24 != null) {
          local9 = local24.alternativa3d::vertex;
          if(local9.alternativa3d::offset < local7) {
            local28 = true;
          } else if(local9.alternativa3d::offset > local8) {
            local29 = true;
          }
          local24 = local24.alternativa3d::next;
        }
        if(!local28) {
          if(local17 != null) {
            local17.alternativa3d::next = local22;
          } else {
            local16 = local22;
          }
          local17 = local22;
          local13.alternativa3d::faces[local19] = local22;
          local19++;
        } else if(!local29) {
          if(local15 != null) {
            local15.alternativa3d::next = local22;
          } else {
            local14 = local22;
          }
          local15 = local22;
          local12.alternativa3d::faces[local18] = local22;
          local18++;
          local24 = local22.alternativa3d::wrapper;
          while(local24 != null) {
            if(local24.alternativa3d::vertex.alternativa3d::value != null) {
              local24.alternativa3d::vertex = local24.alternativa3d::vertex.alternativa3d::value;
            }
            local24 = local24.alternativa3d::next;
          }
        } else {
          local30 = new Face();
          local31 = new Face();
          local32 = null;
          local33 = null;
          local24 = local22.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
          while(local24.alternativa3d::next != null) {
            local24 = local24.alternativa3d::next;
          }
          local25 = local24.alternativa3d::vertex;
          local24 = local22.alternativa3d::wrapper;
          while(local24 != null) {
            local26 = local24.alternativa3d::vertex;
            if(local25.alternativa3d::offset < local7 && local26.alternativa3d::offset > local8 || local25.alternativa3d::offset > local8 && local26.alternativa3d::offset < local7) {
              local35 = (local6.w - local25.alternativa3d::offset) / (local26.alternativa3d::offset - local25.alternativa3d::offset);
              local9 = new Vertex();
              local9.x = local25.x + (local26.x - local25.x) * local35;
              local9.y = local25.y + (local26.y - local25.y) * local35;
              local9.z = local25.z + (local26.z - local25.z) * local35;
              local9.u = local25.u + (local26.u - local25.u) * local35;
              local9.v = local25.v + (local26.v - local25.v) * local35;
              local9.normalX = local25.normalX + (local26.normalX - local25.normalX) * local35;
              local9.normalY = local25.normalY + (local26.normalY - local25.normalY) * local35;
              local9.normalZ = local25.normalZ + (local26.normalZ - local25.normalZ) * local35;
              local34 = new Wrapper();
              local34.alternativa3d::vertex = local9;
              if(local32 != null) {
                local32.alternativa3d::next = local34;
              } else {
                local30.alternativa3d::wrapper = local34;
              }
              local32 = local34;
              local36 = new Vertex();
              local36.x = local9.x;
              local36.y = local9.y;
              local36.z = local9.z;
              local36.u = local9.u;
              local36.v = local9.v;
              local36.normalX = local9.normalX;
              local36.normalY = local9.normalY;
              local36.normalZ = local9.normalZ;
              local34 = new Wrapper();
              local34.alternativa3d::vertex = local36;
              if(local33 != null) {
                local33.alternativa3d::next = local34;
              } else {
                local31.alternativa3d::wrapper = local34;
              }
              local33 = local34;
            }
            if(local26.alternativa3d::offset < local7) {
              local34 = local24.alternativa3d::create();
              local34.alternativa3d::vertex = local26;
              if(local32 != null) {
                local32.alternativa3d::next = local34;
              } else {
                local30.alternativa3d::wrapper = local34;
              }
              local32 = local34;
            } else if(local26.alternativa3d::offset > local8) {
              local34 = local24.alternativa3d::create();
              local34.alternativa3d::vertex = local26;
              if(local33 != null) {
                local33.alternativa3d::next = local34;
              } else {
                local31.alternativa3d::wrapper = local34;
              }
              local33 = local34;
            } else {
              local34 = local24.alternativa3d::create();
              local34.alternativa3d::vertex = local26.alternativa3d::value;
              if(local32 != null) {
                local32.alternativa3d::next = local34;
              } else {
                local30.alternativa3d::wrapper = local34;
              }
              local32 = local34;
              local34 = local24.alternativa3d::create();
              local34.alternativa3d::vertex = local26;
              if(local33 != null) {
                local33.alternativa3d::next = local34;
              } else {
                local31.alternativa3d::wrapper = local34;
              }
              local33 = local34;
            }
            local25 = local26;
            local24 = local24.alternativa3d::next;
          }
          local30.material = local22.material;
          local30.alternativa3d::calculateBestSequenceAndNormal();
          if(local15 != null) {
            local15.alternativa3d::next = local30;
          } else {
            local14 = local30;
          }
          local15 = local30;
          local12.alternativa3d::faces[local18] = local30;
          local18++;
          local31.material = local22.material;
          local31.alternativa3d::calculateBestSequenceAndNormal();
          if(local17 != null) {
            local17.alternativa3d::next = local31;
          } else {
            local16 = local31;
          }
          local17 = local31;
          local13.alternativa3d::faces[local19] = local31;
          local19++;
        }
        local21++;
      }
      if(local15 != null) {
        local15.alternativa3d::next = null;
        ++local12.alternativa3d::transformId;
        local12.collectVertices();
        local12.root = local12.createNode(local14);
        local12.calculateBounds();
        local5[0] = local12;
      }
      if(local17 != null) {
        local17.alternativa3d::next = null;
        ++local13.alternativa3d::transformId;
        local13.collectVertices();
        local13.root = local13.createNode(local16);
        local13.calculateBounds();
        local5[1] = local13;
      }
      return local5;
    }

    private function collectVertices() : void {
      var local3:Face = null;
      var local4:Wrapper = null;
      var local5:Vertex = null;
      var local1:int = int(this.alternativa3d::faces.length);
      var local2:int = 0;
      while(local2 < local1) {
        local3 = this.alternativa3d::faces[local2];
        local4 = local3.alternativa3d::wrapper;
        while(local4 != null) {
          local5 = local4.alternativa3d::vertex;
          if(local5.alternativa3d::transformId != alternativa3d::transformId) {
            local5.alternativa3d::next = this.alternativa3d::vertexList;
            this.alternativa3d::vertexList = local5;
            local5.alternativa3d::transformId = alternativa3d::transformId;
            local5.alternativa3d::value = null;
          }
          local4 = local4.alternativa3d::next;
        }
        local2++;
      }
    }

    private function createNode(param1:Face) : Node {
      var local3:Wrapper = null;
      var local4:Vertex = null;
      var local5:Vertex = null;
      var local6:Vertex = null;
      var local7:Vertex = null;
      var local8:Boolean = false;
      var local9:Boolean = false;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local21:Face = null;
      var local22:Face = null;
      var local25:Face = null;
      var local26:Face = null;
      var local27:int = 0;
      var local28:Face = null;
      var local29:int = 0;
      var local30:Face = null;
      var local31:Face = null;
      var local32:Face = null;
      var local33:Face = null;
      var local34:Wrapper = null;
      var local35:Wrapper = null;
      var local36:Wrapper = null;
      var local37:Number = NaN;
      var local2:Node = new Node();
      var local20:Face = param1;
      if(this.splitAnalysis && param1.alternativa3d::next != null) {
        local27 = 2147483647;
        local28 = param1;
        while(local28 != null) {
          local14 = Number(local28.alternativa3d::normalX);
          local15 = Number(local28.alternativa3d::normalY);
          local16 = Number(local28.alternativa3d::normalZ);
          local17 = Number(local28.alternativa3d::offset);
          local18 = local17 - this.threshold;
          local19 = local17 + this.threshold;
          local29 = 0;
          local30 = param1;
          while(local30 != null) {
            if(local30 != local28) {
              local3 = local30.alternativa3d::wrapper;
              local4 = local3.alternativa3d::vertex;
              local3 = local3.alternativa3d::next;
              local5 = local3.alternativa3d::vertex;
              local3 = local3.alternativa3d::next;
              local6 = local3.alternativa3d::vertex;
              local3 = local3.alternativa3d::next;
              local10 = local4.x * local14 + local4.y * local15 + local4.z * local16;
              local11 = local5.x * local14 + local5.y * local15 + local5.z * local16;
              local12 = local6.x * local14 + local6.y * local15 + local6.z * local16;
              local8 = local10 < local18 || local11 < local18 || local12 < local18;
              local9 = local10 > local19 || local11 > local19 || local12 > local19;
              while(local3 != null) {
                local7 = local3.alternativa3d::vertex;
                local13 = local7.x * local14 + local7.y * local15 + local7.z * local16;
                if(local13 < local18) {
                  local8 = true;
                  if(local9) {
                    break;
                  }
                } else if(local13 > local19) {
                  local9 = true;
                  if(local8) {
                    break;
                  }
                }
                local3 = local3.alternativa3d::next;
              }
              if(local9 && local8) {
                local29++;
                if(local29 >= local27) {
                  break;
                }
              }
            }
            local30 = local30.alternativa3d::next;
          }
          if(local29 < local27) {
            local20 = local28;
            local27 = local29;
            if(local27 == 0) {
              break;
            }
          }
          local28 = local28.alternativa3d::next;
        }
      }
      var local23:Face = local20;
      var local24:Face = local20.alternativa3d::next;
      local14 = Number(local20.alternativa3d::normalX);
      local15 = Number(local20.alternativa3d::normalY);
      local16 = Number(local20.alternativa3d::normalZ);
      local17 = Number(local20.alternativa3d::offset);
      local18 = local17 - this.threshold;
      local19 = local17 + this.threshold;
      while(param1 != null) {
        if(param1 != local20) {
          local31 = param1.alternativa3d::next;
          local3 = param1.alternativa3d::wrapper;
          local4 = local3.alternativa3d::vertex;
          local3 = local3.alternativa3d::next;
          local5 = local3.alternativa3d::vertex;
          local3 = local3.alternativa3d::next;
          local6 = local3.alternativa3d::vertex;
          local3 = local3.alternativa3d::next;
          local10 = local4.x * local14 + local4.y * local15 + local4.z * local16;
          local11 = local5.x * local14 + local5.y * local15 + local5.z * local16;
          local12 = local6.x * local14 + local6.y * local15 + local6.z * local16;
          local8 = local10 < local18 || local11 < local18 || local12 < local18;
          local9 = local10 > local19 || local11 > local19 || local12 > local19;
          while(local3 != null) {
            local7 = local3.alternativa3d::vertex;
            local13 = local7.x * local14 + local7.y * local15 + local7.z * local16;
            if(local13 < local18) {
              local8 = true;
            } else if(local13 > local19) {
              local9 = true;
            }
            local7.alternativa3d::offset = local13;
            local3 = local3.alternativa3d::next;
          }
          if(!local8) {
            if(!local9) {
              if(param1.alternativa3d::normalX * local14 + param1.alternativa3d::normalY * local15 + param1.alternativa3d::normalZ * local16 > 0) {
                local23.alternativa3d::next = param1;
                local23 = param1;
              } else {
                if(local21 != null) {
                  local22.alternativa3d::next = param1;
                } else {
                  local21 = param1;
                }
                local22 = param1;
              }
            } else {
              if(local25 != null) {
                local26.alternativa3d::next = param1;
              } else {
                local25 = param1;
              }
              local26 = param1;
            }
          } else if(!local9) {
            if(local21 != null) {
              local22.alternativa3d::next = param1;
            } else {
              local21 = param1;
            }
            local22 = param1;
          } else {
            local4.alternativa3d::offset = local10;
            local5.alternativa3d::offset = local11;
            local6.alternativa3d::offset = local12;
            local32 = new Face();
            local33 = new Face();
            local34 = null;
            local35 = null;
            local3 = param1.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
            while(local3.alternativa3d::next != null) {
              local3 = local3.alternativa3d::next;
            }
            local4 = local3.alternativa3d::vertex;
            local10 = Number(local4.alternativa3d::offset);
            local3 = param1.alternativa3d::wrapper;
            while(local3 != null) {
              local5 = local3.alternativa3d::vertex;
              local11 = Number(local5.alternativa3d::offset);
              if(local10 < local18 && local11 > local19 || local10 > local19 && local11 < local18) {
                local37 = (local17 - local10) / (local11 - local10);
                local7 = new Vertex();
                local7.alternativa3d::next = this.alternativa3d::vertexList;
                this.alternativa3d::vertexList = local7;
                local7.x = local4.x + (local5.x - local4.x) * local37;
                local7.y = local4.y + (local5.y - local4.y) * local37;
                local7.z = local4.z + (local5.z - local4.z) * local37;
                local7.u = local4.u + (local5.u - local4.u) * local37;
                local7.v = local4.v + (local5.v - local4.v) * local37;
                local7.normalX = local4.normalX + (local5.normalX - local4.normalX) * local37;
                local7.normalY = local4.normalY + (local5.normalY - local4.normalY) * local37;
                local7.normalZ = local4.normalZ + (local5.normalZ - local4.normalZ) * local37;
                local36 = new Wrapper();
                local36.alternativa3d::vertex = local7;
                if(local34 != null) {
                  local34.alternativa3d::next = local36;
                } else {
                  local32.alternativa3d::wrapper = local36;
                }
                local34 = local36;
                local36 = new Wrapper();
                local36.alternativa3d::vertex = local7;
                if(local35 != null) {
                  local35.alternativa3d::next = local36;
                } else {
                  local33.alternativa3d::wrapper = local36;
                }
                local35 = local36;
              }
              if(local11 <= local19) {
                local36 = new Wrapper();
                local36.alternativa3d::vertex = local5;
                if(local34 != null) {
                  local34.alternativa3d::next = local36;
                } else {
                  local32.alternativa3d::wrapper = local36;
                }
                local34 = local36;
              }
              if(local11 >= local18) {
                local36 = new Wrapper();
                local36.alternativa3d::vertex = local5;
                if(local35 != null) {
                  local35.alternativa3d::next = local36;
                } else {
                  local33.alternativa3d::wrapper = local36;
                }
                local35 = local36;
              }
              local4 = local5;
              local10 = local11;
              local3 = local3.alternativa3d::next;
            }
            local32.material = param1.material;
            local32.smoothingGroups = param1.smoothingGroups;
            local32.alternativa3d::calculateBestSequenceAndNormal();
            if(local21 != null) {
              local22.alternativa3d::next = local32;
            } else {
              local21 = local32;
            }
            local22 = local32;
            local33.material = param1.material;
            local33.smoothingGroups = param1.smoothingGroups;
            local33.alternativa3d::calculateBestSequenceAndNormal();
            if(local25 != null) {
              local26.alternativa3d::next = local33;
            } else {
              local25 = local33;
            }
            local26 = local33;
          }
          param1 = local31;
        } else {
          param1 = local24;
        }
      }
      if(local21 != null) {
        local22.alternativa3d::next = null;
        local2.negative = this.createNode(local21);
      }
      local23.alternativa3d::next = null;
      local2.faceList = local20;
      local2.normalX = local14;
      local2.normalY = local15;
      local2.normalZ = local16;
      local2.offset = local17;
      if(local25 != null) {
        local26.alternativa3d::next = null;
        local2.positive = this.createNode(local25);
      }
      return local2;
    }

    private function destroyNode(param1:Node) : void {
      var local3:Face = null;
      if(param1.negative != null) {
        this.destroyNode(param1.negative);
        param1.negative = null;
      }
      if(param1.positive != null) {
        this.destroyNode(param1.positive);
        param1.positive = null;
      }
      var local2:Face = param1.faceList;
      while(local2 != null) {
        local3 = local2.alternativa3d::next;
        local2.alternativa3d::next = null;
        local2 = local3;
      }
    }
  }
}

import alternativa.engine3d.core.Face;
class Node {
  public var negative:Node;
  public var positive:Node;
  public var faceList:Face;
  public var normalX:Number;
  public var normalY:Number;
  public var normalZ:Number;
  public var offset:Number;

  public function Node() {
    super();
  }
}
