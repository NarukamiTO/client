package alternativa.tanks.models.battle.rugby {
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Decal;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.BattleRestartEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.assault.IndicatorStateAdapter;
  import alternativa.tanks.models.battle.battlefield.BattleModel;
  import alternativa.tanks.models.battle.battlefield.BattleType;
  import alternativa.tanks.models.battle.commonflag.CommonFlag;
  import alternativa.tanks.models.battle.commonflag.FlagNotification;
  import alternativa.tanks.models.battle.commonflag.ICommonFlagModeModel;
  import alternativa.tanks.models.battle.commonflag.IFlagModeInitilizer;
  import alternativa.tanks.models.battle.commonflag.MarkersUtils;
  import alternativa.tanks.models.battle.ctf.FlagMessage;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator.FlagIndicator;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
  import projects.tanks.client.battlefield.models.battle.pointbased.rugby.IRugbyModelBase;
  import projects.tanks.client.battlefield.models.battle.pointbased.rugby.RugbyCC;
  import projects.tanks.client.battlefield.models.battle.pointbased.rugby.RugbyModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class RugbyModel extends RugbyModelBase implements IRugbyModelBase, IFlagModeInitilizer, FlagNotification, ObjectLoadListener, ObjectUnloadListener, BattleModel, LogicUnit {
    [Inject]
    public static var materialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    private var ballSpawnZones:Vector.<Mesh>;
    private var ballSpawnZoneMaterial:TextureMaterial;
    private var guiModel:BattlefieldGUI;
    private var messages:RugbyMessages = new RugbyMessages();
    private var battleEventSupport:BattleEventSupport;
    private var ball:Ball;
    private var nextNotificationTime:int;

    public function RugbyModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
      this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestart);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
    }

    private static function createBallSpawnZone(param1:Vector3d, param2:TextureMaterial) : Mesh {
      var local3:Decal = null;
      local3 = new Decal();
      var local4:Number = 500;
      var local5:Vertex = local3.addVertex(-local4,local4,0,0,0);
      var local6:Vertex = local3.addVertex(-local4,-local4,0,0,1);
      var local7:Vertex = local3.addVertex(local4,-local4,0,1,1);
      var local8:Vertex = local3.addVertex(local4,local4,0,1,0);
      local3.addQuadFace(local5,local6,local7,local8,param2);
      local3.calculateFacesNormals();
      local3.calculateVerticesNormals();
      local3.x = param1.x;
      local3.y = param1.y;
      local3.z = param1.z + 0.001;
      battleService.getBattleScene3D().addObject(local3);
      return local3;
    }

    public function objectLoaded() : void {
      this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
      this.battleEventSupport.activateHandlers();
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      if(param1.tank.getUser().id == this.ball.carrierId) {
        this.ball.setRemoteCarrier(this.ball.carrierId,param1.tank);
        this.initHudIndicator();
      }
    }

    private function initHudIndicator() : void {
      var local1:BattleTeam = null;
      if(this.ball.state == FlagState.CARRIED) {
        local1 = this.ball.carrier.teamType;
        this.guiModel.setIndicatorState(local1,FlagIndicator.STATE_BLINK);
        this.guiModel.setIndicatorState(this.oppositeTeam(local1),FlagIndicator.STATE_DEFAULT);
      } else {
        this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
      }
    }

    public function objectUnloaded() : void {
      var local1:Mesh = null;
      this.battleEventSupport.deactivateHandlers();
      for each(local1 in this.ballSpawnZones) {
        battleService.getBattleScene3D().removeObject(local1);
      }
      materialRegistry.releaseMaterial(this.ballSpawnZoneMaterial);
      this.ballSpawnZones = null;
      this.ballSpawnZoneMaterial = null;
      this.ball = null;
      battleService.getBattleRunner().removeLogicUnit(this);
    }

    public function init(param1:Vector.<ClientFlag>, param2:Vector.<ClientTeamPoint>) : void {
      var local5:ClientTeamPoint = null;
      var local6:ClientFlag = null;
      var local7:IndicatorStateAdapter = null;
      var local3:ICommonFlagModeModel = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel));
      var local4:RugbyCC = getInitParam();
      this.ballSpawnZones = new Vector.<Mesh>();
      this.ballSpawnZoneMaterial = materialRegistry.getMaterial(local4.ballSpawnZone.data);
      for each(local5 in param2) {
        local7 = new IndicatorStateAdapter(Vector3.fromVector3d(local5.flagBasePosition));
        if(local5.id == -1) {
          local3.createBasePoint(local5,local4.blueGoalModel);
          MarkersUtils.createMarkers(BattleTeam.BLUE,local4.blueBallMarker.data,local4.bigBlueBallMarker.data,local7);
        } else if(local5.id == -2) {
          local3.createBasePoint(local5,local4.redGoalModel);
          MarkersUtils.createMarkers(BattleTeam.RED,local4.redBallMarker.data,local4.bigRedBallMarker.data,local7);
        } else {
          this.ballSpawnZones.push(createBallSpawnZone(local5.flagBasePosition,this.ballSpawnZoneMaterial));
          local3.addMineProtectedZone(Vector3.fromVector3d(local5.flagBasePosition));
        }
      }
      local6 = param1[0];
      this.ball = new Ball(local6.flagId,local4.ballRadius,local4.ballModel,local4.parachuteResource,local4.parachuteInnerResource,local4.cordResource);
      MarkersUtils.createMarkers(null,local4.greenBallMarker.data,local4.bigGreenBallMarker.data,this.ball);
      local3.initFlag(this.ball,local6);
    }

    public function guiShowFlagDropped(param1:CommonFlag) : void {
      this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_EMPTY,FlagIndicator.STATE_DEFAULT);
    }

    public function guiShowFlagCarried(param1:CommonFlag) : void {
      this.guiModel.setIndicatorState(param1.carrier.teamType,FlagIndicator.STATE_BLINK);
      this.guiModel.setIndicatorState(this.oppositeTeam(param1.carrier.teamType),FlagIndicator.STATE_DEFAULT);
    }

    public function guiShowFlagAtBase(param1:CommonFlag) : void {
      this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
    }

    public function notifyFlagTaken(param1:CommonFlag, param2:Tank) : void {
      var local3:String = this.messages.getBattleLogMessage(RugbyMessages.TAKE);
      this.guiModel.showUserBattleLogMessage(param2.getUser().id,UserAction.RGB_PLAYER_PICK_BALL);
      var local4:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
      var local5:Boolean = Boolean(local4) && local4.teamType == param2.teamType;
      var local6:SoundResource = local5 ? getInitParam().sounds.ballTakePositiveSound : getInitParam().sounds.ballTakeNegativeSound;
      battleService.soundManager.playSound(local6.sound);
    }

    public function notifyFlagReturned(param1:CommonFlag, param2:IGameObject) : void {
    }

    public function notifyFlagDropped(param1:CommonFlag) : void {
      this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
      if(param1.carrier != null) {
        this.guiModel.showUserBattleLogMessage(param1.carrierId,UserAction.RGB_PLAYER_LOOSE_BALL);
        this.ballDroppedCommon(param1);
      }
    }

    public function notifyFlagThrown(param1:CommonFlag) : void {
      this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
      if(param1.carrier != null) {
        this.guiModel.showUserBattleLogMessage(param1.carrierId,UserAction.RGB_PLAYER_THREW_BALL);
        this.ballDroppedCommon(param1);
      }
    }

    private function ballDroppedCommon(param1:CommonFlag) : void {
      var local2:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
      var local3:Boolean = Boolean(local2) && local2.teamType != param1.carrier.teamType;
      var local4:SoundResource = local3 ? getInitParam().sounds.ballDropPositiveSound : getInitParam().sounds.ballDropNegativeSound;
      battleService.soundManager.playSound(local4.sound);
    }

    public function notifyFlagDelivered(param1:CommonFlag, param2:Tank) : void {
      this.guiModel.showUserBattleLogMessage(param2.getUser().id,UserAction.RGB_PLAYER_DELIVER_BALL);
      var local3:FlagMessage = this.messages.getMessage(RugbyMessages.GOAL,param2.teamType);
      this.guiModel.showBattleMessage(local3.color,local3.text);
      this.guiModel.setIndicatorState(param2.teamType,FlagIndicator.STATE_FLASHING);
      this.guiModel.setIndicatorState(this.oppositeTeam(param2.teamType),FlagIndicator.STATE_DEFAULT);
      var local4:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
      var local5:Boolean = Boolean(local4) && local4.teamType == param2.teamType;
      var local6:SoundResource = local5 ? getInitParam().sounds.goalPositiveSound : getInitParam().sounds.goalNegativeSound;
      battleService.soundManager.playSound(local6.sound);
      this.nextNotificationTime = getTimer() + 1500;
      battleService.getBattleRunner().addLogicUnit(this);
    }

    public function runLogic(param1:int, param2:int) : void {
      if(param1 >= this.nextNotificationTime) {
        this.notifyReadyToFaceOff();
        battleService.getBattleRunner().removeLogicUnit(this);
      }
    }

    public function getBattleType() : BattleType {
      return BattleType.RUGBY;
    }

    public function notifyFlagFacedOff(param1:CommonFlag) : void {
      var local2:FlagMessage = this.messages.getFacedOffMessage();
      this.guiModel.showBattleMessage(local2.color,local2.text);
      this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
      battleService.soundManager.playSound(getInitParam().sounds.ballFaceOffSound.sound);
    }

    public function notifyReadyToFaceOff() : void {
      this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
      var local1:FlagMessage = this.messages.getReadyToFaceOffMessage();
      this.guiModel.showBattleMessage(local1.color,local1.text);
    }

    private function onBattleFinish(param1:Object) : void {
      if(this.ball.isFlying()) {
        this.ball.stopFalling();
        this.ball.returnToBase();
      }
    }

    private function onBattleRestart(param1:Object) : void {
      FlagNotification(object.adapt(FlagNotification)).notifyReadyToFaceOff();
    }

    private function oppositeTeam(param1:BattleTeam) : BattleTeam {
      if(param1 == BattleTeam.BLUE) {
        return BattleTeam.RED;
      }
      if(param1 == BattleTeam.RED) {
        return BattleTeam.BLUE;
      }
      return BattleTeam.NONE;
    }
  }
}
