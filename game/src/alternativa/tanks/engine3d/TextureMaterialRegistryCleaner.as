package alternativa.tanks.engine3d {
  import alternativa.engine3d.materials.TextureResourcesRegistry;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.utils.TextureMaterialRegistry;

  public class TextureMaterialRegistryCleaner implements BattleEventListener {
    private var registry:TextureMaterialRegistry;

    public function TextureMaterialRegistryCleaner(param1:TextureMaterialRegistry) {
      super();
      this.registry = param1;
    }

    public function handleBattleEvent(param1:Object) : void {
      this.registry.clear();
      TextureResourcesRegistry.releaseTextureResources();
    }
  }
}
