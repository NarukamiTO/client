package alternativa.engine3d.containers {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.core.RayIntersectionData;
  import alternativa.engine3d.core.VG;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.objects.Mesh;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class BSPContainer extends ConflictContainer {
    private static const treeSphere:Vector3D = new Vector3D();

    public var clipping:int = 2;
    public var debugAlphaFade:Number = 0.8;

    alternativa3d var root:BSPNode;
    alternativa3d var vertexList:Vertex;

    private var nearPlaneX:Number;
    private var nearPlaneY:Number;
    private var nearPlaneZ:Number;
    private var nearPlaneOffset:Number;
    private var farPlaneX:Number;
    private var farPlaneY:Number;
    private var farPlaneZ:Number;
    private var farPlaneOffset:Number;
    private var leftPlaneX:Number;
    private var leftPlaneY:Number;
    private var leftPlaneZ:Number;
    private var leftPlaneOffset:Number;
    private var rightPlaneX:Number;
    private var rightPlaneY:Number;
    private var rightPlaneZ:Number;
    private var rightPlaneOffset:Number;
    private var topPlaneX:Number;
    private var topPlaneY:Number;
    private var topPlaneZ:Number;
    private var topPlaneOffset:Number;
    private var bottomPlaneX:Number;
    private var bottomPlaneY:Number;
    private var bottomPlaneZ:Number;
    private var bottomPlaneOffset:Number;
    private var directionX:Number;
    private var directionY:Number;
    private var directionZ:Number;
    private var viewAngle:Number;

    public function BSPContainer() {
      super();
    }

    public function createTree(param1:Vector.<Mesh>, param2:Vector.<Mesh> = null, param3:Boolean = false, param4:Vector.<Object3D> = null) : void {
      var local5:int = 0;
      var local6:int = 0;
      var local7:Face = null;
      var local8:Face = null;
      var local9:Object3D = null;
      var local10:Object3D = null;
      var local11:Object3D = null;
      var local12:Object3D = null;
      this.destroyTree();
      if(param2 != null) {
        local6 = int(param2.length);
        local5 = local6 - 1;
        while(local5 >= 0) {
          local7 = this.calculateFaceList(param3 ? param2[local5] : Mesh(param2[local5].clone()),false,local7);
          local5--;
        }
      }
      local6 = int(param1.length);
      local5 = local6 - 1;
      while(local5 >= 0) {
        local8 = this.calculateFaceList(param3 ? param1[local5] : Mesh(param1[local5].clone()),true,local8);
        local5--;
      }
      if(param4 != null) {
        local6 = int(param4.length);
        local5 = 0;
        while(local5 < local6) {
          local11 = param4[local5];
          local11 = local11.clone();
          local11.alternativa3d::setParent(this);
          this.calculateObjectBounds(local11);
          local12 = this.createObjectBounds(local11);
          if(local12.boundMinX <= local12.boundMaxX) {
            local11.alternativa3d::next = local9;
            local9 = local11;
            local12.alternativa3d::next = local10;
            local10 = local12;
          }
          local5++;
        }
      }
      if(local8 != null || local9 != null || local7 != null) {
        this.alternativa3d::root = this.createNode(local7,local8,local9,local10,new Vector.<Face>(3),new Vector.<Object3D>(4));
      }
    }

    public function destroyTree() : void {
      if(this.alternativa3d::root != null) {
        this.alternativa3d::vertexList = null;
        this.destroyNode(this.alternativa3d::root);
        this.alternativa3d::root = null;
      }
    }

    override public function intersectRay(param1:Vector3D, param2:Vector3D, param3:Dictionary = null, param4:Camera3D = null) : RayIntersectionData {
      var local6:RayIntersectionData = null;
      if(param3 != null && Boolean(param3[this])) {
        return null;
      }
      if(!alternativa3d::boundIntersectRay(param1,param2,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
        return null;
      }
      var local5:RayIntersectionData = super.intersectRay(param1,param2,param3,param4);
      if(this.alternativa3d::root != null && Boolean(alternativa3d::boundIntersectRay(param1,param2,this.alternativa3d::root.boundMinX,this.alternativa3d::root.boundMinY,this.alternativa3d::root.boundMinZ,this.alternativa3d::root.boundMaxX,this.alternativa3d::root.boundMaxY,this.alternativa3d::root.boundMaxZ))) {
        local6 = this.intersectRayNode(this.alternativa3d::root,param1,param2,param3,param4);
        if(local6 != null && (local5 == null || local6.time < local5.time)) {
          local5 = local6;
        }
      }
      return local5;
    }

    private function intersectRayNode(param1:BSPNode, param2:Vector3D, param3:Vector3D, param4:Dictionary, param5:Camera3D) : RayIntersectionData {
      var local6:RayIntersectionData = null;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Face = null;
      var local17:Wrapper = null;
      var local18:Vertex = null;
      var local19:Vertex = null;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:Vector3D = null;
      var local27:Vector3D = null;
      var local28:Number = NaN;
      var local29:RayIntersectionData = null;
      var local30:Object3D = null;
      if(param1.objectList == null) {
        local7 = param1.normalX;
        local8 = param1.normalY;
        local9 = param1.normalZ;
        local10 = local7 * param2.x + local8 * param2.y + local9 * param2.z - param1.offset;
        if(local10 > 0) {
          if(param1.positive != null && Boolean(alternativa3d::boundIntersectRay(param2,param3,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ))) {
            local6 = this.intersectRayNode(param1.positive,param2,param3,param4,param5);
            if(local6 != null) {
              return local6;
            }
          }
          local11 = param3.x * local7 + param3.y * local8 + param3.z * local9;
          if(local11 < 0) {
            local12 = -local10 / local11;
            local13 = param2.x + param3.x * local12;
            local14 = param2.y + param3.y * local12;
            local15 = param2.z + param3.z * local12;
            local16 = param1.faceList;
            while(true) {
              if(local16 != null) {
                local17 = local16.alternativa3d::wrapper;
                while(local17 != null) {
                  local18 = local17.alternativa3d::vertex;
                  local19 = local17.alternativa3d::next != null ? local17.alternativa3d::next.alternativa3d::vertex : local16.alternativa3d::wrapper.alternativa3d::vertex;
                  local20 = local19.x - local18.x;
                  local21 = local19.y - local18.y;
                  local22 = local19.z - local18.z;
                  local23 = local13 - local18.x;
                  local24 = local14 - local18.y;
                  local25 = local15 - local18.z;
                  if((local25 * local21 - local24 * local22) * local7 + (local23 * local22 - local25 * local20) * local8 + (local24 * local20 - local23 * local21) * local9 < 0) {
                    break;
                  }
                  local17 = local17.alternativa3d::next;
                }
                if(local17 == null) {
                  break;
                }
                local16 = local16.alternativa3d::next;
                continue;
              }
              if(param1.negative != null && Boolean(alternativa3d::boundIntersectRay(param2,param3,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ))) {
                return this.intersectRayNode(param1.negative,param2,param3,param4,param5);
              }
            }
            local6 = new RayIntersectionData();
            local6.object = this;
            local6.face = local16;
            local6.point = new Vector3D(local13,local14,local15);
            local6.uv = local16.getUV(local6.point);
            local6.time = local12;
            return local6;
          }
        } else {
          if(param1.negative != null && Boolean(alternativa3d::boundIntersectRay(param2,param3,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ))) {
            local6 = this.intersectRayNode(param1.negative,param2,param3,param4,param5);
            if(local6 != null) {
              return local6;
            }
          }
          if(param1.positive != null && param3.x * local7 + param3.y * local8 + param3.z * local9 > 0 && Boolean(alternativa3d::boundIntersectRay(param2,param3,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ))) {
            return this.intersectRayNode(param1.positive,param2,param3,param4,param5);
          }
        }
        return null;
      }
      local28 = 1e+22;
      local30 = param1.objectList;
      while(local30 != null) {
        local30.alternativa3d::composeMatrix();
        local30.alternativa3d::invertMatrix();
        if(local26 == null) {
          local26 = new Vector3D();
          local27 = new Vector3D();
        }
        local26.x = local30.alternativa3d::ma * param2.x + local30.alternativa3d::mb * param2.y + local30.alternativa3d::mc * param2.z + local30.alternativa3d::md;
        local26.y = local30.alternativa3d::me * param2.x + local30.alternativa3d::mf * param2.y + local30.alternativa3d::mg * param2.z + local30.alternativa3d::mh;
        local26.z = local30.alternativa3d::mi * param2.x + local30.alternativa3d::mj * param2.y + local30.alternativa3d::mk * param2.z + local30.alternativa3d::ml;
        local27.x = local30.alternativa3d::ma * param3.x + local30.alternativa3d::mb * param3.y + local30.alternativa3d::mc * param3.z;
        local27.y = local30.alternativa3d::me * param3.x + local30.alternativa3d::mf * param3.y + local30.alternativa3d::mg * param3.z;
        local27.z = local30.alternativa3d::mi * param3.x + local30.alternativa3d::mj * param3.y + local30.alternativa3d::mk * param3.z;
        local6 = local30.intersectRay(local26,local27,param4,param5);
        if(local6 != null && local6.time < local28) {
          local28 = local6.time;
          local29 = local6;
        }
        local30 = local30.alternativa3d::next;
      }
      return local29;
    }

    override alternativa3d function checkIntersection(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Dictionary) : Boolean {
      if(super.alternativa3d::checkIntersection(param1,param2,param3,param4,param5,param6,param7,param8)) {
        return true;
      }
      if(this.alternativa3d::root != null && Boolean(alternativa3d::boundCheckIntersection(param1,param2,param3,param4,param5,param6,param7,this.alternativa3d::root.boundMinX,this.alternativa3d::root.boundMinY,this.alternativa3d::root.boundMinZ,this.alternativa3d::root.boundMaxX,this.alternativa3d::root.boundMaxY,this.alternativa3d::root.boundMaxZ))) {
        return this.checkIntersectionNode(this.alternativa3d::root,param1,param2,param3,param4,param5,param6,param7,param8);
      }
      return false;
    }

    private function checkIntersectionNode(param1:BSPNode, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Dictionary) : Boolean {
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Face = null;
      var local20:Wrapper = null;
      var local21:Vertex = null;
      var local22:Vertex = null;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local28:Number = NaN;
      var local29:Object3D = null;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local35:Number = NaN;
      if(param1.objectList == null) {
        local11 = param1.normalX;
        local12 = param1.normalY;
        local13 = param1.normalZ;
        local14 = local11 * param2 + local12 * param3 + local13 * param4 - param1.offset;
        if(local14 > 0) {
          local10 = param5 * local11 + param6 * local12 + param7 * local13;
          if(local10 < 0) {
            local15 = -local14 / local10;
            if(local15 < param8) {
              local16 = param2 + param5 * local15;
              local17 = param3 + param6 * local15;
              local18 = param4 + param7 * local15;
              local19 = param1.faceList;
              while(true) {
                if(local19 != null) {
                  local20 = local19.alternativa3d::wrapper;
                  while(local20 != null) {
                    local21 = local20.alternativa3d::vertex;
                    local22 = local20.alternativa3d::next != null ? local20.alternativa3d::next.alternativa3d::vertex : local19.alternativa3d::wrapper.alternativa3d::vertex;
                    local23 = local22.x - local21.x;
                    local24 = local22.y - local21.y;
                    local25 = local22.z - local21.z;
                    local26 = local16 - local21.x;
                    local27 = local17 - local21.y;
                    local28 = local18 - local21.z;
                    if((local28 * local24 - local27 * local25) * local11 + (local26 * local25 - local28 * local23) * local12 + (local27 * local23 - local26 * local24) * local13 < 0) {
                      break;
                    }
                    local20 = local20.alternativa3d::next;
                  }
                  if(local20 == null) {
                    break;
                  }
                  local19 = local19.alternativa3d::next;
                  continue;
                }
                if(param1.negative != null && Boolean(alternativa3d::boundCheckIntersection(param2,param3,param4,param5,param6,param7,param8,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ)) && this.checkIntersectionNode(param1.negative,param2,param3,param4,param5,param6,param7,param8,param9)) {
                  return true;
                }
              }
              return true;
            }
          }
          return param1.positive != null && Boolean(alternativa3d::boundCheckIntersection(param2,param3,param4,param5,param6,param7,param8,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ)) && this.checkIntersectionNode(param1.positive,param2,param3,param4,param5,param6,param7,param8,param9);
        }
        if(param1.negative != null && Boolean(alternativa3d::boundCheckIntersection(param2,param3,param4,param5,param6,param7,param8,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ)) && this.checkIntersectionNode(param1.negative,param2,param3,param4,param5,param6,param7,param8,param9)) {
          return true;
        }
        if(param1.positive != null) {
          local10 = param5 * local11 + param6 * local12 + param7 * local13;
          return local10 > 0 && -local14 / local10 < param8 && Boolean(alternativa3d::boundCheckIntersection(param2,param3,param4,param5,param6,param7,param8,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ)) && this.checkIntersectionNode(param1.positive,param2,param3,param4,param5,param6,param7,param8,param9);
        }
      } else {
        local29 = param1.objectList;
        while(local29 != null) {
          local29.alternativa3d::composeMatrix();
          local29.alternativa3d::invertMatrix();
          local30 = local29.alternativa3d::ma * param2 + local29.alternativa3d::mb * param3 + local29.alternativa3d::mc * param4 + local29.alternativa3d::md;
          local31 = local29.alternativa3d::me * param2 + local29.alternativa3d::mf * param3 + local29.alternativa3d::mg * param4 + local29.alternativa3d::mh;
          local32 = local29.alternativa3d::mi * param2 + local29.alternativa3d::mj * param3 + local29.alternativa3d::mk * param4 + local29.alternativa3d::ml;
          local33 = local29.alternativa3d::ma * param5 + local29.alternativa3d::mb * param6 + local29.alternativa3d::mc * param7;
          local34 = local29.alternativa3d::me * param5 + local29.alternativa3d::mf * param6 + local29.alternativa3d::mg * param7;
          local35 = local29.alternativa3d::mi * param5 + local29.alternativa3d::mj * param6 + local29.alternativa3d::mk * param7;
          if(local29.alternativa3d::checkIntersection(local30,local31,local32,local33,local34,local35,param8,param9)) {
            return true;
          }
          local29 = local29.alternativa3d::next;
        }
      }
      return false;
    }

    override alternativa3d function collectPlanes(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:Vector3D, param6:Vector.<Face>, param7:Dictionary = null) : void {
      var local10:Vertex = null;
      if(param7 != null && Boolean(param7[this])) {
        return;
      }
      var local8:Vector3D = alternativa3d::calculateSphere(param1,param2,param3,param4,param5,treeSphere);
      if(!alternativa3d::boundIntersectSphere(local8,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
        return;
      }
      if(alternativa3d::transformId > 500000000) {
        alternativa3d::transformId = 0;
        local10 = this.alternativa3d::vertexList;
        while(local10 != null) {
          local10.alternativa3d::transformId = 0;
          local10 = local10.alternativa3d::next;
        }
      }
      ++alternativa3d::transformId;
      var local9:Object3D = alternativa3d::childrenList;
      while(local9 != null) {
        local9.alternativa3d::composeAndAppend(this);
        local9.alternativa3d::collectPlanes(param1,param2,param3,param4,param5,param6,param7);
        local9 = local9.alternativa3d::next;
      }
      if(this.alternativa3d::root != null && Boolean(alternativa3d::boundIntersectSphere(local8,this.alternativa3d::root.boundMinX,this.alternativa3d::root.boundMinY,this.alternativa3d::root.boundMinZ,this.alternativa3d::root.boundMaxX,this.alternativa3d::root.boundMaxY,this.alternativa3d::root.boundMaxZ))) {
        this.collectPlanesNode(this.alternativa3d::root,local8,param1,param2,param3,param4,param5,param6,param7);
      }
    }

    private function collectPlanesNode(param1:BSPNode, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:Vector3D, param6:Vector3D, param7:Vector3D, param8:Vector.<Face>, param9:Dictionary = null) : void {
      var local10:Number = NaN;
      var local11:Face = null;
      var local12:Wrapper = null;
      var local13:Vertex = null;
      var local14:Object3D = null;
      if(param1.objectList == null) {
        local10 = param1.normalX * param2.x + param1.normalY * param2.y + param1.normalZ * param2.z - param1.offset;
        if(local10 >= param2.w) {
          if(param1.positive != null && Boolean(alternativa3d::boundIntersectSphere(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ))) {
            this.collectPlanesNode(param1.positive,param2,param3,param4,param5,param6,param7,param8,param9);
          }
        } else if(local10 <= -param2.w) {
          if(param1.negative != null && Boolean(alternativa3d::boundIntersectSphere(param2,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ))) {
            this.collectPlanesNode(param1.negative,param2,param3,param4,param5,param6,param7,param8,param9);
          }
        } else {
          local11 = param1.faceList;
          while(local11 != null) {
            local12 = local11.alternativa3d::wrapper;
            while(local12 != null) {
              local13 = local12.alternativa3d::vertex;
              if(local13.alternativa3d::transformId != alternativa3d::transformId) {
                local13.alternativa3d::cameraX = alternativa3d::ma * local13.x + alternativa3d::mb * local13.y + alternativa3d::mc * local13.z + alternativa3d::md;
                local13.alternativa3d::cameraY = alternativa3d::me * local13.x + alternativa3d::mf * local13.y + alternativa3d::mg * local13.z + alternativa3d::mh;
                local13.alternativa3d::cameraZ = alternativa3d::mi * local13.x + alternativa3d::mj * local13.y + alternativa3d::mk * local13.z + alternativa3d::ml;
                local13.alternativa3d::transformId = alternativa3d::transformId;
              }
              local12 = local12.alternativa3d::next;
            }
            param8.push(local11);
            local11 = local11.alternativa3d::next;
          }
          if(param1.positive != null && Boolean(alternativa3d::boundIntersectSphere(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ))) {
            this.collectPlanesNode(param1.positive,param2,param3,param4,param5,param6,param7,param8,param9);
          }
          if(param1.negative != null && Boolean(alternativa3d::boundIntersectSphere(param2,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ))) {
            this.collectPlanesNode(param1.negative,param2,param3,param4,param5,param6,param7,param8,param9);
          }
        }
      } else {
        local14 = param1.objectList;
        while(local14 != null) {
          local14.alternativa3d::composeAndAppend(this);
          local14.alternativa3d::collectPlanes(param3,param4,param5,param6,param7,param8,param9);
          local14 = local14.alternativa3d::next;
        }
      }
    }

    override public function clone() : Object3D {
      var local1:BSPContainer = new BSPContainer();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local5:Vertex = null;
      super.clonePropertiesFrom(param1);
      var local2:BSPContainer = param1 as BSPContainer;
      this.clipping = local2.clipping;
      this.debugAlphaFade = local2.debugAlphaFade;
      local3 = local2.alternativa3d::vertexList;
      while(local3 != null) {
        local5 = new Vertex();
        local5.x = local3.x;
        local5.y = local3.y;
        local5.z = local3.z;
        local5.u = local3.u;
        local5.v = local3.v;
        local5.normalX = local3.normalX;
        local5.normalY = local3.normalY;
        local5.normalZ = local3.normalZ;
        local3.alternativa3d::value = local5;
        if(local4 != null) {
          local4.alternativa3d::next = local5;
        } else {
          this.alternativa3d::vertexList = local5;
        }
        local4 = local5;
        local3 = local3.alternativa3d::next;
      }
      if(local2.alternativa3d::root != null) {
        this.alternativa3d::root = local2.cloneNode(local2.alternativa3d::root,this);
      }
      local3 = local2.alternativa3d::vertexList;
      while(local3 != null) {
        local3.alternativa3d::value = null;
        local3 = local3.alternativa3d::next;
      }
    }

    private function cloneNode(param1:BSPNode, param2:Object3DContainer) : BSPNode {
      var local4:Face = null;
      var local6:Object3D = null;
      var local7:Object3D = null;
      var local8:Object3D = null;
      var local9:Face = null;
      var local10:Wrapper = null;
      var local11:Wrapper = null;
      var local12:Wrapper = null;
      var local3:BSPNode = new BSPNode();
      local3.normalX = param1.normalX;
      local3.normalY = param1.normalY;
      local3.normalZ = param1.normalZ;
      local3.offset = param1.offset;
      local3.boundMinX = param1.boundMinX;
      local3.boundMinY = param1.boundMinY;
      local3.boundMinZ = param1.boundMinZ;
      local3.boundMaxX = param1.boundMaxX;
      local3.boundMaxY = param1.boundMaxY;
      local3.boundMaxZ = param1.boundMaxZ;
      var local5:Face = param1.faceList;
      while(local5 != null) {
        local9 = new Face();
        local9.material = local5.material;
        local9.alternativa3d::normalX = local5.alternativa3d::normalX;
        local9.alternativa3d::normalY = local5.alternativa3d::normalY;
        local9.alternativa3d::normalZ = local5.alternativa3d::normalZ;
        local9.alternativa3d::offset = local5.alternativa3d::offset;
        local10 = null;
        local11 = local5.alternativa3d::wrapper;
        while(local11 != null) {
          local12 = new Wrapper();
          local12.alternativa3d::vertex = local11.alternativa3d::vertex.alternativa3d::value;
          if(local10 != null) {
            local10.alternativa3d::next = local12;
          } else {
            local9.alternativa3d::wrapper = local12;
          }
          local10 = local12;
          local11 = local11.alternativa3d::next;
        }
        if(local3.faceList != null) {
          local4.alternativa3d::next = local9;
        } else {
          local3.faceList = local9;
        }
        local4 = local9;
        local5 = local5.alternativa3d::next;
      }
      local6 = param1.objectList;
      local7 = null;
      while(local6 != null) {
        local8 = local6.clone();
        if(local3.objectList != null) {
          local7.alternativa3d::next = local8;
        } else {
          local3.objectList = local8;
        }
        local7 = local8;
        local8.alternativa3d::setParent(param2);
        local6 = local6.alternativa3d::next;
      }
      local6 = param1.boundList;
      local7 = null;
      while(local6 != null) {
        local8 = local6.clone();
        if(local3.boundList != null) {
          local7.alternativa3d::next = local8;
        } else {
          local3.boundList = local8;
        }
        local7 = local8;
        local6 = local6.alternativa3d::next;
      }
      if(param1.negative != null) {
        local3.negative = this.cloneNode(param1.negative,param2);
      }
      if(param1.positive != null) {
        local3.positive = this.cloneNode(param1.positive,param2);
      }
      return local3;
    }

    override alternativa3d function draw(param1:Camera3D, param2:Canvas) : void {
      var local3:Canvas = null;
      var local4:int = 0;
      var local5:int = 0;
      var local6:Vertex = null;
      var local7:VG = null;
      var local8:VG = null;
      var local9:Face = null;
      if(this.alternativa3d::root != null) {
        if(alternativa3d::transformId > 500000000) {
          alternativa3d::transformId = 0;
          local6 = this.alternativa3d::vertexList;
          while(local6 != null) {
            local6.alternativa3d::transformId = 0;
            local6 = local6.alternativa3d::next;
          }
        }
        ++alternativa3d::transformId;
        alternativa3d::calculateInverseMatrix();
        this.calculateCameraPlanes(param1.nearClipping,param1.farClipping);
        local5 = this.cullingInContainer(alternativa3d::culling,this.alternativa3d::root.boundMinX,this.alternativa3d::root.boundMinY,this.alternativa3d::root.boundMinZ,this.alternativa3d::root.boundMaxX,this.alternativa3d::root.boundMaxY,this.alternativa3d::root.boundMaxZ);
        if(local5 >= 0) {
          if(param1.debug && (local4 = int(param1.alternativa3d::checkInDebug(this))) > 0) {
            local3 = param2.alternativa3d::getChildCanvas(true,false);
            if(Boolean(local4 & Debug.NODES)) {
              this.debugNode(this.alternativa3d::root,local5,param1,local3,1);
            }
            if(Boolean(local4 & Debug.BOUNDS)) {
              Debug.alternativa3d::drawBounds(param1,local3,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
            }
          }
          local3 = param2.alternativa3d::getChildCanvas(false,true,this,alpha,blendMode,colorTransform,filters);
          local3.alternativa3d::numDraws = 0;
          local7 = alternativa3d::collectVG(param1);
          local8 = local7;
          while(local8 != null) {
            local8.alternativa3d::calculateAABB(alternativa3d::ima,alternativa3d::imb,alternativa3d::imc,alternativa3d::imd,alternativa3d::ime,alternativa3d::imf,alternativa3d::img,alternativa3d::imh,alternativa3d::imi,alternativa3d::imj,alternativa3d::imk,alternativa3d::iml);
            local8 = local8.alternativa3d::next;
          }
          local9 = this.drawNode(this.alternativa3d::root,local5,param1,local3,local7);
          if(local9 != null) {
            this.drawFaces(param1,local3,local9);
          }
          if(local3.alternativa3d::numDraws > 0) {
            local3.alternativa3d::remChildren(local3.alternativa3d::numDraws);
          } else {
            --param2.alternativa3d::numDraws;
          }
        } else {
          super.alternativa3d::draw(param1,param2);
        }
      } else {
        super.alternativa3d::draw(param1,param2);
      }
    }

    override alternativa3d function getVG(param1:Camera3D) : VG {
      var local3:int = 0;
      var local4:Vertex = null;
      var local2:VG = alternativa3d::collectVG(param1);
      if(this.alternativa3d::root != null) {
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
        this.calculateCameraPlanes(param1.nearClipping,param1.farClipping);
        local3 = this.cullingInContainer(alternativa3d::culling,this.alternativa3d::root.boundMinX,this.alternativa3d::root.boundMinY,this.alternativa3d::root.boundMinZ,this.alternativa3d::root.boundMaxX,this.alternativa3d::root.boundMaxY,this.alternativa3d::root.boundMaxZ);
        if(local3 >= 0) {
          local2 = this.collectVGNode(this.alternativa3d::root,local3,param1,local2);
        }
      }
      alternativa3d::colorizeVG(local2);
      return local2;
    }

    private function collectVGNode(param1:BSPNode, param2:int, param3:Camera3D, param4:VG = null) : VG {
      var local5:VG = null;
      var local6:VG = null;
      var local9:VG = null;
      var local10:int = 0;
      var local11:int = 0;
      var local7:Object3D = param1.objectList;
      var local8:Object3D = param1.boundList;
      while(local7 != null) {
        if(local7.visible && ((local7.alternativa3d::culling = param2) == 0 || (local7.alternativa3d::culling = this.cullingInContainer(param2,local8.boundMinX,local8.boundMinY,local8.boundMinZ,local8.boundMaxX,local8.boundMaxY,local8.boundMaxZ)) >= 0)) {
          local7.alternativa3d::composeAndAppend(this);
          local9 = local7.alternativa3d::getVG(param3);
          if(local9 != null) {
            if(local5 != null) {
              local6.alternativa3d::next = local9;
            } else {
              local5 = local9;
              local6 = local9;
            }
            while(local6.alternativa3d::next != null) {
              local6 = local6.alternativa3d::next;
            }
          }
        }
        local7 = local7.alternativa3d::next;
        local8 = local8.alternativa3d::next;
      }
      if(local5 != null) {
        local6.alternativa3d::next = param4;
        param4 = local5;
      }
      if(param1.negative != null) {
        local10 = param2 > 0 ? this.cullingInContainer(param2,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ) : 0;
        if(local10 >= 0) {
          param4 = this.collectVGNode(param1.negative,local10,param3,param4);
        }
      }
      if(param1.positive != null) {
        local11 = param2 > 0 ? this.cullingInContainer(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ) : 0;
        if(local11 >= 0) {
          param4 = this.collectVGNode(param1.positive,local11,param3,param4);
        }
      }
      return param4;
    }

    override alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
      super.alternativa3d::updateBounds(param1,param2);
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
      if(this.alternativa3d::root != null) {
        this.updateBoundsNode(this.alternativa3d::root,param1,param2);
      }
    }

    private function updateBoundsNode(param1:BSPNode, param2:Object3D, param3:Object3D) : void {
      var local4:Object3D = null;
      if(param1.objectList == null) {
        if(param1.negative != null) {
          this.updateBoundsNode(param1.negative,param2,param3);
        }
        if(param1.positive != null) {
          this.updateBoundsNode(param1.positive,param2,param3);
        }
      } else {
        local4 = param1.objectList;
        while(local4 != null) {
          if(param3 != null) {
            local4.alternativa3d::composeAndAppend(param3);
          } else {
            local4.alternativa3d::composeMatrix();
          }
          local4.alternativa3d::updateBounds(param2,local4);
          local4 = local4.alternativa3d::next;
        }
      }
    }

    private function debugNode(param1:BSPNode, param2:int, param3:Camera3D, param4:Canvas, param5:Number) : void {
      var local6:int = 0;
      var local7:int = 0;
      if(param1 != null) {
        local6 = -1;
        local7 = -1;
        if(param1.negative != null) {
          local6 = param2 > 0 ? this.cullingInContainer(param2,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ) : 0;
        }
        if(param1.positive != null) {
          local7 = param2 > 0 ? this.cullingInContainer(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ) : 0;
        }
        if(local6 >= 0) {
          this.debugNode(param1.negative,local6,param3,param4,param5 * this.debugAlphaFade);
        }
        Debug.alternativa3d::drawBounds(param3,param4,this,param1.boundMinX,param1.boundMinY,param1.boundMinZ,param1.boundMaxX,param1.boundMaxY,param1.boundMaxZ,14496733,param5);
        if(local7 >= 0) {
          this.debugNode(param1.positive,local7,param3,param4,param5 * this.debugAlphaFade);
        }
      }
    }

    private function drawNode(param1:BSPNode, param2:int, param3:Camera3D, param4:Canvas, param5:VG, param6:Face = null) : Face {
      var local7:VG = null;
      var local8:VG = null;
      var local9:VG = null;
      var local10:int = 0;
      var local11:int = 0;
      var local12:int = 0;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Face = null;
      var local18:Face = null;
      var local19:Wrapper = null;
      var local20:Vertex = null;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Object3D = null;
      var local25:Object3D = null;
      var local26:VG = null;
      if(param1.objectList == null) {
        local11 = -1;
        local12 = -1;
        local13 = param1.normalX;
        local14 = param1.normalY;
        local15 = param1.normalZ;
        local16 = param1.offset;
        if(alternativa3d::imd * local13 + alternativa3d::imh * local14 + alternativa3d::iml * local15 > local16) {
          if(this.directionX * local13 + this.directionY * local14 + this.directionZ * local15 < this.viewAngle) {
            while(param5 != null) {
              local7 = param5.alternativa3d::next;
              local10 = this.checkBounds(local13,local14,local15,local16,param5.alternativa3d::boundMinX,param5.alternativa3d::boundMinY,param5.alternativa3d::boundMinZ,param5.alternativa3d::boundMaxX,param5.alternativa3d::boundMaxY,param5.alternativa3d::boundMaxZ,true);
              if(local10 < 0) {
                param5.alternativa3d::next = local8;
                local8 = param5;
              } else if(local10 > 0) {
                param5.alternativa3d::next = local9;
                local9 = param5;
              } else {
                param5.alternativa3d::split(param3,local13,local14,local15,local16,threshold);
                if(param5.alternativa3d::next != null) {
                  param5.alternativa3d::next.alternativa3d::next = local8;
                  local8 = param5.alternativa3d::next;
                }
                if(param5.alternativa3d::faceStruct != null) {
                  param5.alternativa3d::next = local9;
                  local9 = param5;
                } else {
                  param5.alternativa3d::destroy();
                }
              }
              param5 = local7;
            }
            if(param1.positive != null) {
              local12 = param2 > 0 ? this.cullingInContainer(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ) : 0;
            }
            if(local12 >= 0) {
              param6 = this.drawNode(param1.positive,local12,param3,param4,local9,param6);
            } else if(local9 != null) {
              if(param6 != null) {
                this.drawFaces(param3,param4,param6);
                param6 = null;
              }
              if(local9.alternativa3d::next != null) {
                if(resolveByAABB) {
                  alternativa3d::drawAABBGeometry(param3,param4,local9);
                } else if(resolveByOOBB) {
                  param5 = local9;
                  while(param5 != null) {
                    param5.alternativa3d::calculateOOBB(this);
                    param5 = param5.alternativa3d::next;
                  }
                  alternativa3d::drawOOBBGeometry(param3,param4,local9);
                } else {
                  alternativa3d::drawConflictGeometry(param3,param4,local9);
                }
              } else {
                local9.alternativa3d::draw(param3,param4,threshold,this);
                local9.alternativa3d::destroy();
              }
            }
            local18 = param1.faceList;
            while(local18 != null) {
              local19 = local18.alternativa3d::wrapper;
              while(local19 != null) {
                local20 = local19.alternativa3d::vertex;
                if(local20.alternativa3d::transformId != alternativa3d::transformId) {
                  local21 = local20.x;
                  local22 = local20.y;
                  local23 = local20.z;
                  local20.alternativa3d::cameraX = alternativa3d::ma * local21 + alternativa3d::mb * local22 + alternativa3d::mc * local23 + alternativa3d::md;
                  local20.alternativa3d::cameraY = alternativa3d::me * local21 + alternativa3d::mf * local22 + alternativa3d::mg * local23 + alternativa3d::mh;
                  local20.alternativa3d::cameraZ = alternativa3d::mi * local21 + alternativa3d::mj * local22 + alternativa3d::mk * local23 + alternativa3d::ml;
                  local20.alternativa3d::transformId = alternativa3d::transformId;
                  local20.alternativa3d::drawId = 0;
                }
                local19 = local19.alternativa3d::next;
              }
              local18.alternativa3d::processNext = local17;
              local17 = local18;
              local18 = local18.alternativa3d::next;
            }
            if(local17 != null) {
              if(param2 > 0) {
                if(this.clipping == 2) {
                  local17 = param3.alternativa3d::clip(local17,param2);
                } else {
                  local17 = param3.alternativa3d::cull(local17,param2);
                }
                if(local17 != null) {
                  local18 = local17;
                  while(local18.alternativa3d::processNext != null) {
                    local18 = local18.alternativa3d::processNext;
                  }
                  local18.alternativa3d::processNext = param6;
                  param6 = local17;
                }
              } else {
                local18 = local17;
                while(local18.alternativa3d::processNext != null) {
                  local18 = local18.alternativa3d::processNext;
                }
                local18.alternativa3d::processNext = param6;
                param6 = local17;
              }
            }
            if(param1.negative != null) {
              local11 = param2 > 0 ? this.cullingInContainer(param2,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ) : 0;
            }
            if(local11 >= 0) {
              param6 = this.drawNode(param1.negative,local11,param3,param4,local8,param6);
            } else if(local8 != null) {
              if(param6 != null) {
                this.drawFaces(param3,param4,param6);
                param6 = null;
              }
              if(local8.alternativa3d::next != null) {
                if(resolveByAABB) {
                  alternativa3d::drawAABBGeometry(param3,param4,local8);
                } else if(resolveByOOBB) {
                  param5 = local8;
                  while(param5 != null) {
                    param5.alternativa3d::calculateOOBB(this);
                    param5 = param5.alternativa3d::next;
                  }
                  alternativa3d::drawOOBBGeometry(param3,param4,local8);
                } else {
                  alternativa3d::drawConflictGeometry(param3,param4,local8);
                }
              } else {
                local8.alternativa3d::draw(param3,param4,threshold,this);
                local8.alternativa3d::destroy();
              }
            }
          } else {
            while(param5 != null) {
              local7 = param5.alternativa3d::next;
              local10 = this.checkBounds(local13,local14,local15,local16,param5.alternativa3d::boundMinX,param5.alternativa3d::boundMinY,param5.alternativa3d::boundMinZ,param5.alternativa3d::boundMaxX,param5.alternativa3d::boundMaxY,param5.alternativa3d::boundMaxZ,true);
              if(local10 < 0) {
                param5.alternativa3d::destroy();
              } else if(local10 > 0) {
                param5.alternativa3d::next = local9;
                local9 = param5;
              } else {
                param5.alternativa3d::crop(param3,local13,local14,local15,local16,threshold);
                if(param5.alternativa3d::faceStruct != null) {
                  param5.alternativa3d::next = local9;
                  local9 = param5;
                } else {
                  param5.alternativa3d::destroy();
                }
              }
              param5 = local7;
            }
            if(param1.positive != null) {
              local12 = param2 > 0 ? this.cullingInContainer(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ) : 0;
            }
            if(local12 >= 0) {
              param6 = this.drawNode(param1.positive,local12,param3,param4,local9,param6);
            } else if(local9 != null) {
              if(param6 != null) {
                this.drawFaces(param3,param4,param6);
                param6 = null;
              }
              if(local9.alternativa3d::next != null) {
                if(resolveByAABB) {
                  alternativa3d::drawAABBGeometry(param3,param4,local9);
                } else if(resolveByOOBB) {
                  param5 = local9;
                  while(param5 != null) {
                    param5.alternativa3d::calculateOOBB(this);
                    param5 = param5.alternativa3d::next;
                  }
                  alternativa3d::drawOOBBGeometry(param3,param4,local9);
                } else {
                  alternativa3d::drawConflictGeometry(param3,param4,local9);
                }
              } else {
                local9.alternativa3d::draw(param3,param4,threshold,this);
                local9.alternativa3d::destroy();
              }
            }
          }
        } else if(this.directionX * local13 + this.directionY * local14 + this.directionZ * local15 > -this.viewAngle) {
          while(param5 != null) {
            local7 = param5.alternativa3d::next;
            local10 = this.checkBounds(local13,local14,local15,local16,param5.alternativa3d::boundMinX,param5.alternativa3d::boundMinY,param5.alternativa3d::boundMinZ,param5.alternativa3d::boundMaxX,param5.alternativa3d::boundMaxY,param5.alternativa3d::boundMaxZ,false);
            if(local10 < 0) {
              param5.alternativa3d::next = local8;
              local8 = param5;
            } else if(local10 > 0) {
              param5.alternativa3d::next = local9;
              local9 = param5;
            } else {
              param5.alternativa3d::split(param3,local13,local14,local15,local16,threshold);
              if(param5.alternativa3d::next != null) {
                param5.alternativa3d::next.alternativa3d::next = local8;
                local8 = param5.alternativa3d::next;
              }
              if(param5.alternativa3d::faceStruct != null) {
                param5.alternativa3d::next = local9;
                local9 = param5;
              } else {
                param5.alternativa3d::destroy();
              }
            }
            param5 = local7;
          }
          if(param1.negative != null) {
            local11 = param2 > 0 ? this.cullingInContainer(param2,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ) : 0;
          }
          if(local11 >= 0) {
            param6 = this.drawNode(param1.negative,local11,param3,param4,local8,param6);
          } else if(local8 != null) {
            if(param6 != null) {
              this.drawFaces(param3,param4,param6);
              param6 = null;
            }
            if(local8.alternativa3d::next != null) {
              if(resolveByAABB) {
                alternativa3d::drawAABBGeometry(param3,param4,local8);
              } else if(resolveByOOBB) {
                param5 = local8;
                while(param5 != null) {
                  param5.alternativa3d::calculateOOBB(this);
                  param5 = param5.alternativa3d::next;
                }
                alternativa3d::drawOOBBGeometry(param3,param4,local8);
              } else {
                alternativa3d::drawConflictGeometry(param3,param4,local8);
              }
            } else {
              local8.alternativa3d::draw(param3,param4,threshold,this);
              local8.alternativa3d::destroy();
            }
          }
          if(param1.positive != null) {
            local12 = param2 > 0 ? this.cullingInContainer(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ) : 0;
          }
          if(local12 >= 0) {
            param6 = this.drawNode(param1.positive,local12,param3,param4,local9,param6);
          } else if(local9 != null) {
            if(param6 != null) {
              this.drawFaces(param3,param4,param6);
              param6 = null;
            }
            if(local9.alternativa3d::next != null) {
              if(resolveByAABB) {
                alternativa3d::drawAABBGeometry(param3,param4,local9);
              } else if(resolveByOOBB) {
                param5 = local9;
                while(param5 != null) {
                  param5.alternativa3d::calculateOOBB(this);
                  param5 = param5.alternativa3d::next;
                }
                alternativa3d::drawOOBBGeometry(param3,param4,local9);
              } else {
                alternativa3d::drawConflictGeometry(param3,param4,local9);
              }
            } else {
              local9.alternativa3d::draw(param3,param4,threshold,this);
              local9.alternativa3d::destroy();
            }
          }
        } else {
          while(param5 != null) {
            local7 = param5.alternativa3d::next;
            local10 = this.checkBounds(local13,local14,local15,local16,param5.alternativa3d::boundMinX,param5.alternativa3d::boundMinY,param5.alternativa3d::boundMinZ,param5.alternativa3d::boundMaxX,param5.alternativa3d::boundMaxY,param5.alternativa3d::boundMaxZ,false);
            if(local10 < 0) {
              param5.alternativa3d::next = local8;
              local8 = param5;
            } else if(local10 > 0) {
              param5.alternativa3d::destroy();
            } else {
              param5.alternativa3d::crop(param3,-local13,-local14,-local15,-local16,threshold);
              if(param5.alternativa3d::faceStruct != null) {
                param5.alternativa3d::next = local8;
                local8 = param5;
              } else {
                param5.alternativa3d::destroy();
              }
            }
            param5 = local7;
          }
          if(param1.negative != null) {
            local11 = param2 > 0 ? this.cullingInContainer(param2,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ) : 0;
          }
          if(local11 >= 0) {
            param6 = this.drawNode(param1.negative,local11,param3,param4,local8,param6);
          } else if(local8 != null) {
            if(param6 != null) {
              this.drawFaces(param3,param4,param6);
              param6 = null;
            }
            if(local8.alternativa3d::next != null) {
              if(resolveByAABB) {
                alternativa3d::drawAABBGeometry(param3,param4,local8);
              } else if(resolveByOOBB) {
                param5 = local8;
                while(param5 != null) {
                  param5.alternativa3d::calculateOOBB(this);
                  param5 = param5.alternativa3d::next;
                }
                alternativa3d::drawOOBBGeometry(param3,param4,local8);
              } else {
                alternativa3d::drawConflictGeometry(param3,param4,local8);
              }
            } else {
              local8.alternativa3d::draw(param3,param4,threshold,this);
              local8.alternativa3d::destroy();
            }
          }
        }
      } else {
        if(param6 != null) {
          this.drawFaces(param3,param4,param6);
          param6 = null;
        }
        if(param1.objectList.alternativa3d::next != null || param5 != null) {
          local24 = param1.objectList;
          local25 = param1.boundList;
          while(local24 != null) {
            if(local24.visible && ((local24.alternativa3d::culling = param2) == 0 || (local24.alternativa3d::culling = this.cullingInContainer(param2,local25.boundMinX,local25.boundMinY,local25.boundMinZ,local25.boundMaxX,local25.boundMaxY,local25.boundMaxZ)) >= 0)) {
              local24.alternativa3d::composeAndAppend(this);
              local26 = local24.alternativa3d::getVG(param3);
              while(local26 != null) {
                local7 = local26.alternativa3d::next;
                local26.alternativa3d::next = param5;
                param5 = local26;
                if(resolveByAABB) {
                  local26.alternativa3d::calculateAABB(alternativa3d::ima,alternativa3d::imb,alternativa3d::imc,alternativa3d::imd,alternativa3d::ime,alternativa3d::imf,alternativa3d::img,alternativa3d::imh,alternativa3d::imi,alternativa3d::imj,alternativa3d::imk,alternativa3d::iml);
                }
                local26 = local7;
              }
            }
            local24 = local24.alternativa3d::next;
            local25 = local25.alternativa3d::next;
          }
          if(param5 != null) {
            if(param5.alternativa3d::next != null) {
              alternativa3d::drawConflictGeometry(param3,param4,param5);
            } else {
              param5.alternativa3d::draw(param3,param4,threshold,this);
              param5.alternativa3d::destroy();
            }
          }
        } else {
          local24 = param1.objectList;
          if(local24.visible) {
            local24.alternativa3d::composeAndAppend(this);
            local24.alternativa3d::culling = param2;
            local24.alternativa3d::draw(param3,param4);
          }
        }
      }
      return param6;
    }

    private function drawFaces(param1:Camera3D, param2:Canvas, param3:Face) : void {
      var local6:Face = null;
      if(param1.debug && Boolean(param1.alternativa3d::checkInDebug(this) & Debug.EDGES)) {
        Debug.alternativa3d::drawEdges(param1,param2.alternativa3d::getChildCanvas(true,false),param3,16777215);
      }
      var local4:Canvas = param2.alternativa3d::getChildCanvas(true,false,this);
      var local5:Face = param3;
      while(local5 != null) {
        local6 = local5.alternativa3d::processNext;
        if(local6 == null || local6.material != param3.material) {
          local5.alternativa3d::processNext = null;
          if(param3.material != null) {
            param3.material.alternativa3d::draw(param1,local4,param3,alternativa3d::ml);
          } else {
            while(param3 != null) {
              local5 = param3.alternativa3d::processNext;
              param3.alternativa3d::processNext = null;
              param3 = local5;
            }
          }
          param3 = local6;
        }
        local5 = local6;
      }
    }

    private function checkBounds(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Boolean) : int {
      if(param11) {
        if(param1 >= 0) {
          if(param2 >= 0) {
            if(param3 >= 0) {
              if(param5 * param1 + param6 * param2 + param7 * param3 >= param4 - threshold) {
                return 1;
              }
              if(param8 * param1 + param9 * param2 + param10 * param3 <= param4 + threshold) {
                return -1;
              }
            } else {
              if(param5 * param1 + param6 * param2 + param10 * param3 >= param4 - threshold) {
                return 1;
              }
              if(param8 * param1 + param9 * param2 + param7 * param3 <= param4 + threshold) {
                return -1;
              }
            }
          } else if(param3 >= 0) {
            if(param5 * param1 + param9 * param2 + param7 * param3 >= param4 - threshold) {
              return 1;
            }
            if(param8 * param1 + param6 * param2 + param10 * param3 <= param4 + threshold) {
              return -1;
            }
          } else {
            if(param5 * param1 + param9 * param2 + param10 * param3 >= param4 - threshold) {
              return 1;
            }
            if(param8 * param1 + param6 * param2 + param7 * param3 <= param4 + threshold) {
              return -1;
            }
          }
        } else if(param2 >= 0) {
          if(param3 >= 0) {
            if(param8 * param1 + param6 * param2 + param7 * param3 >= param4 - threshold) {
              return 1;
            }
            if(param5 * param1 + param9 * param2 + param10 * param3 <= param4 + threshold) {
              return -1;
            }
          } else {
            if(param8 * param1 + param6 * param2 + param10 * param3 >= param4 - threshold) {
              return 1;
            }
            if(param5 * param1 + param9 * param2 + param7 * param3 <= param4 + threshold) {
              return -1;
            }
          }
        } else if(param3 >= 0) {
          if(param8 * param1 + param9 * param2 + param7 * param3 >= param4 - threshold) {
            return 1;
          }
          if(param5 * param1 + param6 * param2 + param10 * param3 <= param4 + threshold) {
            return -1;
          }
        } else {
          if(param8 * param1 + param9 * param2 + param10 * param3 >= param4 - threshold) {
            return 1;
          }
          if(param5 * param1 + param6 * param2 + param7 * param3 <= param4 + threshold) {
            return -1;
          }
        }
      } else if(param1 >= 0) {
        if(param2 >= 0) {
          if(param3 >= 0) {
            if(param8 * param1 + param9 * param2 + param10 * param3 <= param4 + threshold) {
              return -1;
            }
            if(param5 * param1 + param6 * param2 + param7 * param3 >= param4 - threshold) {
              return 1;
            }
          } else {
            if(param8 * param1 + param9 * param2 + param7 * param3 <= param4 + threshold) {
              return -1;
            }
            if(param5 * param1 + param6 * param2 + param10 * param3 >= param4 - threshold) {
              return 1;
            }
          }
        } else if(param3 >= 0) {
          if(param8 * param1 + param6 * param2 + param10 * param3 <= param4 + threshold) {
            return -1;
          }
          if(param5 * param1 + param9 * param2 + param7 * param3 >= param4 - threshold) {
            return 1;
          }
        } else {
          if(param8 * param1 + param6 * param2 + param7 * param3 <= param4 + threshold) {
            return -1;
          }
          if(param5 * param1 + param9 * param2 + param10 * param3 >= param4 - threshold) {
            return 1;
          }
        }
      } else if(param2 >= 0) {
        if(param3 >= 0) {
          if(param5 * param1 + param9 * param2 + param10 * param3 <= param4 + threshold) {
            return -1;
          }
          if(param8 * param1 + param6 * param2 + param7 * param3 >= param4 - threshold) {
            return 1;
          }
        } else {
          if(param5 * param1 + param9 * param2 + param7 * param3 <= param4 + threshold) {
            return -1;
          }
          if(param8 * param1 + param6 * param2 + param10 * param3 >= param4 - threshold) {
            return 1;
          }
        }
      } else if(param3 >= 0) {
        if(param5 * param1 + param6 * param2 + param10 * param3 <= param4 + threshold) {
          return -1;
        }
        if(param8 * param1 + param9 * param2 + param7 * param3 >= param4 - threshold) {
          return 1;
        }
      } else {
        if(param5 * param1 + param6 * param2 + param7 * param3 <= param4 + threshold) {
          return -1;
        }
        if(param8 * param1 + param9 * param2 + param10 * param3 >= param4 - threshold) {
          return 1;
        }
      }
      return 0;
    }

    private function calculateCameraPlanes(param1:Number, param2:Number) : void {
      this.directionX = alternativa3d::imc;
      this.directionY = alternativa3d::img;
      this.directionZ = alternativa3d::imk;
      var local3:Number = 1 / Math.sqrt(this.directionX * this.directionX + this.directionY * this.directionY + this.directionZ * this.directionZ);
      this.directionX *= local3;
      this.directionY *= local3;
      this.directionZ *= local3;
      this.nearPlaneX = alternativa3d::imc;
      this.nearPlaneY = alternativa3d::img;
      this.nearPlaneZ = alternativa3d::imk;
      this.nearPlaneOffset = (alternativa3d::imc * param1 + alternativa3d::imd) * this.nearPlaneX + (alternativa3d::img * param1 + alternativa3d::imh) * this.nearPlaneY + (alternativa3d::imk * param1 + alternativa3d::iml) * this.nearPlaneZ;
      this.farPlaneX = -alternativa3d::imc;
      this.farPlaneY = -alternativa3d::img;
      this.farPlaneZ = -alternativa3d::imk;
      this.farPlaneOffset = (alternativa3d::imc * param2 + alternativa3d::imd) * this.farPlaneX + (alternativa3d::img * param2 + alternativa3d::imh) * this.farPlaneY + (alternativa3d::imk * param2 + alternativa3d::iml) * this.farPlaneZ;
      var local4:Number = -alternativa3d::ima - alternativa3d::imb + alternativa3d::imc;
      var local5:Number = -alternativa3d::ime - alternativa3d::imf + alternativa3d::img;
      var local6:Number = -alternativa3d::imi - alternativa3d::imj + alternativa3d::imk;
      var local7:Number = alternativa3d::ima - alternativa3d::imb + alternativa3d::imc;
      var local8:Number = alternativa3d::ime - alternativa3d::imf + alternativa3d::img;
      var local9:Number = alternativa3d::imi - alternativa3d::imj + alternativa3d::imk;
      this.topPlaneX = local9 * local5 - local8 * local6;
      this.topPlaneY = local7 * local6 - local9 * local4;
      this.topPlaneZ = local8 * local4 - local7 * local5;
      this.topPlaneOffset = alternativa3d::imd * this.topPlaneX + alternativa3d::imh * this.topPlaneY + alternativa3d::iml * this.topPlaneZ;
      local3 = 1 / Math.sqrt(local4 * local4 + local5 * local5 + local6 * local6);
      local4 *= local3;
      local5 *= local3;
      local6 *= local3;
      var local10:Number = local4 * this.directionX + local5 * this.directionY + local6 * this.directionZ;
      this.viewAngle = local10;
      local4 = local7;
      local5 = local8;
      local6 = local9;
      local7 = alternativa3d::ima + alternativa3d::imb + alternativa3d::imc;
      local8 = alternativa3d::ime + alternativa3d::imf + alternativa3d::img;
      local9 = alternativa3d::imi + alternativa3d::imj + alternativa3d::imk;
      this.rightPlaneX = local9 * local5 - local8 * local6;
      this.rightPlaneY = local7 * local6 - local9 * local4;
      this.rightPlaneZ = local8 * local4 - local7 * local5;
      this.rightPlaneOffset = alternativa3d::imd * this.rightPlaneX + alternativa3d::imh * this.rightPlaneY + alternativa3d::iml * this.rightPlaneZ;
      local3 = 1 / Math.sqrt(local4 * local4 + local5 * local5 + local6 * local6);
      local4 *= local3;
      local5 *= local3;
      local6 *= local3;
      local10 = local4 * this.directionX + local5 * this.directionY + local6 * this.directionZ;
      if(local10 < this.viewAngle) {
        this.viewAngle = local10;
      }
      local4 = local7;
      local5 = local8;
      local6 = local9;
      local7 = -alternativa3d::ima + alternativa3d::imb + alternativa3d::imc;
      local8 = -alternativa3d::ime + alternativa3d::imf + alternativa3d::img;
      local9 = -alternativa3d::imi + alternativa3d::imj + alternativa3d::imk;
      this.bottomPlaneX = local9 * local5 - local8 * local6;
      this.bottomPlaneY = local7 * local6 - local9 * local4;
      this.bottomPlaneZ = local8 * local4 - local7 * local5;
      this.bottomPlaneOffset = alternativa3d::imd * this.bottomPlaneX + alternativa3d::imh * this.bottomPlaneY + alternativa3d::iml * this.bottomPlaneZ;
      local3 = 1 / Math.sqrt(local4 * local4 + local5 * local5 + local6 * local6);
      local4 *= local3;
      local5 *= local3;
      local6 *= local3;
      local10 = local4 * this.directionX + local5 * this.directionY + local6 * this.directionZ;
      if(local10 < this.viewAngle) {
        this.viewAngle = local10;
      }
      local4 = local7;
      local5 = local8;
      local6 = local9;
      local7 = -alternativa3d::ima - alternativa3d::imb + alternativa3d::imc;
      local8 = -alternativa3d::ime - alternativa3d::imf + alternativa3d::img;
      local9 = -alternativa3d::imi - alternativa3d::imj + alternativa3d::imk;
      this.leftPlaneX = local9 * local5 - local8 * local6;
      this.leftPlaneY = local7 * local6 - local9 * local4;
      this.leftPlaneZ = local8 * local4 - local7 * local5;
      this.leftPlaneOffset = alternativa3d::imd * this.leftPlaneX + alternativa3d::imh * this.leftPlaneY + alternativa3d::iml * this.leftPlaneZ;
      local3 = 1 / Math.sqrt(local4 * local4 + local5 * local5 + local6 * local6);
      local4 *= local3;
      local5 *= local3;
      local6 *= local3;
      local10 = local4 * this.directionX + local5 * this.directionY + local6 * this.directionZ;
      if(local10 < this.viewAngle) {
        this.viewAngle = local10;
      }
      this.viewAngle = Math.sin(Math.acos(this.viewAngle));
    }

    private function cullingInContainer(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : int {
      if(param1 > 0) {
        if(Boolean(param1 & 1)) {
          if(this.nearPlaneX >= 0) {
            if(this.nearPlaneY >= 0) {
              if(this.nearPlaneZ >= 0) {
                if(param5 * this.nearPlaneX + param6 * this.nearPlaneY + param7 * this.nearPlaneZ <= this.nearPlaneOffset) {
                  return -1;
                }
                if(param2 * this.nearPlaneX + param3 * this.nearPlaneY + param4 * this.nearPlaneZ > this.nearPlaneOffset) {
                  param1 &= 62;
                }
              } else {
                if(param5 * this.nearPlaneX + param6 * this.nearPlaneY + param4 * this.nearPlaneZ <= this.nearPlaneOffset) {
                  return -1;
                }
                if(param2 * this.nearPlaneX + param3 * this.nearPlaneY + param7 * this.nearPlaneZ > this.nearPlaneOffset) {
                  param1 &= 62;
                }
              }
            } else if(this.nearPlaneZ >= 0) {
              if(param5 * this.nearPlaneX + param3 * this.nearPlaneY + param7 * this.nearPlaneZ <= this.nearPlaneOffset) {
                return -1;
              }
              if(param2 * this.nearPlaneX + param6 * this.nearPlaneY + param4 * this.nearPlaneZ > this.nearPlaneOffset) {
                param1 &= 62;
              }
            } else {
              if(param5 * this.nearPlaneX + param3 * this.nearPlaneY + param4 * this.nearPlaneZ <= this.nearPlaneOffset) {
                return -1;
              }
              if(param2 * this.nearPlaneX + param6 * this.nearPlaneY + param7 * this.nearPlaneZ > this.nearPlaneOffset) {
                param1 &= 62;
              }
            }
          } else if(this.nearPlaneY >= 0) {
            if(this.nearPlaneZ >= 0) {
              if(param2 * this.nearPlaneX + param6 * this.nearPlaneY + param7 * this.nearPlaneZ <= this.nearPlaneOffset) {
                return -1;
              }
              if(param5 * this.nearPlaneX + param3 * this.nearPlaneY + param4 * this.nearPlaneZ > this.nearPlaneOffset) {
                param1 &= 62;
              }
            } else {
              if(param2 * this.nearPlaneX + param6 * this.nearPlaneY + param4 * this.nearPlaneZ <= this.nearPlaneOffset) {
                return -1;
              }
              if(param5 * this.nearPlaneX + param3 * this.nearPlaneY + param7 * this.nearPlaneZ > this.nearPlaneOffset) {
                param1 &= 62;
              }
            }
          } else if(this.nearPlaneZ >= 0) {
            if(param2 * this.nearPlaneX + param3 * this.nearPlaneY + param7 * this.nearPlaneZ <= this.nearPlaneOffset) {
              return -1;
            }
            if(param5 * this.nearPlaneX + param6 * this.nearPlaneY + param4 * this.nearPlaneZ > this.nearPlaneOffset) {
              param1 &= 62;
            }
          } else {
            if(param2 * this.nearPlaneX + param3 * this.nearPlaneY + param4 * this.nearPlaneZ <= this.nearPlaneOffset) {
              return -1;
            }
            if(param5 * this.nearPlaneX + param6 * this.nearPlaneY + param7 * this.nearPlaneZ > this.nearPlaneOffset) {
              param1 &= 62;
            }
          }
        }
        if(Boolean(param1 & 2)) {
          if(this.farPlaneX >= 0) {
            if(this.farPlaneY >= 0) {
              if(this.farPlaneZ >= 0) {
                if(param5 * this.farPlaneX + param6 * this.farPlaneY + param7 * this.farPlaneZ <= this.farPlaneOffset) {
                  return -1;
                }
                if(param2 * this.farPlaneX + param3 * this.farPlaneY + param4 * this.farPlaneZ > this.farPlaneOffset) {
                  param1 &= 61;
                }
              } else {
                if(param5 * this.farPlaneX + param6 * this.farPlaneY + param4 * this.farPlaneZ <= this.farPlaneOffset) {
                  return -1;
                }
                if(param2 * this.farPlaneX + param3 * this.farPlaneY + param7 * this.farPlaneZ > this.farPlaneOffset) {
                  param1 &= 61;
                }
              }
            } else if(this.farPlaneZ >= 0) {
              if(param5 * this.farPlaneX + param3 * this.farPlaneY + param7 * this.farPlaneZ <= this.farPlaneOffset) {
                return -1;
              }
              if(param2 * this.farPlaneX + param6 * this.farPlaneY + param4 * this.farPlaneZ > this.farPlaneOffset) {
                param1 &= 61;
              }
            } else {
              if(param5 * this.farPlaneX + param3 * this.farPlaneY + param4 * this.farPlaneZ <= this.farPlaneOffset) {
                return -1;
              }
              if(param2 * this.farPlaneX + param6 * this.farPlaneY + param7 * this.farPlaneZ > this.farPlaneOffset) {
                param1 &= 61;
              }
            }
          } else if(this.farPlaneY >= 0) {
            if(this.farPlaneZ >= 0) {
              if(param2 * this.farPlaneX + param6 * this.farPlaneY + param7 * this.farPlaneZ <= this.farPlaneOffset) {
                return -1;
              }
              if(param5 * this.farPlaneX + param3 * this.farPlaneY + param4 * this.farPlaneZ > this.farPlaneOffset) {
                param1 &= 61;
              }
            } else {
              if(param2 * this.farPlaneX + param6 * this.farPlaneY + param4 * this.farPlaneZ <= this.farPlaneOffset) {
                return -1;
              }
              if(param5 * this.farPlaneX + param3 * this.farPlaneY + param7 * this.farPlaneZ > this.farPlaneOffset) {
                param1 &= 61;
              }
            }
          } else if(this.farPlaneZ >= 0) {
            if(param2 * this.farPlaneX + param3 * this.farPlaneY + param7 * this.farPlaneZ <= this.farPlaneOffset) {
              return -1;
            }
            if(param5 * this.farPlaneX + param6 * this.farPlaneY + param4 * this.farPlaneZ > this.farPlaneOffset) {
              param1 &= 61;
            }
          } else {
            if(param2 * this.farPlaneX + param3 * this.farPlaneY + param4 * this.farPlaneZ <= this.farPlaneOffset) {
              return -1;
            }
            if(param5 * this.farPlaneX + param6 * this.farPlaneY + param7 * this.farPlaneZ > this.farPlaneOffset) {
              param1 &= 61;
            }
          }
        }
        if(Boolean(param1 & 4)) {
          if(this.leftPlaneX >= 0) {
            if(this.leftPlaneY >= 0) {
              if(this.leftPlaneZ >= 0) {
                if(param5 * this.leftPlaneX + param6 * this.leftPlaneY + param7 * this.leftPlaneZ <= this.leftPlaneOffset) {
                  return -1;
                }
                if(param2 * this.leftPlaneX + param3 * this.leftPlaneY + param4 * this.leftPlaneZ > this.leftPlaneOffset) {
                  param1 &= 59;
                }
              } else {
                if(param5 * this.leftPlaneX + param6 * this.leftPlaneY + param4 * this.leftPlaneZ <= this.leftPlaneOffset) {
                  return -1;
                }
                if(param2 * this.leftPlaneX + param3 * this.leftPlaneY + param7 * this.leftPlaneZ > this.leftPlaneOffset) {
                  param1 &= 59;
                }
              }
            } else if(this.leftPlaneZ >= 0) {
              if(param5 * this.leftPlaneX + param3 * this.leftPlaneY + param7 * this.leftPlaneZ <= this.leftPlaneOffset) {
                return -1;
              }
              if(param2 * this.leftPlaneX + param6 * this.leftPlaneY + param4 * this.leftPlaneZ > this.leftPlaneOffset) {
                param1 &= 59;
              }
            } else {
              if(param5 * this.leftPlaneX + param3 * this.leftPlaneY + param4 * this.leftPlaneZ <= this.leftPlaneOffset) {
                return -1;
              }
              if(param2 * this.leftPlaneX + param6 * this.leftPlaneY + param7 * this.leftPlaneZ > this.leftPlaneOffset) {
                param1 &= 59;
              }
            }
          } else if(this.leftPlaneY >= 0) {
            if(this.leftPlaneZ >= 0) {
              if(param2 * this.leftPlaneX + param6 * this.leftPlaneY + param7 * this.leftPlaneZ <= this.leftPlaneOffset) {
                return -1;
              }
              if(param5 * this.leftPlaneX + param3 * this.leftPlaneY + param4 * this.leftPlaneZ > this.leftPlaneOffset) {
                param1 &= 59;
              }
            } else {
              if(param2 * this.leftPlaneX + param6 * this.leftPlaneY + param4 * this.leftPlaneZ <= this.leftPlaneOffset) {
                return -1;
              }
              if(param5 * this.leftPlaneX + param3 * this.leftPlaneY + param7 * this.leftPlaneZ > this.leftPlaneOffset) {
                param1 &= 59;
              }
            }
          } else if(this.leftPlaneZ >= 0) {
            if(param2 * this.leftPlaneX + param3 * this.leftPlaneY + param7 * this.leftPlaneZ <= this.leftPlaneOffset) {
              return -1;
            }
            if(param5 * this.leftPlaneX + param6 * this.leftPlaneY + param4 * this.leftPlaneZ > this.leftPlaneOffset) {
              param1 &= 59;
            }
          } else {
            if(param2 * this.leftPlaneX + param3 * this.leftPlaneY + param4 * this.leftPlaneZ <= this.leftPlaneOffset) {
              return -1;
            }
            if(param5 * this.leftPlaneX + param6 * this.leftPlaneY + param7 * this.leftPlaneZ > this.leftPlaneOffset) {
              param1 &= 59;
            }
          }
        }
        if(Boolean(param1 & 8)) {
          if(this.rightPlaneX >= 0) {
            if(this.rightPlaneY >= 0) {
              if(this.rightPlaneZ >= 0) {
                if(param5 * this.rightPlaneX + param6 * this.rightPlaneY + param7 * this.rightPlaneZ <= this.rightPlaneOffset) {
                  return -1;
                }
                if(param2 * this.rightPlaneX + param3 * this.rightPlaneY + param4 * this.rightPlaneZ > this.rightPlaneOffset) {
                  param1 &= 55;
                }
              } else {
                if(param5 * this.rightPlaneX + param6 * this.rightPlaneY + param4 * this.rightPlaneZ <= this.rightPlaneOffset) {
                  return -1;
                }
                if(param2 * this.rightPlaneX + param3 * this.rightPlaneY + param7 * this.rightPlaneZ > this.rightPlaneOffset) {
                  param1 &= 55;
                }
              }
            } else if(this.rightPlaneZ >= 0) {
              if(param5 * this.rightPlaneX + param3 * this.rightPlaneY + param7 * this.rightPlaneZ <= this.rightPlaneOffset) {
                return -1;
              }
              if(param2 * this.rightPlaneX + param6 * this.rightPlaneY + param4 * this.rightPlaneZ > this.rightPlaneOffset) {
                param1 &= 55;
              }
            } else {
              if(param5 * this.rightPlaneX + param3 * this.rightPlaneY + param4 * this.rightPlaneZ <= this.rightPlaneOffset) {
                return -1;
              }
              if(param2 * this.rightPlaneX + param6 * this.rightPlaneY + param7 * this.rightPlaneZ > this.rightPlaneOffset) {
                param1 &= 55;
              }
            }
          } else if(this.rightPlaneY >= 0) {
            if(this.rightPlaneZ >= 0) {
              if(param2 * this.rightPlaneX + param6 * this.rightPlaneY + param7 * this.rightPlaneZ <= this.rightPlaneOffset) {
                return -1;
              }
              if(param5 * this.rightPlaneX + param3 * this.rightPlaneY + param4 * this.rightPlaneZ > this.rightPlaneOffset) {
                param1 &= 55;
              }
            } else {
              if(param2 * this.rightPlaneX + param6 * this.rightPlaneY + param4 * this.rightPlaneZ <= this.rightPlaneOffset) {
                return -1;
              }
              if(param5 * this.rightPlaneX + param3 * this.rightPlaneY + param7 * this.rightPlaneZ > this.rightPlaneOffset) {
                param1 &= 55;
              }
            }
          } else if(this.rightPlaneZ >= 0) {
            if(param2 * this.rightPlaneX + param3 * this.rightPlaneY + param7 * this.rightPlaneZ <= this.rightPlaneOffset) {
              return -1;
            }
            if(param5 * this.rightPlaneX + param6 * this.rightPlaneY + param4 * this.rightPlaneZ > this.rightPlaneOffset) {
              param1 &= 55;
            }
          } else {
            if(param2 * this.rightPlaneX + param3 * this.rightPlaneY + param4 * this.rightPlaneZ <= this.rightPlaneOffset) {
              return -1;
            }
            if(param5 * this.rightPlaneX + param6 * this.rightPlaneY + param7 * this.rightPlaneZ > this.rightPlaneOffset) {
              param1 &= 55;
            }
          }
        }
        if(Boolean(param1 & 0x10)) {
          if(this.topPlaneX >= 0) {
            if(this.topPlaneY >= 0) {
              if(this.topPlaneZ >= 0) {
                if(param5 * this.topPlaneX + param6 * this.topPlaneY + param7 * this.topPlaneZ <= this.topPlaneOffset) {
                  return -1;
                }
                if(param2 * this.topPlaneX + param3 * this.topPlaneY + param4 * this.topPlaneZ > this.topPlaneOffset) {
                  param1 &= 47;
                }
              } else {
                if(param5 * this.topPlaneX + param6 * this.topPlaneY + param4 * this.topPlaneZ <= this.topPlaneOffset) {
                  return -1;
                }
                if(param2 * this.topPlaneX + param3 * this.topPlaneY + param7 * this.topPlaneZ > this.topPlaneOffset) {
                  param1 &= 47;
                }
              }
            } else if(this.topPlaneZ >= 0) {
              if(param5 * this.topPlaneX + param3 * this.topPlaneY + param7 * this.topPlaneZ <= this.topPlaneOffset) {
                return -1;
              }
              if(param2 * this.topPlaneX + param6 * this.topPlaneY + param4 * this.topPlaneZ > this.topPlaneOffset) {
                param1 &= 47;
              }
            } else {
              if(param5 * this.topPlaneX + param3 * this.topPlaneY + param4 * this.topPlaneZ <= this.topPlaneOffset) {
                return -1;
              }
              if(param2 * this.topPlaneX + param6 * this.topPlaneY + param7 * this.topPlaneZ > this.topPlaneOffset) {
                param1 &= 47;
              }
            }
          } else if(this.topPlaneY >= 0) {
            if(this.topPlaneZ >= 0) {
              if(param2 * this.topPlaneX + param6 * this.topPlaneY + param7 * this.topPlaneZ <= this.topPlaneOffset) {
                return -1;
              }
              if(param5 * this.topPlaneX + param3 * this.topPlaneY + param4 * this.topPlaneZ > this.topPlaneOffset) {
                param1 &= 47;
              }
            } else {
              if(param2 * this.topPlaneX + param6 * this.topPlaneY + param4 * this.topPlaneZ <= this.topPlaneOffset) {
                return -1;
              }
              if(param5 * this.topPlaneX + param3 * this.topPlaneY + param7 * this.topPlaneZ > this.topPlaneOffset) {
                param1 &= 47;
              }
            }
          } else if(this.topPlaneZ >= 0) {
            if(param2 * this.topPlaneX + param3 * this.topPlaneY + param7 * this.topPlaneZ <= this.topPlaneOffset) {
              return -1;
            }
            if(param5 * this.topPlaneX + param6 * this.topPlaneY + param4 * this.topPlaneZ > this.topPlaneOffset) {
              param1 &= 47;
            }
          } else {
            if(param2 * this.topPlaneX + param3 * this.topPlaneY + param4 * this.topPlaneZ <= this.topPlaneOffset) {
              return -1;
            }
            if(param5 * this.topPlaneX + param6 * this.topPlaneY + param7 * this.topPlaneZ > this.topPlaneOffset) {
              param1 &= 47;
            }
          }
        }
        if(Boolean(param1 & 0x20)) {
          if(this.bottomPlaneX >= 0) {
            if(this.bottomPlaneY >= 0) {
              if(this.bottomPlaneZ >= 0) {
                if(param5 * this.bottomPlaneX + param6 * this.bottomPlaneY + param7 * this.bottomPlaneZ <= this.bottomPlaneOffset) {
                  return -1;
                }
                if(param2 * this.bottomPlaneX + param3 * this.bottomPlaneY + param4 * this.bottomPlaneZ > this.bottomPlaneOffset) {
                  param1 &= 31;
                }
              } else {
                if(param5 * this.bottomPlaneX + param6 * this.bottomPlaneY + param4 * this.bottomPlaneZ <= this.bottomPlaneOffset) {
                  return -1;
                }
                if(param2 * this.bottomPlaneX + param3 * this.bottomPlaneY + param7 * this.bottomPlaneZ > this.bottomPlaneOffset) {
                  param1 &= 31;
                }
              }
            } else if(this.bottomPlaneZ >= 0) {
              if(param5 * this.bottomPlaneX + param3 * this.bottomPlaneY + param7 * this.bottomPlaneZ <= this.bottomPlaneOffset) {
                return -1;
              }
              if(param2 * this.bottomPlaneX + param6 * this.bottomPlaneY + param4 * this.bottomPlaneZ > this.bottomPlaneOffset) {
                param1 &= 31;
              }
            } else {
              if(param5 * this.bottomPlaneX + param3 * this.bottomPlaneY + param4 * this.bottomPlaneZ <= this.bottomPlaneOffset) {
                return -1;
              }
              if(param2 * this.bottomPlaneX + param6 * this.bottomPlaneY + param7 * this.bottomPlaneZ > this.bottomPlaneOffset) {
                param1 &= 31;
              }
            }
          } else if(this.bottomPlaneY >= 0) {
            if(this.bottomPlaneZ >= 0) {
              if(param2 * this.bottomPlaneX + param6 * this.bottomPlaneY + param7 * this.bottomPlaneZ <= this.bottomPlaneOffset) {
                return -1;
              }
              if(param5 * this.bottomPlaneX + param3 * this.bottomPlaneY + param4 * this.bottomPlaneZ > this.bottomPlaneOffset) {
                param1 &= 31;
              }
            } else {
              if(param2 * this.bottomPlaneX + param6 * this.bottomPlaneY + param4 * this.bottomPlaneZ <= this.bottomPlaneOffset) {
                return -1;
              }
              if(param5 * this.bottomPlaneX + param3 * this.bottomPlaneY + param7 * this.bottomPlaneZ > this.bottomPlaneOffset) {
                param1 &= 31;
              }
            }
          } else if(this.bottomPlaneZ >= 0) {
            if(param2 * this.bottomPlaneX + param3 * this.bottomPlaneY + param7 * this.bottomPlaneZ <= this.bottomPlaneOffset) {
              return -1;
            }
            if(param5 * this.bottomPlaneX + param6 * this.bottomPlaneY + param4 * this.bottomPlaneZ > this.bottomPlaneOffset) {
              param1 &= 31;
            }
          } else {
            if(param2 * this.bottomPlaneX + param3 * this.bottomPlaneY + param4 * this.bottomPlaneZ <= this.bottomPlaneOffset) {
              return -1;
            }
            if(param5 * this.bottomPlaneX + param6 * this.bottomPlaneY + param7 * this.bottomPlaneZ > this.bottomPlaneOffset) {
              param1 &= 31;
            }
          }
        }
      }
      return param1;
    }

    private function calculateFaceList(param1:Mesh, param2:Boolean, param3:Face = null) : Face {
      var local4:Vertex = null;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Face = null;
      param1.alternativa3d::composeMatrix();
      local4 = param1.alternativa3d::vertexList;
      while(local4.alternativa3d::next != null) {
        local4.alternativa3d::transformId = 0;
        local4.id = null;
        local5 = local4.x;
        local6 = local4.y;
        local7 = local4.z;
        local4.x = param1.alternativa3d::ma * local5 + param1.alternativa3d::mb * local6 + param1.alternativa3d::mc * local7 + param1.alternativa3d::md;
        local4.y = param1.alternativa3d::me * local5 + param1.alternativa3d::mf * local6 + param1.alternativa3d::mg * local7 + param1.alternativa3d::mh;
        local4.z = param1.alternativa3d::mi * local5 + param1.alternativa3d::mj * local6 + param1.alternativa3d::mk * local7 + param1.alternativa3d::ml;
        local4 = local4.alternativa3d::next;
      }
      local4.alternativa3d::transformId = 0;
      local4.id = null;
      local5 = local4.x;
      local6 = local4.y;
      local7 = local4.z;
      local4.x = param1.alternativa3d::ma * local5 + param1.alternativa3d::mb * local6 + param1.alternativa3d::mc * local7 + param1.alternativa3d::md;
      local4.y = param1.alternativa3d::me * local5 + param1.alternativa3d::mf * local6 + param1.alternativa3d::mg * local7 + param1.alternativa3d::mh;
      local4.z = param1.alternativa3d::mi * local5 + param1.alternativa3d::mj * local6 + param1.alternativa3d::mk * local7 + param1.alternativa3d::ml;
      if(param2) {
        local4.alternativa3d::next = this.alternativa3d::vertexList;
        this.alternativa3d::vertexList = param1.alternativa3d::vertexList;
      }
      param1.alternativa3d::vertexList = null;
      local8 = param1.alternativa3d::faceList;
      while(local8.alternativa3d::next != null) {
        local8.alternativa3d::calculateBestSequenceAndNormal();
        local8.id = null;
        local8 = local8.alternativa3d::next;
      }
      local8.alternativa3d::calculateBestSequenceAndNormal();
      local8.id = null;
      local8.alternativa3d::next = param3;
      param3 = param1.alternativa3d::faceList;
      param1.alternativa3d::faceList = null;
      return param3;
    }

    private function createObjectBounds(param1:Object3D) : Object3D {
      var local2:Object3D = new Object3D();
      local2.boundMinX = 1e+22;
      local2.boundMinY = 1e+22;
      local2.boundMinZ = 1e+22;
      local2.boundMaxX = -1e+22;
      local2.boundMaxY = -1e+22;
      local2.boundMaxZ = -1e+22;
      param1.alternativa3d::composeMatrix();
      param1.alternativa3d::updateBounds(local2,param1);
      return local2;
    }

    private function calculateObjectBounds(param1:Object3D) : void {
      var local2:Object3D = null;
      param1.calculateBounds();
      if(param1 is Object3DContainer) {
        local2 = Object3DContainer(param1).alternativa3d::childrenList;
        while(local2 != null) {
          this.calculateObjectBounds(local2);
          local2 = local2.alternativa3d::next;
        }
      }
    }

    private function createNode(param1:Face, param2:Face, param3:Object3D, param4:Object3D, param5:Vector.<Face>, param6:Vector.<Object3D>, param7:Face = null) : BSPNode {
      var local9:Face = null;
      var local10:Face = null;
      var local11:Face = null;
      var local12:Face = null;
      var local13:Face = null;
      var local14:Object3D = null;
      var local15:Object3D = null;
      var local16:Object3D = null;
      var local17:Object3D = null;
      var local18:Face = null;
      var local19:Face = null;
      var local20:Face = null;
      var local8:BSPNode = new BSPNode();
      this.calculateNodeBounds(local8,param2,param4);
      if(param1 != null) {
        local9 = param1.alternativa3d::next != null ? this.findSplitter(param1) : param1;
      } else {
        if(param3 != null) {
          local19 = this.createBoundFaces(param4);
          local18 = param7;
          while(local18 != null) {
            local19 = this.cropBoundFaceList(local19,local18.alternativa3d::normalX,local18.alternativa3d::normalY,local18.alternativa3d::normalZ,local18.alternativa3d::offset);
            if(local19 == null) {
              break;
            }
            local18 = local18.alternativa3d::next;
          }
        }
        if(local19 != null) {
          local18 = local19;
          while(local18.alternativa3d::next != null) {
            local18 = local18.alternativa3d::next;
          }
          local18.alternativa3d::next = param2;
          local9 = local19.alternativa3d::next != null ? this.findSplitter(local19) : local19;
        } else if(param2 != null) {
          local9 = param2.alternativa3d::next != null ? this.findSplitter(param2) : param2;
        }
      }
      if(local9 != null) {
        local8.normalX = local9.alternativa3d::normalX;
        local8.normalY = local9.alternativa3d::normalY;
        local8.normalZ = local9.alternativa3d::normalZ;
        local8.offset = local9.alternativa3d::offset;
        if(param1 != null) {
          this.splitFaceList(local9,param1,false,param5);
          local10 = param5[0];
          local11 = param5[2];
        }
        if(param2 != null) {
          this.splitFaceList(local9,param2,true,param5);
          local12 = param5[0];
          local8.faceList = param5[1];
          local13 = param5[2];
        }
        if(param3 != null) {
          this.splitObjectList(local9,param3,param4,param6);
          local14 = param6[0];
          local16 = param6[1];
          local15 = param6[2];
          local17 = param6[3];
        }
        local20 = new Face();
        local20.alternativa3d::next = param7;
        if(local12 != null || local14 != null) {
          local20.alternativa3d::normalX = -local8.normalX;
          local20.alternativa3d::normalY = -local8.normalY;
          local20.alternativa3d::normalZ = -local8.normalZ;
          local20.alternativa3d::offset = -local8.offset;
          local8.negative = this.createNode(local10,local12,local14,local16,param5,param6,local20);
        }
        if(local13 != null || local15 != null) {
          local20.alternativa3d::normalX = local8.normalX;
          local20.alternativa3d::normalY = local8.normalY;
          local20.alternativa3d::normalZ = local8.normalZ;
          local20.alternativa3d::offset = local8.offset;
          local8.positive = this.createNode(local11,local13,local15,local17,param5,param6,local20);
        }
      } else {
        local8.objectList = param3;
        local8.boundList = param4;
      }
      return local8;
    }

    private function calculateNodeBounds(param1:BSPNode, param2:Face, param3:Object3D) : void {
      var local6:Wrapper = null;
      var local7:Vertex = null;
      param1.boundMinX = 1e+22;
      param1.boundMinY = 1e+22;
      param1.boundMinZ = 1e+22;
      param1.boundMaxX = -1e+22;
      param1.boundMaxY = -1e+22;
      param1.boundMaxZ = -1e+22;
      var local4:Object3D = param3;
      while(local4 != null) {
        if(local4.boundMinX < param1.boundMinX) {
          param1.boundMinX = local4.boundMinX;
        }
        if(local4.boundMaxX > param1.boundMaxX) {
          param1.boundMaxX = local4.boundMaxX;
        }
        if(local4.boundMinY < param1.boundMinY) {
          param1.boundMinY = local4.boundMinY;
        }
        if(local4.boundMaxY > param1.boundMaxY) {
          param1.boundMaxY = local4.boundMaxY;
        }
        if(local4.boundMinZ < param1.boundMinZ) {
          param1.boundMinZ = local4.boundMinZ;
        }
        if(local4.boundMaxZ > param1.boundMaxZ) {
          param1.boundMaxZ = local4.boundMaxZ;
        }
        local4 = local4.alternativa3d::next;
      }
      var local5:Face = param2;
      while(local5 != null) {
        local6 = local5.alternativa3d::wrapper;
        while(local6 != null) {
          local7 = local6.alternativa3d::vertex;
          if(local7.x < param1.boundMinX) {
            param1.boundMinX = local7.x;
          }
          if(local7.x > param1.boundMaxX) {
            param1.boundMaxX = local7.x;
          }
          if(local7.y < param1.boundMinY) {
            param1.boundMinY = local7.y;
          }
          if(local7.y > param1.boundMaxY) {
            param1.boundMaxY = local7.y;
          }
          if(local7.z < param1.boundMinZ) {
            param1.boundMinZ = local7.z;
          }
          if(local7.z > param1.boundMaxZ) {
            param1.boundMaxZ = local7.z;
          }
          local6 = local6.alternativa3d::next;
        }
        local5 = local5.alternativa3d::next;
      }
    }

    private function findSplitter(param1:Face) : Face {
      var local2:Face = null;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:int = 0;
      var local12:Face = null;
      var local13:Wrapper = null;
      var local14:Vertex = null;
      var local15:Vertex = null;
      var local16:Vertex = null;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Boolean = false;
      var local21:Boolean = false;
      var local22:Vertex = null;
      var local23:Number = NaN;
      var local3:int = 2147483647;
      var local4:Face = param1;
      while(local4 != null) {
        local5 = Number(local4.alternativa3d::normalX);
        local6 = Number(local4.alternativa3d::normalY);
        local7 = Number(local4.alternativa3d::normalZ);
        local8 = Number(local4.alternativa3d::offset);
        local9 = local8 - threshold;
        local10 = local8 + threshold;
        local11 = 0;
        local12 = param1;
        while(local12 != null) {
          if(local12 != local4) {
            local13 = local12.alternativa3d::wrapper;
            local14 = local13.alternativa3d::vertex;
            local13 = local13.alternativa3d::next;
            local15 = local13.alternativa3d::vertex;
            local13 = local13.alternativa3d::next;
            local16 = local13.alternativa3d::vertex;
            local17 = local14.x * local5 + local14.y * local6 + local14.z * local7;
            local18 = local15.x * local5 + local15.y * local6 + local15.z * local7;
            local19 = local16.x * local5 + local16.y * local6 + local16.z * local7;
            local20 = local17 < local9 || local18 < local9 || local19 < local9;
            local21 = local17 > local10 || local18 > local10 || local19 > local10;
            local13 = local13.alternativa3d::next;
            while(local13 != null) {
              local22 = local13.alternativa3d::vertex;
              local23 = local22.x * local5 + local22.y * local6 + local22.z * local7;
              if(local23 < local9) {
                local20 = true;
                if(local21) {
                  break;
                }
              } else if(local23 > local10) {
                local21 = true;
                if(local20) {
                  break;
                }
              }
              local13 = local13.alternativa3d::next;
            }
            if(local21 && local20) {
              local11++;
              if(local11 >= local3) {
                break;
              }
            }
          }
          local12 = local12.alternativa3d::next;
        }
        if(local11 < local3) {
          local2 = local4;
          local3 = local11;
          if(local3 == 0) {
            break;
          }
        }
        local4 = local4.alternativa3d::next;
      }
      return local2;
    }

    private function createBoundFaces(param1:Object3D) : Face {
      var local2:Face = null;
      var local4:Vertex = null;
      var local5:Vertex = null;
      var local6:Vertex = null;
      var local7:Vertex = null;
      var local8:Vertex = null;
      var local9:Vertex = null;
      var local10:Vertex = null;
      var local11:Vertex = null;
      var local12:Face = null;
      var local3:Object3D = param1;
      while(local3 != null) {
        local4 = new Vertex();
        local4.x = local3.boundMinX;
        local4.y = local3.boundMinY;
        local4.z = local3.boundMinZ;
        local5 = new Vertex();
        local5.x = local3.boundMaxX;
        local5.y = local3.boundMinY;
        local5.z = local3.boundMinZ;
        local6 = new Vertex();
        local6.x = local3.boundMinX;
        local6.y = local3.boundMaxY;
        local6.z = local3.boundMinZ;
        local7 = new Vertex();
        local7.x = local3.boundMaxX;
        local7.y = local3.boundMaxY;
        local7.z = local3.boundMinZ;
        local8 = new Vertex();
        local8.x = local3.boundMinX;
        local8.y = local3.boundMinY;
        local8.z = local3.boundMaxZ;
        local9 = new Vertex();
        local9.x = local3.boundMaxX;
        local9.y = local3.boundMinY;
        local9.z = local3.boundMaxZ;
        local10 = new Vertex();
        local10.x = local3.boundMinX;
        local10.y = local3.boundMaxY;
        local10.z = local3.boundMaxZ;
        local11 = new Vertex();
        local11.x = local3.boundMaxX;
        local11.y = local3.boundMaxY;
        local11.z = local3.boundMaxZ;
        local12 = new Face();
        local12.alternativa3d::normalX = -1;
        local12.alternativa3d::normalY = 0;
        local12.alternativa3d::normalZ = 0;
        local12.alternativa3d::offset = -local3.boundMinX;
        local12.alternativa3d::wrapper = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::vertex = local4;
        local12.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = local8;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local10;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local6;
        local12.alternativa3d::next = local2;
        local2 = local12;
        local12 = new Face();
        local12.alternativa3d::normalX = 1;
        local12.alternativa3d::normalY = 0;
        local12.alternativa3d::normalZ = 0;
        local12.alternativa3d::offset = local3.boundMaxX;
        local12.alternativa3d::wrapper = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::vertex = local5;
        local12.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = local7;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local11;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local9;
        local12.alternativa3d::next = local2;
        local2 = local12;
        local12 = new Face();
        local12.alternativa3d::normalX = 0;
        local12.alternativa3d::normalY = -1;
        local12.alternativa3d::normalZ = 0;
        local12.alternativa3d::offset = -local3.boundMinY;
        local12.alternativa3d::wrapper = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::vertex = local4;
        local12.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = local5;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local9;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local8;
        local12.alternativa3d::next = local2;
        local2 = local12;
        local12 = new Face();
        local12.alternativa3d::normalX = 0;
        local12.alternativa3d::normalY = 1;
        local12.alternativa3d::normalZ = 0;
        local12.alternativa3d::offset = local3.boundMaxY;
        local12.alternativa3d::wrapper = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::vertex = local6;
        local12.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = local10;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local11;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local7;
        local12.alternativa3d::next = local2;
        local2 = local12;
        local12 = new Face();
        local12.alternativa3d::normalX = 0;
        local12.alternativa3d::normalY = 0;
        local12.alternativa3d::normalZ = -1;
        local12.alternativa3d::offset = -local3.boundMinZ;
        local12.alternativa3d::wrapper = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::vertex = local4;
        local12.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = local6;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local7;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local5;
        local12.alternativa3d::next = local2;
        local2 = local12;
        local12 = new Face();
        local12.alternativa3d::normalX = 0;
        local12.alternativa3d::normalY = 0;
        local12.alternativa3d::normalZ = 1;
        local12.alternativa3d::offset = local3.boundMaxZ;
        local12.alternativa3d::wrapper = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::vertex = local8;
        local12.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = local9;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local11;
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next = new Wrapper();
        local12.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local10;
        local12.alternativa3d::next = local2;
        local2 = local12;
        local3 = local3.alternativa3d::next;
      }
      return local2;
    }

    private function cropBoundFaceList(param1:Face, param2:Number, param3:Number, param4:Number, param5:Number) : Face {
      var local6:Face = null;
      var local10:Face = null;
      var local11:Vertex = null;
      var local12:Wrapper = null;
      var local13:Vertex = null;
      var local14:Vertex = null;
      var local15:Vertex = null;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Boolean = false;
      var local20:Boolean = false;
      var local21:Number = NaN;
      var local22:Wrapper = null;
      var local23:Wrapper = null;
      var local24:Number = NaN;
      var local7:Number = param5 - threshold;
      var local8:Number = param5 + threshold;
      var local9:Face = param1;
      while(local9 != null) {
        local10 = local9.alternativa3d::next;
        local9.alternativa3d::next = null;
        local12 = local9.alternativa3d::wrapper;
        local13 = local12.alternativa3d::vertex;
        local12 = local12.alternativa3d::next;
        local14 = local12.alternativa3d::vertex;
        local12 = local12.alternativa3d::next;
        local15 = local12.alternativa3d::vertex;
        local12 = local12.alternativa3d::next;
        local16 = local13.x * param2 + local13.y * param3 + local13.z * param4;
        local17 = local14.x * param2 + local14.y * param3 + local14.z * param4;
        local18 = local15.x * param2 + local15.y * param3 + local15.z * param4;
        local19 = local16 < local7 || local17 < local7 || local18 < local7;
        local20 = local16 > local8 || local17 > local8 || local18 > local8;
        while(local12 != null) {
          local11 = local12.alternativa3d::vertex;
          local21 = local11.x * param2 + local11.y * param3 + local11.z * param4;
          if(local21 < local7) {
            local19 = true;
          } else if(local21 > local8) {
            local20 = true;
          }
          local11.alternativa3d::offset = local21;
          local12 = local12.alternativa3d::next;
        }
        if(local20) {
          if(!local19) {
            local9.alternativa3d::next = local6;
            local6 = local9;
          } else {
            local13.alternativa3d::offset = local16;
            local14.alternativa3d::offset = local17;
            local15.alternativa3d::offset = local18;
            local22 = null;
            local12 = local9.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
            while(local12.alternativa3d::next != null) {
              local12 = local12.alternativa3d::next;
            }
            local13 = local12.alternativa3d::vertex;
            local16 = Number(local13.alternativa3d::offset);
            local12 = local9.alternativa3d::wrapper;
            local9.alternativa3d::wrapper = null;
            while(local12 != null) {
              local14 = local12.alternativa3d::vertex;
              local17 = Number(local14.alternativa3d::offset);
              if(local16 < local7 && local17 > local8 || local16 > local8 && local17 < local7) {
                local24 = (param5 - local16) / (local17 - local16);
                local11 = new Vertex();
                local11.x = local13.x + (local14.x - local13.x) * local24;
                local11.y = local13.y + (local14.y - local13.y) * local24;
                local11.z = local13.z + (local14.z - local13.z) * local24;
                local23 = local12.alternativa3d::create();
                local23.alternativa3d::vertex = local11;
                if(local22 != null) {
                  local22.alternativa3d::next = local23;
                } else {
                  local9.alternativa3d::wrapper = local23;
                }
                local22 = local23;
              }
              if(local17 >= local7) {
                local23 = local12.alternativa3d::create();
                local23.alternativa3d::vertex = local14;
                if(local22 != null) {
                  local22.alternativa3d::next = local23;
                } else {
                  local9.alternativa3d::wrapper = local23;
                }
                local22 = local23;
              }
              local13 = local14;
              local16 = local17;
              local12 = local12.alternativa3d::next;
            }
            local9.alternativa3d::next = local6;
            local6 = local9;
          }
        }
        local9 = local10;
      }
      return local6;
    }

    private function splitFaceList(param1:Face, param2:Face, param3:Boolean, param4:Vector.<Face>) : void {
      var local11:Face = null;
      var local12:Face = null;
      var local13:Face = null;
      var local14:Face = null;
      var local15:Face = null;
      var local16:Face = null;
      var local17:Face = null;
      var local18:Wrapper = null;
      var local19:Vertex = null;
      var local20:Vertex = null;
      var local21:Vertex = null;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Boolean = false;
      var local26:Boolean = false;
      var local27:Vertex = null;
      var local28:Number = NaN;
      var local29:Face = null;
      var local30:Face = null;
      var local31:Wrapper = null;
      var local32:Wrapper = null;
      var local33:Wrapper = null;
      var local34:Number = NaN;
      var local5:Number = Number(param1.alternativa3d::normalX);
      var local6:Number = Number(param1.alternativa3d::normalY);
      var local7:Number = Number(param1.alternativa3d::normalZ);
      var local8:Number = Number(param1.alternativa3d::offset);
      var local9:Number = local8 - threshold;
      var local10:Number = local8 + threshold;
      while(param2 != null) {
        local17 = param2.alternativa3d::next;
        param2.alternativa3d::next = null;
        if(param2 == param1) {
          if(local13 != null) {
            local14.alternativa3d::next = param2;
          } else {
            local13 = param2;
          }
          local14 = param2;
          param2 = local17;
        } else {
          local18 = param2.alternativa3d::wrapper;
          local19 = local18.alternativa3d::vertex;
          local18 = local18.alternativa3d::next;
          local20 = local18.alternativa3d::vertex;
          local18 = local18.alternativa3d::next;
          local21 = local18.alternativa3d::vertex;
          local22 = local19.x * local5 + local19.y * local6 + local19.z * local7;
          local23 = local20.x * local5 + local20.y * local6 + local20.z * local7;
          local24 = local21.x * local5 + local21.y * local6 + local21.z * local7;
          local25 = local22 < local9 || local23 < local9 || local24 < local9;
          local26 = local22 > local10 || local23 > local10 || local24 > local10;
          local18 = local18.alternativa3d::next;
          while(local18 != null) {
            local27 = local18.alternativa3d::vertex;
            local28 = local27.x * local5 + local27.y * local6 + local27.z * local7;
            if(local28 < local9) {
              local25 = true;
            } else if(local28 > local10) {
              local26 = true;
            }
            local27.alternativa3d::offset = local28;
            local18 = local18.alternativa3d::next;
          }
          if(!local25) {
            if(!local26) {
              if(param2.alternativa3d::normalX * local5 + param2.alternativa3d::normalY * local6 + param2.alternativa3d::normalZ * local7 > 0) {
                if(local13 != null) {
                  local14.alternativa3d::next = param2;
                } else {
                  local13 = param2;
                }
                local14 = param2;
              } else {
                if(local11 != null) {
                  local12.alternativa3d::next = param2;
                } else {
                  local11 = param2;
                }
                local12 = param2;
              }
            } else {
              if(local15 != null) {
                local16.alternativa3d::next = param2;
              } else {
                local15 = param2;
              }
              local16 = param2;
            }
          } else if(!local26) {
            if(local11 != null) {
              local12.alternativa3d::next = param2;
            } else {
              local11 = param2;
            }
            local12 = param2;
          } else {
            local19.alternativa3d::offset = local22;
            local20.alternativa3d::offset = local23;
            local21.alternativa3d::offset = local24;
            local29 = new Face();
            local30 = new Face();
            local31 = null;
            local32 = null;
            local18 = param2.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
            while(local18.alternativa3d::next != null) {
              local18 = local18.alternativa3d::next;
            }
            local19 = local18.alternativa3d::vertex;
            local22 = Number(local19.alternativa3d::offset);
            local18 = param2.alternativa3d::wrapper;
            while(local18 != null) {
              local20 = local18.alternativa3d::vertex;
              local23 = Number(local20.alternativa3d::offset);
              if(local22 < local9 && local23 > local10 || local22 > local10 && local23 < local9) {
                local34 = (local8 - local22) / (local23 - local22);
                local27 = new Vertex();
                if(param3) {
                  local27.alternativa3d::next = this.alternativa3d::vertexList;
                  this.alternativa3d::vertexList = local27;
                }
                local27.x = local19.x + (local20.x - local19.x) * local34;
                local27.y = local19.y + (local20.y - local19.y) * local34;
                local27.z = local19.z + (local20.z - local19.z) * local34;
                local27.u = local19.u + (local20.u - local19.u) * local34;
                local27.v = local19.v + (local20.v - local19.v) * local34;
                local27.normalX = local19.normalX + (local20.normalX - local19.normalX) * local34;
                local27.normalY = local19.normalY + (local20.normalY - local19.normalY) * local34;
                local27.normalZ = local19.normalZ + (local20.normalZ - local19.normalZ) * local34;
                local33 = new Wrapper();
                local33.alternativa3d::vertex = local27;
                if(local31 != null) {
                  local31.alternativa3d::next = local33;
                } else {
                  local29.alternativa3d::wrapper = local33;
                }
                local31 = local33;
                local33 = new Wrapper();
                local33.alternativa3d::vertex = local27;
                if(local32 != null) {
                  local32.alternativa3d::next = local33;
                } else {
                  local30.alternativa3d::wrapper = local33;
                }
                local32 = local33;
              }
              if(local23 <= local10) {
                local33 = new Wrapper();
                local33.alternativa3d::vertex = local20;
                if(local31 != null) {
                  local31.alternativa3d::next = local33;
                } else {
                  local29.alternativa3d::wrapper = local33;
                }
                local31 = local33;
              }
              if(local23 >= local9) {
                local33 = new Wrapper();
                local33.alternativa3d::vertex = local20;
                if(local32 != null) {
                  local32.alternativa3d::next = local33;
                } else {
                  local30.alternativa3d::wrapper = local33;
                }
                local32 = local33;
              }
              local19 = local20;
              local22 = local23;
              local18 = local18.alternativa3d::next;
            }
            local29.material = param2.material;
            local29.alternativa3d::calculateBestSequenceAndNormal();
            if(local11 != null) {
              local12.alternativa3d::next = local29;
            } else {
              local11 = local29;
            }
            local12 = local29;
            local30.material = param2.material;
            local30.alternativa3d::calculateBestSequenceAndNormal();
            if(local15 != null) {
              local16.alternativa3d::next = local30;
            } else {
              local15 = local30;
            }
            local16 = local30;
          }
          param2 = local17;
        }
      }
      param4[0] = local11;
      param4[1] = local13;
      param4[2] = local15;
    }

    private function splitObjectList(param1:Face, param2:Object3D, param3:Object3D, param4:Vector.<Object3D>) : void {
      var local5:Object3D = null;
      var local6:Object3D = null;
      var local7:Object3D = null;
      var local8:Object3D = null;
      var local9:Object3D = null;
      var local10:Object3D = null;
      var local11:Object3D = null;
      var local12:Object3D = null;
      var local13:int = 0;
      var local14:Vertex = null;
      var local15:Vector3D = null;
      var local16:Vector3D = null;
      var local17:Vector3D = null;
      var local18:int = 0;
      var local19:Vector.<Object3D> = null;
      local9 = param2;
      local10 = param3;
      while(local9 != null) {
        local11 = local9.alternativa3d::next;
        local12 = local10.alternativa3d::next;
        local9.alternativa3d::next = null;
        local10.alternativa3d::next = null;
        local13 = this.checkBounds(param1.alternativa3d::normalX,param1.alternativa3d::normalY,param1.alternativa3d::normalZ,param1.alternativa3d::offset,local10.boundMinX,local10.boundMinY,local10.boundMinZ,local10.boundMaxX,local10.boundMaxY,local10.boundMaxZ,true);
        if(local13 < 0) {
          local9.alternativa3d::next = local5;
          local5 = local9;
          local10.alternativa3d::next = local6;
          local6 = local10;
        } else if(local13 > 0) {
          local9.alternativa3d::next = local7;
          local7 = local9;
          local10.alternativa3d::next = local8;
          local8 = local10;
        } else {
          local9.alternativa3d::composeMatrix();
          local9.alternativa3d::calculateInverseMatrix();
          local14 = param1.alternativa3d::wrapper.alternativa3d::vertex;
          local15 = new Vector3D(local9.alternativa3d::ima * local14.x + local9.alternativa3d::imb * local14.y + local9.alternativa3d::imc * local14.z + local9.alternativa3d::imd,local9.alternativa3d::ime * local14.x + local9.alternativa3d::imf * local14.y + local9.alternativa3d::img * local14.z + local9.alternativa3d::imh,local9.alternativa3d::imi * local14.x + local9.alternativa3d::imj * local14.y + local9.alternativa3d::imk * local14.z + local9.alternativa3d::iml);
          local14 = param1.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex;
          local16 = new Vector3D(local9.alternativa3d::ima * local14.x + local9.alternativa3d::imb * local14.y + local9.alternativa3d::imc * local14.z + local9.alternativa3d::imd,local9.alternativa3d::ime * local14.x + local9.alternativa3d::imf * local14.y + local9.alternativa3d::img * local14.z + local9.alternativa3d::imh,local9.alternativa3d::imi * local14.x + local9.alternativa3d::imj * local14.y + local9.alternativa3d::imk * local14.z + local9.alternativa3d::iml);
          local14 = param1.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex;
          local17 = new Vector3D(local9.alternativa3d::ima * local14.x + local9.alternativa3d::imb * local14.y + local9.alternativa3d::imc * local14.z + local9.alternativa3d::imd,local9.alternativa3d::ime * local14.x + local9.alternativa3d::imf * local14.y + local9.alternativa3d::img * local14.z + local9.alternativa3d::imh,local9.alternativa3d::imi * local14.x + local9.alternativa3d::imj * local14.y + local9.alternativa3d::imk * local14.z + local9.alternativa3d::iml);
          local18 = int(local9.alternativa3d::testSplit(local15,local16,local17,threshold));
          if(local18 < 0) {
            local9.alternativa3d::next = local5;
            local5 = local9;
            local10.alternativa3d::next = local6;
            local6 = local10;
          } else if(local18 > 0) {
            local9.alternativa3d::next = local7;
            local7 = local9;
            local10.alternativa3d::next = local8;
            local8 = local10;
          } else {
            local19 = local9.alternativa3d::split(local15,local16,local17,threshold);
            if(local19[0] != null) {
              local9 = local19[0];
              local9.alternativa3d::setParent(this);
              local9.alternativa3d::next = local5;
              local5 = local9;
              local10 = this.createObjectBounds(local9);
              local10.alternativa3d::next = local6;
              local6 = local10;
            }
            if(local19[1] != null) {
              local9 = local19[1];
              local9.alternativa3d::setParent(this);
              local9.alternativa3d::next = local7;
              local7 = local9;
              local10 = this.createObjectBounds(local9);
              local10.alternativa3d::next = local8;
              local8 = local10;
            }
          }
        }
        local9 = local11;
        local10 = local12;
      }
      param4[0] = local5;
      param4[1] = local6;
      param4[2] = local7;
      param4[3] = local8;
    }

    private function destroyNode(param1:BSPNode) : void {
      var local3:Object3D = null;
      var local4:Object3D = null;
      var local5:Face = null;
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
        local5 = local2.alternativa3d::next;
        local2.alternativa3d::next = null;
        local2 = local5;
      }
      local3 = param1.objectList;
      while(local3 != null) {
        local4 = local3.alternativa3d::next;
        local3.alternativa3d::setParent(null);
        local3.alternativa3d::next = null;
        local3 = local4;
      }
      local3 = param1.boundList;
      while(local3 != null) {
        local4 = local3.alternativa3d::next;
        local3.alternativa3d::next = null;
        local3 = local4;
      }
      param1.faceList = null;
      param1.objectList = null;
      param1.boundList = null;
    }
  }
}

import alternativa.engine3d.core.Face;
import alternativa.engine3d.core.Object3D;
class BSPNode {
  public var faceList:Face;
  public var negative:BSPNode;
  public var positive:BSPNode;
  public var normalX:Number;
  public var normalY:Number;
  public var normalZ:Number;
  public var offset:Number;
  public var boundMinX:Number;
  public var boundMinY:Number;
  public var boundMinZ:Number;
  public var boundMaxX:Number;
  public var boundMaxY:Number;
  public var boundMaxZ:Number;
  public var objectList:Object3D;
  public var boundList:Object3D;

  public function BSPNode() {
    super();
  }
}
