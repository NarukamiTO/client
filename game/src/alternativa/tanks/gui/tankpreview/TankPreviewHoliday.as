package alternativa.tanks.gui.tankpreview {
  import alternativa.engine3d.containers.BSPContainer;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.MipMapping;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.View;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.objects.Decal;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.service.garage.GarageService;
  import controls.TankWindowInner;
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.display.Shape;
  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.filters.BitmapFilterQuality;
  import flash.filters.BlurFilter;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.geom.Vector3D;
  import flash.utils.Timer;
  import forms.TankWindowWithHeader;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
  import projects.tanks.clients.flash.resources.tanks.Tank3D;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.disposeBitmapsData;

  public class TankPreviewHoliday extends TankWindowWithHeader {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var garageService:GarageService;

    private static const ENTER_FRAME_PRIORITY:Number = -1;
    private static const INITIAL_CAMERA_DIRECTION:Number = -150;
    private static const WINDOW_MARGIN:int = 11;
    private static const SHADOW_ALPHA:Number = 0.7;
    private static const SHADOW_BLUR:Number = 13;
    private static const SHADOW_RESOLUTION:Number = 2.5;
    private static const SHADOW_DIRECTION:Vector3D = new Vector3D(0,0,-1);

    private var innerBevel:TankWindowInner;
    private var backgroundEraser:Shape;
    private var rootContainer:Object3DContainer;
    private var hangarContainer:Object3DContainer;
    private var cameraContainer:Object3DContainer;
    private var camera:Camera3D;
    private var stateMachine:TankPreviewStateMachine;
    private var tank:Tank3D;
    private var loadedPartsCounter:int = 0;
    private var backgroundEraserTimer:Timer;
    private var shadow:Mesh;
    private var _hullMesh:Mesh;
    private var bitmapsData:Array;

    public function TankPreviewHoliday(param1:Tanks3DSResource) {
      super();
      this.bitmapsData = [];
      setHeaderId(TanksLocale.TEXT_HEADER_YOUR_TANK);
      this.init3D();
      this.createWindowInnerBevel();
      this.addGarageObjectsToScene(param1);
      this.createTank();
      this.resize(400,300);
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    private function init3D() : void {
      this.rootContainer = new Object3DContainer();
      this.camera = new Camera3D();
      this.camera.view = new View(100,100,GPUCapabilities.constrained);
      this.camera.view.hideLogo();
      addChild(this.camera.view);
      this.cameraContainer = new Object3DContainer();
      this.rootContainer.addChild(this.cameraContainer);
      this.hangarContainer = new BSPContainer();
      this.rootContainer.addChild(this.hangarContainer);
      this.cameraContainer.addChild(this.camera);
      this.cameraContainer.rotationX = garageService.getCameraPitch() * Math.PI / 180;
      this.camera.y = garageService.getCameraAltitude();
      this.camera.z = garageService.getCameraDistance();
      this.camera.fov = garageService.getCameraFieldOfView();
      this.cameraContainer.rotationZ = INITIAL_CAMERA_DIRECTION * Math.PI / 180;
      if(GPUCapabilities.gpuEnabled) {
        this.backgroundEraser = new Shape();
        this.backgroundEraser.blendMode = BlendMode.ERASE;
      }
    }

    private function createWindowInnerBevel() : void {
      this.innerBevel = new TankWindowInner(0,0,TankWindowInner.TRANSPARENT);
      addChild(this.innerBevel);
      this.innerBevel.mouseEnabled = true;
    }

    private function createTank() : void {
      this.tank = new Tank3D();
      this.tank.z = 120;
      this.tank.y = -30;
      this.tank.x = 0;
      this.rootContainer.addChild(this.tank);
    }

    private function addGarageObjectsToScene(param1:Tanks3DSResource) : void {
      var local4:Mesh = null;
      var local5:TextureMaterial = null;
      var local6:BSP = null;
      var local2:int = int(param1.objects.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1.objects[local3] as Mesh;
        if(local4 != null) {
          local5 = TextureMaterial(local4.faceList.material);
          local5.texture = param1.getTextureForObject(local3);
          local4.setMaterialToAllFaces(local5);
          local6 = new BSP();
          local6.createTree(local4);
          local6.matrix = local4.matrix;
          this.hangarContainer.addChild(local6);
        }
        local3++;
      }
    }

    private function onAddedToStage(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,ENTER_FRAME_PRIORITY);
      this.initStateMachine();
      if(GPUCapabilities.gpuEnabled) {
        this.backgroundEraserTimer = new Timer(1000,1);
        this.backgroundEraserTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onBackgroundEraserTimerComplete);
        this.backgroundEraserTimer.start();
      }
    }

    private function onBackgroundEraserTimerComplete(param1:TimerEvent) : void {
      addChild(this.backgroundEraser);
      this.backgroundEraserTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onBackgroundEraserTimerComplete);
      this.backgroundEraserTimer = null;
    }

    private function onEnterFrame(param1:Event) : void {
      this.stateMachine.updateCurrentState();
      this.camera.render();
    }

    private function initStateMachine() : void {
      this.stateMachine = new TankPreviewStateMachine();
      var local1:TankPreviewContext = new TankPreviewContext();
      var local2:ManualRotationState = new ManualRotationState(this.stateMachine,stage,local1,this.camera,this.cameraContainer);
      var local3:RotationDecelerationState = new RotationDecelerationState(this.stateMachine,this.innerBevel,local1,this.cameraContainer);
      var local4:IdleState = new IdleState(this.stateMachine,this.innerBevel);
      var local5:AutoRotationState = new AutoRotationState(this.stateMachine,this.innerBevel,this.cameraContainer);
      this.stateMachine.addTransition(TankPreviewEvent.MOUSE_DOWN,local3,local2);
      this.stateMachine.addTransition(TankPreviewEvent.MOUSE_DOWN,local4,local2);
      this.stateMachine.addTransition(TankPreviewEvent.MOUSE_DOWN,local5,local2);
      this.stateMachine.addTransition(TankPreviewEvent.STOP_MANUAL_ROTATION,local2,local3);
      this.stateMachine.addTransition(TankPreviewEvent.ROTATION_STOPPED,local3,local4);
      this.stateMachine.addTransition(TankPreviewEvent.IDLE_STATE_TIMEOUT,local4,local5);
      this.stateMachine.setCurrentState(local4);
    }

    public function destroy() : void {
      removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      if(this.backgroundEraserTimer != null) {
        this.backgroundEraserTimer.stop();
        this.backgroundEraserTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onBackgroundEraserTimerComplete);
        this.backgroundEraserTimer = null;
      }
      this.innerBevel = null;
      this.rootContainer = null;
      this.cameraContainer = null;
      this.camera.view.clear();
      this.camera = null;
      this.tank.destroy();
      this.tank = null;
      this.shadow = null;
      disposeBitmapsData(this.bitmapsData);
      this.bitmapsData = null;
    }

    public function setHull(param1:Tanks3DSResource) : void {
      this._hullMesh = Mesh(param1.objects[0]);
      this.tank.setHull(param1);
      this.onTankPartLoaded();
    }

    public function setTurret(param1:Tanks3DSResource) : void {
      this.tank.setTurret(param1);
      this.onTankPartLoaded();
    }

    public function setColorMap(param1:BitmapData) : void {
      this.tank.setColorMap(param1);
      this.onTankPartLoaded();
    }

    private function onTankPartLoaded() : void {
      if(this.loadedPartsCounter < 3) {
        ++this.loadedPartsCounter;
      }
      if(this.loadedPartsCounter == 3) {
        if(this.shadow != null && Boolean(this.tank.contains(this.shadow))) {
          this.tank.removeChild(this.shadow);
        }
        this.shadow = this.createShadow(this._hullMesh,SHADOW_DIRECTION,SHADOW_RESOLUTION,SHADOW_BLUR,SHADOW_ALPHA);
        this.tank.addChildAt(this.shadow,0);
        if(!GPUCapabilities.gpuEnabled) {
          this.camera.render();
        }
      }
    }

    public function resize(param1:Number, param2:Number) : void {
      this.width = param1;
      this.height = param2;
      this.adjustInnerBevel(param1,param2);
      this.adjustView3D(param1,param2);
      this.adjustBackgroundEraser();
      if(!GPUCapabilities.gpuEnabled) {
        this.camera.render();
      }
    }

    private function adjustInnerBevel(param1:Number, param2:Number) : void {
      this.innerBevel.width = param1 - WINDOW_MARGIN * 2;
      this.innerBevel.height = param2 - WINDOW_MARGIN * 2;
      this.innerBevel.x = WINDOW_MARGIN;
      this.innerBevel.y = WINDOW_MARGIN;
    }

    private function adjustView3D(param1:Number, param2:Number) : void {
      this.camera.view.width = param1 - WINDOW_MARGIN * 2 - 2;
      this.camera.view.height = param2 - WINDOW_MARGIN * 2 - 2;
      this.camera.view.x = WINDOW_MARGIN;
      this.camera.view.y = WINDOW_MARGIN;
    }

    private function adjustBackgroundEraser() : void {
      if(GPUCapabilities.gpuEnabled) {
        this.backgroundEraser.x = this.camera.view.x;
        this.backgroundEraser.y = this.camera.view.y;
        this.backgroundEraser.graphics.clear();
        this.backgroundEraser.graphics.beginFill(16711680);
        this.backgroundEraser.graphics.drawRect(0,0,this.camera.view.width,this.camera.view.height);
        this.backgroundEraser.graphics.endFill();
      }
    }

    private function createShadow(param1:Mesh, param2:Vector3D, param3:Number, param4:int, param5:Number, param6:uint = 0) : Mesh {
      var local20:Wrapper = null;
      var local21:Vertex = null;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Decal = null;
      param2 = param2.clone();
      param2.normalize();
      var local7:Number = 1e+22;
      var local8:Number = 1e+22;
      var local9:Number = -1e+22;
      var local10:Number = -1e+22;
      var local11:Shape = new Shape();
      var local12:Face = param1.faceList;
      while(local12 != null) {
        local20 = local12.wrapper;
        while(local20 != null) {
          local21 = local20.vertex;
          local22 = -local21.z / param2.z;
          local23 = local21.x + param2.x * local22;
          local24 = local21.y + param2.y * local22;
          if(local23 < local7) {
            local7 = local23;
          }
          if(local23 > local9) {
            local9 = local23;
          }
          if(local24 < local8) {
            local8 = local24;
          }
          if(local24 > local10) {
            local10 = local24;
          }
          if(local20 == local12.wrapper) {
            local11.graphics.beginFill(param6);
            local11.graphics.moveTo(local23,local24);
          } else {
            local11.graphics.lineTo(local23,local24);
          }
          local20 = local20.next;
        }
        local12 = local12.next;
      }
      local7 = (Math.floor(local7 / param3) - param4) * param3;
      local8 = (Math.floor(local8 / param3) - param4) * param3;
      local9 = (Math.ceil(local9 / param3) + param4) * param3;
      local10 = (Math.ceil(local10 / param3) + param4) * param3;
      var local13:BitmapData = new BitmapData(Math.round((local9 - local7) / param3),Math.round((local10 - local8) / param3),true,0);
      this.bitmapsData.push(local13);
      local13.draw(local11,new Matrix(1 / param3,0,0,-1 / param3,-local7 / param3,local10 / param3));
      local13.applyFilter(local13,local13.rect,new Point(),new BlurFilter(param4,param4,BitmapFilterQuality.MEDIUM));
      var local14:TextureMaterial = new TextureMaterial(local13,false,true,MipMapping.PER_PIXEL,param3);
      var local15:Mesh = new Mesh();
      var local16:Vertex = local15.addVertex(local7,local10,0,0,0);
      var local17:Vertex = local15.addVertex(local7,local8,0,0,1);
      var local18:Vertex = local15.addVertex(local9,local8,0,1,1);
      var local19:Vertex = local15.addVertex(local9,local10,0,1,0);
      local15.addQuadFace(local16,local17,local18,local19,local14);
      local15.calculateFacesNormals();
      local15.calculateBounds();
      local15.alpha = param5;
      if(GPUCapabilities.gpuEnabled) {
        local25 = new Decal();
        local25.createGeometry(local15,true);
        local25.x = local15.x;
        local25.y = local15.y;
        local25.z = local15.z;
        local25.alpha = local15.alpha;
        return local25;
      }
      return local15;
    }
  }
}
