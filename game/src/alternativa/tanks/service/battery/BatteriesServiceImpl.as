package alternativa.tanks.service.battery {
  public class BatteriesServiceImpl implements BatteriesService {
    private var _hasBatteries:Boolean;

    public function BatteriesServiceImpl() {
      super();
    }

    public function hasBatteries() : Boolean {
      return this._hasBatteries;
    }

    public function setHasBatteries(param1:Boolean) : * {
      this._hasBatteries = param1;
    }
  }
}
