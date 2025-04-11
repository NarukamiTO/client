package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class Object3DContainer extends Object3D {
    public var mouseChildren:Boolean = true;

    alternativa3d var childrenList:Object3D;
    alternativa3d var lightList:Light3D;
    alternativa3d var visibleChildren:Vector.<Object3D> = new Vector.<Object3D>();
    alternativa3d var numVisibleChildren:int = 0;

    public function Object3DContainer() {
      super();
    }

    public function addChild(param1:Object3D) : Object3D {
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
      if(param1.alternativa3d::_parent != null) {
        param1.alternativa3d::_parent.removeChild(param1);
      }
      this.alternativa3d::addToList(param1);
      return param1;
    }

    public function removeChild(param1:Object3D) : Object3D {
      var local2:Object3D = null;
      var local3:Object3D = null;
      if(param1 == null) {
        throw new TypeError("Parameter child must be non-null.");
      }
      if(param1.alternativa3d::_parent != this) {
        throw new ArgumentError("The supplied Object3D must be a child of the caller.");
      }
      local3 = this.alternativa3d::childrenList;
      while(local3 != null) {
        if(local3 == param1) {
          if(local2 != null) {
            local2.alternativa3d::next = local3.alternativa3d::next;
          } else {
            this.alternativa3d::childrenList = local3.alternativa3d::next;
          }
          local3.alternativa3d::next = null;
          local3.alternativa3d::setParent(null);
          return param1;
        }
        local2 = local3;
        local3 = local3.alternativa3d::next;
      }
      throw new ArgumentError("Cannot remove child.");
    }

    public function addChildAt(param1:Object3D, param2:int) : Object3D {
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
      var local4:Object3D = this.alternativa3d::childrenList;
      var local5:int = 0;
      while(local5 < param2) {
        if(local4 == null) {
          throw new RangeError("The supplied index is out of bounds.");
        }
        local4 = local4.alternativa3d::next;
        local5++;
      }
      if(param1.alternativa3d::_parent != null) {
        param1.alternativa3d::_parent.removeChild(param1);
      }
      this.alternativa3d::addToList(param1,local4);
      return param1;
    }

    public function removeChildAt(param1:int) : Object3D {
      if(param1 < 0) {
        throw new RangeError("The supplied index is out of bounds.");
      }
      var local2:Object3D = this.alternativa3d::childrenList;
      var local3:int = 0;
      while(local3 < param1) {
        if(local2 == null) {
          throw new RangeError("The supplied index is out of bounds.");
        }
        local2 = local2.alternativa3d::next;
        local3++;
      }
      if(local2 == null) {
        throw new RangeError("The supplied index is out of bounds.");
      }
      this.removeChild(local2);
      return local2;
    }

    public function getChildAt(param1:int) : Object3D {
      if(param1 < 0) {
        throw new RangeError("The supplied index is out of bounds.");
      }
      var local2:Object3D = this.alternativa3d::childrenList;
      var local3:int = 0;
      while(local3 < param1) {
        if(local2 == null) {
          throw new RangeError("The supplied index is out of bounds.");
        }
        local2 = local2.alternativa3d::next;
        local3++;
      }
      if(local2 == null) {
        throw new RangeError("The supplied index is out of bounds.");
      }
      return local2;
    }

    public function getChildIndex(param1:Object3D) : int {
      if(param1 == null) {
        throw new TypeError("Parameter child must be non-null.");
      }
      if(param1.alternativa3d::_parent != this) {
        throw new ArgumentError("The supplied Object3D must be a child of the caller.");
      }
      var local2:int = 0;
      var local3:Object3D = this.alternativa3d::childrenList;
      while(local3 != null) {
        if(local3 == param1) {
          return local2;
        }
        local2++;
        local3 = local3.alternativa3d::next;
      }
      throw new ArgumentError("Cannot get child index.");
    }

    public function setChildIndex(param1:Object3D, param2:int) : void {
      if(param1 == null) {
        throw new TypeError("Parameter child must be non-null.");
      }
      if(param1.alternativa3d::_parent != this) {
        throw new ArgumentError("The supplied Object3D must be a child of the caller.");
      }
      if(param2 < 0) {
        throw new RangeError("The supplied index is out of bounds.");
      }
      var local3:Object3D = this.alternativa3d::childrenList;
      var local4:int = 0;
      while(local4 < param2) {
        if(local3 == null) {
          throw new RangeError("The supplied index is out of bounds.");
        }
        local3 = local3.alternativa3d::next;
        local4++;
      }
      this.removeChild(param1);
      this.alternativa3d::addToList(param1,local3);
    }

    public function swapChildren(param1:Object3D, param2:Object3D) : void {
      var local3:Object3D = null;
      if(param1 == null || param2 == null) {
        throw new TypeError("Parameter child must be non-null.");
      }
      if(param1.alternativa3d::_parent != this || param2.alternativa3d::_parent != this) {
        throw new ArgumentError("The supplied Object3D must be a child of the caller.");
      }
      if(param1 != param2) {
        if(param1.alternativa3d::next == param2) {
          this.removeChild(param2);
          this.alternativa3d::addToList(param2,param1);
        } else if(param2.alternativa3d::next == param1) {
          this.removeChild(param1);
          this.alternativa3d::addToList(param1,param2);
        } else {
          local3 = param1.alternativa3d::next;
          this.removeChild(param1);
          this.alternativa3d::addToList(param1,param2);
          this.removeChild(param2);
          this.alternativa3d::addToList(param2,local3);
        }
      }
    }

    public function swapChildrenAt(param1:int, param2:int) : void {
      var local3:int = 0;
      var local4:Object3D = null;
      var local5:Object3D = null;
      var local6:Object3D = null;
      if(param1 < 0 || param2 < 0) {
        throw new RangeError("The supplied index is out of bounds.");
      }
      if(param1 != param2) {
        local4 = this.alternativa3d::childrenList;
        local3 = 0;
        while(local3 < param1) {
          if(local4 == null) {
            throw new RangeError("The supplied index is out of bounds.");
          }
          local4 = local4.alternativa3d::next;
          local3++;
        }
        if(local4 == null) {
          throw new RangeError("The supplied index is out of bounds.");
        }
        local5 = this.alternativa3d::childrenList;
        local3 = 0;
        while(local3 < param2) {
          if(local5 == null) {
            throw new RangeError("The supplied index is out of bounds.");
          }
          local5 = local5.alternativa3d::next;
          local3++;
        }
        if(local5 == null) {
          throw new RangeError("The supplied index is out of bounds.");
        }
        if(local4 != local5) {
          if(local4.alternativa3d::next == local5) {
            this.removeChild(local5);
            this.alternativa3d::addToList(local5,local4);
          } else if(local5.alternativa3d::next == local4) {
            this.removeChild(local4);
            this.alternativa3d::addToList(local4,local5);
          } else {
            local6 = local4.alternativa3d::next;
            this.removeChild(local4);
            this.alternativa3d::addToList(local4,local5);
            this.removeChild(local5);
            this.alternativa3d::addToList(local5,local6);
          }
        }
      }
    }

    public function getChildByName(param1:String) : Object3D {
      if(param1 == null) {
        throw new TypeError("Parameter name must be non-null.");
      }
      var local2:Object3D = this.alternativa3d::childrenList;
      while(local2 != null) {
        if(local2.name == param1) {
          return local2;
        }
        local2 = local2.alternativa3d::next;
      }
      return null;
    }

    public function contains(param1:Object3D) : Boolean {
      if(param1 == null) {
        throw new TypeError("Parameter child must be non-null.");
      }
      if(param1 == this) {
        return true;
      }
      var local2:Object3D = this.alternativa3d::childrenList;
      while(local2 != null) {
        if(local2 is Object3DContainer) {
          if((local2 as Object3DContainer).contains(param1)) {
            return true;
          }
        } else if(local2 == param1) {
          return true;
        }
        local2 = local2.alternativa3d::next;
      }
      return false;
    }

    public function get numChildren() : int {
      var local1:int = 0;
      var local2:Object3D = this.alternativa3d::childrenList;
      while(local2 != null) {
        local1++;
        local2 = local2.alternativa3d::next;
      }
      return local1;
    }

    override public function intersectRay(param1:Vector3D, param2:Vector3D, param3:Dictionary = null, param4:Camera3D = null) : RayIntersectionData {
      var local5:Vector3D = null;
      var local6:Vector3D = null;
      var local7:RayIntersectionData = null;
      var local10:RayIntersectionData = null;
      if(param3 != null && Boolean(param3[this])) {
        return null;
      }
      if(!alternativa3d::boundIntersectRay(param1,param2,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
        return null;
      }
      var local8:Number = 1e+22;
      var local9:Object3D = this.alternativa3d::childrenList;
      while(local9 != null) {
        local9.alternativa3d::composeMatrix();
        local9.alternativa3d::invertMatrix();
        if(local5 == null) {
          local5 = new Vector3D();
          local6 = new Vector3D();
        }
        local5.x = local9.alternativa3d::ma * param1.x + local9.alternativa3d::mb * param1.y + local9.alternativa3d::mc * param1.z + local9.alternativa3d::md;
        local5.y = local9.alternativa3d::me * param1.x + local9.alternativa3d::mf * param1.y + local9.alternativa3d::mg * param1.z + local9.alternativa3d::mh;
        local5.z = local9.alternativa3d::mi * param1.x + local9.alternativa3d::mj * param1.y + local9.alternativa3d::mk * param1.z + local9.alternativa3d::ml;
        local6.x = local9.alternativa3d::ma * param2.x + local9.alternativa3d::mb * param2.y + local9.alternativa3d::mc * param2.z;
        local6.y = local9.alternativa3d::me * param2.x + local9.alternativa3d::mf * param2.y + local9.alternativa3d::mg * param2.z;
        local6.z = local9.alternativa3d::mi * param2.x + local9.alternativa3d::mj * param2.y + local9.alternativa3d::mk * param2.z;
        local10 = local9.intersectRay(local5,local6,param3,param4);
        if(local10 != null && local10.time < local8) {
          local8 = local10.time;
          local7 = local10;
        }
        local9 = local9.alternativa3d::next;
      }
      return local7;
    }

    override alternativa3d function checkIntersection(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Dictionary) : Boolean {
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local9:Object3D = this.alternativa3d::childrenList;
      while(local9 != null) {
        if(param8 != null && !param8[local9]) {
          local9.alternativa3d::composeMatrix();
          local9.alternativa3d::invertMatrix();
          local10 = local9.alternativa3d::ma * param1 + local9.alternativa3d::mb * param2 + local9.alternativa3d::mc * param3 + local9.alternativa3d::md;
          local11 = local9.alternativa3d::me * param1 + local9.alternativa3d::mf * param2 + local9.alternativa3d::mg * param3 + local9.alternativa3d::mh;
          local12 = local9.alternativa3d::mi * param1 + local9.alternativa3d::mj * param2 + local9.alternativa3d::mk * param3 + local9.alternativa3d::ml;
          local13 = local9.alternativa3d::ma * param4 + local9.alternativa3d::mb * param5 + local9.alternativa3d::mc * param6;
          local14 = local9.alternativa3d::me * param4 + local9.alternativa3d::mf * param5 + local9.alternativa3d::mg * param6;
          local15 = local9.alternativa3d::mi * param4 + local9.alternativa3d::mj * param5 + local9.alternativa3d::mk * param6;
          if(Boolean(alternativa3d::boundCheckIntersection(local10,local11,local12,local13,local14,local15,param7,local9.boundMinX,local9.boundMinY,local9.boundMinZ,local9.boundMaxX,local9.boundMaxY,local9.boundMaxZ)) && Boolean(local9.alternativa3d::checkIntersection(local10,local11,local12,local13,local14,local15,param7,param8))) {
            return true;
          }
        }
        local9 = local9.alternativa3d::next;
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
      var local9:Object3D = this.alternativa3d::childrenList;
      while(local9 != null) {
        local9.alternativa3d::composeAndAppend(this);
        local9.alternativa3d::collectPlanes(param1,param2,param3,param4,param5,param6,param7);
        local9 = local9.alternativa3d::next;
      }
    }

    override public function clone() : Object3D {
      var local1:Object3DContainer = new Object3DContainer();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      var local4:Object3D = null;
      var local5:Object3D = null;
      super.clonePropertiesFrom(param1);
      var local2:Object3DContainer = param1 as Object3DContainer;
      this.mouseChildren = local2.mouseChildren;
      var local3:Object3D = local2.alternativa3d::childrenList;
      while(local3 != null) {
        local5 = local3.clone();
        if(this.alternativa3d::childrenList != null) {
          local4.alternativa3d::next = local5;
        } else {
          this.alternativa3d::childrenList = local5;
        }
        local4 = local5;
        local5.alternativa3d::setParent(this);
        local3 = local3.alternativa3d::next;
      }
    }

    override alternativa3d function draw(param1:Camera3D) : void {
      var local2:int = 0;
      this.alternativa3d::numVisibleChildren = 0;
      var local3:Object3D = this.alternativa3d::childrenList;
      while(local3 != null) {
        if(local3.visible) {
          local3.alternativa3d::composeAndAppend(this);
          if(local3.alternativa3d::cullingInCamera(param1,alternativa3d::culling) >= 0) {
            local3.alternativa3d::concat(this);
            this.alternativa3d::visibleChildren[this.alternativa3d::numVisibleChildren] = local3;
            ++this.alternativa3d::numVisibleChildren;
          }
        }
        local3 = local3.alternativa3d::next;
      }
      if(this.alternativa3d::numVisibleChildren > 0) {
        if(param1.debug && (local2 = int(param1.alternativa3d::checkInDebug(this))) > 0) {
          if(Boolean(local2 & Debug.BOUNDS)) {
            Debug.alternativa3d::drawBounds(param1,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
          }
        }
        this.alternativa3d::drawVisibleChildren(param1);
      }
    }

    alternativa3d function drawVisibleChildren(param1:Camera3D) : void {
      var local3:Object3D = null;
      var local2:int = this.alternativa3d::numVisibleChildren - 1;
      while(local2 >= 0) {
        local3 = this.alternativa3d::visibleChildren[local2];
        local3.alternativa3d::draw(param1);
        this.alternativa3d::visibleChildren[local2] = null;
        local2--;
      }
    }

    override alternativa3d function getVG(param1:Camera3D) : VG {
      var local2:VG = null;
      var local3:VG = null;
      var local5:VG = null;
      var local4:Object3D = this.alternativa3d::childrenList;
      while(local4 != null) {
        if(local4.visible) {
          local4.alternativa3d::composeAndAppend(this);
          if(local4.alternativa3d::cullingInCamera(param1,alternativa3d::culling) >= 0) {
            local4.alternativa3d::concat(this);
            local5 = local4.alternativa3d::getVG(param1);
            if(local5 != null) {
              if(local2 != null) {
                local3.alternativa3d::next = local5;
              } else {
                local2 = local5;
                local3 = local5;
              }
              while(local3.alternativa3d::next != null) {
                local3 = local3.alternativa3d::next;
              }
            }
          }
        }
        local4 = local4.alternativa3d::next;
      }
      return local2;
    }

    override alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
      var local3:Object3D = this.alternativa3d::childrenList;
      while(local3 != null) {
        if(param2 != null) {
          local3.alternativa3d::composeAndAppend(param2);
        } else {
          local3.alternativa3d::composeMatrix();
        }
        local3.alternativa3d::updateBounds(param1,local3);
        local3 = local3.alternativa3d::next;
      }
    }

    override alternativa3d function split(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Number) : Vector.<Object3D> {
      var local10:Object3D = null;
      var local11:Object3D = null;
      var local13:Object3D = null;
      var local14:Vector3D = null;
      var local15:Vector3D = null;
      var local16:Vector3D = null;
      var local17:int = 0;
      var local18:Vector.<Object3D> = null;
      var local19:Number = NaN;
      var local5:Vector.<Object3D> = new Vector.<Object3D>(2);
      var local6:Vector3D = alternativa3d::calculatePlane(param1,param2,param3);
      var local7:Object3D = this.alternativa3d::childrenList;
      this.alternativa3d::childrenList = null;
      var local8:Object3DContainer = this.clone() as Object3DContainer;
      var local9:Object3DContainer = this.clone() as Object3DContainer;
      var local12:Object3D = local7;
      while(local12 != null) {
        local13 = local12.alternativa3d::next;
        local12.alternativa3d::next = null;
        local12.alternativa3d::setParent(null);
        local12.alternativa3d::composeMatrix();
        local12.alternativa3d::calculateInverseMatrix();
        local14 = new Vector3D(local12.alternativa3d::ima * param1.x + local12.alternativa3d::imb * param1.y + local12.alternativa3d::imc * param1.z + local12.alternativa3d::imd,local12.alternativa3d::ime * param1.x + local12.alternativa3d::imf * param1.y + local12.alternativa3d::img * param1.z + local12.alternativa3d::imh,local12.alternativa3d::imi * param1.x + local12.alternativa3d::imj * param1.y + local12.alternativa3d::imk * param1.z + local12.alternativa3d::iml);
        local15 = new Vector3D(local12.alternativa3d::ima * param2.x + local12.alternativa3d::imb * param2.y + local12.alternativa3d::imc * param2.z + local12.alternativa3d::imd,local12.alternativa3d::ime * param2.x + local12.alternativa3d::imf * param2.y + local12.alternativa3d::img * param2.z + local12.alternativa3d::imh,local12.alternativa3d::imi * param2.x + local12.alternativa3d::imj * param2.y + local12.alternativa3d::imk * param2.z + local12.alternativa3d::iml);
        local16 = new Vector3D(local12.alternativa3d::ima * param3.x + local12.alternativa3d::imb * param3.y + local12.alternativa3d::imc * param3.z + local12.alternativa3d::imd,local12.alternativa3d::ime * param3.x + local12.alternativa3d::imf * param3.y + local12.alternativa3d::img * param3.z + local12.alternativa3d::imh,local12.alternativa3d::imi * param3.x + local12.alternativa3d::imj * param3.y + local12.alternativa3d::imk * param3.z + local12.alternativa3d::iml);
        local17 = int(local12.alternativa3d::testSplit(local14,local15,local16,param4));
        if(local17 < 0) {
          if(local10 != null) {
            local10.alternativa3d::next = local12;
          } else {
            local8.alternativa3d::childrenList = local12;
          }
          local10 = local12;
          local12.alternativa3d::setParent(local8);
        } else if(local17 > 0) {
          if(local11 != null) {
            local11.alternativa3d::next = local12;
          } else {
            local9.alternativa3d::childrenList = local12;
          }
          local11 = local12;
          local12.alternativa3d::setParent(local9);
        } else {
          local18 = local12.alternativa3d::split(local14,local15,local16,param4);
          local19 = Number(local12.alternativa3d::distance);
          if(local18[0] != null) {
            local12 = local18[0];
            if(local10 != null) {
              local10.alternativa3d::next = local12;
            } else {
              local8.alternativa3d::childrenList = local12;
            }
            local10 = local12;
            local12.alternativa3d::setParent(local8);
            local12.alternativa3d::distance = local19;
          }
          if(local18[1] != null) {
            local12 = local18[1];
            if(local11 != null) {
              local11.alternativa3d::next = local12;
            } else {
              local9.alternativa3d::childrenList = local12;
            }
            local11 = local12;
            local12.alternativa3d::setParent(local9);
            local12.alternativa3d::distance = local19;
          }
        }
        local12 = local13;
      }
      if(local10 != null) {
        local8.calculateBounds();
        local5[0] = local8;
      }
      if(local11 != null) {
        local9.calculateBounds();
        local5[1] = local9;
      }
      return local5;
    }

    alternativa3d function addToList(param1:Object3D, param2:Object3D = null) : void {
      var local3:Object3D = null;
      param1.alternativa3d::next = param2;
      param1.alternativa3d::setParent(this);
      if(param2 == this.alternativa3d::childrenList) {
        this.alternativa3d::childrenList = param1;
      } else {
        local3 = this.alternativa3d::childrenList;
        while(local3 != null) {
          if(local3.alternativa3d::next == param2) {
            local3.alternativa3d::next = param1;
            break;
          }
          local3 = local3.alternativa3d::next;
        }
      }
    }

    override alternativa3d function setParent(param1:Object3DContainer) : void {
      var local2:Object3DContainer = null;
      var local3:Light3D = null;
      if(param1 == null) {
        local2 = alternativa3d::_parent;
        while(local2.alternativa3d::_parent != null) {
          local2 = local2.alternativa3d::_parent;
        }
        if(local2.alternativa3d::lightList != null) {
          this.transferLights(local2,this);
        }
      } else if(this.alternativa3d::lightList != null) {
        local2 = param1;
        while(local2.alternativa3d::_parent != null) {
          local2 = local2.alternativa3d::_parent;
        }
        local3 = this.alternativa3d::lightList;
        while(local3.alternativa3d::nextLight != null) {
          local3 = local3.alternativa3d::nextLight;
        }
        local3.alternativa3d::nextLight = local2.alternativa3d::lightList;
        local2.alternativa3d::lightList = this.alternativa3d::lightList;
        this.alternativa3d::lightList = null;
      }
      alternativa3d::_parent = param1;
    }

    private function transferLights(param1:Object3DContainer, param2:Object3DContainer) : void {
      var local4:Light3D = null;
      var local5:Light3D = null;
      var local6:Light3D = null;
      var local3:Object3D = this.alternativa3d::childrenList;
      while(local3 != null) {
        if(local3 is Light3D) {
          local4 = local3 as Light3D;
          local5 = null;
          local6 = param1.alternativa3d::lightList;
          while(local6 != null) {
            if(local6 == local4) {
              if(local5 != null) {
                local5.alternativa3d::nextLight = local6.alternativa3d::nextLight;
              } else {
                param1.alternativa3d::lightList = local6.alternativa3d::nextLight;
              }
              local6.alternativa3d::nextLight = param2.alternativa3d::lightList;
              param2.alternativa3d::lightList = local6;
              break;
            }
            local5 = local6;
            local6 = local6.alternativa3d::nextLight;
          }
        } else if(local3 is Object3DContainer) {
          (local3 as Object3DContainer).transferLights(param1,param2);
        }
        if(param1.alternativa3d::lightList == null) {
          break;
        }
        local3 = local3.alternativa3d::next;
      }
    }
  }
}
