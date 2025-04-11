package alternativa.tanks.models.controlpoints {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.TeamDMTargetEvaluator;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleRestartEvent;
  import alternativa.tanks.battle.events.LocalTankActivationEvent;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankLoadedEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.events.death.TankDeadEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.models.battle.battlefield.BattleModel;
  import alternativa.tanks.models.battle.battlefield.BattleType;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
  import alternativa.tanks.models.battle.tdm.TDMCommonTargetEvaluator;
  import alternativa.tanks.models.battle.tdm.TDMHealingGunTargetEvaluator;
  import alternativa.tanks.models.battle.tdm.TDMRailgunTargetEvaluator;
  import alternativa.tanks.models.controlpoints.hud.KeyPoint;
  import alternativa.tanks.models.controlpoints.hud.KeyPointView;
  import alternativa.tanks.models.controlpoints.hud.marker.KeyPointHUDMarker;
  import alternativa.tanks.models.controlpoints.hud.marker.KeyPointHUDMarkers;
  import alternativa.tanks.models.controlpoints.hud.panel.KeyPointsHUDPanel;
  import alternativa.tanks.models.controlpoints.message.ControlPointMessage;
  import alternativa.tanks.models.controlpoints.message.ControlPointMessages;
  import alternativa.tanks.models.controlpoints.sfx.AllBeamProperties;
  import alternativa.tanks.models.controlpoints.sfx.BeamEffects;
  import alternativa.tanks.models.controlpoints.sfx.DominationBeamEffect;
  import alternativa.tanks.models.controlpoints.sound.KeyPointSoundEffects;
  import alternativa.tanks.models.controlpoints.sound.Sounds;
  import alternativa.tanks.models.inventory.IInventoryModel;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.models.inventory.InventoryLock;
  import alternativa.tanks.models.weapon.ricochet.TeamDMRicochetTargetEvaluator;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.cp.ClientPointData;
  import projects.tanks.client.battlefield.models.battle.cp.ControlPointState;
  import projects.tanks.client.battlefield.models.battle.cp.ControlPointsModelBase;
  import projects.tanks.client.battlefield.models.battle.cp.IControlPointsModelBase;
  import projects.tanks.client.battlefield.models.battle.cp.resources.DominationSounds;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class ControlPointsModel extends ControlPointsModelBase implements IControlPointsModelBase, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, BattleModel, IDominationModel {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var effectsMaterialRegistry:EffectsMaterialRegistry;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleGuiService:BattleGUIService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    private var targetEvaluators:Vector.<TeamDMTargetEvaluator>;
    private var guiModel:BattlefieldGUI;
    private var inventoryModel:IInventoryModel;
    private var keyPoints:Dictionary = new Dictionary();
    private var triggers:Vector.<KeyPointTrigger>;
    private var battleEventSupport:BattleEventSupport;
    private var keyPointHUDMarkers:KeyPointHUDMarkers;
    private var dominationPointsHUDPanel:KeyPointsHUDPanel;
    private var localTank:Tank;
    private var tanksInBattle:Dictionary;
    private var gameObject:IGameObject;

    public function ControlPointsModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestart);
      this.battleEventSupport.addEventHandler(LocalTankActivationEvent,this.onLocalTankActivation);
      this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.addEventHandler(TankDeadEvent,this.onTankDeadEvent);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
    }

    private static function getGameObject(param1:IGameObject, param2:Long) : IGameObject {
      return param1.space.getObject(param2);
    }

    private static function getBattleTeam(param1:ControlPointState) : BattleTeam {
      if(param1 == ControlPointState.RED) {
        return BattleTeam.RED;
      }
      if(param1 == ControlPointState.BLUE) {
        return BattleTeam.BLUE;
      }
      throw new Error();
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      this.tanksInBattle[param1.tank.getUser()] = param1.tank;
      var local2:int = this.getPointOccupationBuffer().takeTankPointId(param1.tank.getUser().id);
      if(local2 >= 0) {
        this.createBeamEffect(local2,param1.tank,AllBeamProperties(this.getMyData(AllBeamProperties)));
      }
    }

    private function getMyData(param1:Class) : Object {
      Model.object = this.gameObject;
      var local2:Object = getData(param1);
      Model.popObject();
      return local2;
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      var local2:IGameObject = param1.tank.getUser();
      this.getBeamEffects().removeEffect(local2);
      delete this.tanksInBattle[local2];
    }

    private function onTankLoaded(param1:TankLoadedEvent) : void {
      if(param1.isLocal) {
        this.localTank = param1.tank;
        this.keyPointHUDMarkers.show();
        this.dominationPointsHUDPanel.visible = true;
      }
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      if(param1.tank == this.localTank) {
        this.localTank = null;
      }
    }

    private function onTankDeadEvent(param1:TankDeadEvent) : void {
      this.getBeamEffects().removeEffect(param1.victim);
    }

    private function getBeamEffects() : BeamEffects {
      return BeamEffects(this.getMyData(BeamEffects));
    }

    private function onLocalTankActivation(param1:Object) : void {
      var local3:TeamDMTargetEvaluator = null;
      var local2:BattleTeam = LocalTankActivationEvent(param1).tank.teamType;
      for each(local3 in this.targetEvaluators) {
        local3.setLocalTeamType(local2);
      }
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      this.gameObject = Model.object;
      this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
      this.inventoryModel = IInventoryModel(object.adapt(IInventoryModel));
      this.triggers = new Vector.<KeyPointTrigger>();
      this.tanksInBattle = new Dictionary();
      this.battleEventSupport.activateHandlers();
      putData(PointOccupationBuffer,new PointOccupationBuffer());
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      this.initTargetEvaluators();
      this.initKeyPoints();
      putData(AllBeamProperties,new AllBeamProperties(effectsMaterialRegistry,getInitParam().resources));
      putData(BeamEffects,new BeamEffects());
      putData(Sounds,new Sounds(battleService.soundManager,getInitParam().sounds));
    }

    private function initTargetEvaluators() : void {
      this.targetEvaluators = new Vector.<TeamDMTargetEvaluator>();
      var local1:TDMCommonTargetEvaluator = new TDMCommonTargetEvaluator();
      battleService.setCommonTargetEvaluator(local1);
      this.targetEvaluators.push(local1);
      var local2:TDMHealingGunTargetEvaluator = new TDMHealingGunTargetEvaluator();
      battleService.setHealingGunTargetEvaluator(local2);
      this.targetEvaluators.push(local2);
      var local3:TDMRailgunTargetEvaluator = new TDMRailgunTargetEvaluator();
      battleService.setRailgunTargetEvaluator(local3);
      this.targetEvaluators.push(local3);
      var local4:TeamDMRicochetTargetEvaluator = new TeamDMRicochetTargetEvaluator();
      battleService.setRicochetTargetEvaluator(local4);
      this.targetEvaluators.push(local4);
    }

    private function initKeyPoints() : void {
      var local2:ClientPointData = null;
      var local3:KeyPoint = null;
      var local4:KeyPointTrigger = null;
      var local5:PointOccupationBuffer = null;
      var local6:Long = null;
      this.keyPointHUDMarkers = new KeyPointHUDMarkers(battleService.getBattleScene3D().getCamera());
      battleService.getBattleScene3D().addRenderer(this.keyPointHUDMarkers,0);
      var local1:Vector.<KeyPoint> = new Vector.<KeyPoint>();
      for each(local2 in getInitParam().points) {
        local3 = this.createKeyPoint(local2);
        this.keyPoints[local2.id] = local3;
        battleService.getBattleRunner().addLogicUnit(local3);
        local1.push(local3);
        local4 = new KeyPointTrigger(local3.getPosition(),BattleUtils.toClientScale(getInitParam().keypointTriggerRadius),BattleUtils.toClientScale(getInitParam().minesRestrictionRadius),local2.id,this,battleService.getBattleRunner().getCollisionDetector(),getInitParam().keypointVisorHeight);
        this.triggers.push(local4);
        battleService.getBattleRunner().addTrigger(local4);
        this.keyPointHUDMarkers.addMarker(new KeyPointHUDMarker(local3));
        local5 = this.getPointOccupationBuffer();
        for each(local6 in local2.tankIds) {
          local5.add(local6,local2.id);
        }
      }
      this.dominationPointsHUDPanel = new KeyPointsHUDPanel(local1);
      this.dominationPointsHUDPanel.visible = false;
      battleGuiService.getGuiContainer().addChild(this.dominationPointsHUDPanel);
      battleService.getBattleScene3D().addRenderer(this.dominationPointsHUDPanel,0);
      this.guiModel.addWidget(this.dominationPointsHUDPanel);
      if(battleInfoService.isSpectatorMode()) {
        this.keyPointHUDMarkers.show();
        this.dominationPointsHUDPanel.visible = true;
      }
    }

    private function createKeyPoint(param1:ClientPointData) : KeyPoint {
      var local2:KeyPointView = new KeyPointView(param1.name,battleService.getBattleScene3D(),getInitParam().resources);
      var local3:Vector3 = BattleUtils.getVector3(param1.position);
      var local4:DominationSounds = getInitParam().sounds;
      var local5:KeyPointSoundEffects = new KeyPointSoundEffects(battleService,local4.pointScoreIncreasingSound.sound,local4.pointScoreDecreasingSound.sound);
      var local6:KeyPoint = new KeyPoint(param1.id,param1.name,local3,battleService,this,local5,local2);
      local6.tanksCount = param1.tankIds.length;
      local6.setCaptureState(param1.state);
      local6.setServerProgressData(param1.score,param1.scoreChangeRate);
      return local6;
    }

    private function getPointOccupationBuffer() : PointOccupationBuffer {
      return PointOccupationBuffer(this.getMyData(PointOccupationBuffer));
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      this.targetEvaluators = null;
      battleService.setCommonTargetEvaluator(null);
      battleService.setHealingGunTargetEvaluator(null);
      battleService.setRailgunTargetEvaluator(null);
      battleService.setRicochetTargetEvaluator(null);
      this.battleEventSupport.deactivateHandlers();
      this.dominationPointsHUDPanel.removeFromParent();
      this.dominationPointsHUDPanel = null;
      this.tanksInBattle = null;
    }

    [Obfuscation(rename="false")]
    public function tankEnteredPointZone(param1:int, param2:Long) : void {
      var local3:KeyPoint = this.keyPoints[param1];
      ++local3.tanksCount;
      var local4:Tank = this.tanksInBattle[getGameObject(object,param2)];
      if(local4 != null) {
        this.createBeamEffect(param1,local4,AllBeamProperties(getData(AllBeamProperties)));
      } else {
        this.getPointOccupationBuffer().add(param2,param1);
      }
    }

    private function createBeamEffect(param1:int, param2:Tank, param3:AllBeamProperties) : void {
      var local4:DominationBeamEffect = DominationBeamEffect(battleService.getObjectPool().getObject(DominationBeamEffect));
      var local5:KeyPoint = this.keyPoints[param1];
      var local6:Vector3 = new Vector3();
      local5.readPosition(local6);
      local4.init(param2.getSkin().getTurret3D(),local6,param3.getBeamProperties(param2.teamType),battleService.getExcludedObjects3D());
      this.getBeamEffects().addEffect(param2.getUser(),local4);
    }

    [Obfuscation(rename="false")]
    public function tankLeftPointZone(param1:int, param2:Long) : void {
      var local3:KeyPoint = this.keyPoints[param1];
      --local3.tanksCount;
      var local4:Tank = this.tanksInBattle[getGameObject(object,param2)];
      if(local4 != null) {
        this.getBeamEffects().removeEffect(local4.getUser());
      } else {
        this.getPointOccupationBuffer().remove(param2);
      }
    }

    public function getBattleType() : BattleType {
      return BattleType.DOMINATION;
    }

    [Obfuscation(rename="false")]
    public function setPointProgress(param1:int, param2:Number, param3:Number) : void {
      var local4:KeyPoint = this.keyPoints[param1];
      local4.setServerProgressData(param2,param3);
    }

    [Obfuscation(rename="false")]
    public function setPointState(param1:int, param2:ControlPointState) : void {
      var local3:KeyPoint = this.keyPoints[param1];
      var local4:ControlPointState = local3.getCaptureState();
      local3.setCaptureState(param2);
      if(param2 == ControlPointState.NEUTRAL) {
        this.onPointNeutralized(local3,local4);
      } else {
        this.onPointCaptured(local3);
      }
    }

    private function onPointNeutralized(param1:KeyPoint, param2:ControlPointState) : void {
      var local3:BattleTeam = getBattleTeam(param2);
      var local4:ControlPointMessage = this.getNeutralizationMessage(local3);
      var local5:String = local4.getMessage(param1.getName());
      this.guiModel.showBattleMessage(local4.color,local5);
      var local6:UserAction = local3 == BattleTeam.BLUE ? UserAction.CP_POINT_BLUE_NEUTRAL : UserAction.CP_POINT_RED_NEUTRAL;
      var local7:ControlPointMessage = new ControlPointMessage(0,TanksLocale.TEXT_DOM_POINT);
      this.guiModel.showPointBattleLogMessage(local7.getMessage(param1.getName()),local6);
      this.getSounds().playNeutralizedSound(local3);
    }

    private function getNeutralizationMessage(param1:BattleTeam) : ControlPointMessage {
      if(this.localTank == null) {
        return ControlPointMessages.getLostMessage(param1);
      }
      if(param1 == this.localTank.teamType) {
        return ControlPointMessages.weLostPoint;
      }
      return ControlPointMessages.enemyLostPoint;
    }

    private function onPointCaptured(param1:KeyPoint) : void {
      var local2:BattleTeam = getBattleTeam(param1.getCaptureState());
      var local3:ControlPointMessage = this.getCaptureMessage(local2);
      var local4:String = local3.getMessage(param1.getName());
      this.guiModel.showBattleMessage(local3.color,local4);
      var local5:UserAction = local2 == BattleTeam.BLUE ? UserAction.CP_POINT_NEUTRAL_BLUE : UserAction.CP_POINT_NEUTRAL_RED;
      var local6:ControlPointMessage = new ControlPointMessage(0,TanksLocale.TEXT_DOM_POINT);
      this.guiModel.showPointBattleLogMessage(local6.getMessage(param1.getName()),local5);
      this.getSounds().playCapturingSound(local2);
    }

    private function getCaptureMessage(param1:BattleTeam) : ControlPointMessage {
      if(this.localTank == null) {
        return ControlPointMessages.getCaptureMessage(param1);
      }
      if(param1 == this.localTank.teamType) {
        return ControlPointMessages.weCapturedPoint;
      }
      return ControlPointMessages.enemyCapturedPoint;
    }

    private function resetPoints() : void {
      var local1:KeyPoint = null;
      for each(local1 in this.keyPoints) {
        local1.reset();
      }
    }

    [Obfuscation(rename="false")]
    public function pointCaptureStarted(param1:BattleTeam) : void {
      this.getSounds().playCaptureStartSound(param1);
    }

    [Obfuscation(rename="false")]
    public function pointCaptureStopped(param1:BattleTeam) : void {
      this.getSounds().playCaptureStopSound(param1);
    }

    private function getSounds() : Sounds {
      return Sounds(getData(Sounds));
    }

    public function onEnterPointCapturingZone(param1:int) : void {
      this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
    }

    public function onLeavePointCapturingZone(param1:int) : void {
      this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
    }

    public function onEnterMineRestrictionZone(param1:int) : void {
      this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,true);
    }

    public function onLeaveMineRestrictionZone(param1:int) : void {
      this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,false);
    }

    private function onBattleRestart(param1:Object) : void {
      this.reset();
    }

    private function reset() : void {
      this.resetPoints();
      this.resetTriggers();
    }

    private function resetTriggers() : void {
      var local1:KeyPointTrigger = null;
      for each(local1 in this.triggers) {
        local1.reset();
      }
    }

    public function forceUpdatePoint(param1:int) : void {
      var pointId:int = param1;
      Model.object = this.gameObject;
      try {
        server.forceUpdatePoint(pointId);
      }
      finally {
        Model.popObject();
      }
    }

    [Obfuscation(rename="false")]
    public function stopBattle() : void {
      this.reset();
    }
  }
}
