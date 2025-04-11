package alternativa.tanks.models.drones {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.sfx.drone.DroneSFXData;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import projects.tanks.clients.flash.commons.models.coloring.IColoring;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class Drone {
    private static var droneMaterialFactory:DroneMaterialFactory = new DroneMaterialFactory();

    private var battleService:BattleService;
    private var tank:Tank;
    private var isLocal:Boolean;
    private var object3D:Object3D;
    private var resource:Tanks3DSResource;
    private var material:TextureMaterial;
    private var textureMaterialRegistry:TextureMaterialRegistry;
    private var coloring:IColoring;
    private var settings:ISettingsService;
    private var position:* = new Vector3();
    private var currentRenderer:DroneRenderer;
    private var onGoRenderer:DroneRenderer;
    private var activationRenderer:DroneRenderer;
    private var deactivationRenderer:DroneRenderer;
    private var isCooldown:Boolean;
    private var isDroneReady:Boolean;
    private var tankIsActive:Boolean = false;
    private var cooldownTimer:int = 0;
    private var enabledBySettings:Boolean = false;
    private var sfxData:DroneSFXData;
    private var droneEffects:DroneEffects;

    public function Drone(param1:Tank, param2:Boolean, param3:BattleService, param4:Tanks3DSResource, param5:ISettingsService, param6:TextureMaterialRegistry, param7:IColoring, param8:DroneSFXData) {
      super();
      this.tank = param1;
      this.isLocal = param2;
      this.battleService = param3;
      this.resource = param4;
      this.settings = param5;
      this.textureMaterialRegistry = param6;
      this.coloring = param7;
      this.sfxData = param8;
      this.enabledBySettings = this.isEnabledBySettings();
      this.initialize();
    }

    public function setState(param1:Boolean) : void {
      this.isDroneReady = param1;
      if(param1) {
        this.startActivation();
      } else {
        this.deactivate();
      }
    }

    public function setInitialCooldownState(param1:int) : void {
      if(param1 > 5000) {
        this.cooldown(param1);
      } else {
        this.isCooldown = false;
      }
    }

    public function cooldown(param1:int) : void {
      this.isCooldown = true;
      this.deactivate();
      this.cooldownTimer = setTimeout(this.onCooldownTimer,param1);
    }

    private function onCooldownTimer() : void {
      this.isCooldown = false;
      this.cooldownTimer = 0;
      this.startActivation();
    }

    private function cancelCooldownTimer() : void {
      if(this.cooldownTimer != 0) {
        clearTimeout(this.cooldownTimer);
        this.cooldownTimer = 0;
      }
    }

    private function isEnabledBySettings() : Boolean {
      return Boolean(this.settings.showLocalDrone) && this.isLocal || Boolean(this.settings.showRemoteDrones) && !this.isLocal;
    }

    private function initialize() : * {
      if(this.isEnabledBySettings()) {
        this.createIfNeed();
        this.startActivation();
        this.droneEffects = new DroneEffects(this.sfxData,this.object3D);
      }
    }

    private function startActivation() : void {
      if(this.isEnabledBySettings() && this.isTankActive() && !this.isCooldown && this.isDroneReady && this.currentRenderer != this.activationRenderer) {
        this.activationRenderer.start();
        if(this.droneEffects != null) {
          this.droneEffects.playActivationSound();
        }
      }
    }

    private function deactivate() : void {
      if(this.currentRenderer != null && this.currentRenderer != this.deactivationRenderer) {
        if(this.tankIsActive) {
          this.deactivationRenderer.start();
        } else {
          this.currentRenderer.stop();
          this.droneEffects.stopSound();
        }
      }
    }

    private function createIfNeed() : void {
      if(this.object3D != null) {
        return;
      }
      this.object3D = this.createObject3D();
      this.onGoRenderer = new DroneOnGoRenderer(this.isLocal,this.tank.getSkin(),this,this.battleService,this.settings);
      this.activationRenderer = new DroneActivationRenderer(this.isLocal,this.tank.getSkin(),this,this.battleService,this.settings);
      this.deactivationRenderer = new DroneDeactivationRenderer(this.isLocal,this.tank.getSkin(),this,this.battleService,this.settings);
    }

    private function createObject3D() : Object3D {
      var local1:Mesh = this.resource.objects[0].clone() as Mesh;
      local1.shadowMapAlphaThreshold = 2;
      local1.depthMapAlphaThreshold = 2;
      this.material = droneMaterialFactory.createMaterial(this.resource,this.coloring);
      local1.setMaterialToAllFaces(this.material);
      local1.visible = false;
      this.battleService.getBattleScene3D().getMapContainer().addChild(local1);
      return local1;
    }

    private function removeObject3D() : void {
      if(this.object3D != null) {
        this.battleService.getBattleScene3D().getMapContainer().removeChild(this.object3D);
      }
    }

    public function transitToActiveState() : void {
      this.onGoRenderer.start();
    }

    public function getPosition() : Vector3 {
      return this.position;
    }

    public function getObject3D() : Object3D {
      return this.object3D;
    }

    public function onTankActiveStateChanged(param1:Boolean) : void {
      this.tankIsActive = param1;
      if(param1) {
        this.startActivation();
      }
    }

    public function destroy() : * {
      droneMaterialFactory.releaseMaterial(this.material);
      this.removeObject3D();
      this.cancelCooldownTimer();
      this.isDroneReady = false;
      this.tankIsActive = false;
    }

    public function isTankActive() : Boolean {
      return this.tankIsActive;
    }

    public function getCurrentRenderer() : DroneRenderer {
      return this.currentRenderer;
    }

    public function setCurrentRenderer(param1:DroneRenderer) : void {
      this.currentRenderer = param1;
    }

    public function updateGameSettings() : void {
      if(!this.enabledBySettings && this.isEnabledBySettings()) {
        this.deactivate();
        this.enabledBySettings = true;
        this.initialize();
      } else if(this.enabledBySettings && !this.isEnabledBySettings()) {
        this.enabledBySettings = false;
        this.deactivate();
      }
    }
  }
}
