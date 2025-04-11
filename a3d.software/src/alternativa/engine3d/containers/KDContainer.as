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
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Decal;
  import alternativa.engine3d.objects.Occluder;
  import flash.geom.Matrix3D;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class KDContainer extends ConflictContainer {
    private static const treeSphere:Vector3D = new Vector3D();
    private static const splitCoordsX:Vector.<Number> = new Vector.<Number>();
    private static const splitCoordsY:Vector.<Number> = new Vector.<Number>();
    private static const splitCoordsZ:Vector.<Number> = new Vector.<Number>();

    public var debugAlphaFade:Number = 0.8;
    public var ignoreChildrenInCollider:Boolean = false;

    alternativa3d var root:KDNode;

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
    private var occluders:Vector.<Vertex> = new Vector.<Vertex>();
    private var numOccluders:int;

    public var batched:Boolean = true;

    public function KDContainer() {
      super();
    }

    public function createTree(param1:Vector.<Object3D>, param2:Vector.<Occluder> = null) : void {
      var local3:int = 0;
      var local4:Object3D = null;
      var local5:Object3D = null;
      var local8:Object3D = null;
      var local9:Object3D = null;
      var local10:Object3D = null;
      var local11:Object3D = null;
      this.destroyTree();
      var local6:int = int(param1.length);
      var local7:int = param2 != null ? int(param2.length) : 0;
      var local12:Number = 1e+22;
      var local13:Number = 1e+22;
      var local14:Number = 1e+22;
      var local15:Number = -1e+22;
      var local16:Number = -1e+22;
      var local17:Number = -1e+22;
      local3 = 0;
      while(local3 < local6) {
        local4 = param1[local3];
        local5 = this.createObjectBounds(local4);
        if(local5.boundMinX <= local5.boundMaxX) {
          if(local4.alternativa3d::_parent != null) {
            local4.alternativa3d::_parent.removeChild(local4);
          }
          local4.alternativa3d::setParent(this);
          local4.alternativa3d::next = local8;
          local8 = local4;
          local5.alternativa3d::next = local9;
          local9 = local5;
          if(local5.boundMinX < local12) {
            local12 = local5.boundMinX;
          }
          if(local5.boundMaxX > local15) {
            local15 = local5.boundMaxX;
          }
          if(local5.boundMinY < local13) {
            local13 = local5.boundMinY;
          }
          if(local5.boundMaxY > local16) {
            local16 = local5.boundMaxY;
          }
          if(local5.boundMinZ < local14) {
            local14 = local5.boundMinZ;
          }
          if(local5.boundMaxZ > local17) {
            local17 = local5.boundMaxZ;
          }
        }
        local3++;
      }
      local3 = 0;
      while(local3 < local7) {
        local4 = param2[local3];
        local5 = this.createObjectBounds(local4);
        if(local5.boundMinX <= local5.boundMaxX) {
          if(!(local5.boundMinX < local12 || local5.boundMaxX > local15 || local5.boundMinY < local13 || local5.boundMaxY > local16 || local5.boundMinZ < local14 || local5.boundMaxZ > local17)) {
            if(local4.alternativa3d::_parent != null) {
              local4.alternativa3d::_parent.removeChild(local4);
            }
            local4.alternativa3d::setParent(this);
            local4.alternativa3d::next = local10;
            local10 = local4;
            local5.alternativa3d::next = local11;
            local11 = local5;
          }
        }
        local3++;
      }
      if(local8 != null) {
        this.alternativa3d::root = this.createNode(local8,local9,local10,local11,local12,local13,local14,local15,local16,local17);
      }
    }

    public function destroyTree() : void {
      if(this.alternativa3d::root != null) {
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

    private function intersectRayNode(param1:KDNode, param2:Vector3D, param3:Vector3D, param4:Dictionary, param5:Camera3D) : RayIntersectionData {
      var local6:RayIntersectionData = null;
      var local7:Number = NaN;
      var local8:Object3D = null;
      var local9:Object3D = null;
      var local10:Vector3D = null;
      var local11:Vector3D = null;
      var local12:Boolean = false;
      var local13:Boolean = false;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:RayIntersectionData = null;
      if(param1.negative != null) {
        local12 = param1.axis == 0;
        local13 = param1.axis == 1;
        local14 = (local12 ? param2.x : (local13 ? param2.y : param2.z)) - param1.coord;
        if(local14 > 0) {
          if(alternativa3d::boundIntersectRay(param2,param3,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ)) {
            local6 = this.intersectRayNode(param1.positive,param2,param3,param4,param5);
            if(local6 != null) {
              return local6;
            }
          }
          local7 = local12 ? param3.x : (local13 ? param3.y : param3.z);
          if(local7 < 0) {
            local8 = param1.objectList;
            local9 = param1.objectBoundList;
            while(local8 != null) {
              if(alternativa3d::boundIntersectRay(param2,param3,local9.boundMinX,local9.boundMinY,local9.boundMinZ,local9.boundMaxX,local9.boundMaxY,local9.boundMaxZ)) {
                local8.alternativa3d::composeMatrix();
                local8.alternativa3d::invertMatrix();
                if(local10 == null) {
                  local10 = new Vector3D();
                  local11 = new Vector3D();
                }
                local10.x = local8.alternativa3d::ma * param2.x + local8.alternativa3d::mb * param2.y + local8.alternativa3d::mc * param2.z + local8.alternativa3d::md;
                local10.y = local8.alternativa3d::me * param2.x + local8.alternativa3d::mf * param2.y + local8.alternativa3d::mg * param2.z + local8.alternativa3d::mh;
                local10.z = local8.alternativa3d::mi * param2.x + local8.alternativa3d::mj * param2.y + local8.alternativa3d::mk * param2.z + local8.alternativa3d::ml;
                local11.x = local8.alternativa3d::ma * param3.x + local8.alternativa3d::mb * param3.y + local8.alternativa3d::mc * param3.z;
                local11.y = local8.alternativa3d::me * param3.x + local8.alternativa3d::mf * param3.y + local8.alternativa3d::mg * param3.z;
                local11.z = local8.alternativa3d::mi * param3.x + local8.alternativa3d::mj * param3.y + local8.alternativa3d::mk * param3.z;
                local6 = local8.intersectRay(local10,local11,param4,param5);
                if(local6 != null) {
                  return local6;
                }
              }
              local8 = local8.alternativa3d::next;
              local9 = local9.alternativa3d::next;
            }
            if(alternativa3d::boundIntersectRay(param2,param3,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ)) {
              return this.intersectRayNode(param1.negative,param2,param3,param4,param5);
            }
          }
        } else {
          if(alternativa3d::boundIntersectRay(param2,param3,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ)) {
            local6 = this.intersectRayNode(param1.negative,param2,param3,param4,param5);
            if(local6 != null) {
              return local6;
            }
          }
          local7 = local12 ? param3.x : (local13 ? param3.y : param3.z);
          if(local7 > 0) {
            local8 = param1.objectList;
            local9 = param1.objectBoundList;
            while(local8 != null) {
              if(alternativa3d::boundIntersectRay(param2,param3,local9.boundMinX,local9.boundMinY,local9.boundMinZ,local9.boundMaxX,local9.boundMaxY,local9.boundMaxZ)) {
                local8.alternativa3d::composeMatrix();
                local8.alternativa3d::invertMatrix();
                if(local10 == null) {
                  local10 = new Vector3D();
                  local11 = new Vector3D();
                }
                local10.x = local8.alternativa3d::ma * param2.x + local8.alternativa3d::mb * param2.y + local8.alternativa3d::mc * param2.z + local8.alternativa3d::md;
                local10.y = local8.alternativa3d::me * param2.x + local8.alternativa3d::mf * param2.y + local8.alternativa3d::mg * param2.z + local8.alternativa3d::mh;
                local10.z = local8.alternativa3d::mi * param2.x + local8.alternativa3d::mj * param2.y + local8.alternativa3d::mk * param2.z + local8.alternativa3d::ml;
                local11.x = local8.alternativa3d::ma * param3.x + local8.alternativa3d::mb * param3.y + local8.alternativa3d::mc * param3.z;
                local11.y = local8.alternativa3d::me * param3.x + local8.alternativa3d::mf * param3.y + local8.alternativa3d::mg * param3.z;
                local11.z = local8.alternativa3d::mi * param3.x + local8.alternativa3d::mj * param3.y + local8.alternativa3d::mk * param3.z;
                local6 = local8.intersectRay(local10,local11,param4,param5);
                if(local6 != null) {
                  return local6;
                }
              }
              local8 = local8.alternativa3d::next;
              local9 = local9.alternativa3d::next;
            }
            if(alternativa3d::boundIntersectRay(param2,param3,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ)) {
              return this.intersectRayNode(param1.positive,param2,param3,param4,param5);
            }
          }
        }
        return null;
      }
      local15 = 1e+22;
      local8 = param1.objectList;
      while(local8 != null) {
        local8.alternativa3d::composeMatrix();
        local8.alternativa3d::invertMatrix();
        if(local10 == null) {
          local10 = new Vector3D();
          local11 = new Vector3D();
        }
        local10.x = local8.alternativa3d::ma * param2.x + local8.alternativa3d::mb * param2.y + local8.alternativa3d::mc * param2.z + local8.alternativa3d::md;
        local10.y = local8.alternativa3d::me * param2.x + local8.alternativa3d::mf * param2.y + local8.alternativa3d::mg * param2.z + local8.alternativa3d::mh;
        local10.z = local8.alternativa3d::mi * param2.x + local8.alternativa3d::mj * param2.y + local8.alternativa3d::mk * param2.z + local8.alternativa3d::ml;
        local11.x = local8.alternativa3d::ma * param3.x + local8.alternativa3d::mb * param3.y + local8.alternativa3d::mc * param3.z;
        local11.y = local8.alternativa3d::me * param3.x + local8.alternativa3d::mf * param3.y + local8.alternativa3d::mg * param3.z;
        local11.z = local8.alternativa3d::mi * param3.x + local8.alternativa3d::mj * param3.y + local8.alternativa3d::mk * param3.z;
        local6 = local8.intersectRay(local10,local11,param4,param5);
        if(local6 != null && local6.time < local15) {
          local15 = local6.time;
          local16 = local6;
        }
        local8 = local8.alternativa3d::next;
      }
      return local16;
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

    private function checkIntersectionNode(param1:KDNode, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Dictionary) : Boolean {
      var local10:Object3D = null;
      var local11:Object3D = null;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Boolean = false;
      var local20:Boolean = false;
      var local21:Number = NaN;
      var local22:Number = NaN;
      if(param1.negative != null) {
        local19 = param1.axis == 0;
        local20 = param1.axis == 1;
        local21 = (local19 ? param2 : (local20 ? param3 : param4)) - param1.coord;
        local22 = local19 ? param5 : (local20 ? param6 : param7);
        if(local21 > 0) {
          if(local22 < 0) {
            local18 = -local21 / local22;
            if(local18 < param8) {
              local10 = param1.objectList;
              local11 = param1.objectBoundList;
              while(local10 != null) {
                if(alternativa3d::boundCheckIntersection(param2,param3,param4,param5,param6,param7,param8,local11.boundMinX,local11.boundMinY,local11.boundMinZ,local11.boundMaxX,local11.boundMaxY,local11.boundMaxZ)) {
                  local10.alternativa3d::composeMatrix();
                  local10.alternativa3d::invertMatrix();
                  local12 = local10.alternativa3d::ma * param2 + local10.alternativa3d::mb * param3 + local10.alternativa3d::mc * param4 + local10.alternativa3d::md;
                  local13 = local10.alternativa3d::me * param2 + local10.alternativa3d::mf * param3 + local10.alternativa3d::mg * param4 + local10.alternativa3d::mh;
                  local14 = local10.alternativa3d::mi * param2 + local10.alternativa3d::mj * param3 + local10.alternativa3d::mk * param4 + local10.alternativa3d::ml;
                  local15 = local10.alternativa3d::ma * param5 + local10.alternativa3d::mb * param6 + local10.alternativa3d::mc * param7;
                  local16 = local10.alternativa3d::me * param5 + local10.alternativa3d::mf * param6 + local10.alternativa3d::mg * param7;
                  local17 = local10.alternativa3d::mi * param5 + local10.alternativa3d::mj * param6 + local10.alternativa3d::mk * param7;
                  if(local10.alternativa3d::checkIntersection(local12,local13,local14,local15,local16,local17,param8,param9)) {
                    return true;
                  }
                }
                local10 = local10.alternativa3d::next;
                local11 = local11.alternativa3d::next;
              }
              if(Boolean(alternativa3d::boundCheckIntersection(param2,param3,param4,param5,param6,param7,param8,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ)) && this.checkIntersectionNode(param1.negative,param2,param3,param4,param5,param6,param7,param8,param9)) {
                return true;
              }
            }
          }
          return Boolean(alternativa3d::boundCheckIntersection(param2,param3,param4,param5,param6,param7,param8,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ)) && this.checkIntersectionNode(param1.positive,param2,param3,param4,param5,param6,param7,param8,param9);
        }
        if(local22 > 0) {
          local18 = -local21 / local22;
          if(local18 < param8) {
            local10 = param1.objectList;
            local11 = param1.objectBoundList;
            while(local10 != null) {
              if(alternativa3d::boundCheckIntersection(param2,param3,param4,param5,param6,param7,param8,local11.boundMinX,local11.boundMinY,local11.boundMinZ,local11.boundMaxX,local11.boundMaxY,local11.boundMaxZ)) {
                local10.alternativa3d::composeMatrix();
                local10.alternativa3d::invertMatrix();
                local12 = local10.alternativa3d::ma * param2 + local10.alternativa3d::mb * param3 + local10.alternativa3d::mc * param4 + local10.alternativa3d::md;
                local13 = local10.alternativa3d::me * param2 + local10.alternativa3d::mf * param3 + local10.alternativa3d::mg * param4 + local10.alternativa3d::mh;
                local14 = local10.alternativa3d::mi * param2 + local10.alternativa3d::mj * param3 + local10.alternativa3d::mk * param4 + local10.alternativa3d::ml;
                local15 = local10.alternativa3d::ma * param5 + local10.alternativa3d::mb * param6 + local10.alternativa3d::mc * param7;
                local16 = local10.alternativa3d::me * param5 + local10.alternativa3d::mf * param6 + local10.alternativa3d::mg * param7;
                local17 = local10.alternativa3d::mi * param5 + local10.alternativa3d::mj * param6 + local10.alternativa3d::mk * param7;
                if(local10.alternativa3d::checkIntersection(local12,local13,local14,local15,local16,local17,param8,param9)) {
                  return true;
                }
              }
              local10 = local10.alternativa3d::next;
              local11 = local11.alternativa3d::next;
            }
            if(Boolean(alternativa3d::boundCheckIntersection(param2,param3,param4,param5,param6,param7,param8,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ)) && this.checkIntersectionNode(param1.positive,param2,param3,param4,param5,param6,param7,param8,param9)) {
              return true;
            }
          }
        }
        return Boolean(alternativa3d::boundCheckIntersection(param2,param3,param4,param5,param6,param7,param8,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ)) && this.checkIntersectionNode(param1.negative,param2,param3,param4,param5,param6,param7,param8,param9);
      }
      local10 = param1.objectList;
      while(local10 != null) {
        local10.alternativa3d::composeMatrix();
        local10.alternativa3d::invertMatrix();
        local12 = local10.alternativa3d::ma * param2 + local10.alternativa3d::mb * param3 + local10.alternativa3d::mc * param4 + local10.alternativa3d::md;
        local13 = local10.alternativa3d::me * param2 + local10.alternativa3d::mf * param3 + local10.alternativa3d::mg * param4 + local10.alternativa3d::mh;
        local14 = local10.alternativa3d::mi * param2 + local10.alternativa3d::mj * param3 + local10.alternativa3d::mk * param4 + local10.alternativa3d::ml;
        local15 = local10.alternativa3d::ma * param5 + local10.alternativa3d::mb * param6 + local10.alternativa3d::mc * param7;
        local16 = local10.alternativa3d::me * param5 + local10.alternativa3d::mf * param6 + local10.alternativa3d::mg * param7;
        local17 = local10.alternativa3d::mi * param5 + local10.alternativa3d::mj * param6 + local10.alternativa3d::mk * param7;
        if(local10.alternativa3d::checkIntersection(local12,local13,local14,local15,local16,local17,param8,param9)) {
          return true;
        }
        local10 = local10.alternativa3d::next;
      }
      return false;
    }

    override alternativa3d function collectPlanes(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:Vector3D, param6:Vector.<Face>, param7:Dictionary = null) : void {
      var local9:Object3D = null;
      if(param7 != null && Boolean(param7[this])) {
        return;
      }
      var local8:Vector3D = alternativa3d::calculateSphere(param1,param2,param3,param4,param5,treeSphere);
      if(!this.ignoreChildrenInCollider) {
        if(!alternativa3d::boundIntersectSphere(local8,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
          return;
        }
        local9 = alternativa3d::childrenList;
        while(local9 != null) {
          local9.alternativa3d::composeAndAppend(this);
          local9.alternativa3d::collectPlanes(param1,param2,param3,param4,param5,param6,param7);
          local9 = local9.alternativa3d::next;
        }
      }
      if(this.alternativa3d::root != null && Boolean(alternativa3d::boundIntersectSphere(local8,this.alternativa3d::root.boundMinX,this.alternativa3d::root.boundMinY,this.alternativa3d::root.boundMinZ,this.alternativa3d::root.boundMaxX,this.alternativa3d::root.boundMaxY,this.alternativa3d::root.boundMaxZ))) {
        this.collectPlanesNode(this.alternativa3d::root,local8,param1,param2,param3,param4,param5,param6,param7);
      }
    }

    private function collectPlanesNode(param1:KDNode, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:Vector3D, param6:Vector3D, param7:Vector3D, param8:Vector.<Face>, param9:Dictionary = null) : void {
      var local10:Object3D = null;
      var local11:Object3D = null;
      var local12:Boolean = false;
      var local13:Boolean = false;
      var local14:Number = NaN;
      if(param1.negative != null) {
        local12 = param1.axis == 0;
        local13 = param1.axis == 1;
        local14 = (local12 ? param2.x : (local13 ? param2.y : param2.z)) - param1.coord;
        if(local14 >= param2.w) {
          if(alternativa3d::boundIntersectSphere(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ)) {
            this.collectPlanesNode(param1.positive,param2,param3,param4,param5,param6,param7,param8,param9);
          }
        } else if(local14 <= -param2.w) {
          if(alternativa3d::boundIntersectSphere(param2,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ)) {
            this.collectPlanesNode(param1.negative,param2,param3,param4,param5,param6,param7,param8,param9);
          }
        } else {
          local10 = param1.objectList;
          local11 = param1.objectBoundList;
          while(local10 != null) {
            if(alternativa3d::boundIntersectSphere(param2,local11.boundMinX,local11.boundMinY,local11.boundMinZ,local11.boundMaxX,local11.boundMaxY,local11.boundMaxZ)) {
              local10.alternativa3d::composeAndAppend(this);
              local10.alternativa3d::collectPlanes(param3,param4,param5,param6,param7,param8,param9);
            }
            local10 = local10.alternativa3d::next;
            local11 = local11.alternativa3d::next;
          }
          if(alternativa3d::boundIntersectSphere(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ)) {
            this.collectPlanesNode(param1.positive,param2,param3,param4,param5,param6,param7,param8,param9);
          }
          if(alternativa3d::boundIntersectSphere(param2,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ)) {
            this.collectPlanesNode(param1.negative,param2,param3,param4,param5,param6,param7,param8,param9);
          }
        }
      } else {
        local10 = param1.objectList;
        while(local10 != null) {
          local10.alternativa3d::composeAndAppend(this);
          local10.alternativa3d::collectPlanes(param3,param4,param5,param6,param7,param8,param9);
          local10 = local10.alternativa3d::next;
        }
      }
    }

    public function createDecal(param1:Vector3D, param2:Vector3D, param3:Number, param4:Number, param5:Number, param6:Number, param7:Material) : Decal {
      var local8:Decal = new Decal();
      local8.attenuation = param6;
      var local9:Matrix3D = new Matrix3D();
      local9.appendRotation(param4 * 180 / Math.PI,Vector3D.Z_AXIS);
      local9.appendRotation(Math.atan2(-param2.z,Math.sqrt(param2.x * param2.x + param2.y * param2.y)) * 180 / Math.PI - 90,Vector3D.X_AXIS);
      local9.appendRotation(-Math.atan2(-param2.x,-param2.y) * 180 / Math.PI,Vector3D.Z_AXIS);
      local9.appendTranslation(param1.x,param1.y,param1.z);
      local8.matrix = local9;
      local8.alternativa3d::composeMatrix();
      local8.boundMinX = -param3;
      local8.boundMaxX = param3;
      local8.boundMinY = -param3;
      local8.boundMaxY = param3;
      local8.boundMinZ = -param6;
      local8.boundMaxZ = param6;
      var local10:Number = 1e+22;
      var local11:Number = 1e+22;
      var local12:Number = 1e+22;
      var local13:Number = -1e+22;
      var local14:Number = -1e+22;
      var local15:Number = -1e+22;
      var local16:Vertex = alternativa3d::boundVertexList;
      local16.x = local8.boundMinX;
      local16.y = local8.boundMinY;
      local16.z = local8.boundMinZ;
      local16 = local16.alternativa3d::next;
      local16.x = local8.boundMaxX;
      local16.y = local8.boundMinY;
      local16.z = local8.boundMinZ;
      local16 = local16.alternativa3d::next;
      local16.x = local8.boundMinX;
      local16.y = local8.boundMaxY;
      local16.z = local8.boundMinZ;
      local16 = local16.alternativa3d::next;
      local16.x = local8.boundMaxX;
      local16.y = local8.boundMaxY;
      local16.z = local8.boundMinZ;
      local16 = local16.alternativa3d::next;
      local16.x = local8.boundMinX;
      local16.y = local8.boundMinY;
      local16.z = local8.boundMaxZ;
      local16 = local16.alternativa3d::next;
      local16.x = local8.boundMaxX;
      local16.y = local8.boundMinY;
      local16.z = local8.boundMaxZ;
      local16 = local16.alternativa3d::next;
      local16.x = local8.boundMinX;
      local16.y = local8.boundMaxY;
      local16.z = local8.boundMaxZ;
      local16 = local16.alternativa3d::next;
      local16.x = local8.boundMaxX;
      local16.y = local8.boundMaxY;
      local16.z = local8.boundMaxZ;
      local16 = alternativa3d::boundVertexList;
      while(local16 != null) {
        local16.alternativa3d::cameraX = local8.alternativa3d::ma * local16.x + local8.alternativa3d::mb * local16.y + local8.alternativa3d::mc * local16.z + local8.alternativa3d::md;
        local16.alternativa3d::cameraY = local8.alternativa3d::me * local16.x + local8.alternativa3d::mf * local16.y + local8.alternativa3d::mg * local16.z + local8.alternativa3d::mh;
        local16.alternativa3d::cameraZ = local8.alternativa3d::mi * local16.x + local8.alternativa3d::mj * local16.y + local8.alternativa3d::mk * local16.z + local8.alternativa3d::ml;
        if(local16.alternativa3d::cameraX < local10) {
          local10 = Number(local16.alternativa3d::cameraX);
        }
        if(local16.alternativa3d::cameraX > local13) {
          local13 = Number(local16.alternativa3d::cameraX);
        }
        if(local16.alternativa3d::cameraY < local11) {
          local11 = Number(local16.alternativa3d::cameraY);
        }
        if(local16.alternativa3d::cameraY > local14) {
          local14 = Number(local16.alternativa3d::cameraY);
        }
        if(local16.alternativa3d::cameraZ < local12) {
          local12 = Number(local16.alternativa3d::cameraZ);
        }
        if(local16.alternativa3d::cameraZ > local15) {
          local15 = Number(local16.alternativa3d::cameraZ);
        }
        local16 = local16.alternativa3d::next;
      }
      local8.alternativa3d::invertMatrix();
      if(param5 > Math.PI / 2) {
        param5 = Math.PI / 2;
      }
      if(this.alternativa3d::root != null) {
        this.alternativa3d::root.collectPolygons(local8,Math.sqrt(param3 * param3 + param3 * param3 + param6 * param6),Math.cos(param5) - 0.001,local10,local13,local11,local14,local12,local15);
      }
      if(local8.alternativa3d::faceList != null) {
        local8.calculateBounds();
      } else {
        local8.boundMinX = -1;
        local8.boundMinY = -1;
        local8.boundMinZ = -1;
        local8.boundMaxX = 1;
        local8.boundMaxY = 1;
        local8.boundMaxZ = 1;
      }
      local8.setMaterialToAllFaces(param7);
      return local8;
    }

    override public function clone() : Object3D {
      var local1:KDContainer = new KDContainer();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      super.clonePropertiesFrom(param1);
      var local2:KDContainer = param1 as KDContainer;
      this.debugAlphaFade = local2.debugAlphaFade;
      if(local2.alternativa3d::root != null) {
        this.alternativa3d::root = local2.cloneNode(local2.alternativa3d::root,this);
      }
    }

    private function cloneNode(param1:KDNode, param2:Object3DContainer) : KDNode {
      var local4:Object3D = null;
      var local5:Object3D = null;
      var local6:Object3D = null;
      var local3:KDNode = new KDNode();
      local3.axis = param1.axis;
      local3.coord = param1.coord;
      local3.minCoord = param1.minCoord;
      local3.maxCoord = param1.maxCoord;
      local3.boundMinX = param1.boundMinX;
      local3.boundMinY = param1.boundMinY;
      local3.boundMinZ = param1.boundMinZ;
      local3.boundMaxX = param1.boundMaxX;
      local3.boundMaxY = param1.boundMaxY;
      local3.boundMaxZ = param1.boundMaxZ;
      local4 = param1.objectList;
      local5 = null;
      while(local4 != null) {
        local6 = local4.clone();
        if(local3.objectList != null) {
          local5.alternativa3d::next = local6;
        } else {
          local3.objectList = local6;
        }
        local5 = local6;
        local6.alternativa3d::setParent(param2);
        local4 = local4.alternativa3d::next;
      }
      local4 = param1.objectBoundList;
      local5 = null;
      while(local4 != null) {
        local6 = local4.clone();
        if(local3.objectBoundList != null) {
          local5.alternativa3d::next = local6;
        } else {
          local3.objectBoundList = local6;
        }
        local5 = local6;
        local4 = local4.alternativa3d::next;
      }
      local4 = param1.occluderList;
      local5 = null;
      while(local4 != null) {
        local6 = local4.clone();
        if(local3.occluderList != null) {
          local5.alternativa3d::next = local6;
        } else {
          local3.occluderList = local6;
        }
        local5 = local6;
        local6.alternativa3d::setParent(param2);
        local4 = local4.alternativa3d::next;
      }
      local4 = param1.occluderBoundList;
      local5 = null;
      while(local4 != null) {
        local6 = local4.clone();
        if(local3.occluderBoundList != null) {
          local5.alternativa3d::next = local6;
        } else {
          local3.occluderBoundList = local6;
        }
        local5 = local6;
        local4 = local4.alternativa3d::next;
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
      var local6:VG = null;
      var local7:VG = null;
      var local8:int = 0;
      var local9:Vertex = null;
      var local10:Vertex = null;
      if(this.alternativa3d::root != null) {
        alternativa3d::calculateInverseMatrix();
        this.calculateCameraPlanes(param1.nearClipping,param1.farClipping);
        local5 = this.cullingInContainer(alternativa3d::culling,this.alternativa3d::root.boundMinX,this.alternativa3d::root.boundMinY,this.alternativa3d::root.boundMinZ,this.alternativa3d::root.boundMaxX,this.alternativa3d::root.boundMaxY,this.alternativa3d::root.boundMaxZ);
        if(local5 >= 0) {
          if(param1.debug && (local4 = int(param1.alternativa3d::checkInDebug(this))) > 0) {
            local3 = param2.alternativa3d::getChildCanvas(true,false);
            if(Boolean(local4 & Debug.NODES)) {
              this.debugNode(this.alternativa3d::root,local5,param1,local3,1);
              Debug.alternativa3d::drawBounds(param1,local3,this,this.alternativa3d::root.boundMinX,this.alternativa3d::root.boundMinY,this.alternativa3d::root.boundMinZ,this.alternativa3d::root.boundMaxX,this.alternativa3d::root.boundMaxY,this.alternativa3d::root.boundMaxZ,14496733);
            }
            if(Boolean(local4 & Debug.BOUNDS)) {
              Debug.alternativa3d::drawBounds(param1,local3,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
            }
          }
          local3 = param2.alternativa3d::getChildCanvas(false,true,this,alpha,blendMode,colorTransform,filters);
          local3.alternativa3d::numDraws = 0;
          this.numOccluders = 0;
          if(param1.alternativa3d::numOccluders > 0) {
            this.updateOccluders(param1);
          }
          local6 = alternativa3d::collectVG(param1);
          local7 = local6;
          while(local7 != null) {
            local7.alternativa3d::calculateAABB(alternativa3d::ima,alternativa3d::imb,alternativa3d::imc,alternativa3d::imd,alternativa3d::ime,alternativa3d::imf,alternativa3d::img,alternativa3d::imh,alternativa3d::imi,alternativa3d::imj,alternativa3d::imk,alternativa3d::iml);
            local7 = local7.alternativa3d::next;
          }
          this.drawNode(this.alternativa3d::root,local5,param1,local3,local6);
          local8 = 0;
          while(local8 < this.numOccluders) {
            local9 = this.occluders[local8];
            local10 = local9;
            while(local10.alternativa3d::next != null) {
              local10 = local10.alternativa3d::next;
            }
            local10.alternativa3d::next = Vertex.alternativa3d::collector;
            Vertex.alternativa3d::collector = local9;
            this.occluders[local8] = null;
            local8++;
          }
          this.numOccluders = 0;
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
      var local2:VG = alternativa3d::collectVG(param1);
      if(this.alternativa3d::root != null) {
        this.numOccluders = 0;
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

    private function collectVGNode(param1:KDNode, param2:int, param3:Camera3D, param4:VG = null) : VG {
      var local5:VG = null;
      var local6:VG = null;
      var local9:VG = null;
      var local10:int = 0;
      var local11:int = 0;
      var local7:Object3D = param1.objectList;
      var local8:Object3D = param1.objectBoundList;
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
        local11 = param2 > 0 ? this.cullingInContainer(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ) : 0;
        if(local10 >= 0) {
          param4 = this.collectVGNode(param1.negative,local10,param3,param4);
        }
        if(local11 >= 0) {
          param4 = this.collectVGNode(param1.positive,local11,param3,param4);
        }
      }
      return param4;
    }

    override alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
      super.alternativa3d::updateBounds(param1,param2);
      if(this.alternativa3d::root != null) {
        if(param2 != null) {
          this.updateBoundsNode(this.alternativa3d::root,param1,param2);
        } else {
          if(this.alternativa3d::root.boundMinX < param1.boundMinX) {
            param1.boundMinX = this.alternativa3d::root.boundMinX;
          }
          if(this.alternativa3d::root.boundMaxX > param1.boundMaxX) {
            param1.boundMaxX = this.alternativa3d::root.boundMaxX;
          }
          if(this.alternativa3d::root.boundMinY < param1.boundMinY) {
            param1.boundMinY = this.alternativa3d::root.boundMinY;
          }
          if(this.alternativa3d::root.boundMaxY > param1.boundMaxY) {
            param1.boundMaxY = this.alternativa3d::root.boundMaxY;
          }
          if(this.alternativa3d::root.boundMinZ < param1.boundMinZ) {
            param1.boundMinZ = this.alternativa3d::root.boundMinZ;
          }
          if(this.alternativa3d::root.boundMaxZ > param1.boundMaxZ) {
            param1.boundMaxZ = this.alternativa3d::root.boundMaxZ;
          }
        }
      }
    }

    private function updateBoundsNode(param1:KDNode, param2:Object3D, param3:Object3D) : void {
      var local4:Object3D = param1.objectList;
      while(local4 != null) {
        if(param3 != null) {
          local4.alternativa3d::composeAndAppend(param3);
        } else {
          local4.alternativa3d::composeMatrix();
        }
        local4.alternativa3d::updateBounds(param2,local4);
        local4 = local4.alternativa3d::next;
      }
      if(param1.negative != null) {
        this.updateBoundsNode(param1.negative,param2,param3);
        this.updateBoundsNode(param1.positive,param2,param3);
      }
    }

    private function debugNode(param1:KDNode, param2:int, param3:Camera3D, param4:Canvas, param5:Number) : void {
      var local6:int = 0;
      var local7:int = 0;
      if(param1 != null && param1.negative != null) {
        local6 = param2 > 0 ? this.cullingInContainer(param2,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ) : 0;
        local7 = param2 > 0 ? this.cullingInContainer(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ) : 0;
        if(local6 >= 0) {
          this.debugNode(param1.negative,local6,param3,param4,param5 * this.debugAlphaFade);
        }
        Debug.alternativa3d::drawKDNode(param3,param4,this,param1.axis,param1.coord,param1.boundMinX,param1.boundMinY,param1.boundMinZ,param1.boundMaxX,param1.boundMaxY,param1.boundMaxZ,param5);
        if(local7 >= 0) {
          this.debugNode(param1.positive,local7,param3,param4,param5 * this.debugAlphaFade);
        }
      }
    }

    private function drawNode(param1:KDNode, param2:int, param3:Camera3D, param4:Canvas, param5:VG) : void {
      var local6:int = 0;
      var local7:VG = null;
      var local8:VG = null;
      var local9:VG = null;
      var local10:VG = null;
      var local11:Object3D = null;
      var local12:Object3D = null;
      var local13:int = 0;
      var local14:int = 0;
      var local15:Boolean = false;
      var local16:Boolean = false;
      var local17:Number = NaN;
      var local18:Number = NaN;
      if(param3.alternativa3d::occludedAll) {
        while(param5 != null) {
          local7 = param5.alternativa3d::next;
          param5.alternativa3d::destroy();
          param5 = local7;
        }
        return;
      }
      if(param1.negative != null) {
        local13 = param2 > 0 || this.numOccluders > 0 ? this.cullingInContainer(param2,param1.negative.boundMinX,param1.negative.boundMinY,param1.negative.boundMinZ,param1.negative.boundMaxX,param1.negative.boundMaxY,param1.negative.boundMaxZ) : 0;
        local14 = param2 > 0 || this.numOccluders > 0 ? this.cullingInContainer(param2,param1.positive.boundMinX,param1.positive.boundMinY,param1.positive.boundMinZ,param1.positive.boundMaxX,param1.positive.boundMaxY,param1.positive.boundMaxZ) : 0;
        local15 = param1.axis == 0;
        local16 = param1.axis == 1;
        if(local13 >= 0 && local14 >= 0) {
          while(param5 != null) {
            local7 = param5.alternativa3d::next;
            if(param5.alternativa3d::numOccluders < this.numOccluders && this.occludeGeometry(param3,param5)) {
              param5.alternativa3d::destroy();
            } else {
              local17 = local15 ? Number(param5.alternativa3d::boundMinX) : (local16 ? Number(param5.alternativa3d::boundMinY) : Number(param5.alternativa3d::boundMinZ));
              local18 = local15 ? Number(param5.alternativa3d::boundMaxX) : (local16 ? Number(param5.alternativa3d::boundMaxY) : Number(param5.alternativa3d::boundMaxZ));
              if(local18 <= param1.maxCoord) {
                if(local17 < param1.minCoord) {
                  param5.alternativa3d::next = local8;
                  local8 = param5;
                } else {
                  param5.alternativa3d::next = local9;
                  local9 = param5;
                }
              } else if(local17 >= param1.minCoord) {
                param5.alternativa3d::next = local10;
                local10 = param5;
              } else {
                param5.alternativa3d::split(param3,param1.axis == 0 ? 1 : 0,param1.axis == 1 ? 1 : 0,param1.axis == 2 ? 1 : 0,param1.coord,threshold);
                if(param5.alternativa3d::next != null) {
                  param5.alternativa3d::next.alternativa3d::next = local8;
                  local8 = param5.alternativa3d::next;
                }
                if(param5.alternativa3d::faceStruct != null) {
                  param5.alternativa3d::next = local10;
                  local10 = param5;
                } else {
                  param5.alternativa3d::destroy();
                }
              }
            }
            param5 = local7;
          }
          if(local15 && alternativa3d::imd > param1.coord || local16 && alternativa3d::imh > param1.coord || !local15 && !local16 && alternativa3d::iml > param1.coord) {
            this.drawNode(param1.positive,local14,param3,param4,local10);
            while(local9 != null) {
              local7 = local9.alternativa3d::next;
              if(local9.alternativa3d::numOccluders >= this.numOccluders || !this.occludeGeometry(param3,local9)) {
                local9.alternativa3d::draw(param3,param4,threshold,this);
              }
              local9.alternativa3d::destroy();
              local9 = local7;
            }
            local11 = param1.objectList;
            local12 = param1.objectBoundList;
            while(local11 != null) {
              if(local11.visible && ((local11.alternativa3d::culling = param2) == 0 && this.numOccluders == 0 || (local11.alternativa3d::culling = this.cullingInContainer(param2,local12.boundMinX,local12.boundMinY,local12.boundMinZ,local12.boundMaxX,local12.boundMaxY,local12.boundMaxZ)) >= 0)) {
                local11.alternativa3d::composeAndAppend(this);
                local11.alternativa3d::draw(param3,param4);
              }
              local11 = local11.alternativa3d::next;
              local12 = local12.alternativa3d::next;
            }
            local11 = param1.occluderList;
            local12 = param1.occluderBoundList;
            while(local11 != null) {
              if(local11.visible && ((local11.alternativa3d::culling = param2) == 0 && this.numOccluders == 0 || (local11.alternativa3d::culling = this.cullingInContainer(param2,local12.boundMinX,local12.boundMinY,local12.boundMinZ,local12.boundMaxX,local12.boundMaxY,local12.boundMaxZ)) >= 0)) {
                local11.alternativa3d::composeAndAppend(this);
                local11.alternativa3d::draw(param3,param4);
              }
              local11 = local11.alternativa3d::next;
              local12 = local12.alternativa3d::next;
            }
            if(param1.occluderList != null) {
              this.updateOccluders(param3);
            }
            this.drawNode(param1.negative,local13,param3,param4,local8);
          } else {
            this.drawNode(param1.negative,local13,param3,param4,local8);
            while(local9 != null) {
              local7 = local9.alternativa3d::next;
              if(local9.alternativa3d::numOccluders >= this.numOccluders || !this.occludeGeometry(param3,local9)) {
                local9.alternativa3d::draw(param3,param4,threshold,this);
              }
              local9.alternativa3d::destroy();
              local9 = local7;
            }
            local11 = param1.objectList;
            local12 = param1.objectBoundList;
            while(local11 != null) {
              if(local11.visible && ((local11.alternativa3d::culling = param2) == 0 && this.numOccluders == 0 || (local11.alternativa3d::culling = this.cullingInContainer(param2,local12.boundMinX,local12.boundMinY,local12.boundMinZ,local12.boundMaxX,local12.boundMaxY,local12.boundMaxZ)) >= 0)) {
                local11.alternativa3d::composeAndAppend(this);
                local11.alternativa3d::draw(param3,param4);
              }
              local11 = local11.alternativa3d::next;
              local12 = local12.alternativa3d::next;
            }
            local11 = param1.occluderList;
            local12 = param1.occluderBoundList;
            while(local11 != null) {
              if(local11.visible && ((local11.alternativa3d::culling = param2) == 0 && this.numOccluders == 0 || (local11.alternativa3d::culling = this.cullingInContainer(param2,local12.boundMinX,local12.boundMinY,local12.boundMinZ,local12.boundMaxX,local12.boundMaxY,local12.boundMaxZ)) >= 0)) {
                local11.alternativa3d::composeAndAppend(this);
                local11.alternativa3d::draw(param3,param4);
              }
              local11 = local11.alternativa3d::next;
              local12 = local12.alternativa3d::next;
            }
            if(param1.occluderList != null) {
              this.updateOccluders(param3);
            }
            this.drawNode(param1.positive,local14,param3,param4,local10);
          }
        } else if(local13 >= 0) {
          while(param5 != null) {
            local7 = param5.alternativa3d::next;
            if(param5.alternativa3d::numOccluders < this.numOccluders && this.occludeGeometry(param3,param5)) {
              param5.alternativa3d::destroy();
            } else {
              local17 = local15 ? Number(param5.alternativa3d::boundMinX) : (local16 ? Number(param5.alternativa3d::boundMinY) : Number(param5.alternativa3d::boundMinZ));
              local18 = local15 ? Number(param5.alternativa3d::boundMaxX) : (local16 ? Number(param5.alternativa3d::boundMaxY) : Number(param5.alternativa3d::boundMaxZ));
              if(local18 <= param1.maxCoord) {
                param5.alternativa3d::next = local8;
                local8 = param5;
              } else if(local17 >= param1.minCoord) {
                param5.alternativa3d::destroy();
              } else {
                param5.alternativa3d::crop(param3,param1.axis == 0 ? -1 : 0,param1.axis == 1 ? -1 : 0,param1.axis == 2 ? -1 : 0,-param1.coord,threshold);
                if(param5.alternativa3d::faceStruct != null) {
                  param5.alternativa3d::next = local8;
                  local8 = param5;
                } else {
                  param5.alternativa3d::destroy();
                }
              }
            }
            param5 = local7;
          }
          this.drawNode(param1.negative,local13,param3,param4,local8);
        } else if(local14 >= 0) {
          while(param5 != null) {
            local7 = param5.alternativa3d::next;
            if(param5.alternativa3d::numOccluders < this.numOccluders && this.occludeGeometry(param3,param5)) {
              param5.alternativa3d::destroy();
            } else {
              local17 = local15 ? Number(param5.alternativa3d::boundMinX) : (local16 ? Number(param5.alternativa3d::boundMinY) : Number(param5.alternativa3d::boundMinZ));
              local18 = local15 ? Number(param5.alternativa3d::boundMaxX) : (local16 ? Number(param5.alternativa3d::boundMaxY) : Number(param5.alternativa3d::boundMaxZ));
              if(local18 <= param1.maxCoord) {
                param5.alternativa3d::destroy();
              } else if(local17 >= param1.minCoord) {
                param5.alternativa3d::next = local10;
                local10 = param5;
              } else {
                param5.alternativa3d::crop(param3,param1.axis == 0 ? 1 : 0,param1.axis == 1 ? 1 : 0,param1.axis == 2 ? 1 : 0,param1.coord,threshold);
                if(param5.alternativa3d::faceStruct != null) {
                  param5.alternativa3d::next = local10;
                  local10 = param5;
                } else {
                  param5.alternativa3d::destroy();
                }
              }
            }
            param5 = local7;
          }
          this.drawNode(param1.positive,local14,param3,param4,local10);
        } else {
          while(param5 != null) {
            local7 = param5.alternativa3d::next;
            param5.alternativa3d::destroy();
            param5 = local7;
          }
        }
      } else {
        if(param1.objectList != null) {
          if(param1.objectList.alternativa3d::next != null || param5 != null) {
            while(param5 != null) {
              local7 = param5.alternativa3d::next;
              if(param5.alternativa3d::numOccluders < this.numOccluders && this.occludeGeometry(param3,param5)) {
                param5.alternativa3d::destroy();
              } else {
                param5.alternativa3d::next = local9;
                local9 = param5;
              }
              param5 = local7;
            }
            local11 = param1.objectList;
            local12 = param1.objectBoundList;
            while(local11 != null) {
              if(local11.visible && ((local11.alternativa3d::culling = param2) == 0 && this.numOccluders == 0 || (local11.alternativa3d::culling = this.cullingInContainer(param2,local12.boundMinX,local12.boundMinY,local12.boundMinZ,local12.boundMaxX,local12.boundMaxY,local12.boundMaxZ)) >= 0)) {
                local11.alternativa3d::composeAndAppend(this);
                param5 = local11.alternativa3d::getVG(param3);
                while(param5 != null) {
                  local7 = param5.alternativa3d::next;
                  param5.alternativa3d::next = local9;
                  local9 = param5;
                  param5 = local7;
                }
              }
              local11 = local11.alternativa3d::next;
              local12 = local12.alternativa3d::next;
            }
            if(local9 != null) {
              if(local9.alternativa3d::next != null) {
                alternativa3d::drawConflictGeometry(param3,param4,local9);
              } else {
                local9.alternativa3d::draw(param3,param4,threshold,this);
                local9.alternativa3d::destroy();
              }
            }
          } else {
            local11 = param1.objectList;
            if(local11.visible) {
              local11.alternativa3d::composeAndAppend(this);
              local11.alternativa3d::culling = param2;
              local11.alternativa3d::draw(param3,param4);
            }
          }
        } else if(param5 != null) {
          if(param5.alternativa3d::next != null) {
            if(this.numOccluders > 0) {
              while(param5 != null) {
                local7 = param5.alternativa3d::next;
                if(param5.alternativa3d::numOccluders < this.numOccluders && this.occludeGeometry(param3,param5)) {
                  param5.alternativa3d::destroy();
                } else {
                  param5.alternativa3d::next = local9;
                  local9 = param5;
                }
                param5 = local7;
              }
              if(local9 != null) {
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
              local9 = param5;
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
            }
          } else {
            if(param5.alternativa3d::numOccluders >= this.numOccluders || !this.occludeGeometry(param3,param5)) {
              param5.alternativa3d::draw(param3,param4,threshold,this);
            }
            param5.alternativa3d::destroy();
          }
        }
        local11 = param1.occluderList;
        local12 = param1.occluderBoundList;
        while(local11 != null) {
          if(local11.visible && ((local11.alternativa3d::culling = param2) == 0 && this.numOccluders == 0 || (local11.alternativa3d::culling = this.cullingInContainer(param2,local12.boundMinX,local12.boundMinY,local12.boundMinZ,local12.boundMaxX,local12.boundMaxY,local12.boundMaxZ)) >= 0)) {
            local11.alternativa3d::composeAndAppend(this);
            local11.alternativa3d::draw(param3,param4);
          }
          local11 = local11.alternativa3d::next;
          local12 = local12.alternativa3d::next;
        }
        if(param1.occluderList != null) {
          this.updateOccluders(param3);
        }
      }
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

    private function createNode(param1:Object3D, param2:Object3D, param3:Object3D, param4:Object3D, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number) : KDNode {
      var local12:int = 0;
      var local13:int = 0;
      var local14:Object3D = null;
      var local15:Object3D = null;
      var local16:Number = NaN;
      var local21:Number = NaN;
      var local23:int = 0;
      var local24:int = 0;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local28:Number = NaN;
      var local29:Object3D = null;
      var local30:Object3D = null;
      var local31:Object3D = null;
      var local32:Object3D = null;
      var local33:Object3D = null;
      var local34:Object3D = null;
      var local35:Object3D = null;
      var local36:Object3D = null;
      var local37:Number = NaN;
      var local38:Number = NaN;
      var local39:Object3D = null;
      var local40:Object3D = null;
      var local41:Number = NaN;
      var local42:Number = NaN;
      var local43:Number = NaN;
      var local44:Number = NaN;
      var local45:Number = NaN;
      var local46:Number = NaN;
      var local47:Number = NaN;
      var local48:Number = NaN;
      var local49:Number = NaN;
      var local50:Number = NaN;
      var local51:Number = NaN;
      var local52:Number = NaN;
      var local11:KDNode = new KDNode();
      local11.boundMinX = param5;
      local11.boundMinY = param6;
      local11.boundMinZ = param7;
      local11.boundMaxX = param8;
      local11.boundMaxY = param9;
      local11.boundMaxZ = param10;
      if(param1 == null) {
        if(param3 != null) {
        }
        return local11;
      }
      var local17:int = 0;
      var local18:int = 0;
      var local19:int = 0;
      local15 = param2;
      while(local15 != null) {
        if(local15.boundMinX > param5 + threshold) {
          local13 = 0;
          while(local13 < local17) {
            if(local15.boundMinX >= splitCoordsX[local13] - threshold && local15.boundMinX <= splitCoordsX[local13] + threshold) {
              break;
            }
            local13++;
          }
          if(local13 == local17) {
            var local53:* = local17++;
            splitCoordsX[local53] = local15.boundMinX;
          }
        }
        if(local15.boundMaxX < param8 - threshold) {
          local13 = 0;
          while(local13 < local17) {
            if(local15.boundMaxX >= splitCoordsX[local13] - threshold && local15.boundMaxX <= splitCoordsX[local13] + threshold) {
              break;
            }
            local13++;
          }
          if(local13 == local17) {
            local53 = local17++;
            splitCoordsX[local53] = local15.boundMaxX;
          }
        }
        if(local15.boundMinY > param6 + threshold) {
          local13 = 0;
          while(local13 < local18) {
            if(local15.boundMinY >= splitCoordsY[local13] - threshold && local15.boundMinY <= splitCoordsY[local13] + threshold) {
              break;
            }
            local13++;
          }
          if(local13 == local18) {
            local53 = local18++;
            splitCoordsY[local53] = local15.boundMinY;
          }
        }
        if(local15.boundMaxY < param9 - threshold) {
          local13 = 0;
          while(local13 < local18) {
            if(local15.boundMaxY >= splitCoordsY[local13] - threshold && local15.boundMaxY <= splitCoordsY[local13] + threshold) {
              break;
            }
            local13++;
          }
          if(local13 == local18) {
            local53 = local18++;
            splitCoordsY[local53] = local15.boundMaxY;
          }
        }
        if(local15.boundMinZ > param7 + threshold) {
          local13 = 0;
          while(local13 < local19) {
            if(local15.boundMinZ >= splitCoordsZ[local13] - threshold && local15.boundMinZ <= splitCoordsZ[local13] + threshold) {
              break;
            }
            local13++;
          }
          if(local13 == local19) {
            local53 = local19++;
            splitCoordsZ[local53] = local15.boundMinZ;
          }
        }
        if(local15.boundMaxZ < param10 - threshold) {
          local13 = 0;
          while(local13 < local19) {
            if(local15.boundMaxZ >= splitCoordsZ[local13] - threshold && local15.boundMaxZ <= splitCoordsZ[local13] + threshold) {
              break;
            }
            local13++;
          }
          if(local13 == local19) {
            local53 = local19++;
            splitCoordsZ[local53] = local15.boundMaxZ;
          }
        }
        local15 = local15.alternativa3d::next;
      }
      var local20:int = -1;
      var local22:Number = 1e+22;
      local25 = (param9 - param6) * (param10 - param7);
      local12 = 0;
      while(local12 < local17) {
        local16 = splitCoordsX[local12];
        local26 = local25 * (local16 - param5);
        local27 = local25 * (param8 - local16);
        local23 = 0;
        local24 = 0;
        local15 = param2;
        while(local15 != null) {
          if(local15.boundMaxX <= local16 + threshold) {
            if(local15.boundMinX < local16 - threshold) {
              local23++;
            }
          } else {
            if(local15.boundMinX < local16 - threshold) {
              break;
            }
            local24++;
          }
          local15 = local15.alternativa3d::next;
        }
        if(local15 == null) {
          local28 = local26 * local23 + local27 * local24;
          if(local28 < local22) {
            local22 = local28;
            local20 = 0;
            local21 = local16;
          }
        }
        local12++;
      }
      local25 = (param8 - param5) * (param10 - param7);
      local12 = 0;
      while(local12 < local18) {
        local16 = splitCoordsY[local12];
        local26 = local25 * (local16 - param6);
        local27 = local25 * (param9 - local16);
        local23 = 0;
        local24 = 0;
        local15 = param2;
        while(local15 != null) {
          if(local15.boundMaxY <= local16 + threshold) {
            if(local15.boundMinY < local16 - threshold) {
              local23++;
            }
          } else {
            if(local15.boundMinY < local16 - threshold) {
              break;
            }
            local24++;
          }
          local15 = local15.alternativa3d::next;
        }
        if(local15 == null) {
          local28 = local26 * local23 + local27 * local24;
          if(local28 < local22) {
            local22 = local28;
            local20 = 1;
            local21 = local16;
          }
        }
        local12++;
      }
      local25 = (param8 - param5) * (param9 - param6);
      local12 = 0;
      while(local12 < local19) {
        local16 = splitCoordsZ[local12];
        local26 = local25 * (local16 - param7);
        local27 = local25 * (param10 - local16);
        local23 = 0;
        local24 = 0;
        local15 = param2;
        while(local15 != null) {
          if(local15.boundMaxZ <= local16 + threshold) {
            if(local15.boundMinZ < local16 - threshold) {
              local23++;
            }
          } else {
            if(local15.boundMinZ < local16 - threshold) {
              break;
            }
            local24++;
          }
          local15 = local15.alternativa3d::next;
        }
        if(local15 == null) {
          local28 = local26 * local23 + local27 * local24;
          if(local28 < local22) {
            local22 = local28;
            local20 = 2;
            local21 = local16;
          }
        }
        local12++;
      }
      if(local20 < 0) {
        local11.objectList = param1;
        local11.objectBoundList = param2;
        local11.occluderList = param3;
        local11.occluderBoundList = param4;
      } else {
        local11.axis = local20;
        local11.coord = local21;
        local11.minCoord = local21 - threshold;
        local11.maxCoord = local21 + threshold;
        local14 = param1;
        local15 = param2;
        while(local14 != null) {
          local39 = local14.alternativa3d::next;
          local40 = local15.alternativa3d::next;
          local14.alternativa3d::next = null;
          local15.alternativa3d::next = null;
          local37 = local20 == 0 ? local15.boundMinX : (local20 == 1 ? local15.boundMinY : local15.boundMinZ);
          local38 = local20 == 0 ? local15.boundMaxX : (local20 == 1 ? local15.boundMaxY : local15.boundMaxZ);
          if(local38 <= local21 + threshold) {
            if(local37 < local21 - threshold) {
              local14.alternativa3d::next = local29;
              local29 = local14;
              local15.alternativa3d::next = local30;
              local30 = local15;
            } else {
              local14.alternativa3d::next = local11.objectList;
              local11.objectList = local14;
              local15.alternativa3d::next = local11.objectBoundList;
              local11.objectBoundList = local15;
            }
          } else if(local37 >= local21 - threshold) {
            local14.alternativa3d::next = local33;
            local33 = local14;
            local15.alternativa3d::next = local34;
            local34 = local15;
          }
          local14 = local39;
          local15 = local40;
        }
        local14 = param3;
        local15 = param4;
        while(local14 != null) {
          local39 = local14.alternativa3d::next;
          local40 = local15.alternativa3d::next;
          local14.alternativa3d::next = null;
          local15.alternativa3d::next = null;
          local37 = local20 == 0 ? local15.boundMinX : (local20 == 1 ? local15.boundMinY : local15.boundMinZ);
          local38 = local20 == 0 ? local15.boundMaxX : (local20 == 1 ? local15.boundMaxY : local15.boundMaxZ);
          if(local38 <= local21 + threshold) {
            if(local37 < local21 - threshold) {
              local14.alternativa3d::next = local31;
              local31 = local14;
              local15.alternativa3d::next = local32;
              local32 = local15;
            } else {
              local14.alternativa3d::next = local11.occluderList;
              local11.occluderList = local14;
              local15.alternativa3d::next = local11.occluderBoundList;
              local11.occluderBoundList = local15;
            }
          } else if(local37 >= local21 - threshold) {
            local14.alternativa3d::next = local35;
            local35 = local14;
            local15.alternativa3d::next = local36;
            local36 = local15;
          }
          local14 = local39;
          local15 = local40;
        }
        local41 = local11.boundMinX;
        local42 = local11.boundMinY;
        local43 = local11.boundMinZ;
        local44 = local11.boundMaxX;
        local45 = local11.boundMaxY;
        local46 = local11.boundMaxZ;
        local47 = local11.boundMinX;
        local48 = local11.boundMinY;
        local49 = local11.boundMinZ;
        local50 = local11.boundMaxX;
        local51 = local11.boundMaxY;
        local52 = local11.boundMaxZ;
        if(local20 == 0) {
          local44 = local21;
          local47 = local21;
        } else if(local20 == 1) {
          local45 = local21;
          local48 = local21;
        } else {
          local46 = local21;
          local49 = local21;
        }
        local11.negative = this.createNode(local29,local30,local31,local32,local41,local42,local43,local44,local45,local46);
        local11.positive = this.createNode(local33,local34,local35,local36,local47,local48,local49,local50,local51,local52);
      }
      return local11;
    }

    private function destroyNode(param1:KDNode) : void {
      var local2:Object3D = null;
      var local3:Object3D = null;
      if(param1.negative != null) {
        this.destroyNode(param1.negative);
        param1.negative = null;
      }
      if(param1.positive != null) {
        this.destroyNode(param1.positive);
        param1.positive = null;
      }
      local2 = param1.objectList;
      while(local2 != null) {
        local3 = local2.alternativa3d::next;
        local2.alternativa3d::setParent(null);
        local2.alternativa3d::next = null;
        local2 = local3;
      }
      local2 = param1.objectBoundList;
      while(local2 != null) {
        local3 = local2.alternativa3d::next;
        local2.alternativa3d::next = null;
        local2 = local3;
      }
      local2 = param1.occluderList;
      while(local2 != null) {
        local3 = local2.alternativa3d::next;
        local2.alternativa3d::setParent(null);
        local2.alternativa3d::next = null;
        local2 = local3;
      }
      local2 = param1.occluderBoundList;
      while(local2 != null) {
        local3 = local2.alternativa3d::next;
        local2.alternativa3d::next = null;
        local2 = local3;
      }
      param1.objectList = null;
      param1.objectBoundList = null;
      param1.occluderList = null;
      param1.occluderBoundList = null;
    }

    private function calculateCameraPlanes(param1:Number, param2:Number) : void {
      this.nearPlaneX = alternativa3d::imc;
      this.nearPlaneY = alternativa3d::img;
      this.nearPlaneZ = alternativa3d::imk;
      this.nearPlaneOffset = (alternativa3d::imc * param1 + alternativa3d::imd) * this.nearPlaneX + (alternativa3d::img * param1 + alternativa3d::imh) * this.nearPlaneY + (alternativa3d::imk * param1 + alternativa3d::iml) * this.nearPlaneZ;
      this.farPlaneX = -alternativa3d::imc;
      this.farPlaneY = -alternativa3d::img;
      this.farPlaneZ = -alternativa3d::imk;
      this.farPlaneOffset = (alternativa3d::imc * param2 + alternativa3d::imd) * this.farPlaneX + (alternativa3d::img * param2 + alternativa3d::imh) * this.farPlaneY + (alternativa3d::imk * param2 + alternativa3d::iml) * this.farPlaneZ;
      var local3:Number = -alternativa3d::ima - alternativa3d::imb + alternativa3d::imc;
      var local4:Number = -alternativa3d::ime - alternativa3d::imf + alternativa3d::img;
      var local5:Number = -alternativa3d::imi - alternativa3d::imj + alternativa3d::imk;
      var local6:Number = alternativa3d::ima - alternativa3d::imb + alternativa3d::imc;
      var local7:Number = alternativa3d::ime - alternativa3d::imf + alternativa3d::img;
      var local8:Number = alternativa3d::imi - alternativa3d::imj + alternativa3d::imk;
      this.topPlaneX = local8 * local4 - local7 * local5;
      this.topPlaneY = local6 * local5 - local8 * local3;
      this.topPlaneZ = local7 * local3 - local6 * local4;
      this.topPlaneOffset = alternativa3d::imd * this.topPlaneX + alternativa3d::imh * this.topPlaneY + alternativa3d::iml * this.topPlaneZ;
      local3 = local6;
      local4 = local7;
      local5 = local8;
      local6 = alternativa3d::ima + alternativa3d::imb + alternativa3d::imc;
      local7 = alternativa3d::ime + alternativa3d::imf + alternativa3d::img;
      local8 = alternativa3d::imi + alternativa3d::imj + alternativa3d::imk;
      this.rightPlaneX = local8 * local4 - local7 * local5;
      this.rightPlaneY = local6 * local5 - local8 * local3;
      this.rightPlaneZ = local7 * local3 - local6 * local4;
      this.rightPlaneOffset = alternativa3d::imd * this.rightPlaneX + alternativa3d::imh * this.rightPlaneY + alternativa3d::iml * this.rightPlaneZ;
      local3 = local6;
      local4 = local7;
      local5 = local8;
      local6 = -alternativa3d::ima + alternativa3d::imb + alternativa3d::imc;
      local7 = -alternativa3d::ime + alternativa3d::imf + alternativa3d::img;
      local8 = -alternativa3d::imi + alternativa3d::imj + alternativa3d::imk;
      this.bottomPlaneX = local8 * local4 - local7 * local5;
      this.bottomPlaneY = local6 * local5 - local8 * local3;
      this.bottomPlaneZ = local7 * local3 - local6 * local4;
      this.bottomPlaneOffset = alternativa3d::imd * this.bottomPlaneX + alternativa3d::imh * this.bottomPlaneY + alternativa3d::iml * this.bottomPlaneZ;
      local3 = local6;
      local4 = local7;
      local5 = local8;
      local6 = -alternativa3d::ima - alternativa3d::imb + alternativa3d::imc;
      local7 = -alternativa3d::ime - alternativa3d::imf + alternativa3d::img;
      local8 = -alternativa3d::imi - alternativa3d::imj + alternativa3d::imk;
      this.leftPlaneX = local8 * local4 - local7 * local5;
      this.leftPlaneY = local6 * local5 - local8 * local3;
      this.leftPlaneZ = local7 * local3 - local6 * local4;
      this.leftPlaneOffset = alternativa3d::imd * this.leftPlaneX + alternativa3d::imh * this.leftPlaneY + alternativa3d::iml * this.leftPlaneZ;
    }

    private function updateOccluders(param1:Camera3D) : void {
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local5:Vertex = null;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local2:int = this.numOccluders;
      while(local2 < param1.alternativa3d::numOccluders) {
        local3 = null;
        local4 = param1.alternativa3d::occluders[local2];
        while(local4 != null) {
          local5 = local4.alternativa3d::create();
          local5.alternativa3d::next = local3;
          local3 = local5;
          local6 = alternativa3d::ima * local4.x + alternativa3d::imb * local4.y + alternativa3d::imc * local4.z;
          local7 = alternativa3d::ime * local4.x + alternativa3d::imf * local4.y + alternativa3d::img * local4.z;
          local8 = alternativa3d::imi * local4.x + alternativa3d::imj * local4.y + alternativa3d::imk * local4.z;
          local9 = alternativa3d::ima * local4.u + alternativa3d::imb * local4.v + alternativa3d::imc * local4.alternativa3d::offset;
          local10 = alternativa3d::ime * local4.u + alternativa3d::imf * local4.v + alternativa3d::img * local4.alternativa3d::offset;
          local11 = alternativa3d::imi * local4.u + alternativa3d::imj * local4.v + alternativa3d::imk * local4.alternativa3d::offset;
          local3.x = local11 * local7 - local10 * local8;
          local3.y = local9 * local8 - local11 * local6;
          local3.z = local10 * local6 - local9 * local7;
          local3.alternativa3d::offset = alternativa3d::imd * local3.x + alternativa3d::imh * local3.y + alternativa3d::iml * local3.z;
          local4 = local4.alternativa3d::next;
        }
        this.occluders[this.numOccluders] = local3;
        ++this.numOccluders;
        local2++;
      }
    }

    private function cullingInContainer(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : int {
      var local9:Vertex = null;
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
      var local8:int = 0;
      while(true) {
        if(local8 >= this.numOccluders) {
          return param1;
        }
        local9 = this.occluders[local8];
        while(local9 != null) {
          if(local9.x >= 0) {
            if(local9.y >= 0) {
              if(local9.z >= 0) {
                if(param5 * local9.x + param6 * local9.y + param7 * local9.z > local9.alternativa3d::offset) {
                  break;
                }
              } else if(param5 * local9.x + param6 * local9.y + param4 * local9.z > local9.alternativa3d::offset) {
                break;
              }
            } else if(local9.z >= 0) {
              if(param5 * local9.x + param3 * local9.y + param7 * local9.z > local9.alternativa3d::offset) {
                break;
              }
            } else if(param5 * local9.x + param3 * local9.y + param4 * local9.z > local9.alternativa3d::offset) {
              break;
            }
          } else if(local9.y >= 0) {
            if(local9.z >= 0) {
              if(param2 * local9.x + param6 * local9.y + param7 * local9.z > local9.alternativa3d::offset) {
                break;
              }
            } else if(param2 * local9.x + param6 * local9.y + param4 * local9.z > local9.alternativa3d::offset) {
              break;
            }
          } else if(local9.z >= 0) {
            if(param2 * local9.x + param3 * local9.y + param7 * local9.z > local9.alternativa3d::offset) {
              break;
            }
          } else if(param2 * local9.x + param3 * local9.y + param4 * local9.z > local9.alternativa3d::offset) {
            break;
          }
          local9 = local9.alternativa3d::next;
        }
        if(local9 == null) {
          break;
        }
        local8++;
      }
      return -1;
    }

    private function occludeGeometry(param1:Camera3D, param2:VG) : Boolean {
      var local4:Vertex = null;
      var local3:int = int(param2.alternativa3d::numOccluders);
      while(true) {
        if(local3 >= this.numOccluders) {
          param2.alternativa3d::numOccluders = this.numOccluders;
          return false;
        }
        local4 = this.occluders[local3];
        while(local4 != null) {
          if(local4.x >= 0) {
            if(local4.y >= 0) {
              if(local4.z >= 0) {
                if(param2.alternativa3d::boundMaxX * local4.x + param2.alternativa3d::boundMaxY * local4.y + param2.alternativa3d::boundMaxZ * local4.z > local4.alternativa3d::offset) {
                  break;
                }
              } else if(param2.alternativa3d::boundMaxX * local4.x + param2.alternativa3d::boundMaxY * local4.y + param2.alternativa3d::boundMinZ * local4.z > local4.alternativa3d::offset) {
                break;
              }
            } else if(local4.z >= 0) {
              if(param2.alternativa3d::boundMaxX * local4.x + param2.alternativa3d::boundMinY * local4.y + param2.alternativa3d::boundMaxZ * local4.z > local4.alternativa3d::offset) {
                break;
              }
            } else if(param2.alternativa3d::boundMaxX * local4.x + param2.alternativa3d::boundMinY * local4.y + param2.alternativa3d::boundMinZ * local4.z > local4.alternativa3d::offset) {
              break;
            }
          } else if(local4.y >= 0) {
            if(local4.z >= 0) {
              if(param2.alternativa3d::boundMinX * local4.x + param2.alternativa3d::boundMaxY * local4.y + param2.alternativa3d::boundMaxZ * local4.z > local4.alternativa3d::offset) {
                break;
              }
            } else if(param2.alternativa3d::boundMinX * local4.x + param2.alternativa3d::boundMaxY * local4.y + param2.alternativa3d::boundMinZ * local4.z > local4.alternativa3d::offset) {
              break;
            }
          } else if(local4.z >= 0) {
            if(param2.alternativa3d::boundMinX * local4.x + param2.alternativa3d::boundMinY * local4.y + param2.alternativa3d::boundMaxZ * local4.z > local4.alternativa3d::offset) {
              break;
            }
          } else if(param2.alternativa3d::boundMinX * local4.x + param2.alternativa3d::boundMinY * local4.y + param2.alternativa3d::boundMinZ * local4.z > local4.alternativa3d::offset) {
            break;
          }
          local4 = local4.alternativa3d::next;
        }
        if(local4 == null) {
          break;
        }
        local3++;
      }
      return true;
    }
  }
}

import alternativa.engine3d.alternativa3d;
import alternativa.engine3d.core.Face;
import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.core.Vertex;
import alternativa.engine3d.core.Wrapper;
import alternativa.engine3d.objects.BSP;
import alternativa.engine3d.objects.Decal;
import alternativa.engine3d.objects.Mesh;
use namespace alternativa3d;

class KDNode {
  public var negative:KDNode;
  public var positive:KDNode;
  public var axis:int;
  public var coord:Number;
  public var minCoord:Number;
  public var maxCoord:Number;
  public var boundMinX:Number;
  public var boundMinY:Number;
  public var boundMinZ:Number;
  public var boundMaxX:Number;
  public var boundMaxY:Number;
  public var boundMaxZ:Number;
  public var objectList:Object3D;
  public var objectBoundList:Object3D;
  public var occluderList:Object3D;
  public var occluderBoundList:Object3D;

  public function KDNode() {
    super();
  }

  public function collectPolygons(param1:Decal, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number) : void {
    var local10:Object3D = null;
    var local11:Object3D = null;
    var local12:Boolean = false;
    var local13:Boolean = false;
    var local14:Number = NaN;
    var local15:Number = NaN;
    if(this.negative != null) {
      local12 = this.axis == 0;
      local13 = this.axis == 1;
      local14 = local12 ? param4 : (local13 ? param6 : param8);
      local15 = local12 ? param5 : (local13 ? param7 : param9);
      if(local15 <= this.maxCoord) {
        this.negative.collectPolygons(param1,param2,param3,param4,param5,param6,param7,param8,param9);
      } else if(local14 >= this.minCoord) {
        this.positive.collectPolygons(param1,param2,param3,param4,param5,param6,param7,param8,param9);
      } else {
        local11 = this.objectBoundList;
        local10 = this.objectList;
        while(local11 != null) {
          if(local12) {
            if(param6 < local11.boundMaxY && param7 > local11.boundMinY && param8 < local11.boundMaxZ && param9 > local11.boundMinZ) {
              this.clip(param1,param2,param3,local10);
            }
          } else if(local13) {
            if(param4 < local11.boundMaxX && param5 > local11.boundMinX && param8 < local11.boundMaxZ && param9 > local11.boundMinZ) {
              this.clip(param1,param2,param3,local10);
            }
          } else if(param4 < local11.boundMaxX && param5 > local11.boundMinX && param6 < local11.boundMaxY && param7 > local11.boundMinY) {
            this.clip(param1,param2,param3,local10);
          }
          local11 = local11.alternativa3d::next;
          local10 = local10.alternativa3d::next;
        }
        this.negative.collectPolygons(param1,param2,param3,param4,param5,param6,param7,param8,param9);
        this.positive.collectPolygons(param1,param2,param3,param4,param5,param6,param7,param8,param9);
      }
    } else {
      local10 = this.objectList;
      while(local10 != null) {
        this.clip(param1,param2,param3,local10);
        local10 = local10.alternativa3d::next;
      }
    }
  }

  private function clip(param1:Decal, param2:Number, param3:Number, param4:Object3D) : void {
    var local5:Face = null;
    var local6:Vertex = null;
    var local7:Wrapper = null;
    var local8:Vertex = null;
    var local9:Vector.<Face> = null;
    var local12:Number = NaN;
    var local13:Number = NaN;
    var local14:Vertex = null;
    var local15:Vertex = null;
    var local16:Vertex = null;
    var local17:Vertex = null;
    var local18:Vertex = null;
    var local19:Vertex = null;
    var local20:Wrapper = null;
    if(param4 is Mesh) {
      local8 = Mesh(param4).alternativa3d::vertexList;
      local5 = Mesh(param4).alternativa3d::faceList;
      if(local5.material == null || Boolean(local5.material.alternativa3d::transparent)) {
        return;
      }
      local9 = Mesh(param4).faces;
    } else if(param4 is BSP) {
      local8 = BSP(param4).alternativa3d::vertexList;
      local9 = BSP(param4).alternativa3d::faces;
      local5 = local9[0];
      if(local5.material == null || Boolean(local5.material.alternativa3d::transparent)) {
        return;
      }
    }
    param4.alternativa3d::composeAndAppend(param1);
    param4.alternativa3d::calculateInverseMatrix();
    ++param4.alternativa3d::transformId;
    var local10:int = int(local9.length);
    var local11:int = 0;
    while(local11 < local10) {
      local5 = local9[local11];
      if(-local5.alternativa3d::normalX * param4.alternativa3d::imc - local5.alternativa3d::normalY * param4.alternativa3d::img - local5.alternativa3d::normalZ * param4.alternativa3d::imk >= param3) {
        local12 = local5.alternativa3d::normalX * param4.alternativa3d::imd + local5.alternativa3d::normalY * param4.alternativa3d::imh + local5.alternativa3d::normalZ * param4.alternativa3d::iml;
        if(!(local12 <= local5.alternativa3d::offset - param2 || local12 >= local5.alternativa3d::offset + param2)) {
          local7 = local5.alternativa3d::wrapper;
          while(local7 != null) {
            local6 = local7.alternativa3d::vertex;
            if(local6.alternativa3d::transformId != param4.alternativa3d::transformId) {
              local6.alternativa3d::cameraX = param4.alternativa3d::ma * local6.x + param4.alternativa3d::mb * local6.y + param4.alternativa3d::mc * local6.z + param4.alternativa3d::md;
              local6.alternativa3d::cameraY = param4.alternativa3d::me * local6.x + param4.alternativa3d::mf * local6.y + param4.alternativa3d::mg * local6.z + param4.alternativa3d::mh;
              local6.alternativa3d::cameraZ = param4.alternativa3d::mi * local6.x + param4.alternativa3d::mj * local6.y + param4.alternativa3d::mk * local6.z + param4.alternativa3d::ml;
              local6.alternativa3d::transformId = param4.alternativa3d::transformId;
            }
            local7 = local7.alternativa3d::next;
          }
          local7 = local5.alternativa3d::wrapper;
          while(local7 != null) {
            if(local7.alternativa3d::vertex.alternativa3d::cameraX > param1.boundMinX) {
              break;
            }
            local7 = local7.alternativa3d::next;
          }
          if(local7 != null) {
            local7 = local5.alternativa3d::wrapper;
            while(local7 != null) {
              if(local7.alternativa3d::vertex.alternativa3d::cameraX < param1.boundMaxX) {
                break;
              }
              local7 = local7.alternativa3d::next;
            }
            if(local7 != null) {
              local7 = local5.alternativa3d::wrapper;
              while(local7 != null) {
                if(local7.alternativa3d::vertex.alternativa3d::cameraY > param1.boundMinY) {
                  break;
                }
                local7 = local7.alternativa3d::next;
              }
              if(local7 != null) {
                local7 = local5.alternativa3d::wrapper;
                while(local7 != null) {
                  if(local7.alternativa3d::vertex.alternativa3d::cameraY < param1.boundMaxY) {
                    break;
                  }
                  local7 = local7.alternativa3d::next;
                }
                if(local7 != null) {
                  local7 = local5.alternativa3d::wrapper;
                  while(local7 != null) {
                    if(local7.alternativa3d::vertex.alternativa3d::cameraZ > param1.boundMinZ) {
                      break;
                    }
                    local7 = local7.alternativa3d::next;
                  }
                  if(local7 != null) {
                    local7 = local5.alternativa3d::wrapper;
                    while(local7 != null) {
                      if(local7.alternativa3d::vertex.alternativa3d::cameraZ < param1.boundMaxZ) {
                        break;
                      }
                      local7 = local7.alternativa3d::next;
                    }
                    if(local7 != null) {
                      local18 = null;
                      local19 = null;
                      local7 = local5.alternativa3d::wrapper;
                      while(local7 != null) {
                        local6 = local7.alternativa3d::vertex;
                        local16 = new Vertex();
                        local16.x = local6.alternativa3d::cameraX;
                        local16.y = local6.alternativa3d::cameraY;
                        local16.z = local6.alternativa3d::cameraZ;
                        local16.normalX = param4.alternativa3d::ma * local6.normalX + param4.alternativa3d::mb * local6.normalY + param4.alternativa3d::mc * local6.normalZ;
                        local16.normalY = param4.alternativa3d::me * local6.normalX + param4.alternativa3d::mf * local6.normalY + param4.alternativa3d::mg * local6.normalZ;
                        local16.normalZ = param4.alternativa3d::mi * local6.normalX + param4.alternativa3d::mj * local6.normalY + param4.alternativa3d::mk * local6.normalZ;
                        if(local19 != null) {
                          local19.alternativa3d::next = local16;
                        } else {
                          local18 = local16;
                        }
                        local19 = local16;
                        local7 = local7.alternativa3d::next;
                      }
                      local14 = local19;
                      local15 = local18;
                      local18 = null;
                      local19 = null;
                      while(local15 != null) {
                        local17 = local15.alternativa3d::next;
                        local15.alternativa3d::next = null;
                        if(local15.z > param1.boundMinZ && local14.z <= param1.boundMinZ || local15.z <= param1.boundMinZ && local14.z > param1.boundMinZ) {
                          local13 = (param1.boundMinZ - local14.z) / (local15.z - local14.z);
                          local16 = new Vertex();
                          local16.x = local14.x + (local15.x - local14.x) * local13;
                          local16.y = local14.y + (local15.y - local14.y) * local13;
                          local16.z = local14.z + (local15.z - local14.z) * local13;
                          local16.normalX = local14.normalX + (local15.normalX - local14.normalX) * local13;
                          local16.normalY = local14.normalY + (local15.normalY - local14.normalY) * local13;
                          local16.normalZ = local14.normalZ + (local15.normalZ - local14.normalZ) * local13;
                          if(local19 != null) {
                            local19.alternativa3d::next = local16;
                          } else {
                            local18 = local16;
                          }
                          local19 = local16;
                        }
                        if(local15.z > param1.boundMinZ) {
                          if(local19 != null) {
                            local19.alternativa3d::next = local15;
                          } else {
                            local18 = local15;
                          }
                          local19 = local15;
                        }
                        local14 = local15;
                        local15 = local17;
                      }
                      if(local18 != null) {
                        local14 = local19;
                        local15 = local18;
                        local18 = null;
                        local19 = null;
                        while(local15 != null) {
                          local17 = local15.alternativa3d::next;
                          local15.alternativa3d::next = null;
                          if(local15.z < param1.boundMaxZ && local14.z >= param1.boundMaxZ || local15.z >= param1.boundMaxZ && local14.z < param1.boundMaxZ) {
                            local13 = (param1.boundMaxZ - local14.z) / (local15.z - local14.z);
                            local16 = new Vertex();
                            local16.x = local14.x + (local15.x - local14.x) * local13;
                            local16.y = local14.y + (local15.y - local14.y) * local13;
                            local16.z = local14.z + (local15.z - local14.z) * local13;
                            local16.normalX = local14.normalX + (local15.normalX - local14.normalX) * local13;
                            local16.normalY = local14.normalY + (local15.normalY - local14.normalY) * local13;
                            local16.normalZ = local14.normalZ + (local15.normalZ - local14.normalZ) * local13;
                            if(local19 != null) {
                              local19.alternativa3d::next = local16;
                            } else {
                              local18 = local16;
                            }
                            local19 = local16;
                          }
                          if(local15.z < param1.boundMaxZ) {
                            if(local19 != null) {
                              local19.alternativa3d::next = local15;
                            } else {
                              local18 = local15;
                            }
                            local19 = local15;
                          }
                          local14 = local15;
                          local15 = local17;
                        }
                        if(local18 != null) {
                          local14 = local19;
                          local15 = local18;
                          local18 = null;
                          local19 = null;
                          while(local15 != null) {
                            local17 = local15.alternativa3d::next;
                            local15.alternativa3d::next = null;
                            if(local15.x > param1.boundMinX && local14.x <= param1.boundMinX || local15.x <= param1.boundMinX && local14.x > param1.boundMinX) {
                              local13 = (param1.boundMinX - local14.x) / (local15.x - local14.x);
                              local16 = new Vertex();
                              local16.x = local14.x + (local15.x - local14.x) * local13;
                              local16.y = local14.y + (local15.y - local14.y) * local13;
                              local16.z = local14.z + (local15.z - local14.z) * local13;
                              local16.normalX = local14.normalX + (local15.normalX - local14.normalX) * local13;
                              local16.normalY = local14.normalY + (local15.normalY - local14.normalY) * local13;
                              local16.normalZ = local14.normalZ + (local15.normalZ - local14.normalZ) * local13;
                              if(local19 != null) {
                                local19.alternativa3d::next = local16;
                              } else {
                                local18 = local16;
                              }
                              local19 = local16;
                            }
                            if(local15.x > param1.boundMinX) {
                              if(local19 != null) {
                                local19.alternativa3d::next = local15;
                              } else {
                                local18 = local15;
                              }
                              local19 = local15;
                            }
                            local14 = local15;
                            local15 = local17;
                          }
                          if(local18 != null) {
                            local14 = local19;
                            local15 = local18;
                            local18 = null;
                            local19 = null;
                            while(local15 != null) {
                              local17 = local15.alternativa3d::next;
                              local15.alternativa3d::next = null;
                              if(local15.x < param1.boundMaxX && local14.x >= param1.boundMaxX || local15.x >= param1.boundMaxX && local14.x < param1.boundMaxX) {
                                local13 = (param1.boundMaxX - local14.x) / (local15.x - local14.x);
                                local16 = new Vertex();
                                local16.x = local14.x + (local15.x - local14.x) * local13;
                                local16.y = local14.y + (local15.y - local14.y) * local13;
                                local16.z = local14.z + (local15.z - local14.z) * local13;
                                local16.normalX = local14.normalX + (local15.normalX - local14.normalX) * local13;
                                local16.normalY = local14.normalY + (local15.normalY - local14.normalY) * local13;
                                local16.normalZ = local14.normalZ + (local15.normalZ - local14.normalZ) * local13;
                                if(local19 != null) {
                                  local19.alternativa3d::next = local16;
                                } else {
                                  local18 = local16;
                                }
                                local19 = local16;
                              }
                              if(local15.x < param1.boundMaxX) {
                                if(local19 != null) {
                                  local19.alternativa3d::next = local15;
                                } else {
                                  local18 = local15;
                                }
                                local19 = local15;
                              }
                              local14 = local15;
                              local15 = local17;
                            }
                            if(local18 != null) {
                              local14 = local19;
                              local15 = local18;
                              local18 = null;
                              local19 = null;
                              while(local15 != null) {
                                local17 = local15.alternativa3d::next;
                                local15.alternativa3d::next = null;
                                if(local15.y > param1.boundMinY && local14.y <= param1.boundMinY || local15.y <= param1.boundMinY && local14.y > param1.boundMinY) {
                                  local13 = (param1.boundMinY - local14.y) / (local15.y - local14.y);
                                  local16 = new Vertex();
                                  local16.x = local14.x + (local15.x - local14.x) * local13;
                                  local16.y = local14.y + (local15.y - local14.y) * local13;
                                  local16.z = local14.z + (local15.z - local14.z) * local13;
                                  local16.normalX = local14.normalX + (local15.normalX - local14.normalX) * local13;
                                  local16.normalY = local14.normalY + (local15.normalY - local14.normalY) * local13;
                                  local16.normalZ = local14.normalZ + (local15.normalZ - local14.normalZ) * local13;
                                  if(local19 != null) {
                                    local19.alternativa3d::next = local16;
                                  } else {
                                    local18 = local16;
                                  }
                                  local19 = local16;
                                }
                                if(local15.y > param1.boundMinY) {
                                  if(local19 != null) {
                                    local19.alternativa3d::next = local15;
                                  } else {
                                    local18 = local15;
                                  }
                                  local19 = local15;
                                }
                                local14 = local15;
                                local15 = local17;
                              }
                              if(local18 != null) {
                                local14 = local19;
                                local15 = local18;
                                local18 = null;
                                local19 = null;
                                while(local15 != null) {
                                  local17 = local15.alternativa3d::next;
                                  local15.alternativa3d::next = null;
                                  if(local15.y < param1.boundMaxY && local14.y >= param1.boundMaxY || local15.y >= param1.boundMaxY && local14.y < param1.boundMaxY) {
                                    local13 = (param1.boundMaxY - local14.y) / (local15.y - local14.y);
                                    local16 = new Vertex();
                                    local16.x = local14.x + (local15.x - local14.x) * local13;
                                    local16.y = local14.y + (local15.y - local14.y) * local13;
                                    local16.z = local14.z + (local15.z - local14.z) * local13;
                                    local16.normalX = local14.normalX + (local15.normalX - local14.normalX) * local13;
                                    local16.normalY = local14.normalY + (local15.normalY - local14.normalY) * local13;
                                    local16.normalZ = local14.normalZ + (local15.normalZ - local14.normalZ) * local13;
                                    if(local19 != null) {
                                      local19.alternativa3d::next = local16;
                                    } else {
                                      local18 = local16;
                                    }
                                    local19 = local16;
                                  }
                                  if(local15.y < param1.boundMaxY) {
                                    if(local19 != null) {
                                      local19.alternativa3d::next = local15;
                                    } else {
                                      local18 = local15;
                                    }
                                    local19 = local15;
                                  }
                                  local14 = local15;
                                  local15 = local17;
                                }
                                if(local18 != null) {
                                  local5 = new Face();
                                  local20 = null;
                                  local6 = local18;
                                  while(local6 != null) {
                                    local17 = local6.alternativa3d::next;
                                    local6.alternativa3d::next = param1.alternativa3d::vertexList;
                                    param1.alternativa3d::vertexList = local6;
                                    local6.u = (local6.x - param1.boundMinX) / (param1.boundMaxX - param1.boundMinX);
                                    local6.v = (local6.y - param1.boundMinY) / (param1.boundMaxY - param1.boundMinY);
                                    if(local20 != null) {
                                      local20.alternativa3d::next = new Wrapper();
                                      local20 = local20.alternativa3d::next;
                                    } else {
                                      local5.alternativa3d::wrapper = new Wrapper();
                                      local20 = local5.alternativa3d::wrapper;
                                    }
                                    local20.alternativa3d::vertex = local6;
                                    local6 = local17;
                                  }
                                  local5.alternativa3d::calculateBestSequenceAndNormal();
                                  local5.alternativa3d::next = param1.alternativa3d::faceList;
                                  param1.alternativa3d::faceList = local5;
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      local11++;
    }
  }
}
