package alternativa.tanks.models.battle.battlefield {
  import alternativa.math.Vector3;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.physics.collision.types.AABB;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.BattleView;
  import alternativa.tanks.battle.SpeedHackChecker;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.BattleRestartEvent;
  import alternativa.tanks.battle.events.MapBuildingCompleteEvent;
  import alternativa.tanks.battle.events.SpeedHackEvent;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.battle.scene3d.DecalFactory;
  import alternativa.tanks.bg.IBackgroundService;
  import alternativa.tanks.bonuses.BonusCache;
  import alternativa.tanks.camera.CameraController;
  import alternativa.tanks.camera.CameraTarget;
  import alternativa.tanks.camera.FlyCameraController;
  import alternativa.tanks.camera.FollowCameraController;
  import alternativa.tanks.camera.controllers.spectator.SpectatorSupport;
  import alternativa.tanks.gui.error.ErrorForm;
  import alternativa.tanks.gui.error.ErrorNotification;
  import alternativa.tanks.models.battle.battlefield.keyboard.AdditionUserTitleSwitcher;
  import alternativa.tanks.models.battle.battlefield.map.MapBuilder;
  import alternativa.tanks.models.coloradjust.IColorAdjust;
  import alternativa.tanks.models.map.IBattleMap;
  import alternativa.tanks.models.mapbonuslight.IMapBonusLight;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.models.tank.support.DialogWindowSupport;
  import alternativa.tanks.models.weapon.ricochet.RicochetTargetEvaluator;
  import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;
  import alternativa.tanks.models.weapon.shared.ConicAreaTargetValidator;
  import alternativa.tanks.models.weapon.shared.HealingGunTargetEvaluator;
  import alternativa.tanks.models.weapon.shared.RailgunTargetEvaluator;
  import alternativa.tanks.models.weapon.shared.streamweapon.DefaultConicAreaTargetValidator;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.SettingsServiceEvent;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.tanks.services.battleinput.BattleInputLockType;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import alternativa.tanks.services.battlereadiness.BattleReadinessService;
  import alternativa.tanks.services.colortransform.ColorTransformService;
  import alternativa.tanks.services.colortransform.ColorTransformUtils;
  import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
  import alternativa.tanks.services.memoryleakguard.MemoryLeakTrackerService;
  import alternativa.tanks.services.mipmapping.MipMappingService;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.ISound3DEffect;
  import alternativa.tanks.sound.ISoundManager;
  import alternativa.tanks.utils.DataValidationErrorEvent;
  import alternativa.tanks.utils.DataValidator;
  import alternativa.tanks.utils.DebugPanel;
  import alternativa.tanks.utils.KeyCodes;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import alternativa.types.Long;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.media.Sound;
  import flash.net.SharedObject;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.logging.serverlog.ServerLogTarget;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadPostListener;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.connection.ControlConnectionSender;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.battlefield.BattlefieldModelBase;
  import projects.tanks.client.battlefield.models.battle.battlefield.IBattlefieldModelBase;
  import projects.tanks.client.battlefield.models.battle.battlefield.fps.FpsStatisticType;
  import projects.tanks.client.battlefield.models.battle.battlefield.types.HitTraceData;
  import projects.tanks.client.battlefield.models.map.DynamicShadowParams;
  import projects.tanks.client.battlefield.models.map.FogParams;
  import projects.tanks.client.battleservice.BattleRoundParameters;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.flash.resources.resource.MapResource;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  [ModelInfo]
  public class BattlefieldModel extends BattlefieldModelBase implements IBattlefieldModelBase, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadPostListener, BattleService, BattleSfx, GameActionListener {
    [Inject]
    public static var logService:LogService;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var addressService:TanksAddressService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var dataValidator:DataValidator;

    [Inject]
    public static var settings:ISettingsService;

    [Inject]
    public static var backgroundService:IBackgroundService;

    [Inject]
    public static var mipMappingService:MipMappingService;

    [Inject]
    public static var materialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var colorTransformService:ColorTransformService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var memoryLeakTrackerService:MemoryLeakTrackerService;

    [Inject]
    public static var battleReadinessService:BattleReadinessService;

    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var battleGuiService:BattleGUIService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var lightingAdjustService:ILightingEffectsService;

    [Inject]
    public static var notificationService:INotificationService;

    private static const cameraPosition:Vector3 = new Vector3();
    private static const cameraAngles:Vector3 = new Vector3();
    private static const CHANNEL:String = "battle";
    private static const SERVER_CHANNEL:String = "battle2server";
    private static const SPECTATOR_ADDITIONAL_HEIGHT:int = 5000;
    private static const LAST_SERVER:String = "LAST_SERVER";

    private const objectPool:ObjectPool = new ObjectPool();

    private var debugPanel:DebugPanel;

    private const fullTimeStatistics:TimeStatistics = new TimeStatistics();

    private var followCameraController:FollowCameraController;
    private var flyCameraController:FlyCameraController;
    private var initialFrameRate:Number;
    private var battleEventSupport:BattleEventSupport;
    private var commonTargetEvaluator:CommonTargetEvaluator;

    private const conicAreaTargetValidator:ConicAreaTargetValidator = new DefaultConicAreaTargetValidator();

    private var healingGunTargetEvaluator:HealingGunTargetEvaluator;
    private var railgunTargetEvaluator:RailgunTargetEvaluator;
    private var ricochetTargetEvaluator:RicochetTargetEvaluator;
    private var battleActive:Boolean;
    private var ambientSound:AmbientSound;
    private var speedHackChecker:SpeedHackChecker;
    private var frameRateController:StageFrameRateController;
    private var skyboxRevolver:Object3DRevolver;
    private var battleScene:BattleScene3D;
    private var battleView:BattleView;
    private var battleRunner:BattleRunner;
    private var battleData:BattleData;
    private var gameObject:IGameObject;
    private var logger:Logger;
    private var serverLogger:Logger;
    private var battleCounter:int;
    private var mapId:Long;
    private var localTankLoad:Boolean;
    private var lightingCommands:LightingCommands;
    private var criticalErrorLogged:Boolean;
    private var localTankPaused:Boolean;

    public function BattlefieldModel() {
      super();
      logService.addLogTarget(new ServerLogTarget(new ControlConnectionSender(),SERVER_CHANNEL + ":e"));
      this.serverLogger = logService.getLogger(SERVER_CHANNEL);
      this.logger = logService.getLogger(CHANNEL);
      this.initBattleEventHandlers();
    }

    private static function showErrorAlert() : void {
      var local1:ErrorForm = new ErrorForm(localeService);
      local1.setErrorText(localeService.getText(TanksLocale.TEXT_ERROR_FATAL));
      local1.setSupportUrl(localeService.getText(TanksLocale.TEXT_FATAL_ERROR_WIKI_LINK));
      display.contentLayer.addChild(local1);
    }

    private function initBattleEventHandlers() : void {
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(SpeedHackEvent,this.onSpeedHack);
      this.battleEventSupport.addEventHandler(DataValidationErrorEvent,this.onDataValidationError);
      this.battleEventSupport.addEventHandler(TimeStatisticsTimerEvent,this.onTimeStatisticsTimer);
      this.battleEventSupport.activateHandlers();
    }

    [Obfuscation(rename="false")]
    public function traceHit(param1:HitTraceData) : void {
      HitTracer.trace(param1);
    }

    [Obfuscation(rename="false")]
    public function battleFinish() : void {
      this.battleActive = false;
      battleEventDispatcher.dispatchEvent(new BattleFinishEvent());
      this.sendTimeStatisticsToServer();
    }

    private function sendTimeStatisticsToServer() : void {
      if(this.gameObject != null) {
        Model.object = this.gameObject;
        try {
          server.sendTimeStatisticsCommand(this.getFpsStatisticType(),this.fullTimeStatistics.getAverageFPS());
        }
        finally {
          Model.popObject();
        }
      }
    }

    private function getFpsStatisticType() : FpsStatisticType {
      var local1:FpsStatisticType = null;
      if(!GPUCapabilities.gpuEnabled) {
        local1 = FpsStatisticType.SOFTWARE;
      } else if(GPUCapabilities.constrained) {
        local1 = FpsStatisticType.HARDWARE_CONSTRAINT;
      } else {
        local1 = FpsStatisticType.HARDWARE_BASELINE;
      }
      return local1;
    }

    [Obfuscation(rename="false")]
    public function battleRestart() : void {
      this.battleActive = true;
      battleEventDispatcher.dispatchEvent(new BattleRestartEvent());
      this.fullTimeStatistics.reset();
      battleInfoService.battleRestart();
    }

    [Obfuscation(rename="false")]
    public function battleStart(param1:BattleRoundParameters) : void {
      this.battleActive = true;
      battleInfoService.battleStart(param1);
    }

    public function addSound3DEffect(param1:ISound3DEffect) : void {
      this.battleRunner.getSoundManager().addEffect(param1);
    }

    private function addListeners() : void {
      display.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      display.stage.addEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKey));
      display.stage.addEventListener(KeyboardEvent.KEY_UP,getFunctionWrapper(this.onKey));
      battleInputService.addGameActionListener(this);
    }

    private function removeListeners() : void {
      battleInputService.removeGameActionListener(this);
      Model.object = this.gameObject;
      try {
        display.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
        display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKey));
        display.stage.removeEventListener(KeyboardEvent.KEY_UP,getFunctionWrapper(this.onKey));
      }
      finally {
        Model.popObject();
      }
    }

    private function onEnterFrame(param1:Event) : void {
      var event:Event = param1;
      try {
        this.tick();
      }
      catch(e:Error) {
        processTickError(e);
      }
    }

    private function tick() : void {
      this.fullTimeStatistics.update();
      this.battleRunner.tick();
    }

    private function processTickError(param1:Error) : void {
      if(!this.criticalErrorLogged) {
        this.criticalErrorLogged = true;
        this.serverLogger.error(param1.message);
        this.showErrorNotification();
      }
    }

    private function showErrorNotification() : void {
      notificationService.addNotification(new ErrorNotification());
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      if(param1 == GameActionEnum.OPEN_GARAGE && param2) {
        if(Boolean(lobbyLayoutService.inBattle()) && Boolean(battleInfoService.enterGarageCausesExitBattle)) {
          lobbyLayoutService.exitFromBattleToGarageThroughAlert();
        } else {
          lobbyLayoutService.showGarage();
        }
      }
    }

    private function onKey(param1:KeyboardEvent) : void {
      if(!battleInputService.isInputLocked()) {
        if(param1.type == KeyboardEvent.KEY_DOWN) {
          this.handleKeyDown(param1);
        }
      }
    }

    private function handleKeyDown(param1:KeyboardEvent) : void {
      switch(param1.keyCode) {
        case KeyCodes.M:
          this.onDebugKey1(param1);
          break;
        case KeyCodes.B:
          this.onDebugKey2(param1);
      }
    }

    private function onDebugKey1(param1:KeyboardEvent) : void {
    }

    private function onDebugKey2(param1:KeyboardEvent) : void {
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      this.saveServerNumber();
      ++this.battleCounter;
      this.gameObject = object;
      battleInputService.unlock(BattleInputLockType.INACTIVE_BATTLE);
      battleInfoService.spectatorMode = getInitParam().spectator;
      if(getInitParam().spectator) {
        battleInputService.forbidMouseLock();
      } else {
        battleInputService.allowMouseLock();
      }
      if(getInitParam().proBattle) {
        battleInfoService.setCurrentSelectionBattle(getInitParam().battleId,getInitParam().range.min,getInitParam().range.max);
        battleInfoService.currentBattleId = getInitParam().battleId;
      } else {
        battleInfoService.currentBattleId = null;
      }
      battleInfoService.setInBattle(true);
      battleInfoService.reArmorEnabled = getInitParam().reArmorEnabled;
      battleInfoService.withoutSupplies = getInitParam().withoutSupplies;
      battleInfoService.withoutBonuses = getInitParam().withoutBonuses;
      battleInfoService.withoutDrones = getInitParam().withoutDrones;
      battleInfoService.enterGarageCausesExitBattle = false;
      this.battleActive = getInitParam().active;
      var local1:IBattleMap = this.getBattleMap();
      colorTransformService.setColorTransform(ColorTransformUtils.calculateColorTransform(local1.getDynamicShadowParams(),getInitParam().colorTransformMultiplier));
      this.initBattleData();
      this.initBattleCore();
      this.initBattleMap();
      this.initColorAdjust();
      this.initBonusAdjust();
      this.battleRunner.getSoundManager().setMute(true);
      this.ambientSound = new AmbientSound(this.battleData.ambientSound,this.battleRunner.getSoundManager());
      this.addSettingsListeners();
      this.initialFrameRate = display.stage.frameRate;
      this.speedHackChecker = new SpeedHackChecker(battleEventDispatcher);
      this.fullTimeStatistics.reset();
      this.addListeners();
      this.startTimeStatisticsTimer();
      BattlefieldEvents(object.adapt(BattlefieldEvents)).onBattleLoaded();
    }

    public function getLightingSfx() : LightingSfx {
      return new LightingSfx(getInitParam().mineExplosionLighting);
    }

    private function saveServerNumber() : void {
      var local1:Number = Number(addressService.getServerNumber());
      var local2:SharedObject = SharedObject.getLocal("launcherStorage");
      local2.data[LAST_SERVER] = local1;
      local2.flush();
    }

    private function clearServerNumber() : void {
      var local1:SharedObject = SharedObject.getLocal("launcherStorage");
      if(local1.data.hasOwnProperty(LAST_SERVER)) {
        delete local1.data[LAST_SERVER];
        local1.flush();
      }
    }

    private function initBonusAdjust() : void {
      var local1:IMapBonusLight = IMapBonusLight(getInitParam().map.adapt(IMapBonusLight));
      lightingAdjustService.setBonusLighting(local1.getBonusLightIntensity(),local1.getHWBonusColorAdjust(),local1.getSoftBonusColorAdjust());
    }

    private function initColorAdjust() : void {
      var local1:IColorAdjust = IColorAdjust(getInitParam().map.adapt(IColorAdjust));
      colorTransformService.setColorAdjust(local1.getSoftHeat(),local1.getSoftFrost(),local1.getHWHeat(),local1.getHWFrost());
    }

    private function addSettingsListeners() : void {
      settings.addEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.settingsAccepted);
    }

    private function removeSettingsListeners() : void {
      settings.removeEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.settingsAccepted);
    }

    private function getBattleMap() : IBattleMap {
      return IBattleMap(getInitParam().map.adapt(IBattleMap));
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      this.setGraphicSettings();
      if(getInitParam().spectator) {
        this.initSpectatorMode();
      } else {
        this.initNonSpectatorMode();
      }
      battleEventDispatcher.dispatchEvent(new BattleLoadEvent());
      battleInfoService.battleLoad();
      putData(AdditionUserTitleSwitcher,new AdditionUserTitleSwitcher());
    }

    private function startTimeStatisticsTimer() : void {
      var local1:TimeStatisticsTimer = new TimeStatisticsTimer(battleEventDispatcher);
      local1.start();
    }

    [Obfuscation(rename="false")]
    public function objectUnloadedPost() : void {
      battleInputService.lock(BattleInputLockType.INACTIVE_BATTLE);
      this.battleActive = false;
      this.clearServerNumber();
      battleEventDispatcher.dispatchEvent(new BattleUnloadEvent());
      this.frameRateController.restoreStageParams();
      this.frameRateController = null;
      this.removeSettingsListeners();
      this.removeListeners();
      this.battleScene.shutdown();
      this.battleRunner.shutdown();
      this.battleView.removeFromScreen();
      this.battleView.destroy();
      this.battleView = null;
      this.battleScene = null;
      this.battleRunner = null;
      this.battleData = null;
      display.stage.removeChild(this.debugPanel);
      display.stage.frameRate = this.initialFrameRate;
      this.debugPanel = null;
      this.skyboxRevolver = null;
      this.speedHackChecker.stop();
      this.speedHackChecker = null;
      backgroundService.drawBg();
      battleInfoService.setInBattle(false);
      battleInfoService.resetCurrentBattle();
      dataValidator.removeAllValidators();
      this.gameObject = null;
      colorTransformService.setColorTransform(null);
      OSGi.getInstance().unregisterService(BattleService);
      battleReadinessService.reset();
      battleGuiService.hide();
      this.followCameraController = null;
      this.flyCameraController = null;
      BonusCache.clear();
      this.localTankLoad = false;
      this.getObjectPool().clear();
      this.localTankPaused = false;
    }

    private function initBattleData() : void {
      this.battleData = new BattleData();
      this.battleData.respawnDurationMs = getInitParam().respawnDuration;
      this.battleData.setIdleKickPeriod(getInitParam().idleKickPeriodMsec);
      this.battleData.ambientSound = this.getBattleMap().getEnvironmentSound().sound;
      this.battleData.battleFinishSound = getInitParam().battlefieldSounds.battleFinishSound.sound;
      this.battleData.tankExplosionSound = getInitParam().battlefieldSounds.killSound.sound;
    }

    private function lightingChanged(param1:uint, param2:uint, param3:Number, param4:Number, param5:uint) : void {
    }

    public function initBattleCore() : void {
      OSGi.getInstance().registerService(BattleService,this);
      this.battleScene = new BattleScene3D(display.stage,materialRegistry,getInitParam().shadowMapCorrectionFactor);
      memoryLeakTrackerService.track(this.battleScene,this.battleCounter.toString());
      var local1:IBattleMap = this.getBattleMap();
      var local2:FogParams = local1.getFogParams();
      var local3:DynamicShadowParams = local1.getDynamicShadowParams();
      this.battleScene.setupFog(local2.color,local2.alpha,local2.nearLimit,local2.farLimit);
      this.battleScene.setupDynamicShadows(local3.lightColor,local3.shadowColor,local3.angleX,local3.angleZ);
      this.battleView = new BattleView();
      memoryLeakTrackerService.track(this.battleView,this.battleCounter.toString());
      var local4:Number = Number(local1.getGravity());
      this.battleRunner = new BattleRunner(local4,this.battleData.ambientSound,battleEventDispatcher);
      memoryLeakTrackerService.track(this.battleRunner,this.battleCounter.toString());
      this.battleScene.setDecalFactory(new DecalFactory(this.battleRunner.getCollisionDetector()));
      this.battleScene.initDustEngine(this,local1.getDustParams());
      this.battleScene.setSSAOColor(local1.getSSAOColor());
      this.frameRateController = new StageFrameRateController(display.stage,this.battleRunner,this.fullTimeStatistics);
      this.frameRateController.setAdaptiveFrameRate(settings.adaptiveFPS);
      this.battleView.addToScreen(battleGuiService.getViewportContainer());
      this.debugPanel = new DebugPanel();
      this.debugPanel.visible = false;
      display.stage.addChild(this.debugPanel);
      this.followCameraController = new FollowCameraController();
      this.flyCameraController = new FlyCameraController(getInitParam().respawnDuration);
      putData(DialogWindowSupport,new DialogWindowSupport());
    }

    private function initBattleMap() : void {
      this.initSkyBox();
      var local1:IBattleMap = this.getBattleMap();
      var local2:MapResource = local1.getMapResource();
      this.mapId = local2.id;
      var local3:XML = XML(local2.mapData.toString());
      var local4:MapBuilder = new MapBuilder(materialRegistry,local2.libRegistry);
      local4.build(local3,getFunctionWrapper(this.onMapBuildingComplete));
      putData(MapBuilder,local4);
    }

    private function initSkyBox() : void {
      var local1:IBattleMap = this.getBattleMap();
      var local2:BattleSkyBox = new BattleSkyBox(local1.getSkybox());
      this.battleScene.setSkyBox(local2);
      this.battleScene.setSkyBoxVisible(settings.showSkyBox);
      var local3:Vector3 = BattleUtils.getVector3(local1.getSkyboxRevolutionAxis());
      var local4:Number = Number(local1.getSkyBoxRevolutionSpeed());
      this.skyboxRevolver = new Object3DRevolver(local2,local3,local4);
      this.battleScene.addRenderer(this.skyboxRevolver,0);
    }

    private function onMapBuildingComplete() : void {
      var local1:MapBuilder = MapBuilder(getData(MapBuilder));
      this.followCameraController.setCollisionObject(local1.getMapContainer());
      this.fixHardwareKeyboardInputBug();
      battleReadinessService.unlockMap();
      battleEventDispatcher.dispatchEvent(new MapBuildingCompleteEvent());
    }

    private function fixHardwareKeyboardInputBug() : void {
      display.stage.frameRate += 1;
      display.stage.frameRate -= 1;
    }

    private function initSpectatorMode() : void {
      var local1:Vector3 = new Vector3();
      var local2:Vector3 = new Vector3();
      var local3:MapBuilder = MapBuilder(getData(MapBuilder));
      this.fillInInitialSpectatorState(local1,local2,local3.getMapBounds());
      this.battleScene.getCamera().setPosition(local1);
      this.battleScene.getCamera().lookAt(local2.x,local2.y,local2.z);
      var local4:SpectatorSupport = new SpectatorSupport();
      putData(SpectatorSupport,local4);
      var local5:SpectatorUserTitleRenderer = new SpectatorUserTitleRenderer();
      putData(SpectatorUserTitleRenderer,local5);
      this.battleScene.setUserTitleRenderer(local5);
      battleReadinessService.unlockUser();
      if(!lobbyLayoutService.isSwitchInProgress()) {
        battleInputService.unlock(BattleInputLockType.MODAL_DIALOG);
      }
    }

    public function fillInInitialSpectatorState(param1:Vector3, param2:Vector3, param3:AABB) : void {
      param1.x = param3.minX;
      param1.y = param3.minY;
      param1.z = param3.maxZ + SPECTATOR_ADDITIONAL_HEIGHT;
      param2.x = (param3.minX + param3.maxX) / 2;
      param2.y = (param3.minY + param3.maxY) / 2;
      param2.z = param3.minZ;
    }

    private function initNonSpectatorMode() : void {
    }

    public function setCameraController(param1:CameraController) : void {
      this.battleScene.setCameraController(param1);
    }

    public function setFollowCameraTarget(param1:CameraTarget) : void {
      this.followCameraController.setTarget(param1);
    }

    public function getObjectPool() : ObjectPool {
      return this.objectPool;
    }

    public function getBattleRunner() : BattleRunner {
      return this.battleRunner;
    }

    public function getBattleScene3D() : BattleScene3D {
      return this.battleScene;
    }

    public function getBattleView() : BattleView {
      return this.battleView;
    }

    public function getCommonTargetEvaluator() : CommonTargetEvaluator {
      return this.commonTargetEvaluator;
    }

    public function setCommonTargetEvaluator(param1:CommonTargetEvaluator) : void {
      this.commonTargetEvaluator = param1;
    }

    public function getConicAreaTargetValidator() : ConicAreaTargetValidator {
      return this.conicAreaTargetValidator;
    }

    public function getHealingGunTargetEvaluator() : HealingGunTargetEvaluator {
      return this.healingGunTargetEvaluator;
    }

    public function setHealingGunTargetEvaluator(param1:HealingGunTargetEvaluator) : void {
      this.healingGunTargetEvaluator = param1;
    }

    public function getRailgunTargetEvaluator() : RailgunTargetEvaluator {
      return this.railgunTargetEvaluator;
    }

    public function setRailgunTargetEvaluator(param1:RailgunTargetEvaluator) : void {
      this.railgunTargetEvaluator = param1;
    }

    public function getIdleKickPeriod() : int {
      return this.battleData.getIdleKickPeriod();
    }

    public function getTankExplosionSound() : Sound {
      return this.battleData.tankExplosionSound;
    }

    public function get soundManager() : ISoundManager {
      return this.battleRunner.getSoundManager();
    }

    public function addGraphicEffect(param1:GraphicEffect) : void {
      this.battleScene.addGraphicEffect(param1);
    }

    public function activateFollowCamera() : void {
      this.setCameraController(this.followCameraController);
    }

    public function lockFollowCamera() : void {
      this.followCameraController.setLocked(true);
    }

    public function unlockFollowCamera() : void {
      this.followCameraController.setLocked(false);
    }

    public function setFollowCameraState(param1:Vector3, param2:Vector3) : void {
      this.followCameraController.setCurrentState(param1,param2);
    }

    public function activateFlyCamera(param1:Vector3, param2:Vector3) : void {
      if(this.battleScene.getCameraController() != this.followCameraController) {
        return;
      }
      this.followCameraController.getCameraState(param1,param2,cameraPosition,cameraAngles);
      this.flyCameraController.init(cameraPosition,cameraAngles);
      this.battleScene.setCameraController(this.flyCameraController);
    }

    public function isBattleActive() : Boolean {
      return this.battleActive;
    }

    public function getExcludedObjects3D() : Dictionary {
      return this.battleScene.getExcludedObjects();
    }

    public function getRicochetTargetEvaluator() : RicochetTargetEvaluator {
      return this.ricochetTargetEvaluator;
    }

    public function setRicochetTargetEvaluator(param1:RicochetTargetEvaluator) : void {
      this.ricochetTargetEvaluator = param1;
    }

    private function onSpeedHack(param1:SpeedHackEvent) : void {
      var event:SpeedHackEvent = param1;
      Model.object = this.gameObject;
      try {
        server.dg(Vector.<int>(event.deltas));
      }
      finally {
        Model.popObject();
      }
    }

    private function onDataValidationError(param1:DataValidationErrorEvent) : void {
      this.reportDataValidationError(param1.type);
    }

    private function reportDataValidationError(param1:int) : void {
      var type:int = param1;
      Model.object = this.gameObject;
      try {
        server.kd(type);
      }
      finally {
        Model.popObject();
      }
    }

    private function onTimeStatisticsTimer(param1:Object) : void {
      this.sendTimeStatisticsToServer();
    }

    private function updateSoundSettings() : void {
      var local1:Boolean = false;
      if(battleReadinessService.isBattleReady()) {
        local1 = Boolean(settings.muteSound);
        this.battleRunner.getSoundManager().setMute(local1);
        this.ambientSound.play(!local1 && Boolean(settings.bgSound));
      }
    }

    private function settingsAccepted(param1:Event) : void {
      if(this.gameObject != null) {
        this.battleScene.setSkyBoxVisible(settings.showSkyBox);
        this.updateSoundSettings();
        this.setGraphicSettings();
        this.frameRateController.setAdaptiveFrameRate(settings.adaptiveFPS);
      }
    }

    private function setGraphicSettings() : void {
      this.battleScene.enableAutoQuality(settings.graphicsAutoQuality,this.mapId.toString());
      if(!settings.graphicsAutoQuality) {
        this.battleScene.enableFog(settings.fog);
        this.battleScene.enableAmbientShadows(settings.shadows);
        this.battleScene.enableDynamicShadows(settings.dynamicShadows);
        this.battleScene.enableSoftTransparency(settings.softParticles);
        this.battleScene.enableDust(settings.dust);
        this.battleScene.enableSSAO(settings.ssao);
        this.battleScene.enableDynamicLighting(settings.dynamicLighting);
        this.battleScene.enableAntialiasing(settings.antialiasing);
      }
      this.battleScene.enableLighting(true);
      mipMappingService.setMipMapping(settings.mipMapping);
    }

    public function setBillboardImage(param1:BitmapData) : void {
      this.battleScene.setBillboardImage(param1);
    }

    public function unlockBattle() : void {
      battleGuiService.show();
      this.battleScene.enableRendering();
      this.updateSoundSettings();
    }

    public function getPhysicsTime() : int {
      return this.battleRunner.getPhysicsTime();
    }

    public function setLocalTankLoaded() : void {
      this.localTankLoad = true;
    }

    public function isLocalTankFirstLoad() : Boolean {
      return !this.localTankLoad;
    }

    public function getRespawnDurationMs() : int {
      return this.battleData.respawnDurationMs;
    }

    public function isLocalTankPaused() : Boolean {
      return this.localTankPaused;
    }

    public function setLocalTankPaused(param1:Boolean) : void {
      this.localTankPaused = param1;
    }

    public function getBattle() : IGameObject {
      return this.gameObject;
    }
  }
}
