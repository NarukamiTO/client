package alternativa.tanks.gui.tankpreview {
  import alternativa.engine3d.containers.KDContainer;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.MipMapping;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.View;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.objects.Decal;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.SkyBox;
  import alternativa.tanks.service.battery.BatteriesService;
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
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
  import projects.tanks.clients.flash.resources.drone.Drone3D;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
  import projects.tanks.clients.flash.resources.tanks.Tank3D;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class TankPreviewWindow extends TankWindowWithHeader {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var garageService:GarageService;

    [Inject]
    public static var batteryService:BatteriesService;

    private static const ENTER_FRAME_PRIORITY:Number = -1;
    private static const INITIAL_CAMERA_DIRECTION:Number = -150;
    private static const WINDOW_MARGIN:int = 11;
    private static const SHADOW_ALPHA:Number = 0.7;
    private static const SHADOW_BLUR:Number = 13;
    private static const SHADOW_RESOLUTION:Number = 2.5;
    private static const SHADOW_DIRECTION:Vector3D = new Vector3D(0,0,-1);

    protected var innerBevel:TankWindowInner;
    protected var backgroundEraser:Shape;
    protected var rootContainer:Object3DContainer;
    protected var hangarContainer:Object3DContainer;
    protected var cameraContainer:Object3DContainer;
    protected var camera:Camera3D;
    protected var stateMachine:TankPreviewStateMachine;
    protected var tank:Tank3D;
    protected var drone:Drone3D;

    private var loadedPartsCounter:int = 0;

    protected var backgroundEraserTimer:Timer;
    protected var shadow:Mesh;

    private var shadowMaterial:TextureMaterial;
    private var cams:Array;
    private var tower:Object3D;
    private var tree1:Object3D;
    private var tree2:Object3D;
    private var tree3:Object3D;
    private var bg2:Object3D;
    private var tree4:Object3D;
    private var tree5:Object3D;
    private var bg:Object3D;
    private var window1:Object3D;
    private var window2:Object3D;
    private var window3:Object3D;
    private var walls:Array;
    private var floor:Object3D;
    private var ventilator1:Object3D;
    private var ventilator2:Object3D;
    private var ventfix:Object3D;
    private var firepanel:Object3D;
    private var electropanel:Object3D;
    private var hullMesh:Mesh;
    private var girders:Object3D;
    private var balkl:Object3D;
    private var balk2:Object3D;
    private var lamps:Array;
    private var tops:Object3D;
    private var pandus1:Object3D;
    private var pandus2:Object3D;
    private var others:Array;
    private var ladder1_part1:Mesh;
    private var ladder1_part2:Mesh;
    private var ladder2_part1:Mesh;
    private var ladder2_part2:Mesh;
    private var garageBoxResource:Tanks3DSResource;
    private var skyBox:SkyBox;

    protected var kdTree:KDContainer;

    public function TankPreviewWindow() {
      super();
    }

    public function init(param1:Tanks3DSResource, param2:SkyBox) : void {
      this.garageBoxResource = param1;
      this.skyBox = param2;
      setHeaderId(TanksLocale.TEXT_HEADER_YOUR_TANK);
      this.init3D();
      this.createWindowInnerBevel();
      this.addGarageObjectsToScene(param1);
      this.createScene();
      this.resize(400,300);
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    protected function init3D() : void {
      this.rootContainer = new Object3DContainer();
      this.cams = new Array();
      this.walls = new Array();
      this.lamps = new Array();
      this.others = new Array();
      this.rootContainer.addChild(this.skyBox);
      this.camera = new Camera3D();
      this.camera.view = new View(100,100,GPUCapabilities.constrained);
      this.camera.view.hideLogo();
      addChild(this.camera.view);
      this.cameraContainer = new Object3DContainer();
      this.rootContainer.addChild(this.cameraContainer);
      this.hangarContainer = new Object3DContainer();
      this.rootContainer.addChild(this.hangarContainer);
      this.cameraContainer.addChild(this.camera);
      this.cameraContainer.rotationX = garageService.getCameraPitch() * Math.PI / 180;
      this.camera.y = garageService.getCameraAltitude();
      this.camera.z = garageService.getCameraDistance();
      this.camera.fov = garageService.getCameraFieldOfView();
      this.camera.x = -20;
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
      this.tank.x = -5;
    }

    protected function createDrone(param1:Vector3D) : void {
      var basePosition:Vector3D = param1;
      this.drone = new Drone3D(this.tank,this.camera,basePosition,function():* {
        return batteryService.hasBatteries();
      });
    }

    private function classifyObject(param1:Mesh, param2:int) : void {
      var local3:TextureMaterial = null;
      if(param1.faceList.material is TextureMaterial) {
        local3 = TextureMaterial(param1.faceList.material);
        local3.texture = this.garageBoxResource.getTextureForObject(param2);
        param1.setMaterialToAllFaces(local3);
      } else {
        param1.setMaterialToAllFaces(param1.faceList.material);
      }
      if(param1.name.indexOf("cam") >= 0) {
        this.cams.push(param1);
      } else if(param1.name == "Tower") {
        this.tower = param1;
      } else if(param1.name == "tree1") {
        this.tree1 = param1;
      } else if(param1.name == "tree2") {
        this.tree2 = param1;
      } else if(param1.name == "tree3") {
        this.tree3 = param1;
      } else if(param1.name == "bg2") {
        this.bg2 = param1;
      } else if(param1.name == "tree4") {
        this.tree4 = param1;
      } else if(param1.name == "tree5") {
        this.tree5 = param1;
      } else if(param1.name == "bg") {
        this.bg = param1;
      } else if(param1.name == "wall_10") {
        this.window1 = param1;
      } else if(param1.name == "wall_12") {
        this.window2 = param1;
      } else if(param1.name == "wall_13") {
        this.window3 = param1;
      } else if(param1.name.indexOf("wall") >= 0) {
        this.walls.push(param1);
      } else if(param1.name == "Object06") {
        this.floor = param1;
      } else if(param1.name == "vent_1") {
        this.ventilator1 = param1;
      } else if(param1.name == "vent_2") {
        this.ventilator2 = param1;
      } else if(param1.name == "Object39") {
        this.ventfix = param1;
      } else if(param1.name == "Object15") {
        this.firepanel = param1;
      } else if(param1.name == "Object20") {
        this.electropanel = param1;
      } else if(param1.name == "girders") {
        this.girders = param1;
      } else if(param1.name == "Object27") {
        this.balkl = param1;
      } else if(param1.name == "Object08") {
        this.balk2 = param1;
      } else if(param1.name.indexOf("lamp") >= 0) {
        this.lamps.push(param1);
      } else if(param1.name == "Object133") {
        this.tops = param1;
      } else if(param1.name == "Object23") {
        this.ladder1_part1 = param1;
      } else if(param1.name == "Object02") {
        this.ladder1_part2 = param1;
      } else if(param1.name == "Object24") {
        this.ladder2_part1 = param1;
      } else if(param1.name == "Object96") {
        this.ladder2_part2 = param1;
      } else if(param1.name == "pandus_1") {
        this.pandus1 = param1;
      } else if(param1.name == "pandus_2") {
        this.pandus2 = param1;
      } else if(param1.name == "Object92") {
        this.others.push(param1);
      } else {
        this.others.push(param1);
      }
    }

    protected function addGarageObjectsToScene(param1:Tanks3DSResource) : void {
      var local2:int = 0;
      var local3:Mesh = null;
      local2 = 0;
      while(local2 < param1.objects.length) {
        local3 = param1.objects[local2] as Mesh;
        if(local3 != null) {
          if(local3.name != "stuff15") {
            this.classifyObject(local3,local2);
          }
        }
        local2++;
      }
      this.others.push(this.ladder1_part1);
      this.others.push(this.ladder1_part2);
      this.others.push(this.ladder2_part1);
      this.others.push(this.ladder2_part2);
      this.tower = this.toBSP(this.tower);
      this.bg = this.toBSP(this.bg);
      local2 = 0;
      while(local2 < this.walls.length) {
        this.walls[local2] = this.toBSP(this.walls[local2]);
        local2++;
      }
      this.firepanel = this.toBSP(this.firepanel);
      this.electropanel = this.toBSP(this.electropanel);
      this.girders = this.toBSP(this.girders);
      this.balkl = this.toBSP(this.balkl);
      local2 = 0;
      while(local2 < this.lamps.length) {
        this.lamps[local2] = this.toBSP(this.lamps[local2]);
        local2++;
      }
      this.tops = this.toBSP(this.tops);
      this.pandus1 = this.toBSP(this.pandus1);
      this.pandus2 = this.toBSP(this.pandus2);
      local2 = 0;
      while(local2 < this.others.length) {
        this.others[local2] = this.toBSP(this.others[local2]);
        local2++;
      }
      this.ventilator1.y += 10;
      this.ventilator2.y += 10;
    }

    private function toBSP(param1:Object3D) : BSP {
      var local2:BSP = new BSP();
      local2.createTree(param1 as Mesh,false);
      local2.name = param1.name;
      local2.matrix = param1.matrix;
      local2.useLight = param1.useLight;
      local2.useShadowMap = param1.useShadowMap;
      local2.shadowMapAlphaThreshold = param1.shadowMapAlphaThreshold;
      local2.boundMinX = param1.boundMinX;
      local2.boundMinY = param1.boundMinY;
      local2.boundMinZ = param1.boundMinZ;
      local2.boundMaxX = param1.boundMaxX;
      local2.boundMaxY = param1.boundMaxY;
      local2.boundMaxZ = param1.boundMaxZ;
      return local2;
    }

    private function addChild1(param1:Object3D) : void {
      if(param1 != null) {
        this.hangarContainer.addChild(param1);
      }
    }

    protected function createScene() : void {
      var local1:Object3D = null;
      var local2:Vector.<Object3D> = null;
      var local3:Object3D = null;
      this.addChild1(this.tower);
      this.addChild1(this.tree1);
      this.addChild1(this.tree2);
      this.addChild1(this.tree3);
      this.addChild1(this.bg2);
      this.addChild1(this.tree4);
      this.addChild1(this.tree5);
      this.addChild1(this.bg);
      this.addChild1(this.window1);
      this.addChild1(this.window2);
      this.addChild1(this.window3);
      for each(local3 in this.walls) {
        this.addChild1(local3);
      }
      this.addChild1(this.floor);
      this.addChild1(this.ventilator1);
      this.addChild1(this.ventilator2);
      this.addChild1(this.ventfix);
      this.addChild1(this.firepanel);
      this.addChild1(this.electropanel);
      this.addChild1(this.girders);
      this.addChild1(this.balkl);
      this.addChild1(this.balk2);
      for each(local3 in this.lamps) {
        this.addChild1(local3);
      }
      this.addChild1(this.tops);
      this.kdTree = new KDContainer();
      this.kdTree.batched = false;
      this.kdTree.threshold = 5;
      this.addChild1(this.kdTree);
      local2 = new Vector.<Object3D>();
      for each(local1 in this.others) {
        local2.push(local1);
      }
      local2.push(this.pandus1);
      local2.push(this.pandus2);
      this.kdTree.createTree(local2);
      this.createTank();
      this.createDrone(new Vector3D(100,-200,300));
      this.kdTree.addChild(this.tank);
      this.kdTree.addChild(this.drone);
    }

    private function attach(param1:Mesh, param2:Mesh) : void {
      var local3:Vector.<Face> = param1.faces;
      local3[local3.length - 1].next = param2.faceList;
      param2.faceList = null;
      var local4:Vector.<Vertex> = param1.vertices;
      param1.vertices[local4.length - 1].next = param2.vertexList;
      param2.vertexList = null;
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
      this.drone.render();
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
      var local1:BitmapData = null;
      removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      if(this.backgroundEraserTimer != null) {
        this.backgroundEraserTimer.stop();
        this.backgroundEraserTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onBackgroundEraserTimerComplete);
        this.backgroundEraserTimer = null;
      }
      if(this.shadowMaterial != null) {
        local1 = this.shadowMaterial.texture;
        this.shadowMaterial.dispose();
        local1.dispose();
      }
      this.hullMesh = null;
      this.innerBevel = null;
      this.rootContainer = null;
      this.cameraContainer = null;
      this.camera.view.clear();
      this.camera = null;
      this.tank.destroy();
      this.drone.destroy();
      this.tank = null;
      this.drone = null;
      this.shadow = null;
      if(this.kdTree != null) {
        this.kdTree.parent.removeChild(this.kdTree);
        this.kdTree.destroyTree();
      }
    }

    public function setHull(param1:Tanks3DSResource) : void {
      this.hullMesh = Mesh(param1.objects[0]);
      this.tank.setHull(param1);
      this.onTankPartLoaded();
      this.drone.onHullChanged();
    }

    public function setTurret(param1:Tanks3DSResource) : void {
      this.tank.setTurret(param1);
      this.onTankPartLoaded();
    }

    public function setColorMap(param1:BitmapData) : void {
      this.tank.setColorMap(param1);
      this.drone.setColorMap(param1);
      this.onTankPartLoaded();
    }

    public function setTextureAnimation(param1:MultiframeTextureResource) : void {
      this.tank.setTextureAnimation(param1);
      this.drone.setTextureAnimation(param1);
      this.onTankPartLoaded();
    }

    public function setDrone(param1:Tanks3DSResource) : void {
      this.drone.set3DResource(param1);
    }

    private function onTankPartLoaded() : void {
      if(this.loadedPartsCounter < 3) {
        ++this.loadedPartsCounter;
      }
      if(this.loadedPartsCounter == 3) {
        if(this.shadow != null && Boolean(this.tank.contains(this.shadow))) {
          this.tank.removeChild(this.shadow);
        }
        this.shadow = this.createShadow(this.hullMesh,SHADOW_DIRECTION,SHADOW_RESOLUTION,SHADOW_BLUR,SHADOW_ALPHA);
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
      var local25:BitmapData = null;
      var local26:Decal = null;
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
      if(this.shadowMaterial != null) {
        local25 = this.shadowMaterial.texture;
        this.shadowMaterial.dispose();
        local25.dispose();
      }
      this.shadowMaterial = local14;
      if(GPUCapabilities.gpuEnabled) {
        local26 = new Decal();
        local26.createGeometry(local15,true);
        local26.x = local15.x;
        local26.y = local15.y;
        local26.z = local15.z;
        local26.alpha = local15.alpha;
        return local26;
      }
      return local15;
    }
  }
}
