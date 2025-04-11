package alternativa.tanks.model.garage.temperature {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.garage.models.garage.temperature.ITemperatureModelBase;
  import projects.tanks.client.garage.models.garage.temperature.TemperatureModelBase;

  [ModelInfo]
  public class TemperatureModel extends TemperatureModelBase implements ITemperatureModelBase, ObjectLoadListener {
    [Inject]
    public static var config:TemperatureConfig;

    public function TemperatureModel() {
      super();
    }

    public function objectLoaded() : void {
      TemperatureConfigImpl(config).temperatureAutoDecrement = getInitParam().temperatureAutoDecrement;
    }
  }
}
