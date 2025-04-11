package alternativa.tanks.model.garage.temperature {
  public class TemperatureConfigImpl implements TemperatureConfig {
    private var _temperatureAutoDecrement:Number;

    public function TemperatureConfigImpl() {
      super();
    }

    public function get temperatureAutoDecrement() : Number {
      return this._temperatureAutoDecrement;
    }

    public function set temperatureAutoDecrement(param1:Number) : void {
      this._temperatureAutoDecrement = param1;
    }
  }
}
