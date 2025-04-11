package alternativa.tanks.battle.objects.tank.tankskin {
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.objects.tank.skintexturesregistry.TankSkinTextureRegistry;

  public class TankSkinTextureRegistryCleaner implements BattleEventListener {
    private var registry:TankSkinTextureRegistry;

    public function TankSkinTextureRegistryCleaner(param1:TankSkinTextureRegistry) {
      super();
      this.registry = param1;
    }

    public function handleBattleEvent(param1:Object) : void {
      this.registry.clear();
    }
  }
}
