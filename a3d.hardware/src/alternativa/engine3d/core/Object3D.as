package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
  import flash.geom.ColorTransform;
  import flash.geom.Matrix3D;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;
  import flash.utils.getQualifiedClassName;

  use namespace alternativa3d;

  [Event(name="mouseWheel",type="alternativa.engine3d.core.MouseEvent3D")]
  [Event(name="mouseMove",type="alternativa.engine3d.core.MouseEvent3D")]
  [Event(name="rollOut",type="alternativa.engine3d.core.MouseEvent3D")]
  [Event(name="rollOver",type="alternativa.engine3d.core.MouseEvent3D")]
  [Event(name="mouseOut",type="alternativa.engine3d.core.MouseEvent3D")]
  [Event(name="mouseOver",type="alternativa.engine3d.core.MouseEvent3D")]
  [Event(name="mouseUp",type="alternativa.engine3d.core.MouseEvent3D")]
  [Event(name="mouseDown",type="alternativa.engine3d.core.MouseEvent3D")]
  [Event(name="doubleClick",type="alternativa.engine3d.core.MouseEvent3D")]
  [Event(name="click",type="alternativa.engine3d.core.MouseEvent3D")]
  public class Object3D implements IEventDispatcher {
    alternativa3d static const boundVertexList:Vertex = Vertex.alternativa3d::createList(8);
    alternativa3d static const tA:Object3D = new Object3D();
    alternativa3d static const tB:Object3D = new Object3D();

    private static const staticSphere:Vector3D = new Vector3D();

    public var x:Number = 0;
    public var y:Number = 0;
    public var z:Number = 0;
    public var rotationX:Number = 0;
    public var rotationY:Number = 0;
    public var rotationZ:Number = 0;
    public var scaleX:Number = 1;
    public var scaleY:Number = 1;
    public var scaleZ:Number = 1;
    public var name:String;
    public var visible:Boolean = true;
    public var alpha:Number = 1;
    public var blendMode:String = "normal";
    public var colorTransform:ColorTransform = null;
    public var filters:Array = null;
    public var mouseEnabled:Boolean = true;
    public var doubleClickEnabled:Boolean = false;
    public var useHandCursor:Boolean = false;
    public var depthMapAlphaThreshold:Number = 1;
    public var shadowMapAlphaThreshold:Number = 1;
    public var softAttenuation:Number = 0;
    public var useShadowMap:Boolean = true;
    public var useLight:Boolean = true;
    public var boundMinX:Number = -1e+22;
    public var boundMinY:Number = -1e+22;
    public var boundMinZ:Number = -1e+22;
    public var boundMaxX:Number = 1e+22;
    public var boundMaxY:Number = 1e+22;
    public var boundMaxZ:Number = 1e+22;

    alternativa3d var ma:Number;
    alternativa3d var mb:Number;
    alternativa3d var mc:Number;
    alternativa3d var md:Number;
    alternativa3d var me:Number;
    alternativa3d var mf:Number;
    alternativa3d var mg:Number;
    alternativa3d var mh:Number;
    alternativa3d var mi:Number;
    alternativa3d var mj:Number;
    alternativa3d var mk:Number;
    alternativa3d var ml:Number;
    alternativa3d var ima:Number;
    alternativa3d var imb:Number;
    alternativa3d var imc:Number;
    alternativa3d var imd:Number;
    alternativa3d var ime:Number;
    alternativa3d var imf:Number;
    alternativa3d var img:Number;
    alternativa3d var imh:Number;
    alternativa3d var imi:Number;
    alternativa3d var imj:Number;
    alternativa3d var imk:Number;
    alternativa3d var iml:Number;
    alternativa3d var _parent:Object3DContainer;
    alternativa3d var next:Object3D;
    alternativa3d var culling:int = 0;
    alternativa3d var transformId:int = 0;
    alternativa3d var distance:Number;
    alternativa3d var concatenatedAlpha:Number = 1;
    alternativa3d var concatenatedBlendMode:String = "normal";
    alternativa3d var concatenatedColorTransform:ColorTransform = null;
    alternativa3d var bubbleListeners:Object;
    alternativa3d var captureListeners:Object;
    alternativa3d var useDepth:Boolean = false;
    alternativa3d var transformConst:Vector.<Number> = new Vector.<Number>(12);
    alternativa3d var colorConst:Vector.<Number> = Vector.<Number>([0,0,0,1,0,0,0,1]);

    public function Object3D() {
      super();
    }

    public function get matrix() : Matrix3D {
      alternativa3d::tA.alternativa3d::composeMatrixFromSource(this);
      return new Matrix3D(Vector.<Number>([alternativa3d::tA.alternativa3d::ma,alternativa3d::tA.alternativa3d::me,alternativa3d::tA.alternativa3d::mi,0,alternativa3d::tA.alternativa3d::mb,alternativa3d::tA.alternativa3d::mf,alternativa3d::tA.alternativa3d::mj,0,alternativa3d::tA.alternativa3d::mc,alternativa3d::tA.alternativa3d::mg,alternativa3d::tA.alternativa3d::mk,0,alternativa3d::tA.alternativa3d::md,alternativa3d::tA.alternativa3d::mh,alternativa3d::tA.alternativa3d::ml,1]));
    }

    public function set matrix(param1:Matrix3D) : void {
      var local2:Vector.<Vector3D> = param1.decompose();
      var local3:Vector3D = local2[0];
      var local4:Vector3D = local2[1];
      var local5:Vector3D = local2[2];
      this.x = local3.x;
      this.y = local3.y;
      this.z = local3.z;
      this.rotationX = local4.x;
      this.rotationY = local4.y;
      this.rotationZ = local4.z;
      this.scaleX = local5.x;
      this.scaleY = local5.y;
      this.scaleZ = local5.z;
    }

    public function get concatenatedMatrix() : Matrix3D {
      alternativa3d::tA.alternativa3d::composeMatrixFromSource(this);
      var local1:Object3D = this;
      while(local1.alternativa3d::_parent != null) {
        local1 = local1.alternativa3d::_parent;
        alternativa3d::tB.alternativa3d::composeMatrixFromSource(local1);
        alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
      }
      return new Matrix3D(Vector.<Number>([alternativa3d::tA.alternativa3d::ma,alternativa3d::tA.alternativa3d::me,alternativa3d::tA.alternativa3d::mi,0,alternativa3d::tA.alternativa3d::mb,alternativa3d::tA.alternativa3d::mf,alternativa3d::tA.alternativa3d::mj,0,alternativa3d::tA.alternativa3d::mc,alternativa3d::tA.alternativa3d::mg,alternativa3d::tA.alternativa3d::mk,0,alternativa3d::tA.alternativa3d::md,alternativa3d::tA.alternativa3d::mh,alternativa3d::tA.alternativa3d::ml,1]));
    }

    public function localToGlobal(param1:Vector3D) : Vector3D {
      alternativa3d::tA.alternativa3d::composeMatrixFromSource(this);
      var local2:Object3D = this;
      while(local2.alternativa3d::_parent != null) {
        local2 = local2.alternativa3d::_parent;
        alternativa3d::tB.alternativa3d::composeMatrixFromSource(local2);
        alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
      }
      var local3:Vector3D = new Vector3D();
      local3.x = alternativa3d::tA.alternativa3d::ma * param1.x + alternativa3d::tA.alternativa3d::mb * param1.y + alternativa3d::tA.alternativa3d::mc * param1.z + alternativa3d::tA.alternativa3d::md;
      local3.y = alternativa3d::tA.alternativa3d::me * param1.x + alternativa3d::tA.alternativa3d::mf * param1.y + alternativa3d::tA.alternativa3d::mg * param1.z + alternativa3d::tA.alternativa3d::mh;
      local3.z = alternativa3d::tA.alternativa3d::mi * param1.x + alternativa3d::tA.alternativa3d::mj * param1.y + alternativa3d::tA.alternativa3d::mk * param1.z + alternativa3d::tA.alternativa3d::ml;
      return local3;
    }

    public function globalToLocal(param1:Vector3D) : Vector3D {
      alternativa3d::tA.alternativa3d::composeMatrixFromSource(this);
      var local2:Object3D = this;
      while(local2.alternativa3d::_parent != null) {
        local2 = local2.alternativa3d::_parent;
        alternativa3d::tB.alternativa3d::composeMatrixFromSource(local2);
        alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
      }
      alternativa3d::tA.alternativa3d::invertMatrix();
      var local3:Vector3D = new Vector3D();
      local3.x = alternativa3d::tA.alternativa3d::ma * param1.x + alternativa3d::tA.alternativa3d::mb * param1.y + alternativa3d::tA.alternativa3d::mc * param1.z + alternativa3d::tA.alternativa3d::md;
      local3.y = alternativa3d::tA.alternativa3d::me * param1.x + alternativa3d::tA.alternativa3d::mf * param1.y + alternativa3d::tA.alternativa3d::mg * param1.z + alternativa3d::tA.alternativa3d::mh;
      local3.z = alternativa3d::tA.alternativa3d::mi * param1.x + alternativa3d::tA.alternativa3d::mj * param1.y + alternativa3d::tA.alternativa3d::mk * param1.z + alternativa3d::tA.alternativa3d::ml;
      return local3;
    }

    public function get parent() : Object3DContainer {
      return this.alternativa3d::_parent;
    }

    alternativa3d function setParent(param1:Object3DContainer) : void {
      this.alternativa3d::_parent = param1;
    }

    public function calculateBounds() : void {
      this.boundMinX = 1e+22;
      this.boundMinY = 1e+22;
      this.boundMinZ = 1e+22;
      this.boundMaxX = -1e+22;
      this.boundMaxY = -1e+22;
      this.boundMaxZ = -1e+22;
      this.alternativa3d::updateBounds(this,null);
      if(this.boundMinX > this.boundMaxX) {
        this.boundMinX = -1e+22;
        this.boundMinY = -1e+22;
        this.boundMinZ = -1e+22;
        this.boundMaxX = 1e+22;
        this.boundMaxY = 1e+22;
        this.boundMaxZ = 1e+22;
      }
    }

    public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void {
      var local6:Object = null;
      if(param2 == null) {
        throw new TypeError("Parameter listener must be non-null.");
      }
      if(param3) {
        if(this.alternativa3d::captureListeners == null) {
          this.alternativa3d::captureListeners = new Object();
        }
        local6 = this.alternativa3d::captureListeners;
      } else {
        if(this.alternativa3d::bubbleListeners == null) {
          this.alternativa3d::bubbleListeners = new Object();
        }
        local6 = this.alternativa3d::bubbleListeners;
      }
      var local7:Vector.<Function> = local6[param1];
      if(local7 == null) {
        local7 = new Vector.<Function>();
        local6[param1] = local7;
      }
      if(local7.indexOf(param2) < 0) {
        local7.push(param2);
      }
    }

    public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void {
      var local5:Vector.<Function> = null;
      var local6:int = 0;
      var local7:int = 0;
      var local8:int = 0;
      var local9:* = undefined;
      if(param2 == null) {
        throw new TypeError("Parameter listener must be non-null.");
      }
      var local4:Object = param3 ? this.alternativa3d::captureListeners : this.alternativa3d::bubbleListeners;
      if(local4 != null) {
        local5 = local4[param1];
        if(local5 != null) {
          local6 = int(local5.indexOf(param2));
          if(local6 >= 0) {
            local7 = int(local5.length);
            local8 = local6 + 1;
            while(local8 < local7) {
              local5[local6] = local5[local8];
              local8++;
              local6++;
            }
            if(local7 > 1) {
              local5.length = local7 - 1;
            } else {
              delete local4[param1];
              var local10:int = 0;
              var local11:* = local4;
              for(local9 in local11) {
              }
              if(!local9) {
                if(local4 == this.alternativa3d::captureListeners) {
                  this.alternativa3d::captureListeners = null;
                } else {
                  this.alternativa3d::bubbleListeners = null;
                }
              }
            }
          }
        }
      }
    }

    public function hasEventListener(param1:String) : Boolean {
      return this.alternativa3d::captureListeners != null && Boolean(this.alternativa3d::captureListeners[param1]) || this.alternativa3d::bubbleListeners != null && Boolean(this.alternativa3d::bubbleListeners[param1]);
    }

    public function willTrigger(param1:String) : Boolean {
      var local2:Object3D = this;
      while(local2 != null) {
        if(local2.alternativa3d::captureListeners != null && local2.alternativa3d::captureListeners[param1] || local2.alternativa3d::bubbleListeners != null && local2.alternativa3d::bubbleListeners[param1]) {
          return true;
        }
        local2 = local2.alternativa3d::_parent;
      }
      return false;
    }

    public function dispatchEvent(param1:Event) : Boolean {
      var local4:Object3D = null;
      var local6:Vector.<Function> = null;
      var local7:int = 0;
      var local8:int = 0;
      var local9:Vector.<Function> = null;
      if(param1 == null) {
        throw new TypeError("Parameter event must be non-null.");
      }
      if(param1 is MouseEvent3D) {
        MouseEvent3D(param1).alternativa3d::_target = this;
      }
      var local2:Vector.<Object3D> = new Vector.<Object3D>();
      var local3:int = 0;
      local4 = this;
      while(local4 != null) {
        local2[local3] = local4;
        local3++;
        local4 = local4.alternativa3d::_parent;
      }
      var local5:int = 0;
      while(local5 < local3) {
        local4 = local2[local5];
        if(param1 is MouseEvent3D) {
          MouseEvent3D(param1).alternativa3d::_currentTarget = local4;
        }
        if(this.alternativa3d::bubbleListeners != null) {
          local6 = this.alternativa3d::bubbleListeners[param1.type];
          if(local6 != null) {
            local8 = int(local6.length);
            local9 = new Vector.<Function>();
            local7 = 0;
            while(local7 < local8) {
              local9[local7] = local6[local7];
              local7++;
            }
            local7 = 0;
            while(local7 < local8) {
              (local9[local7] as Function).call(null,param1);
              local7++;
            }
          }
        }
        if(!param1.bubbles) {
          break;
        }
        local5++;
      }
      return true;
    }

    public function calculateResolution(param1:int, param2:int, param3:int = 1, param4:Matrix3D = null) : Number {
      return 1;
    }

    public function intersectRay(param1:Vector3D, param2:Vector3D, param3:Dictionary = null, param4:Camera3D = null) : RayIntersectionData {
      return null;
    }

    alternativa3d function checkIntersection(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Dictionary) : Boolean {
      return false;
    }

    alternativa3d function boundCheckIntersection(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number) : Boolean {
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local14:Number = param1 + param4 * param7;
      var local15:Number = param2 + param5 * param7;
      var local16:Number = param3 + param6 * param7;
      if(param1 >= param8 && param1 <= param11 && param2 >= param9 && param2 <= param12 && param3 >= param10 && param3 <= param13 || local14 >= param8 && local14 <= param11 && local15 >= param9 && local15 <= param12 && local16 >= param10 && local16 <= param13) {
        return true;
      }
      if(param1 < param8 && local14 < param8 || param1 > param11 && local14 > param11 || param2 < param9 && local15 < param9 || param2 > param12 && local15 > param12 || param3 < param10 && local16 < param10 || param3 > param13 && local16 > param13) {
        return false;
      }
      var local21:Number = 0.000001;
      if(param4 > local21) {
        local17 = (param8 - param1) / param4;
        local18 = (param11 - param1) / param4;
      } else if(param4 < -local21) {
        local17 = (param11 - param1) / param4;
        local18 = (param8 - param1) / param4;
      } else {
        local17 = 0;
        local18 = param7;
      }
      if(param5 > local21) {
        local19 = (param9 - param2) / param5;
        local20 = (param12 - param2) / param5;
      } else if(param5 < -local21) {
        local19 = (param12 - param2) / param5;
        local20 = (param9 - param2) / param5;
      } else {
        local19 = 0;
        local20 = param7;
      }
      if(local19 >= local18 || local20 <= local17) {
        return false;
      }
      if(local19 < local17) {
        if(local20 < local18) {
          local18 = local20;
        }
      } else {
        local17 = local19;
        if(local20 < local18) {
          local18 = local20;
        }
      }
      if(param6 > local21) {
        local19 = (param10 - param3) / param6;
        local20 = (param13 - param3) / param6;
      } else if(param6 < -local21) {
        local19 = (param13 - param3) / param6;
        local20 = (param10 - param3) / param6;
      } else {
        local19 = 0;
        local20 = param7;
      }
      if(local19 >= local18 || local20 <= local17) {
        return false;
      }
      return true;
    }

    public function clone() : Object3D {
      var local1:Object3D = new Object3D();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    protected function clonePropertiesFrom(param1:Object3D) : void {
      this.name = param1.name;
      this.visible = param1.visible;
      this.alpha = param1.alpha;
      this.blendMode = param1.blendMode;
      this.mouseEnabled = param1.mouseEnabled;
      this.doubleClickEnabled = param1.doubleClickEnabled;
      this.useHandCursor = param1.useHandCursor;
      this.depthMapAlphaThreshold = param1.depthMapAlphaThreshold;
      this.shadowMapAlphaThreshold = param1.shadowMapAlphaThreshold;
      this.softAttenuation = param1.softAttenuation;
      this.useShadowMap = param1.useShadowMap;
      this.useLight = param1.useLight;
      this.alternativa3d::transformId = param1.alternativa3d::transformId;
      this.alternativa3d::distance = param1.alternativa3d::distance;
      if(param1.colorTransform != null) {
        this.colorTransform = new ColorTransform();
        this.colorTransform.concat(param1.colorTransform);
      }
      if(param1.filters != null) {
        this.filters = new Array().concat(param1.filters);
      }
      this.x = param1.x;
      this.y = param1.y;
      this.z = param1.z;
      this.rotationX = param1.rotationX;
      this.rotationY = param1.rotationY;
      this.rotationZ = param1.rotationZ;
      this.scaleX = param1.scaleX;
      this.scaleY = param1.scaleY;
      this.scaleZ = param1.scaleZ;
      this.boundMinX = param1.boundMinX;
      this.boundMinY = param1.boundMinY;
      this.boundMinZ = param1.boundMinZ;
      this.boundMaxX = param1.boundMaxX;
      this.boundMaxY = param1.boundMaxY;
      this.boundMaxZ = param1.boundMaxZ;
    }

    public function toString() : String {
      var local1:String = getQualifiedClassName(this);
      return "[" + local1.substr(local1.indexOf("::") + 2) + " " + this.name + "]";
    }

    alternativa3d function draw(param1:Camera3D) : void {
    }

    alternativa3d function getVG(param1:Camera3D) : VG {
      return null;
    }

    alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
    }

    alternativa3d function concat(param1:Object3DContainer) : void {
      this.alternativa3d::concatenatedAlpha = param1.alternativa3d::concatenatedAlpha * this.alpha;
      this.alternativa3d::concatenatedBlendMode = param1.alternativa3d::concatenatedBlendMode != "normal" ? param1.alternativa3d::concatenatedBlendMode : this.blendMode;
      if(param1.alternativa3d::concatenatedColorTransform != null) {
        if(this.colorTransform != null) {
          this.alternativa3d::concatenatedColorTransform = new ColorTransform();
          this.alternativa3d::concatenatedColorTransform.redMultiplier = param1.alternativa3d::concatenatedColorTransform.redMultiplier;
          this.alternativa3d::concatenatedColorTransform.greenMultiplier = param1.alternativa3d::concatenatedColorTransform.greenMultiplier;
          this.alternativa3d::concatenatedColorTransform.blueMultiplier = param1.alternativa3d::concatenatedColorTransform.blueMultiplier;
          this.alternativa3d::concatenatedColorTransform.redOffset = param1.alternativa3d::concatenatedColorTransform.redOffset;
          this.alternativa3d::concatenatedColorTransform.greenOffset = param1.alternativa3d::concatenatedColorTransform.greenOffset;
          this.alternativa3d::concatenatedColorTransform.blueOffset = param1.alternativa3d::concatenatedColorTransform.blueOffset;
          this.alternativa3d::concatenatedColorTransform.concat(this.colorTransform);
        } else {
          this.alternativa3d::concatenatedColorTransform = param1.alternativa3d::concatenatedColorTransform;
        }
      } else {
        this.alternativa3d::concatenatedColorTransform = this.colorTransform;
      }
      if(this.alternativa3d::concatenatedColorTransform != null) {
        this.alternativa3d::colorConst[0] = this.alternativa3d::concatenatedColorTransform.redMultiplier;
        this.alternativa3d::colorConst[1] = this.alternativa3d::concatenatedColorTransform.greenMultiplier;
        this.alternativa3d::colorConst[2] = this.alternativa3d::concatenatedColorTransform.blueMultiplier;
        this.alternativa3d::colorConst[3] = this.alternativa3d::concatenatedAlpha;
        this.alternativa3d::colorConst[4] = this.alternativa3d::concatenatedColorTransform.redOffset / 255;
        this.alternativa3d::colorConst[5] = this.alternativa3d::concatenatedColorTransform.greenOffset / 255;
        this.alternativa3d::colorConst[6] = this.alternativa3d::concatenatedColorTransform.blueOffset / 255;
      } else {
        this.alternativa3d::colorConst[3] = this.alternativa3d::concatenatedAlpha;
      }
    }

    alternativa3d function boundIntersectRay(param1:Vector3D, param2:Vector3D, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Boolean {
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      if(param1.x >= param3 && param1.x <= param6 && param1.y >= param4 && param1.y <= param7 && param1.z >= param5 && param1.z <= param8) {
        return true;
      }
      if(param1.x < param3 && param2.x <= 0 || param1.x > param6 && param2.x >= 0 || param1.y < param4 && param2.y <= 0 || param1.y > param7 && param2.y >= 0 || param1.z < param5 && param2.z <= 0 || param1.z > param8 && param2.z >= 0) {
        return false;
      }
      var local13:Number = 0.000001;
      if(param2.x > local13) {
        local9 = (param3 - param1.x) / param2.x;
        local10 = (param6 - param1.x) / param2.x;
      } else if(param2.x < -local13) {
        local9 = (param6 - param1.x) / param2.x;
        local10 = (param3 - param1.x) / param2.x;
      } else {
        local9 = 0;
        local10 = 1e+22;
      }
      if(param2.y > local13) {
        local11 = (param4 - param1.y) / param2.y;
        local12 = (param7 - param1.y) / param2.y;
      } else if(param2.y < -local13) {
        local11 = (param7 - param1.y) / param2.y;
        local12 = (param4 - param1.y) / param2.y;
      } else {
        local11 = 0;
        local12 = 1e+22;
      }
      if(local11 >= local10 || local12 <= local9) {
        return false;
      }
      if(local11 < local9) {
        if(local12 < local10) {
          local10 = local12;
        }
      } else {
        local9 = local11;
        if(local12 < local10) {
          local10 = local12;
        }
      }
      if(param2.z > local13) {
        local11 = (param5 - param1.z) / param2.z;
        local12 = (param8 - param1.z) / param2.z;
      } else if(param2.z < -local13) {
        local11 = (param8 - param1.z) / param2.z;
        local12 = (param5 - param1.z) / param2.z;
      } else {
        local11 = 0;
        local12 = 1e+22;
      }
      if(local11 >= local10 || local12 <= local9) {
        return false;
      }
      return true;
    }

    alternativa3d function collectPlanes(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:Vector3D, param6:Vector.<Face>, param7:Dictionary = null) : void {
    }

    alternativa3d function calculateSphere(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:Vector3D, param6:Vector3D = null) : Vector3D {
      this.alternativa3d::calculateInverseMatrix();
      var local7:Number = this.alternativa3d::ima * param1.x + this.alternativa3d::imb * param1.y + this.alternativa3d::imc * param1.z + this.alternativa3d::imd;
      var local8:Number = this.alternativa3d::ime * param1.x + this.alternativa3d::imf * param1.y + this.alternativa3d::img * param1.z + this.alternativa3d::imh;
      var local9:Number = this.alternativa3d::imi * param1.x + this.alternativa3d::imj * param1.y + this.alternativa3d::imk * param1.z + this.alternativa3d::iml;
      var local10:Number = this.alternativa3d::ima * param2.x + this.alternativa3d::imb * param2.y + this.alternativa3d::imc * param2.z + this.alternativa3d::imd;
      var local11:Number = this.alternativa3d::ime * param2.x + this.alternativa3d::imf * param2.y + this.alternativa3d::img * param2.z + this.alternativa3d::imh;
      var local12:Number = this.alternativa3d::imi * param2.x + this.alternativa3d::imj * param2.y + this.alternativa3d::imk * param2.z + this.alternativa3d::iml;
      var local13:Number = this.alternativa3d::ima * param3.x + this.alternativa3d::imb * param3.y + this.alternativa3d::imc * param3.z + this.alternativa3d::imd;
      var local14:Number = this.alternativa3d::ime * param3.x + this.alternativa3d::imf * param3.y + this.alternativa3d::img * param3.z + this.alternativa3d::imh;
      var local15:Number = this.alternativa3d::imi * param3.x + this.alternativa3d::imj * param3.y + this.alternativa3d::imk * param3.z + this.alternativa3d::iml;
      var local16:Number = this.alternativa3d::ima * param4.x + this.alternativa3d::imb * param4.y + this.alternativa3d::imc * param4.z + this.alternativa3d::imd;
      var local17:Number = this.alternativa3d::ime * param4.x + this.alternativa3d::imf * param4.y + this.alternativa3d::img * param4.z + this.alternativa3d::imh;
      var local18:Number = this.alternativa3d::imi * param4.x + this.alternativa3d::imj * param4.y + this.alternativa3d::imk * param4.z + this.alternativa3d::iml;
      var local19:Number = this.alternativa3d::ima * param5.x + this.alternativa3d::imb * param5.y + this.alternativa3d::imc * param5.z + this.alternativa3d::imd;
      var local20:Number = this.alternativa3d::ime * param5.x + this.alternativa3d::imf * param5.y + this.alternativa3d::img * param5.z + this.alternativa3d::imh;
      var local21:Number = this.alternativa3d::imi * param5.x + this.alternativa3d::imj * param5.y + this.alternativa3d::imk * param5.z + this.alternativa3d::iml;
      var local22:Number = local10 - local7;
      var local23:Number = local11 - local8;
      var local24:Number = local12 - local9;
      var local25:Number = local22 * local22 + local23 * local23 + local24 * local24;
      local22 = local13 - local7;
      local23 = local14 - local8;
      local24 = local15 - local9;
      var local26:Number = local22 * local22 + local23 * local23 + local24 * local24;
      if(local26 > local25) {
        local25 = local26;
      }
      local22 = local16 - local7;
      local23 = local17 - local8;
      local24 = local18 - local9;
      local26 = local22 * local22 + local23 * local23 + local24 * local24;
      if(local26 > local25) {
        local25 = local26;
      }
      local22 = local19 - local7;
      local23 = local20 - local8;
      local24 = local21 - local9;
      local26 = local22 * local22 + local23 * local23 + local24 * local24;
      if(local26 > local25) {
        local25 = local26;
      }
      if(param6 == null) {
        param6 = staticSphere;
      }
      param6.x = local7;
      param6.y = local8;
      param6.z = local9;
      param6.w = Math.sqrt(local25);
      return param6;
    }

    alternativa3d function boundIntersectSphere(param1:Vector3D, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Boolean {
      return param1.x + param1.w > param2 && param1.x - param1.w < param5 && param1.y + param1.w > param3 && param1.y - param1.w < param6 && param1.z + param1.w > param4 && param1.z - param1.w < param7;
    }

    alternativa3d function split(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Number) : Vector.<Object3D> {
      return new Vector.<Object3D>(2);
    }

    alternativa3d function testSplit(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Number) : int {
      var local5:Vector3D = this.alternativa3d::calculatePlane(param1,param2,param3);
      if(local5.x >= 0) {
        if(local5.y >= 0) {
          if(local5.z >= 0) {
            if(this.boundMaxX * local5.x + this.boundMaxY * local5.y + this.boundMaxZ * local5.z <= local5.w + param4) {
              return -1;
            }
            if(this.boundMinX * local5.x + this.boundMinY * local5.y + this.boundMinZ * local5.z >= local5.w - param4) {
              return 1;
            }
          } else {
            if(this.boundMaxX * local5.x + this.boundMaxY * local5.y + this.boundMinZ * local5.z <= local5.w + param4) {
              return -1;
            }
            if(this.boundMinX * local5.x + this.boundMinY * local5.y + this.boundMaxZ * local5.z >= local5.w - param4) {
              return 1;
            }
          }
        } else if(local5.z >= 0) {
          if(this.boundMaxX * local5.x + this.boundMinY * local5.y + this.boundMaxZ * local5.z <= local5.w + param4) {
            return -1;
          }
          if(this.boundMinX * local5.x + this.boundMaxY * local5.y + this.boundMinZ * local5.z >= local5.w - param4) {
            return 1;
          }
        } else {
          if(this.boundMaxX * local5.x + this.boundMinY * local5.y + this.boundMinZ * local5.z <= local5.w + param4) {
            return -1;
          }
          if(this.boundMinX * local5.x + this.boundMaxY * local5.y + this.boundMaxZ * local5.z >= local5.w - param4) {
            return 1;
          }
        }
      } else if(local5.y >= 0) {
        if(local5.z >= 0) {
          if(this.boundMinX * local5.x + this.boundMaxY * local5.y + this.boundMaxZ * local5.z <= local5.w + param4) {
            return -1;
          }
          if(this.boundMaxX * local5.x + this.boundMinY * local5.y + this.boundMinZ * local5.z >= local5.w - param4) {
            return 1;
          }
        } else {
          if(this.boundMinX * local5.x + this.boundMaxY * local5.y + this.boundMinZ * local5.z <= local5.w + param4) {
            return -1;
          }
          if(this.boundMaxX * local5.x + this.boundMinY * local5.y + this.boundMaxZ * local5.z >= local5.w - param4) {
            return 1;
          }
        }
      } else if(local5.z >= 0) {
        if(this.boundMinX * local5.x + this.boundMinY * local5.y + this.boundMaxZ * local5.z <= local5.w + param4) {
          return -1;
        }
        if(this.boundMaxX * local5.x + this.boundMaxY * local5.y + this.boundMinZ * local5.z >= local5.w - param4) {
          return 1;
        }
      } else {
        if(this.boundMinX * local5.x + this.boundMinY * local5.y + this.boundMinZ * local5.z <= local5.w + param4) {
          return -1;
        }
        if(this.boundMaxX * local5.x + this.boundMaxY * local5.y + this.boundMaxZ * local5.z >= local5.w - param4) {
          return 1;
        }
      }
      return 0;
    }

    alternativa3d function calculatePlane(param1:Vector3D, param2:Vector3D, param3:Vector3D) : Vector3D {
      var local4:Vector3D = new Vector3D();
      var local5:Number = param2.x - param1.x;
      var local6:Number = param2.y - param1.y;
      var local7:Number = param2.z - param1.z;
      var local8:Number = param3.x - param1.x;
      var local9:Number = param3.y - param1.y;
      var local10:Number = param3.z - param1.z;
      local4.x = local10 * local6 - local9 * local7;
      local4.y = local8 * local7 - local10 * local5;
      local4.z = local9 * local5 - local8 * local6;
      var local11:Number = local4.x * local4.x + local4.y * local4.y + local4.z * local4.z;
      if(local11 > 0.0001) {
        local11 = Math.sqrt(local11);
        local4.x /= local11;
        local4.y /= local11;
        local4.z /= local11;
      }
      local4.w = param1.x * local4.x + param1.y * local4.y + param1.z * local4.z;
      return local4;
    }

    alternativa3d function composeMatrix() : void {
      var local1:Number = Math.cos(this.rotationX);
      var local2:Number = Math.sin(this.rotationX);
      var local3:Number = Math.cos(this.rotationY);
      var local4:Number = Math.sin(this.rotationY);
      var local5:Number = Math.cos(this.rotationZ);
      var local6:Number = Math.sin(this.rotationZ);
      var local7:Number = local5 * local4;
      var local8:Number = local6 * local4;
      var local9:Number = local3 * this.scaleX;
      var local10:Number = local2 * this.scaleY;
      var local11:Number = local1 * this.scaleY;
      var local12:Number = local1 * this.scaleZ;
      var local13:Number = local2 * this.scaleZ;
      this.alternativa3d::ma = local5 * local9;
      this.alternativa3d::mb = local7 * local10 - local6 * local11;
      this.alternativa3d::mc = local7 * local12 + local6 * local13;
      this.alternativa3d::md = this.x;
      this.alternativa3d::me = local6 * local9;
      this.alternativa3d::mf = local8 * local10 + local5 * local11;
      this.alternativa3d::mg = local8 * local12 - local5 * local13;
      this.alternativa3d::mh = this.y;
      this.alternativa3d::mi = -local4 * this.scaleX;
      this.alternativa3d::mj = local3 * local10;
      this.alternativa3d::mk = local3 * local12;
      this.alternativa3d::ml = this.z;
    }

    alternativa3d function composeMatrixFromSource(param1:Object3D) : void {
      var local2:Number = Math.cos(param1.rotationX);
      var local3:Number = Math.sin(param1.rotationX);
      var local4:Number = Math.cos(param1.rotationY);
      var local5:Number = Math.sin(param1.rotationY);
      var local6:Number = Math.cos(param1.rotationZ);
      var local7:Number = Math.sin(param1.rotationZ);
      var local8:Number = local6 * local5;
      var local9:Number = local7 * local5;
      var local10:Number = local4 * param1.scaleX;
      var local11:Number = local3 * param1.scaleY;
      var local12:Number = local2 * param1.scaleY;
      var local13:Number = local2 * param1.scaleZ;
      var local14:Number = local3 * param1.scaleZ;
      this.alternativa3d::ma = local6 * local10;
      this.alternativa3d::mb = local8 * local11 - local7 * local12;
      this.alternativa3d::mc = local8 * local13 + local7 * local14;
      this.alternativa3d::md = param1.x;
      this.alternativa3d::me = local7 * local10;
      this.alternativa3d::mf = local9 * local11 + local6 * local12;
      this.alternativa3d::mg = local9 * local13 - local6 * local14;
      this.alternativa3d::mh = param1.y;
      this.alternativa3d::mi = -local5 * param1.scaleX;
      this.alternativa3d::mj = local4 * local11;
      this.alternativa3d::mk = local4 * local13;
      this.alternativa3d::ml = param1.z;
    }

    alternativa3d function appendMatrix(param1:Object3D) : void {
      var local2:Number = this.alternativa3d::ma;
      var local3:Number = this.alternativa3d::mb;
      var local4:Number = this.alternativa3d::mc;
      var local5:Number = this.alternativa3d::md;
      var local6:Number = this.alternativa3d::me;
      var local7:Number = this.alternativa3d::mf;
      var local8:Number = this.alternativa3d::mg;
      var local9:Number = this.alternativa3d::mh;
      var local10:Number = this.alternativa3d::mi;
      var local11:Number = this.alternativa3d::mj;
      var local12:Number = this.alternativa3d::mk;
      var local13:Number = this.alternativa3d::ml;
      this.alternativa3d::ma = param1.alternativa3d::ma * local2 + param1.alternativa3d::mb * local6 + param1.alternativa3d::mc * local10;
      this.alternativa3d::mb = param1.alternativa3d::ma * local3 + param1.alternativa3d::mb * local7 + param1.alternativa3d::mc * local11;
      this.alternativa3d::mc = param1.alternativa3d::ma * local4 + param1.alternativa3d::mb * local8 + param1.alternativa3d::mc * local12;
      this.alternativa3d::md = param1.alternativa3d::ma * local5 + param1.alternativa3d::mb * local9 + param1.alternativa3d::mc * local13 + param1.alternativa3d::md;
      this.alternativa3d::me = param1.alternativa3d::me * local2 + param1.alternativa3d::mf * local6 + param1.alternativa3d::mg * local10;
      this.alternativa3d::mf = param1.alternativa3d::me * local3 + param1.alternativa3d::mf * local7 + param1.alternativa3d::mg * local11;
      this.alternativa3d::mg = param1.alternativa3d::me * local4 + param1.alternativa3d::mf * local8 + param1.alternativa3d::mg * local12;
      this.alternativa3d::mh = param1.alternativa3d::me * local5 + param1.alternativa3d::mf * local9 + param1.alternativa3d::mg * local13 + param1.alternativa3d::mh;
      this.alternativa3d::mi = param1.alternativa3d::mi * local2 + param1.alternativa3d::mj * local6 + param1.alternativa3d::mk * local10;
      this.alternativa3d::mj = param1.alternativa3d::mi * local3 + param1.alternativa3d::mj * local7 + param1.alternativa3d::mk * local11;
      this.alternativa3d::mk = param1.alternativa3d::mi * local4 + param1.alternativa3d::mj * local8 + param1.alternativa3d::mk * local12;
      this.alternativa3d::ml = param1.alternativa3d::mi * local5 + param1.alternativa3d::mj * local9 + param1.alternativa3d::mk * local13 + param1.alternativa3d::ml;
    }

    alternativa3d function composeAndAppend(param1:Object3D) : void {
      var local2:Number = Math.cos(this.rotationX);
      var local3:Number = Math.sin(this.rotationX);
      var local4:Number = Math.cos(this.rotationY);
      var local5:Number = Math.sin(this.rotationY);
      var local6:Number = Math.cos(this.rotationZ);
      var local7:Number = Math.sin(this.rotationZ);
      var local8:Number = local6 * local5;
      var local9:Number = local7 * local5;
      var local10:Number = local4 * this.scaleX;
      var local11:Number = local3 * this.scaleY;
      var local12:Number = local2 * this.scaleY;
      var local13:Number = local2 * this.scaleZ;
      var local14:Number = local3 * this.scaleZ;
      var local15:Number = local6 * local10;
      var local16:Number = local8 * local11 - local7 * local12;
      var local17:Number = local8 * local13 + local7 * local14;
      var local18:Number = this.x;
      var local19:Number = local7 * local10;
      var local20:Number = local9 * local11 + local6 * local12;
      var local21:Number = local9 * local13 - local6 * local14;
      var local22:Number = this.y;
      var local23:Number = -local5 * this.scaleX;
      var local24:Number = local4 * local11;
      var local25:Number = local4 * local13;
      var local26:Number = this.z;
      this.alternativa3d::ma = param1.alternativa3d::ma * local15 + param1.alternativa3d::mb * local19 + param1.alternativa3d::mc * local23;
      this.alternativa3d::mb = param1.alternativa3d::ma * local16 + param1.alternativa3d::mb * local20 + param1.alternativa3d::mc * local24;
      this.alternativa3d::mc = param1.alternativa3d::ma * local17 + param1.alternativa3d::mb * local21 + param1.alternativa3d::mc * local25;
      this.alternativa3d::md = param1.alternativa3d::ma * local18 + param1.alternativa3d::mb * local22 + param1.alternativa3d::mc * local26 + param1.alternativa3d::md;
      this.alternativa3d::me = param1.alternativa3d::me * local15 + param1.alternativa3d::mf * local19 + param1.alternativa3d::mg * local23;
      this.alternativa3d::mf = param1.alternativa3d::me * local16 + param1.alternativa3d::mf * local20 + param1.alternativa3d::mg * local24;
      this.alternativa3d::mg = param1.alternativa3d::me * local17 + param1.alternativa3d::mf * local21 + param1.alternativa3d::mg * local25;
      this.alternativa3d::mh = param1.alternativa3d::me * local18 + param1.alternativa3d::mf * local22 + param1.alternativa3d::mg * local26 + param1.alternativa3d::mh;
      this.alternativa3d::mi = param1.alternativa3d::mi * local15 + param1.alternativa3d::mj * local19 + param1.alternativa3d::mk * local23;
      this.alternativa3d::mj = param1.alternativa3d::mi * local16 + param1.alternativa3d::mj * local20 + param1.alternativa3d::mk * local24;
      this.alternativa3d::mk = param1.alternativa3d::mi * local17 + param1.alternativa3d::mj * local21 + param1.alternativa3d::mk * local25;
      this.alternativa3d::ml = param1.alternativa3d::mi * local18 + param1.alternativa3d::mj * local22 + param1.alternativa3d::mk * local26 + param1.alternativa3d::ml;
    }

    alternativa3d function copyAndAppend(param1:Object3D, param2:Object3D) : void {
      this.alternativa3d::ma = param2.alternativa3d::ma * param1.alternativa3d::ma + param2.alternativa3d::mb * param1.alternativa3d::me + param2.alternativa3d::mc * param1.alternativa3d::mi;
      this.alternativa3d::mb = param2.alternativa3d::ma * param1.alternativa3d::mb + param2.alternativa3d::mb * param1.alternativa3d::mf + param2.alternativa3d::mc * param1.alternativa3d::mj;
      this.alternativa3d::mc = param2.alternativa3d::ma * param1.alternativa3d::mc + param2.alternativa3d::mb * param1.alternativa3d::mg + param2.alternativa3d::mc * param1.alternativa3d::mk;
      this.alternativa3d::md = param2.alternativa3d::ma * param1.alternativa3d::md + param2.alternativa3d::mb * param1.alternativa3d::mh + param2.alternativa3d::mc * param1.alternativa3d::ml + param2.alternativa3d::md;
      this.alternativa3d::me = param2.alternativa3d::me * param1.alternativa3d::ma + param2.alternativa3d::mf * param1.alternativa3d::me + param2.alternativa3d::mg * param1.alternativa3d::mi;
      this.alternativa3d::mf = param2.alternativa3d::me * param1.alternativa3d::mb + param2.alternativa3d::mf * param1.alternativa3d::mf + param2.alternativa3d::mg * param1.alternativa3d::mj;
      this.alternativa3d::mg = param2.alternativa3d::me * param1.alternativa3d::mc + param2.alternativa3d::mf * param1.alternativa3d::mg + param2.alternativa3d::mg * param1.alternativa3d::mk;
      this.alternativa3d::mh = param2.alternativa3d::me * param1.alternativa3d::md + param2.alternativa3d::mf * param1.alternativa3d::mh + param2.alternativa3d::mg * param1.alternativa3d::ml + param2.alternativa3d::mh;
      this.alternativa3d::mi = param2.alternativa3d::mi * param1.alternativa3d::ma + param2.alternativa3d::mj * param1.alternativa3d::me + param2.alternativa3d::mk * param1.alternativa3d::mi;
      this.alternativa3d::mj = param2.alternativa3d::mi * param1.alternativa3d::mb + param2.alternativa3d::mj * param1.alternativa3d::mf + param2.alternativa3d::mk * param1.alternativa3d::mj;
      this.alternativa3d::mk = param2.alternativa3d::mi * param1.alternativa3d::mc + param2.alternativa3d::mj * param1.alternativa3d::mg + param2.alternativa3d::mk * param1.alternativa3d::mk;
      this.alternativa3d::ml = param2.alternativa3d::mi * param1.alternativa3d::md + param2.alternativa3d::mj * param1.alternativa3d::mh + param2.alternativa3d::mk * param1.alternativa3d::ml + param2.alternativa3d::ml;
    }

    alternativa3d function invertMatrix() : void {
      var local1:Number = this.alternativa3d::ma;
      var local2:Number = this.alternativa3d::mb;
      var local3:Number = this.alternativa3d::mc;
      var local4:Number = this.alternativa3d::md;
      var local5:Number = this.alternativa3d::me;
      var local6:Number = this.alternativa3d::mf;
      var local7:Number = this.alternativa3d::mg;
      var local8:Number = this.alternativa3d::mh;
      var local9:Number = this.alternativa3d::mi;
      var local10:Number = this.alternativa3d::mj;
      var local11:Number = this.alternativa3d::mk;
      var local12:Number = this.alternativa3d::ml;
      var local13:Number = 1 / (-local3 * local6 * local9 + local2 * local7 * local9 + local3 * local5 * local10 - local1 * local7 * local10 - local2 * local5 * local11 + local1 * local6 * local11);
      this.alternativa3d::ma = (-local7 * local10 + local6 * local11) * local13;
      this.alternativa3d::mb = (local3 * local10 - local2 * local11) * local13;
      this.alternativa3d::mc = (-local3 * local6 + local2 * local7) * local13;
      this.alternativa3d::md = (local4 * local7 * local10 - local3 * local8 * local10 - local4 * local6 * local11 + local2 * local8 * local11 + local3 * local6 * local12 - local2 * local7 * local12) * local13;
      this.alternativa3d::me = (local7 * local9 - local5 * local11) * local13;
      this.alternativa3d::mf = (-local3 * local9 + local1 * local11) * local13;
      this.alternativa3d::mg = (local3 * local5 - local1 * local7) * local13;
      this.alternativa3d::mh = (local3 * local8 * local9 - local4 * local7 * local9 + local4 * local5 * local11 - local1 * local8 * local11 - local3 * local5 * local12 + local1 * local7 * local12) * local13;
      this.alternativa3d::mi = (-local6 * local9 + local5 * local10) * local13;
      this.alternativa3d::mj = (local2 * local9 - local1 * local10) * local13;
      this.alternativa3d::mk = (-local2 * local5 + local1 * local6) * local13;
      this.alternativa3d::ml = (local4 * local6 * local9 - local2 * local8 * local9 - local4 * local5 * local10 + local1 * local8 * local10 + local2 * local5 * local12 - local1 * local6 * local12) * local13;
    }

    alternativa3d function calculateInverseMatrix() : void {
      var local1:Number = 1 / (-this.alternativa3d::mc * this.alternativa3d::mf * this.alternativa3d::mi + this.alternativa3d::mb * this.alternativa3d::mg * this.alternativa3d::mi + this.alternativa3d::mc * this.alternativa3d::me * this.alternativa3d::mj - this.alternativa3d::ma * this.alternativa3d::mg * this.alternativa3d::mj - this.alternativa3d::mb * this.alternativa3d::me * this.alternativa3d::mk + this.alternativa3d::ma * this.alternativa3d::mf * this.alternativa3d::mk);
      this.alternativa3d::ima = (-this.alternativa3d::mg * this.alternativa3d::mj + this.alternativa3d::mf * this.alternativa3d::mk) * local1;
      this.alternativa3d::imb = (this.alternativa3d::mc * this.alternativa3d::mj - this.alternativa3d::mb * this.alternativa3d::mk) * local1;
      this.alternativa3d::imc = (-this.alternativa3d::mc * this.alternativa3d::mf + this.alternativa3d::mb * this.alternativa3d::mg) * local1;
      this.alternativa3d::imd = (this.alternativa3d::md * this.alternativa3d::mg * this.alternativa3d::mj - this.alternativa3d::mc * this.alternativa3d::mh * this.alternativa3d::mj - this.alternativa3d::md * this.alternativa3d::mf * this.alternativa3d::mk + this.alternativa3d::mb * this.alternativa3d::mh * this.alternativa3d::mk + this.alternativa3d::mc * this.alternativa3d::mf * this.alternativa3d::ml - this.alternativa3d::mb * this.alternativa3d::mg * this.alternativa3d::ml) * local1;
      this.alternativa3d::ime = (this.alternativa3d::mg * this.alternativa3d::mi - this.alternativa3d::me * this.alternativa3d::mk) * local1;
      this.alternativa3d::imf = (-this.alternativa3d::mc * this.alternativa3d::mi + this.alternativa3d::ma * this.alternativa3d::mk) * local1;
      this.alternativa3d::img = (this.alternativa3d::mc * this.alternativa3d::me - this.alternativa3d::ma * this.alternativa3d::mg) * local1;
      this.alternativa3d::imh = (this.alternativa3d::mc * this.alternativa3d::mh * this.alternativa3d::mi - this.alternativa3d::md * this.alternativa3d::mg * this.alternativa3d::mi + this.alternativa3d::md * this.alternativa3d::me * this.alternativa3d::mk - this.alternativa3d::ma * this.alternativa3d::mh * this.alternativa3d::mk - this.alternativa3d::mc * this.alternativa3d::me * this.alternativa3d::ml + this.alternativa3d::ma * this.alternativa3d::mg * this.alternativa3d::ml) * local1;
      this.alternativa3d::imi = (-this.alternativa3d::mf * this.alternativa3d::mi + this.alternativa3d::me * this.alternativa3d::mj) * local1;
      this.alternativa3d::imj = (this.alternativa3d::mb * this.alternativa3d::mi - this.alternativa3d::ma * this.alternativa3d::mj) * local1;
      this.alternativa3d::imk = (-this.alternativa3d::mb * this.alternativa3d::me + this.alternativa3d::ma * this.alternativa3d::mf) * local1;
      this.alternativa3d::iml = (this.alternativa3d::md * this.alternativa3d::mf * this.alternativa3d::mi - this.alternativa3d::mb * this.alternativa3d::mh * this.alternativa3d::mi - this.alternativa3d::md * this.alternativa3d::me * this.alternativa3d::mj + this.alternativa3d::ma * this.alternativa3d::mh * this.alternativa3d::mj + this.alternativa3d::mb * this.alternativa3d::me * this.alternativa3d::ml - this.alternativa3d::ma * this.alternativa3d::mf * this.alternativa3d::ml) * local1;
    }

    alternativa3d function cullingInCamera(param1:Camera3D, param2:int) : int {
      var local4:Vertex = null;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Boolean = false;
      var local9:Boolean = false;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:int = 0;
      var local13:Vertex = null;
      if(param1.alternativa3d::occludedAll) {
        return -1;
      }
      var local3:int = param1.alternativa3d::numOccluders;
      if(param2 > 0 || local3 > 0) {
        local4 = alternativa3d::boundVertexList;
        local4.x = this.boundMinX;
        local4.y = this.boundMinY;
        local4.z = this.boundMinZ;
        local4 = local4.alternativa3d::next;
        local4.x = this.boundMaxX;
        local4.y = this.boundMinY;
        local4.z = this.boundMinZ;
        local4 = local4.alternativa3d::next;
        local4.x = this.boundMinX;
        local4.y = this.boundMaxY;
        local4.z = this.boundMinZ;
        local4 = local4.alternativa3d::next;
        local4.x = this.boundMaxX;
        local4.y = this.boundMaxY;
        local4.z = this.boundMinZ;
        local4 = local4.alternativa3d::next;
        local4.x = this.boundMinX;
        local4.y = this.boundMinY;
        local4.z = this.boundMaxZ;
        local4 = local4.alternativa3d::next;
        local4.x = this.boundMaxX;
        local4.y = this.boundMinY;
        local4.z = this.boundMaxZ;
        local4 = local4.alternativa3d::next;
        local4.x = this.boundMinX;
        local4.y = this.boundMaxY;
        local4.z = this.boundMaxZ;
        local4 = local4.alternativa3d::next;
        local4.x = this.boundMaxX;
        local4.y = this.boundMaxY;
        local4.z = this.boundMaxZ;
        local4 = alternativa3d::boundVertexList;
        while(local4 != null) {
          local5 = local4.x;
          local6 = local4.y;
          local7 = local4.z;
          local4.alternativa3d::cameraX = this.alternativa3d::ma * local5 + this.alternativa3d::mb * local6 + this.alternativa3d::mc * local7 + this.alternativa3d::md;
          local4.alternativa3d::cameraY = this.alternativa3d::me * local5 + this.alternativa3d::mf * local6 + this.alternativa3d::mg * local7 + this.alternativa3d::mh;
          local4.alternativa3d::cameraZ = this.alternativa3d::mi * local5 + this.alternativa3d::mj * local6 + this.alternativa3d::mk * local7 + this.alternativa3d::ml;
          local4 = local4.alternativa3d::next;
        }
      }
      if(param2 > 0) {
        if(Boolean(param2 & 1)) {
          local10 = param1.nearClipping;
          local4 = alternativa3d::boundVertexList;
          local8 = false;
          local9 = false;
          while(local4 != null) {
            if(local4.alternativa3d::cameraZ > local10) {
              local8 = true;
              if(local9) {
                break;
              }
            } else {
              local9 = true;
              if(local8) {
                break;
              }
            }
            local4 = local4.alternativa3d::next;
          }
          if(local9) {
            if(!local8) {
              return -1;
            }
          } else {
            param2 &= 62;
          }
        }
        if(Boolean(param2 & 2)) {
          local11 = param1.farClipping;
          local4 = alternativa3d::boundVertexList;
          local8 = false;
          local9 = false;
          while(local4 != null) {
            if(local4.alternativa3d::cameraZ < local11) {
              local8 = true;
              if(local9) {
                break;
              }
            } else {
              local9 = true;
              if(local8) {
                break;
              }
            }
            local4 = local4.alternativa3d::next;
          }
          if(local9) {
            if(!local8) {
              return -1;
            }
          } else {
            param2 &= 61;
          }
        }
        if(Boolean(param2 & 4)) {
          local4 = alternativa3d::boundVertexList;
          local8 = false;
          local9 = false;
          while(local4 != null) {
            if(-local4.alternativa3d::cameraX < local4.alternativa3d::cameraZ) {
              local8 = true;
              if(local9) {
                break;
              }
            } else {
              local9 = true;
              if(local8) {
                break;
              }
            }
            local4 = local4.alternativa3d::next;
          }
          if(local9) {
            if(!local8) {
              return -1;
            }
          } else {
            param2 &= 59;
          }
        }
        if(Boolean(param2 & 8)) {
          local4 = alternativa3d::boundVertexList;
          local8 = false;
          local9 = false;
          while(local4 != null) {
            if(local4.alternativa3d::cameraX < local4.alternativa3d::cameraZ) {
              local8 = true;
              if(local9) {
                break;
              }
            } else {
              local9 = true;
              if(local8) {
                break;
              }
            }
            local4 = local4.alternativa3d::next;
          }
          if(local9) {
            if(!local8) {
              return -1;
            }
          } else {
            param2 &= 55;
          }
        }
        if(Boolean(param2 & 0x10)) {
          local4 = alternativa3d::boundVertexList;
          local8 = false;
          local9 = false;
          while(local4 != null) {
            if(-local4.alternativa3d::cameraY < local4.alternativa3d::cameraZ) {
              local8 = true;
              if(local9) {
                break;
              }
            } else {
              local9 = true;
              if(local8) {
                break;
              }
            }
            local4 = local4.alternativa3d::next;
          }
          if(local9) {
            if(!local8) {
              return -1;
            }
          } else {
            param2 &= 47;
          }
        }
        if(Boolean(param2 & 0x20)) {
          local4 = alternativa3d::boundVertexList;
          local8 = false;
          local9 = false;
          while(local4 != null) {
            if(local4.alternativa3d::cameraY < local4.alternativa3d::cameraZ) {
              local8 = true;
              if(local9) {
                break;
              }
            } else {
              local9 = true;
              if(local8) {
                break;
              }
            }
            local4 = local4.alternativa3d::next;
          }
          if(local9) {
            if(!local8) {
              return -1;
            }
          } else {
            param2 &= 31;
          }
        }
      }
      if(local3 > 0) {
        local12 = 0;
        while(true) {
          if(local12 < local3) {
            local13 = param1.alternativa3d::occluders[local12];
            while(local13 != null) {
              local4 = alternativa3d::boundVertexList;
              while(local4 != null) {
                if(local13.alternativa3d::cameraX * local4.alternativa3d::cameraX + local13.alternativa3d::cameraY * local4.alternativa3d::cameraY + local13.alternativa3d::cameraZ * local4.alternativa3d::cameraZ >= 0) {
                  break;
                }
                local4 = local4.alternativa3d::next;
              }
              if(local4 != null) {
                break;
              }
              local13 = local13.alternativa3d::next;
            }
            if(local13 == null) {
              break;
            }
            local12++;
            continue;
          }
        }
        return -1;
      }
      this.alternativa3d::culling = param2;
      return param2;
    }

    alternativa3d function removeFromParent() : void {
      if(this.alternativa3d::_parent != null) {
        this.alternativa3d::_parent.removeChild(this);
      }
    }
  }
}
