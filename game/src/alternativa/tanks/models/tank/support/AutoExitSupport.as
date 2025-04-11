package alternativa.tanks.models.tank.support {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.clients.flash.commons.services.autobattleenter.AutomaticEnterExitService;

  public class AutoExitSupport implements AutoClosable, BattleEventListener {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var autoEnterExitService:AutomaticEnterExitService;

    private var tank:Tank;

    public function AutoExitSupport(param1:Tank) {
      super();
    }

    [Obfuscation(rename="false")]
    public function close() : void {
    }

    public function handleBattleEvent(param1:Object) : void {
    }
  }
}
