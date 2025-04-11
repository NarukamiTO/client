package alternativa.tanks.engine3d {
  import alternativa.tanks.battle.events.BattleEventListener;

  public class MutableTextureRegistryCleaner implements BattleEventListener {
    private var registry:MutableTextureRegistry;

    public function MutableTextureRegistryCleaner(param1:MutableTextureRegistry) {
      super();
      this.registry = param1;
    }

    public function handleBattleEvent(param1:Object) : void {
      this.registry.clear();
    }
  }
}
