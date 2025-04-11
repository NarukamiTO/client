package alternativa.tanks.models.tank {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.BodyState;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.UserTitleRenderer;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;
  import alternativa.utils.clearDictionary;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.AutoClosable;

  public class RegularUserTitleRenderer implements UserTitleRenderer, AutoClosable {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleService:BattleService;

    private static const DISTANCE_TO_SHOW_TITLES:EncryptedNumber = new EncryptedNumberImpl(7000);
    private static const DISTANCE_TO_HIDE_TITLES:EncryptedNumber = new EncryptedNumberImpl(7050);

    private var localTank:Tank;
    private var battleEventSupport:BattleEventSupport;

    private const remoteTanksInBattle:Dictionary = new Dictionary();

    public function RegularUserTitleRenderer(param1:Tank, param2:Dictionary) {
      super();
      this.localTank = param1;
      this.remoteTankAddToBattle(param2);
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      this.battleEventSupport.activateHandlers();
    }

    private function remoteTankAddToBattle(param1:Dictionary) : void {
      var local2:Tank = null;
      for each(local2 in param1) {
        if(local2 != this.localTank) {
          this.remoteTanksInBattle[local2] = true;
        }
      }
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      if(param1.tank != this.localTank) {
        this.remoteTanksInBattle[param1.tank] = true;
      }
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      if(param1.tank != this.localTank) {
        delete this.remoteTanksInBattle[param1.tank];
      }
    }

    public function renderUserTitles() : void {
      var local4:* = undefined;
      var local1:BattleScene3D = battleService.getBattleScene3D();
      var local2:GameCamera = local1.getCamera();
      var local3:Vector3 = local2.position;
      for(local4 in this.remoteTanksInBattle) {
        this.updateTitleVisibility(local4,local3);
      }
    }

    private function updateTitleVisibility(param1:Tank, param2:Vector3) : void {
      if(param1.health > 0) {
        if(this.localTank.isSameTeam(param1.teamType)) {
          param1.showTitle();
        } else {
          this.updateTitleForEnemyTank(param1,param2);
        }
      } else {
        param1.hideTitle();
      }
    }

    private function updateTitleForEnemyTank(param1:Tank, param2:Vector3) : void {
      var local3:Body = param1.getBody();
      var local4:BodyState = local3.state;
      var local5:Vector3 = local4.position;
      var local6:Number = local5.x - param2.x;
      var local7:Number = local5.y - param2.y;
      var local8:Number = local5.z - param2.z;
      var local9:Number = Math.sqrt(local6 * local6 + local7 * local7 + local8 * local8);
      if(local9 >= DISTANCE_TO_HIDE_TITLES.getNumber() || param1.isInvisible(param2)) {
        param1.hideTitle();
      } else if(local9 < DISTANCE_TO_SHOW_TITLES.getNumber()) {
        param1.showTitle();
      }
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      if(this.localTank != null) {
        this.battleEventSupport.deactivateHandlers();
        this.battleEventSupport = null;
        this.localTank = null;
        clearDictionary(this.remoteTanksInBattle);
      }
    }
  }
}
