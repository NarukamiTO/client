package alternativa.engine3d.controllers {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Object3D;
  import flash.display.InteractiveObject;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.geom.Matrix3D;
  import flash.geom.Point;
  import flash.geom.Vector3D;
  import flash.ui.Keyboard;
  import flash.utils.getTimer;

  public class SimpleObjectController {
    public static const ACTION_FORWARD:String = "ACTION_FORWARD";
    public static const ACTION_BACK:String = "ACTION_BACK";
    public static const ACTION_LEFT:String = "ACTION_LEFT";
    public static const ACTION_RIGHT:String = "ACTION_RIGHT";
    public static const ACTION_UP:String = "ACTION_UP";
    public static const ACTION_DOWN:String = "ACTION_DOWN";
    public static const ACTION_PITCH_UP:String = "ACTION_PITCH_UP";
    public static const ACTION_PITCH_DOWN:String = "ACTION_PITCH_DOWN";
    public static const ACTION_YAW_LEFT:String = "ACTION_YAW_LEFT";
    public static const ACTION_YAW_RIGHT:String = "ACTION_YAW_RIGHT";
    public static const ACTION_ACCELERATE:String = "ACTION_ACCELERATE";
    public static const ACTION_MOUSE_LOOK:String = "ACTION_MOUSE_LOOK";

    public var speed:Number;
    public var speedMultiplier:Number;
    public var mouseSensitivity:Number;
    public var maxPitch:Number = 1e+22;
    public var minPitch:Number = -1e+22;

    private var eventSource:InteractiveObject;
    private var _object:Object3D;
    private var _up:Boolean;
    private var _down:Boolean;
    private var _forward:Boolean;
    private var _back:Boolean;
    private var _left:Boolean;
    private var _right:Boolean;
    private var _accelerate:Boolean;
    private var displacement:Vector3D = new Vector3D();
    private var mousePoint:Point = new Point();
    private var mouseLook:Boolean;
    private var objectTransform:Vector.<Vector3D>;
    private var time:int;
    private var actionBindings:Object = {};

    protected var keyBindings:Object = {};

    private var _vin:Vector.<Number> = new Vector.<Number>(3);
    private var _vout:Vector.<Number> = new Vector.<Number>(3);

    public function SimpleObjectController(param1:InteractiveObject, param2:Object3D, param3:Number, param4:Number = 3, param5:Number = 1) {
      super();
      this.eventSource = param1;
      this.object = param2;
      this.speed = param3;
      this.speedMultiplier = param4;
      this.mouseSensitivity = param5;
      this.actionBindings[ACTION_FORWARD] = this.moveForward;
      this.actionBindings[ACTION_BACK] = this.moveBack;
      this.actionBindings[ACTION_LEFT] = this.moveLeft;
      this.actionBindings[ACTION_RIGHT] = this.moveRight;
      this.actionBindings[ACTION_UP] = this.moveUp;
      this.actionBindings[ACTION_DOWN] = this.moveDown;
      this.actionBindings[ACTION_ACCELERATE] = this.accelerate;
      this.setDefaultBindings();
      this.enable();
    }

    public function enable() : void {
      this.eventSource.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
      this.eventSource.addEventListener(KeyboardEvent.KEY_UP,this.onKey);
      this.eventSource.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      this.eventSource.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
    }

    public function disable() : void {
      this.eventSource.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
      this.eventSource.removeEventListener(KeyboardEvent.KEY_UP,this.onKey);
      this.eventSource.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      this.eventSource.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      this.stopMouseLook();
    }

    private function onMouseDown(param1:MouseEvent) : void {
      this.startMouseLook();
    }

    private function onMouseUp(param1:MouseEvent) : void {
      this.stopMouseLook();
    }

    public function startMouseLook() : void {
      this.mousePoint.x = this.eventSource.mouseX;
      this.mousePoint.y = this.eventSource.mouseY;
      this.mouseLook = true;
    }

    public function stopMouseLook() : void {
      this.mouseLook = false;
    }

    private function onKey(param1:KeyboardEvent) : void {
      var local2:Function = this.keyBindings[param1.keyCode];
      if(local2 != null) {
        local2.call(this,param1.type == KeyboardEvent.KEY_DOWN);
      }
    }

    public function get object() : Object3D {
      return this._object;
    }

    public function set object(param1:Object3D) : void {
      this._object = param1;
      this.updateObjectTransform();
    }

    public function updateObjectTransform() : void {
      if(this._object != null) {
        this.objectTransform = this._object.matrix.decompose();
      }
    }

    public function update() : void {
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Vector3D = null;
      var local6:Number = NaN;
      var local7:Matrix3D = null;
      if(this._object == null) {
        return;
      }
      var local1:Number = this.time;
      this.time = getTimer();
      local1 = 0.001 * (this.time - local1);
      if(local1 > 0.1) {
        local1 = 0.1;
      }
      var local2:Boolean = false;
      if(this.mouseLook) {
        local3 = this.eventSource.mouseX - this.mousePoint.x;
        local4 = this.eventSource.mouseY - this.mousePoint.y;
        this.mousePoint.x = this.eventSource.mouseX;
        this.mousePoint.y = this.eventSource.mouseY;
        local5 = this.objectTransform[1];
        local5.x -= local4 * Math.PI / 180 * this.mouseSensitivity;
        if(local5.x > this.maxPitch) {
          local5.x = this.maxPitch;
        }
        if(local5.x < this.minPitch) {
          local5.x = this.minPitch;
        }
        local5.z -= local3 * Math.PI / 180 * this.mouseSensitivity;
        local2 = true;
      }
      this.displacement.x = this._right ? 1 : (this._left ? -1 : 0);
      this.displacement.y = this._forward ? 1 : (this._back ? -1 : 0);
      this.displacement.z = this._up ? 1 : (this._down ? -1 : 0);
      if(this.displacement.lengthSquared > 0) {
        if(this._object is Camera3D) {
          local6 = this.displacement.z;
          this.displacement.z = this.displacement.y;
          this.displacement.y = -local6;
        }
        this.deltaTransformVector(this.displacement);
        if(this._accelerate) {
          this.displacement.scaleBy(this.speedMultiplier * this.speed * local1 / this.displacement.length);
        } else {
          this.displacement.scaleBy(this.speed * local1 / this.displacement.length);
        }
        (this.objectTransform[0] as Vector3D).incrementBy(this.displacement);
        local2 = true;
      }
      if(local2) {
        local7 = new Matrix3D();
        local7.recompose(this.objectTransform);
        this._object.matrix = local7;
      }
    }

    public function setObjectPos(param1:Vector3D) : void {
      var local2:Vector3D = null;
      if(this._object != null) {
        local2 = this.objectTransform[0];
        local2.x = param1.x;
        local2.y = param1.y;
        local2.z = param1.z;
      }
    }

    public function setObjectPosXYZ(param1:Number, param2:Number, param3:Number) : void {
      var local4:Vector3D = null;
      if(this._object != null) {
        local4 = this.objectTransform[0];
        local4.x = param1;
        local4.y = param2;
        local4.z = param3;
      }
    }

    public function lookAt(param1:Vector3D) : void {
      this.lookAtXYZ(param1.x,param1.y,param1.z);
    }

    public function lookAtXYZ(param1:Number, param2:Number, param3:Number) : void {
      if(this._object == null) {
        return;
      }
      var local4:Vector3D = this.objectTransform[0];
      var local5:Number = param1 - local4.x;
      var local6:Number = param2 - local4.y;
      var local7:Number = param3 - local4.z;
      local4 = this.objectTransform[1];
      local4.x = Math.atan2(local7,Math.sqrt(local5 * local5 + local6 * local6));
      if(this._object is Camera3D) {
        local4.x -= 0.5 * Math.PI;
      }
      local4.y = 0;
      local4.z = -Math.atan2(local5,local6);
      var local8:Matrix3D = this._object.matrix;
      local8.recompose(this.objectTransform);
      this._object.matrix = local8;
    }

    private function deltaTransformVector(param1:Vector3D) : void {
      this._vin[0] = param1.x;
      this._vin[1] = param1.y;
      this._vin[2] = param1.z;
      this._object.matrix.transformVectors(this._vin,this._vout);
      var local2:Vector3D = this.objectTransform[0];
      param1.x = this._vout[0] - local2.x;
      param1.y = this._vout[1] - local2.y;
      param1.z = this._vout[2] - local2.z;
    }

    public function moveForward(param1:Boolean) : void {
      this._forward = param1;
    }

    public function moveBack(param1:Boolean) : void {
      this._back = param1;
    }

    public function moveLeft(param1:Boolean) : void {
      this._left = param1;
    }

    public function moveRight(param1:Boolean) : void {
      this._right = param1;
    }

    public function moveUp(param1:Boolean) : void {
      this._up = param1;
    }

    public function moveDown(param1:Boolean) : void {
      this._down = param1;
    }

    public function accelerate(param1:Boolean) : void {
      this._accelerate = param1;
    }

    public function bindKey(param1:uint, param2:String) : void {
      var local3:Function = this.actionBindings[param2];
      if(local3 != null) {
        this.keyBindings[param1] = local3;
      }
    }

    public function bindKeys(param1:Array) : void {
      var local2:int = 0;
      while(local2 < param1.length) {
        this.bindKey(param1[local2],param1[local2 + 1]);
        local2 += 2;
      }
    }

    public function unbindKey(param1:uint) : void {
      delete this.keyBindings[param1];
    }

    public function unbindAll() : void {
      var local1:String = null;
      for(local1 in this.keyBindings) {
        delete this.keyBindings[local1];
      }
    }

    public function setDefaultBindings() : void {
      this.bindKey(87,ACTION_FORWARD);
      this.bindKey(83,ACTION_BACK);
      this.bindKey(65,ACTION_LEFT);
      this.bindKey(68,ACTION_RIGHT);
      this.bindKey(69,ACTION_UP);
      this.bindKey(67,ACTION_DOWN);
      this.bindKey(Keyboard.SHIFT,ACTION_ACCELERATE);
      this.bindKey(Keyboard.UP,ACTION_FORWARD);
      this.bindKey(Keyboard.DOWN,ACTION_BACK);
      this.bindKey(Keyboard.LEFT,ACTION_LEFT);
      this.bindKey(Keyboard.RIGHT,ACTION_RIGHT);
    }
  }
}
