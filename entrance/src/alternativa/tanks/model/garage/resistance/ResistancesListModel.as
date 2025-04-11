package alternativa.tanks.model.garage.resistance {
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.panel.model.garage.resistance.IResistancesListModelBase;
  import projects.tanks.client.panel.model.garage.resistance.ResistancesListModelBase;

  [ModelInfo]
  public class ResistancesListModel extends ResistancesListModelBase implements IResistancesListModelBase, ModuleResistances {
    public function ResistancesListModel() {
      super();
    }

    public function getResistances() : Vector.<ItemGarageProperty> {
      return getInitParam().resistances;
    }
  }
}
