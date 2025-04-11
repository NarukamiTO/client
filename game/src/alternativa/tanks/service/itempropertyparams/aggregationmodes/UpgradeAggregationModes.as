package alternativa.tanks.service.itempropertyparams.aggregationmodes {
  public class UpgradeAggregationModes {
    public static const SUM:UpgradeAggregationMode = new SumUpgradeAggregationMode();
    public static const RANGE:UpgradeAggregationMode = new RangeUpgradeAggregationMode();
    public static const CRIT:UpgradeAggregationMode = new CritUpgradeAggregationMode();
    public static const INVERT:UpgradeAggregationMode = new InvertUpgradeAggregationMode();

    public function UpgradeAggregationModes() {
      super();
    }
  }
}
