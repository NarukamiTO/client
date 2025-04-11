package alternativa.tanks.models.battle.battlefield {
  import alternativa.tanks.battle.UserTitleRenderer;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.services.spectatorservice.SpectatorService;
  import alternativa.utils.clearDictionary;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.AutoClosable;

  public class SpectatorUserTitleRenderer implements UserTitleRenderer, AutoClosable {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var spectatorService:SpectatorService;

    private var battleEventSupport:BattleEventSupport;

    private const tanksInBattle:Dictionary = new Dictionary();

    public function SpectatorUserTitleRenderer() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      this.battleEventSupport.activateHandlers();
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.battleEventSupport.deactivateHandlers();
      clearDictionary(this.tanksInBattle);
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      this.tanksInBattle[param1.tank] = true;
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      delete this.tanksInBattle[param1.tank];
    }

    public function renderUserTitles() : void {
      var local1:* = undefined;
      for(local1 in this.tanksInBattle) {
        this.updateTitleVisibility(local1);
      }
    }

    private function updateTitleVisibility(param1:Tank) : void {
      if(param1.health > 0 && Boolean(spectatorService.getUserTitlesVisible())) {
        param1.showTitle();
      } else {
        param1.hideTitle();
      }
    }
  }
}
