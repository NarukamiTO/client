package alternativa.tanks.models.statistics {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.death.TankKilledEvent;
  import alternativa.tanks.battle.events.death.TankReloadedEvent;
  import alternativa.tanks.battle.events.death.TankSuicideEvent;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.DamageType;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class TankKillLogger implements AutoClosable, BattleEventListener {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var localeService:ILocaleService;

    private var battleObject:IGameObject;
    private var suicideMessage:String;
    private var killMessage:String;
    private var reloadedMessage:String;

    public function TankKillLogger(param1:IGameObject) {
      super();
      this.battleObject = param1;
      this.init();
    }

    private function init() : void {
      this.suicideMessage = localeService.getText(TanksLocale.TEXT_BATTLE_PLAYER_SUICIDED);
      this.killMessage = localeService.getText(TanksLocale.TEXT_BATTLE_PLAYER_KILLED);
      this.reloadedMessage = localeService.getText(TanksLocale.TEXT_REARM_BATTLE_EVENT);
      battleEventDispatcher.addBattleEventListener(TankKilledEvent,this);
      battleEventDispatcher.addBattleEventListener(TankSuicideEvent,this);
      battleEventDispatcher.addBattleEventListener(TankReloadedEvent,this);
    }

    public function handleBattleEvent(param1:Object) : void {
      var local3:TankKilledEvent = null;
      var local4:TankSuicideEvent = null;
      var local5:TankReloadedEvent = null;
      var local2:BattlefieldGUI = BattlefieldGUI(this.battleObject.adapt(BattlefieldGUI));
      if(param1 is TankKilledEvent) {
        local3 = TankKilledEvent(param1);
        if(local3.killerId != local3.victimId) {
          if(local3.damageType != DamageType.BOMB) {
            local2.logKillAction(local3.killerId,local3.victimId,local3.damageType);
          }
        } else {
          local2.showUserBattleLogMessage(local3.victimId,UserAction.PLAYER_SELF_DESTROY);
        }
      } else if(param1 is TankSuicideEvent) {
        local4 = TankSuicideEvent(param1);
        local2.showUserBattleLogMessage(local4.victim.id,UserAction.PLAYER_SELF_DESTROY);
      } else if(param1 is TankReloadedEvent) {
        local5 = TankReloadedEvent(param1);
        local2.showUserBattleLogMessage(local5.userId,UserAction.PLAYER_CHANGE_EQUIPMENT);
      }
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.battleObject = null;
      battleEventDispatcher.removeBattleEventListener(TankKilledEvent,this);
      battleEventDispatcher.removeBattleEventListener(TankSuicideEvent,this);
      battleEventDispatcher.removeBattleEventListener(TankReloadedEvent,this);
    }
  }
}
