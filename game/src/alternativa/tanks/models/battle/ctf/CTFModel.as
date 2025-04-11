package alternativa.tanks.models.battle.ctf {
  import alternativa.engine3d.core.Object3D;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.battlefield.BattleModel;
  import alternativa.tanks.models.battle.battlefield.BattleType;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import alternativa.tanks.models.battle.commonflag.CommonFlag;
  import alternativa.tanks.models.battle.commonflag.Flag;
  import alternativa.tanks.models.battle.commonflag.FlagNotification;
  import alternativa.tanks.models.battle.commonflag.ICommonFlagModeModel;
  import alternativa.tanks.models.battle.commonflag.IFlagModeInitilizer;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator.FlagIndicator;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
  import alternativa.tanks.models.battle.gui.markers.PointHudIndicator;
  import flash.media.Sound;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.ctf.CaptureTheFlagModelBase;
  import projects.tanks.client.battlefield.models.battle.pointbased.ctf.CaptureTheFlagSoundFX;
  import projects.tanks.client.battlefield.models.battle.pointbased.ctf.ICaptureTheFlagModelBase;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class CTFModel extends CaptureTheFlagModelBase implements ICaptureTheFlagModelBase, IFlagModeInitilizer, FlagNotification, ObjectLoadListener, BattleModel {
    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var userInfoService:BattleUserInfoService;

    [Inject]
    public static var localeService:ILocaleService;

    private var guiModel:BattlefieldGUI;
    private var flagDropSound:Sound;
    private var flagReturnSound:Sound;
    private var flagTakeSound:Sound;
    private var winSound:Sound;
    private var markers:CTFHudIndicators;
    private var flagMessages:CTFMessages = new CTFMessages();

    public function CTFModel() {
      super();
    }

    public function getBattleType() : BattleType {
      return BattleType.CTF;
    }

    public function objectLoaded() : void {
      this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
      this.flagMessages.init(this.guiModel);
      var local1:CaptureTheFlagSoundFX = getInitParam().sounds;
      this.flagDropSound = local1.flagDropSound.sound;
      this.flagReturnSound = local1.flagReturnSound.sound;
      this.flagTakeSound = local1.flagTakeSound.sound;
      this.winSound = local1.winSound.sound;
    }

    public function init(param1:Vector.<ClientFlag>, param2:Vector.<ClientTeamPoint>) : void {
      var local3:ICommonFlagModeModel = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel));
      var local4:Object3D = local3.createBasePoint(param2[0],getInitParam().redPedestalModel);
      var local5:Object3D = local3.createBasePoint(param2[1],getInitParam().bluePedestalModel);
      var local6:Flag = new Flag(param2[0].id,param2[0].flagBasePosition,BattleTeam.RED,getInitParam().redFlagSprite);
      var local7:Flag = new Flag(param2[1].id,param2[1].flagBasePosition,BattleTeam.BLUE,getInitParam().blueFlagSprite);
      this.markers = new CTFHudIndicators(local6,local4,local7,local5);
      battleService.getBattleScene3D().addRenderer(this.markers);
      local3.initFlag(local6,param1[0]);
      local3.initFlag(local7,param1[1]);
      this.initIndicatorState(local6);
      this.initIndicatorState(local7);
    }

    private function initIndicatorState(param1:Flag) : void {
      switch(param1.state) {
        case FlagState.CARRIED:
          this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_BLINK);
          this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_CARRIED);
          break;
        case FlagState.DROPPED:
          this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_EMPTY);
          this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_DROPPED);
          break;
        case FlagState.EXILED:
        case FlagState.FLYING:
        case FlagState.AT_BASE:
        default:
          this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_DEFAULT);
          this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_DEFAULT);
      }
    }

    public function guiShowFlagDropped(param1:CommonFlag) : void {
      this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_EMPTY);
      this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_DROPPED);
    }

    public function guiShowFlagCarried(param1:CommonFlag) : void {
      this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_BLINK);
      this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_CARRIED);
    }

    public function guiShowFlagAtBase(param1:CommonFlag) : void {
      this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_DEFAULT);
      this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_OUT);
    }

    public function notifyFlagTaken(param1:CommonFlag, param2:Tank) : void {
      this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_BLINK);
      this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_CARRIED);
      var local3:UserAction = param2.teamType == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_PICK_REDFLAG : UserAction.CTF_RED_PLAYER_PICK_BLUEFLAG;
      this.guiModel.showUserBattleLogMessage(param2.user.id,local3);
      battleService.soundManager.playSound(this.flagTakeSound);
    }

    public function notifyFlagReturned(param1:CommonFlag, param2:IGameObject) : void {
      var local3:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
      if(battleInfoService.isSpectatorMode()) {
        this.showFlagReturnMessageForSpectator(param1.teamType,param2);
      } else if(Boolean(local3) && Boolean(local3.teamType)) {
        this.showFlagReturnMessage(param1.teamType,param2);
      }
      battleService.soundManager.playSound(this.flagReturnSound);
    }

    private function showFlagReturnMessageForSpectator(param1:BattleTeam, param2:IGameObject) : void {
      var local3:UserAction = null;
      if(Boolean(param2)) {
        local3 = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
        this.guiModel.showUserBattleLogMessage(param2.id,local3);
      } else {
        local3 = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
        this.guiModel.showBattleLogMessage(local3);
      }
    }

    private function showFlagReturnMessage(param1:BattleTeam, param2:IGameObject) : void {
      var local4:UserAction = null;
      var local3:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
      if(Boolean(param2)) {
        local4 = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
        this.guiModel.showUserBattleLogMessage(param2.id,local4);
      } else {
        local4 = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
        this.guiModel.showBattleLogMessage(local4);
      }
    }

    public function notifyFlagDropped(param1:CommonFlag) : void {
      this.showFlagDropMessage(param1);
      this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_EMPTY);
      this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_DROPPED);
    }

    private function showFlagDropMessage(param1:CommonFlag) : void {
      var local2:UserAction = null;
      if(param1.carrier == null) {
        return;
      }
      try {
        local2 = param1.carrier.teamType == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_DROP_REDFLAG : UserAction.CTF_RED_PLAYER_DROP_BLUEFLAG;
        this.guiModel.showUserBattleLogMessage(param1.carrier.getUser().id,local2);
        battleService.soundManager.playSound(this.flagDropSound);
      }
      catch(e:Error) {
      }
    }

    public function notifyFlagDelivered(param1:CommonFlag, param2:Tank) : void {
      var local4:FlagMessage = null;
      var local3:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
      if(battleInfoService.isSpectatorMode()) {
        local4 = this.flagMessages.getFlagMessageForSpectator(CTFMessages.MESSAGE_CAPTURED,param2.teamType);
      } else {
        local4 = this.flagMessages.getFlagMessage(CTFMessages.MESSAGE_CAPTURED,local3.teamType == param2.teamType);
      }
      this.flagMessages.showBattleMessage(local4,param2.getUser());
      var local5:UserAction = param2.teamType == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_DELIVER_REDFLAG : UserAction.CTF_RED_PLAYER_DELIVER_BLUEFLAG;
      this.guiModel.showUserBattleLogMessage(param2.user.id,local5);
      battleService.soundManager.playSound(this.winSound);
      this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_DEFAULT);
      this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_DEFAULT);
    }

    public function notifyFlagFacedOff(param1:CommonFlag) : void {
    }

    public function notifyReadyToFaceOff() : void {
    }

    public function notifyFlagThrown(param1:CommonFlag) : void {
    }
  }
}
