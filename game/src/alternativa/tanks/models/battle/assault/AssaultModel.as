package alternativa.tanks.models.battle.assault {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleRestartEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.battlefield.BattleModel;
  import alternativa.tanks.models.battle.battlefield.BattleType;
  import alternativa.tanks.models.battle.commonflag.CommonFlag;
  import alternativa.tanks.models.battle.commonflag.Flag;
  import alternativa.tanks.models.battle.commonflag.FlagNotification;
  import alternativa.tanks.models.battle.commonflag.ICommonFlagModeModel;
  import alternativa.tanks.models.battle.commonflag.IFlagModeInitilizer;
  import alternativa.tanks.models.battle.commonflag.MarkersUtils;
  import alternativa.tanks.models.battle.ctf.FlagMessage;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
  import alternativa.tanks.models.battle.gui.markers.PointHudIndicator;
  import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.media.Sound;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.assault.AssaultCC;
  import projects.tanks.client.battlefield.models.battle.pointbased.assault.AssaultModelBase;
  import projects.tanks.client.battlefield.models.battle.pointbased.assault.AssaultSoundFX;
  import projects.tanks.client.battlefield.models.battle.pointbased.assault.IAssaultModelBase;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class AssaultModel extends AssaultModelBase implements IAssaultModelBase, IFlagModeInitilizer, FlagNotification, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, BattleModel {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var lightingEffectsService:ILightingEffectsService;

    [Inject]
    public static var materialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private var guiModel:BattlefieldGUI;
    private var flagReturnSound:Sound;
    private var flagTakeSound:Sound;
    private var winSound:Sound;
    private var flagLostSound:Sound;
    private var flagHudIndicators:AssaultHudIndicators;
    private var messages:AssaultMessages = new AssaultMessages();
    private var battleEventSupport:BattleEventSupport;
    private var flags:Vector.<Flag> = new Vector.<Flag>();

    public function AssaultModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestart);
    }

    public function getBattleType() : BattleType {
      return BattleType.AS;
    }

    public function objectLoaded() : void {
      this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
      var local1:AssaultSoundFX = getInitParam().sounds;
      this.flagReturnSound = local1.flagReturnSound.sound;
      this.flagTakeSound = local1.flagTakeSound.sound;
      this.winSound = local1.winSound.sound;
      this.flagLostSound = local1.flagDropSound.sound;
    }

    public function objectLoadedPost() : void {
      this.battleEventSupport.activateHandlers();
    }

    public function objectUnloaded() : void {
      this.battleEventSupport.deactivateHandlers();
    }

    public function init(param1:Vector.<ClientFlag>, param2:Vector.<ClientTeamPoint>) : void {
      var local6:ClientTeamPoint = null;
      var local7:ClientFlag = null;
      var local8:Flag = null;
      var local9:Flag = null;
      var local10:Object3D = null;
      var local3:ICommonFlagModeModel = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel));
      var local4:Dictionary = new Dictionary();
      var local5:AssaultCC = getInitParam();
      this.flagHudIndicators = new AssaultHudIndicators();
      for each(local6 in param2) {
        if(local6.id >= 0) {
          local4[local6.id] = local6.flagBasePosition;
        }
      }
      for each(local7 in param1) {
        local9 = new Flag(local7.flagId,local4[local7.flagId],BattleTeam.RED,local5.flagSprite);
        this.flags.push(local9);
        local3.initFlag(local9,local7);
        this.flagHudIndicators.addRedFlag(local7.flagId,local9);
      }
      for each(local6 in param2) {
        if(local6.id < 0) {
          local3.createBasePoint(local6,local5.pointPedestalModel);
          MarkersUtils.createMarkers(BattleTeam.BLUE,local5.pointSmallMarker.data,local5.pointBigMarker.data,new IndicatorStateAdapter(Vector3.fromVector3d(local6.flagBasePosition)),true);
        } else {
          local10 = local3.createBasePoint(local6,local5.flagPedestalModel);
          this.flagHudIndicators.addRedBase(local6.id,local10);
        }
      }
      battleService.getBattleScene3D().addRenderer(this.flagHudIndicators);
      for each(local8 in this.flags) {
        this.flagHudIndicators.setFlagState(local8.id,local8.state == FlagState.CARRIED ? PointHudIndicator.STATE_CARRIED : PointHudIndicator.STATE_DEFAULT);
      }
      if(battleInfoService.isSpectatorMode()) {
        this.flagHudIndicators.setLocalTeam(BattleTeam.NONE);
      }
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      var local2:BattleTeam = null;
      var local3:Flag = null;
      if(param1.isLocal) {
        local2 = param1.tank.teamType;
        this.flagHudIndicators.setLocalTeam(local2);
        for each(local3 in this.flags) {
          local3.hideIndicatorOnBase = local2 == BattleTeam.BLUE;
        }
      }
    }

    private function onBattleRestart(param1:BattleRestartEvent) : void {
      var local2:Flag = null;
      for each(local2 in this.flags) {
        this.flagHudIndicators.setFlagState(local2.id,PointHudIndicator.STATE_DEFAULT);
      }
    }

    public function guiShowFlagDropped(param1:CommonFlag) : void {
      this.guiModel.showUserBattleLogMessage(param1.carrierId,UserAction.ASL_RED_PLAYER_DROP_FLAG);
    }

    public function guiShowFlagCarried(param1:CommonFlag) : void {
    }

    public function guiShowFlagAtBase(param1:CommonFlag) : void {
    }

    public function notifyFlagTaken(param1:CommonFlag, param2:Tank) : void {
      battleService.soundManager.playSound(this.flagTakeSound);
      this.flagHudIndicators.setFlagState(param1.id,PointHudIndicator.STATE_CARRIED);
      this.guiModel.showUserBattleLogMessage(param2.getUser().id,UserAction.ASL_RED_PLAYER_PICK_FLAG);
    }

    public function notifyFlagReturned(param1:CommonFlag, param2:IGameObject) : void {
      battleService.soundManager.playSound(this.flagReturnSound);
      this.flagHudIndicators.setFlagState(param1.id,PointHudIndicator.STATE_DEFAULT);
    }

    public function notifyFlagDropped(param1:CommonFlag) : void {
      battleService.soundManager.playSound(this.flagLostSound);
      if(param1.carrier == null) {
        this.guiModel.showBattleLogMessage(UserAction.ASL_RED_PLAYER_DROP_FLAG);
      } else {
        this.guiModel.showUserBattleLogMessage(param1.carrierId,UserAction.ASL_RED_PLAYER_DROP_FLAG);
      }
    }

    public function notifyFlagDelivered(param1:CommonFlag, param2:Tank) : void {
      var local3:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
      var local4:FlagMessage = this.messages.getMessage(Boolean(local3) ? local3.teamType : null);
      this.guiModel.showBattleMessage(local4.color,local4.text);
      this.guiModel.showUserBattleLogMessage(param2.getUser().id,UserAction.ASL_RED_PLAYER_DELIVER_FLAG);
      battleService.soundManager.playSound(this.winSound);
      this.flagHudIndicators.setFlagState(param1.id,PointHudIndicator.STATE_DEFAULT);
    }

    public function notifyFlagFacedOff(param1:CommonFlag) : void {
    }

    public function notifyReadyToFaceOff() : void {
    }

    public function notifyFlagThrown(param1:CommonFlag) : void {
    }
  }
}
