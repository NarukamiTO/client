package alternativa.tanks.model.item.modification {
  import alternativa.types.Long;
  import projects.tanks.client.garage.models.item.modification.IModificationModelBase;
  import projects.tanks.client.garage.models.item.modification.ModificationModelBase;

  [ModelInfo]
  public class ModificationModel extends ModificationModelBase implements IModificationModelBase, IModification {
    public function ModificationModel() {
      super();
    }

    public function getBaseItemId() : Long {
      return getInitParam().baseItemId;
    }

    public function getModificationIndex() : int {
      return getInitParam().modificationIndex;
    }
  }
}
