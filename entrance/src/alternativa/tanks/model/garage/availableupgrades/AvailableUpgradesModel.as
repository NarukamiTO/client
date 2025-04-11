package alternativa.tanks.model.garage.availableupgrades {
  import projects.tanks.client.panel.model.garage.availableupgrades.AvailableUpgradeItem;
  import projects.tanks.client.panel.model.garage.availableupgrades.AvailableUpgradesModelBase;
  import projects.tanks.client.panel.model.garage.availableupgrades.IAvailableUpgradesModelBase;

  [ModelInfo]
  public class AvailableUpgradesModel extends AvailableUpgradesModelBase implements IAvailableUpgradesModelBase {
    public function AvailableUpgradesModel() {
      super();
    }

    public function updateAvailableUpgrade(param1:Vector.<AvailableUpgradeItem>) : void {
    }
  }
}
