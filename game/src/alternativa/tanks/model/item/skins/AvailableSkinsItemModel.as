package alternativa.tanks.model.item.skins {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.skins.AvailableSkinsItemModelBase;
  import projects.tanks.client.garage.skins.IAvailableSkinsItemModelBase;

  [ModelInfo]
  public class AvailableSkinsItemModel extends AvailableSkinsItemModelBase implements IAvailableSkinsItemModelBase, AvailableSkins {
    public function AvailableSkinsItemModel() {
      super();
    }

    public function getSkins() : Vector.<IGameObject> {
      return getInitParam().skins;
    }
  }
}
