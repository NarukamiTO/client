package alternativa.tanks.models.battle.statistics.fps {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.LocalTankActivationEvent;
  import alternativa.tanks.battle.events.LocalTankKilledEvent;
  import alternativa.tanks.battle.events.PauseActivationEvent;
  import alternativa.tanks.battle.events.PauseDeactivationEvent;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.service.settings.ISettingsService;
  import flash.events.Event;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.models.statistics.fps.FpsStatisticsModelBase;
  import projects.tanks.client.battlefield.models.statistics.fps.IFpsStatisticsModelBase;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
  import projects.tanks.clients.flash.commons.services.layout.LobbyLayoutService;

  [ModelInfo]
  public class FpsStatisticsModel extends FpsStatisticsModelBase implements IFpsStatisticsModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var lobbyLayoutService:LobbyLayoutService;

    private const HARDWARE_BIT:int = 1 << 0;
    private const CONSTRAINT_BIT:int = 1 << 1;
    private const AUTO_QUALITY_BIT:int = 1 << 3;
    private const DYNAMIC_SHADOWS_BIT:int = 1 << 4;
    private const DEEP_SHADOWS_BIT:int = 1 << 5;
    private const SHADOW_UNDER_TANK:int = 1 << 6;
    private const FOG_BIT:int = 1 << 7;
    private const SOFT_PARTICLES_BIT:int = 1 << 8;
    private const DUST_BIT:int = 1 << 9;
    private const ANTIALIASING_BIT:int = 1 << 10;
    private const DYNAMIC_LIGHTING_BIT:int = 1 << 11;
    private const SECOND:int = 1000;
    private const MINIMAL_DURATION:int = 10000;

    private var duration:int;
    private var settings:int;
    private var lastTime:int;
    private var numTicks:int;
    private var autoSettingFeatures:Vector.<CameraStatisticFeature>;
    private var battleEventSupport:BattleEventSupport;
    private var isTankSpawned:Boolean;
    private var isPauseEnabled:Boolean;

    public function FpsStatisticsModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      display.stage.addEventListener(Event.ENTER_FRAME,getFunctionWrapper(this.onEnterFrame));
      this.autoSettingFeatures = new Vector.<CameraStatisticFeature>();
      this.autoSettingFeatures.push(new CameraStatisticFeature("shadowMapStrength",this.DYNAMIC_SHADOWS_BIT),new CameraStatisticFeature("ssaoStrength",this.DEEP_SHADOWS_BIT),new CameraStatisticFeature("shadowsStrength",this.SHADOW_UNDER_TANK),new CameraStatisticFeature("fogStrength",this.FOG_BIT),new CameraStatisticFeature("softTransparencyStrength",this.SOFT_PARTICLES_BIT),new CameraStatisticFeature("deferredLightingStrength",this.DYNAMIC_LIGHTING_BIT));
      this.addEventListeners();
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      display.stage.removeEventListener(Event.ENTER_FRAME,getFunctionWrapper(this.onEnterFrame));
    }

    private function onEnterFrame(param1:Event) : void {
      var local3:int = 0;
      var local2:int = getTimer();
      if(!this.isPauseEnabled && this.isTankSpawned && !this.isAutoQualityInProgress()) {
        local3 = this.getSettings();
        if(this.settings != local3) {
          this.sendStatisticsToServer();
          this.duration = 0;
          this.numTicks = 0;
          this.settings = local3;
        }
        this.duration += local2 - this.lastTime;
        ++this.numTicks;
      }
      this.sendStatisticsToServer();
      this.lastTime = local2;
    }

    private function isAutoQualityInProgress() : Boolean {
      var local1:CameraStatisticFeature = null;
      for each(local1 in this.autoSettingFeatures) {
        if(local1.isTesting()) {
          return true;
        }
      }
      return false;
    }

    private function sendStatisticsToServer() : void {
      if(this.duration < this.MINIMAL_DURATION) {
        return;
      }
      server.collectStatistics(this.numTicks,this.duration,this.getSettings());
      this.numTicks = 0;
      this.duration = 0;
    }

    private function getSettings() : int {
      var local2:CameraStatisticFeature = null;
      var local3:BattleScene3D = null;
      var local4:GameCamera = null;
      var local1:int = 0;
      if(GPUCapabilities.gpuEnabled) {
        local1 |= this.HARDWARE_BIT;
      }
      if(GPUCapabilities.constrained) {
        local1 |= this.CONSTRAINT_BIT;
      }
      for each(local2 in this.autoSettingFeatures) {
        local1 |= local2.getMask();
      }
      local3 = battleService.getBattleScene3D();
      local4 = local3.getCamera();
      if(local4.view.antiAliasEnabled) {
        local1 |= this.ANTIALIASING_BIT;
      }
      if(local4.softTransparencyStrength == 1 && local3.getDustEngine().enabled) {
        local1 |= this.DUST_BIT;
      }
      if(settingsService.graphicsAutoQuality) {
        local1 |= this.AUTO_QUALITY_BIT;
      }
      return local1;
    }

    private function addEventListeners() : void {
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(LocalTankActivationEvent,this.localTankActivation);
      this.battleEventSupport.addEventHandler(LocalTankKilledEvent,this.localTankKilled);
      this.battleEventSupport.addEventHandler(PauseActivationEvent,this.onPauseStarted);
      this.battleEventSupport.addEventHandler(PauseDeactivationEvent,this.onPauseFinished);
      this.battleEventSupport.activateHandlers();
    }

    private function localTankActivation(param1:Object) : void {
      this.isTankSpawned = true;
    }

    private function localTankKilled(param1:Object) : void {
      this.isTankSpawned = false;
    }

    private function onPauseStarted(param1:Object) : void {
      this.isPauseEnabled = true;
    }

    private function onPauseFinished(param1:Object) : void {
      this.isPauseEnabled = false;
    }
  }
}
