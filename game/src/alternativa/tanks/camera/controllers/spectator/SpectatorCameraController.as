package alternativa.tanks.camera.controllers.spectator {
  import alternativa.math.Vector3;
  import alternativa.osgi.service.console.variables.ConsoleVarFloat;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.camera.CameraController;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.MathUtils;
  import flash.display.Stage;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.ui.Keyboard;

  public class SpectatorCameraController implements CameraController {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleService:BattleService;

    private static const conSmooth:ConsoleVarFloat = new ConsoleVarFloat("cam_smooth",0.1,0.001,1);
    private static const conSmoothDeceleration:ConsoleVarFloat = new ConsoleVarFloat("cam_smooth_dec",0.025,0.001,1);
    private static const conMousePitchSensitivity:ConsoleVarFloat = new ConsoleVarFloat("m_pitch",-0.006,-100,100);
    private static const conMouseYawSensitivity:ConsoleVarFloat = new ConsoleVarFloat("m_yaw",-0.006,-100,100);
    private static const conSpeed:ConsoleVarFloat = new ConsoleVarFloat("cam_spd",1300,0,10000);
    private static const conAcceleration:ConsoleVarFloat = new ConsoleVarFloat("cam_acc",4,0,1000000);
    private static const conDeceleration:ConsoleVarFloat = new ConsoleVarFloat("cam_dec",0.33,0.05,2);
    private static const conYawSpeed:ConsoleVarFloat = new ConsoleVarFloat("yaw_speed",1,-10,10);
    private static const conPitchSpeed:ConsoleVarFloat = new ConsoleVarFloat("pitch_speed",1,-10,10);

    private var mouseDown:Boolean;
    private var mouseDownX:Number;
    private var mouseDownY:Number;
    private var startCameraRotationX:Number;
    private var startCameraRotationZ:Number;
    private var position:Vector3 = new Vector3();
    private var rotation:Vector3 = new Vector3();
    private var rotationDelta:Vector3 = new Vector3();
    private var moveMethods:MovementMethods;
    private var userInput:UserInputImpl = new UserInputImpl();
    private var addedEvents:Boolean = false;
    private var camera:GameCamera;

    public function SpectatorCameraController() {
      super();
      this.moveMethods = new MovementMethods(Vector.<MovementMethod>([new FlightMovement(conSpeed,conAcceleration,conDeceleration),new WalkMovement(conSpeed,conAcceleration,conDeceleration)]));
    }

    private static function calculateAngleDelta(param1:Number, param2:Number) : Number {
      var local3:Number = (param2 - param1) % (2 * Math.PI);
      if(local3 > Math.PI) {
        return local3 - 2 * Math.PI;
      }
      if(local3 < -Math.PI) {
        return 2 * Math.PI + local3;
      }
      return local3;
    }

    public function setCameraState(param1:Vector3, param2:Vector3) : void {
      this.position.copy(param1);
      this.rotation.copy(param2);
      var local3:GameCamera = battleService.getBattleScene3D().getCamera();
      this.rotationDelta.x = calculateAngleDelta(local3.rotationX,param2.x);
      this.rotationDelta.y = calculateAngleDelta(local3.rotationY,param2.y);
      this.rotationDelta.z = calculateAngleDelta(local3.rotationZ,param2.z);
    }

    public function update(param1:GameCamera, param2:int, param3:int) : void {
      var local4:Number = param3 / 1000;
      this.calculatePosition(param1,local4);
      this.calculateRotation(param1,local4);
      this.applyTransformation(param1);
    }

    private function calculatePosition(param1:GameCamera, param2:Number) : void {
      var local3:Vector3 = this.moveMethods.getMethod().getDisplacement(this.userInput,param1,param2);
      this.position.add(local3);
    }

    private function calculateRotation(param1:GameCamera, param2:Number) : void {
      if(this.mouseDown) {
        this.rotation.x = this.startCameraRotationX + (display.stage.mouseY - this.mouseDownY) * conMousePitchSensitivity.value;
        this.rotation.x = MathUtils.clamp(this.rotation.x,-Math.PI,0);
        this.rotationDelta.x = this.rotation.x - param1.rotationX;
        this.rotation.z = this.startCameraRotationZ + (display.stage.mouseX - this.mouseDownX) * conMouseYawSensitivity.value;
        this.rotationDelta.z = this.rotation.z - param1.rotationZ;
      } else if(this.userInput.isRotating()) {
        this.rotation.x += this.userInput.getPitchDirection() * conPitchSpeed.value * param2;
        this.rotation.x = MathUtils.clamp(this.rotation.x,-Math.PI,0);
        this.rotationDelta.x = this.rotation.x - param1.rotationX;
        this.rotationDelta.z += this.userInput.getYawDirection() * conYawSpeed.value * param2;
      }
    }

    private function applyTransformation(param1:GameCamera) : void {
      this.applyDisplacement(param1);
      this.applyRotation(param1);
    }

    private function applyDisplacement(param1:GameCamera) : void {
      var local2:ConsoleVarFloat = null;
      local2 = !!this.moveMethods.getMethod().accelerationInverted() ? conSmoothDeceleration : conSmooth;
      param1.x += (this.position.x - param1.x) * local2.value;
      param1.y += (this.position.y - param1.y) * local2.value;
      param1.z += (this.position.z - param1.z) * local2.value;
    }

    private function applyRotation(param1:GameCamera) : void {
      var local2:ConsoleVarFloat = null;
      local2 = !!this.moveMethods.getMethod().accelerationInverted() ? conSmoothDeceleration : conSmooth;
      var local3:Number = this.rotationDelta.x * local2.value;
      param1.rotationX += local3;
      this.rotationDelta.x -= local3;
      var local4:Number = this.rotationDelta.y * local2.value;
      param1.rotationY += local4;
      this.rotationDelta.y -= local4;
      var local5:Number = this.rotationDelta.z * local2.value;
      param1.rotationZ += local5;
      this.rotationDelta.z -= local5;
    }

    public function activate(param1:GameCamera) : void {
      this.camera = param1;
      this.rotationDelta.reset();
      this.activateInputListeners();
      param1.readPosition(this.position);
      param1.readRotation(this.rotation);
    }

    public function deactivate() : void {
      this.userInput.reset();
      this.rotationDelta.reset();
      this.deactivateInputListeners();
    }

    private function onMouseDown(param1:MouseEvent) : void {
      this.mouseDown = true;
      this.mouseDownX = param1.stageX;
      this.mouseDownY = param1.stageY;
      this.startCameraRotationX = this.camera.rotationX;
      this.startCameraRotationZ = this.camera.rotationZ;
      display.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
    }

    private function onKeyUp(param1:KeyboardEvent) : void {
      this.userInput.handleKeyUp(param1);
    }

    private function onKeyDown(param1:KeyboardEvent) : void {
      var local2:Boolean = false;
      if(param1.keyCode == Keyboard.SPACE) {
        local2 = Boolean(this.moveMethods.getMethod().accelerationInverted());
        this.moveMethods.selectNextMethod();
        this.moveMethods.getMethod().setAccelerationInverted(local2);
      }
      if(param1.keyCode == Keyboard.I) {
        this.moveMethods.getMethod().invertAcceleration();
      }
      this.userInput.handleKeyDown(param1);
    }

    private function releaseMouse() : void {
      if(this.mouseDown) {
        display.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
        this.mouseDown = false;
      }
    }

    private function onMouseUp(param1:MouseEvent) : void {
      this.releaseMouse();
    }

    public function deactivateInputListeners() : void {
      var local1:Stage = null;
      this.releaseMouse();
      if(this.addedEvents) {
        this.addedEvents = false;
        local1 = display.stage;
        local1.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
        local1.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
        local1.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      }
    }

    public function activateInputListeners() : void {
      var local1:Stage = null;
      if(!this.addedEvents) {
        this.addedEvents = true;
        local1 = display.stage;
        local1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
        local1.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
        local1.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      }
    }
  }
}
