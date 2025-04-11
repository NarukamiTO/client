package alternativa.tanks.model.item.skins {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.skins.shot.AvailableShotSkinsModelBase;
  import projects.tanks.client.garage.skins.shot.IAvailableShotSkinsModelBase;

  [ModelInfo]
  public class AvailableShotSkinsModel extends AvailableShotSkinsModelBase implements IAvailableShotSkinsModelBase, AvailableShotSkins {
    public function AvailableShotSkinsModel() {
      super();
    }

    public function getSkins() : Vector.<IGameObject> {
      return getInitParam().skins;
    }
  }
}
