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
  import flash.geom.ColorTransform;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class LODContainer extends Object3DContainer {
    public function LODContainer() {
      super();
    }

    public function getChildDistance(param1:Object3D) : Number {
      if(param1 == null) {
        throw new TypeError("Parameter child must be non-null.");
      }
      if(param1.alternativa3d::_parent != this) {
        throw new ArgumentError("The supplied Object3D must be a child of the caller.");
      }
      return param1.alternativa3d::distance;
    }

    public function setChildDistance(param1:Object3D, param2:Number) : void {
      if(param1 == null) {
        throw new TypeError("Parameter child must be non-null.");
      }
      if(param1.alternativa3d::_parent != this) {
        throw new ArgumentError("The supplied Object3D must be a child of the caller.");
      }
      param1.alternativa3d::distance = param2;
    }

    public function addLOD(param1:Object3D, param2:Number) : Object3D {
      this.addChild(param1);
      param1.alternativa3d::distance = param2;
      return param1;
    }

    override public function addChild(param1:Object3D) : Object3D {
      if(param1 == null) {
        throw new TypeError("Parameter child must be non-null.");
      }
      if(param1 == this) {
        throw new ArgumentError("An object cannot be added as a child of itself.");
      }
      var local2:Object3DContainer = alternativa3d::_parent;
      while(local2 != null) {
        if(local2 == param1) {
          throw new ArgumentError("An object cannot be added as a child to one of it\'s children (or children\'s children, etc.).");
        }
        local2 = local2.alternativa3d::_parent;
      }
      if(param1.alternativa3d::_parent != this) {
        param1.alternativa3d::distance = 0;
      }
      if(param1.alternativa3d::_parent != null) {
        param1.alternativa3d::_parent.removeChild(param1);
      }
      alternativa3d::addToList(param1);
      return param1;
    }

    override public function addChildAt(param1:Object3D, param2:int) : Object3D {
      if(param1 == null) {
        throw new TypeError("Parameter child must be non-null.");
      }
      if(param1 == this) {
        throw new ArgumentError("An object cannot be added as a child of itself.");
      }
      if(param2 < 0) {
        throw new RangeError("The supplied index is out of bounds.");
      }
      var local3:Object3DContainer = alternativa3d::_parent;
      while(local3 != null) {
        if(local3 == param1) {
          throw new ArgumentError("An object cannot be added as a child to one of it\'s children (or children\'s children, etc.).");
        }
        local3 = local3.alternativa3d::_parent;
      }
      var local4:Object3D = alternativa3d::childrenList;
      var local5:int = 0;
      while(local5 < param2) {
        if(local4 == null) {
          throw new RangeError("The supplied index is out of bounds.");
        }
        local4 = local4.alternativa3d::next;
        local5++;
      }
      if(param1.alternativa3d::_parent != this) {
        param1.alternativa3d::distance = 0;
      }
      if(param1.alternativa3d::_parent != null) {
        param1.alternativa3d::_parent.removeChild(param1);
      }
      alternativa3d::addToList(param1,local4);
      return param1;
    }

    override public function intersectRay(param1:Vector3D, param2:Vector3D, param3:Dictionary = null, param4:Camera3D = null) : RayIntersectionData {
      if(param3 != null && Boolean(param3[this])) {
        return null;
      }
      if(!alternativa3d::boundIntersectRay(param1,param2,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
        return null;
      }
      var local5:Object3D = alternativa3d::childrenList;
      local5.alternativa3d::composeMatrix();
      local5.alternativa3d::invertMatrix();
      var local6:Vector3D = new Vector3D();
      var local7:Vector3D = new Vector3D();
      local6.x = local5.alternativa3d::ma * param1.x + local5.alternativa3d::mb * param1.y + local5.alternativa3d::mc * param1.z + local5.alternativa3d::md;
      local6.y = local5.alternativa3d::me * param1.x + local5.alternativa3d::mf * param1.y + local5.alternativa3d::mg * param1.z + local5.alternativa3d::mh;
      local6.z = local5.alternativa3d::mi * param1.x + local5.alternativa3d::mj * param1.y + local5.alternativa3d::mk * param1.z + local5.alternativa3d::ml;
      local7.x = local5.alternativa3d::ma * param2.x + local5.alternativa3d::mb * param2.y + local5.alternativa3d::mc * param2.z;
      local7.y = local5.alternativa3d::me * param2.x + local5.alternativa3d::mf * param2.y + local5.alternativa3d::mg * param2.z;
      local7.z = local5.alternativa3d::mi * param2.x + local5.alternativa3d::mj * param2.y + local5.alternativa3d::mk * param2.z;
      return local5.intersectRay(local6,local7,param3,param4);
    }

    override alternativa3d function checkIntersection(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Dictionary) : Boolean {
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local9:Object3D = alternativa3d::childrenList;
      if(param8 != null && !param8[local9]) {
        local9.alternativa3d::composeMatrix();
        local9.alternativa3d::invertMatrix();
        local10 = local9.alternativa3d::ma * param1 + local9.alternativa3d::mb * param2 + local9.alternativa3d::mc * param3 + local9.alternativa3d::md;
        local11 = local9.alternativa3d::me * param1 + local9.alternativa3d::mf * param2 + local9.alternativa3d::mg * param3 + local9.alternativa3d::mh;
        local12 = local9.alternativa3d::mi * param1 + local9.alternativa3d::mj * param2 + local9.alternativa3d::mk * param3 + local9.alternativa3d::ml;
        local13 = local9.alternativa3d::ma * param4 + local9.alternativa3d::mb * param5 + local9.alternativa3d::mc * param6;
        local14 = local9.alternativa3d::me * param4 + local9.alternativa3d::mf * param5 + local9.alternativa3d::mg * param6;
        local15 = local9.alternativa3d::mi * param4 + local9.alternativa3d::mj * param5 + local9.alternativa3d::mk * param6;
        return Boolean(alternativa3d::boundCheckIntersection(local10,local11,local12,local13,local14,local15,param7,local9.boundMinX,local9.boundMinY,local9.boundMinZ,local9.boundMaxX,local9.boundMaxY,local9.boundMaxZ)) && Boolean(local9.alternativa3d::checkIntersection(local10,local11,local12,local13,local14,local15,param7,param8));
      }
      return false;
    }

    override alternativa3d function collectPlanes(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:Vector3D, param6:Vector.<Face>, param7:Dictionary = null) : void {
      if(param7 != null && Boolean(param7[this])) {
        return;
      }
      var local8:Vector3D = alternativa3d::calculateSphere(param1,param2,param3,param4,param5);
      if(!alternativa3d::boundIntersectSphere(local8,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
        return;
      }
      var local9:Object3D = alternativa3d::childrenList;
      local9.alternativa3d::composeAndAppend(this);
      local9.alternativa3d::collectPlanes(param1,param2,param3,param4,param5,param6,param7);
    }

    override public function clone() : Object3D {
      var local1:LODContainer = new LODContainer();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override alternativa3d function draw(param1:Camera3D, param2:Canvas) : void {
      var local4:Canvas = null;
      var local5:int = 0;
      var local3:Object3D = this.getLODObject(param1);
      if(local3 != null && local3.visible) {
        local3.alternativa3d::composeAndAppend(this);
        if(local3.alternativa3d::cullingInCamera(param1,alternativa3d::culling) >= 0) {
          if(param1.debug && (local5 = int(param1.alternativa3d::checkInDebug(this))) > 0) {
            local4 = param2.alternativa3d::getChildCanvas(true,false);
            if(Boolean(local5 & Debug.BOUNDS)) {
              Debug.alternativa3d::drawBounds(param1,local4,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
            }
          }
          local4 = param2.alternativa3d::getChildCanvas(false,true,this,alpha,blendMode,colorTransform,filters);
          local4.alternativa3d::numDraws = 0;
          local3.alternativa3d::draw(param1,local4);
          if(local4.alternativa3d::numDraws > 0) {
            local4.alternativa3d::remChildren(local4.alternativa3d::numDraws);
          } else {
            --param2.alternativa3d::numDraws;
          }
        }
      }
    }

    override alternativa3d function getVG(param1:Camera3D) : VG {
      var local2:VG = null;
      var local4:ColorTransform = null;
      var local5:int = 0;
      var local6:Array = null;
      var local7:int = 0;
      var local8:int = 0;
      var local3:Object3D = this.getLODObject(param1);
      if(local3 != null && local3.visible) {
        local3.alternativa3d::composeAndAppend(this);
        if(local3.alternativa3d::cullingInCamera(param1,alternativa3d::culling) >= 0) {
          local2 = local3.alternativa3d::getVG(param1);
          if(alpha != 1) {
            local2.alternativa3d::alpha *= alpha;
          }
          if(blendMode != "normal") {
            if(local2.alternativa3d::blendMode == "normal") {
              local2.alternativa3d::blendMode = blendMode;
            }
          }
          if(colorTransform != null) {
            if(local2.alternativa3d::colorTransform != null) {
              local4 = new ColorTransform(colorTransform.redMultiplier,colorTransform.greenMultiplier,colorTransform.blueMultiplier,colorTransform.alphaMultiplier,colorTransform.redOffset,colorTransform.greenOffset,colorTransform.blueOffset,colorTransform.alphaOffset);
              local4.concat(local2.alternativa3d::colorTransform);
              local2.alternativa3d::colorTransform = local4;
            } else {
              local2.alternativa3d::colorTransform = colorTransform;
            }
          }
          if(filters != null) {
            if(local2.alternativa3d::filters != null) {
              local6 = new Array();
              local7 = 0;
              local8 = int(local2.alternativa3d::filters.length);
              local5 = 0;
              while(local5 < local8) {
                local6[local7] = local2.alternativa3d::filters[local5];
                local7++;
                local5++;
              }
              local8 = int(filters.length);
              local5 = 0;
              while(local5 < local8) {
                local6[local7] = filters[local5];
                local7++;
                local5++;
              }
              local2.alternativa3d::filters = local6;
            } else {
              local2.alternativa3d::filters = filters;
            }
          }
        }
      }
      return local2;
    }

    private function getLODObject(param1:Camera3D) : Object3D {
      var local6:Object3D = null;
      var local8:Number = NaN;
      var local2:Number = alternativa3d::md * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
      var local3:Number = alternativa3d::mh * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
      var local4:Number = Math.sqrt(local2 * local2 + local3 * local3 + alternativa3d::ml * alternativa3d::ml);
      var local5:Number = 1e+22;
      var local7:Object3D = alternativa3d::childrenList;
      while(local7 != null) {
        local8 = local7.alternativa3d::distance - local4;
        if(local8 > 0 && local8 < local5) {
          local5 = local8;
          local6 = local7;
        }
        local7 = local7.alternativa3d::next;
      }
      return local6;
    }
  }
}
