package alternativa.tanks.models.performance {
  import alternativa.tanks.services.performance.PerformanceDataService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battleservice.model.performance.IPerformanceModelBase;
  import projects.tanks.client.battleservice.model.performance.PerformanceModelBase;

  [ModelInfo]
  public class PerformanceModel extends PerformanceModelBase implements IPerformanceModelBase, ObjectLoadListener {
    [Inject]
    public static var performanceDataService:PerformanceDataService;

    public function PerformanceModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      performanceDataService.setQualityFPSThreshold(getInitParam().qualityFPSThreshold);
      performanceDataService.setQualityRatioThreshold(getInitParam().qualityRatioThreshold);
      performanceDataService.setQualityIdleTime(getInitParam().qualityIdleTime);
      performanceDataService.setQualityTestTime(getInitParam().qualityTestTime);
      performanceDataService.setQualityVisualizationSpeed(getInitParam().qualityVisualizationSpeed);
      performanceDataService.setQualityMaxAttempts(getInitParam().qualityMaxAttempts);
      performanceDataService.setAlertFPSThreshold(getInitParam().alertFPSThreshold);
      performanceDataService.setAlertFPSRatioThreshold(getInitParam().alertFPSRatioThreshold);
      performanceDataService.setAlertPingThreshold(getInitParam().alertPingThreshold);
      performanceDataService.setAlertPingRatioThreshold(getInitParam().alertPingRatioThreshold);
      performanceDataService.setAlertMinTestTime(getInitParam().alertMinTestTime);
      performanceDataService.setIndicatorVeryLowFPS(getInitParam().indicatorVeryLowFPS);
      performanceDataService.setIndicatorVeryLowFPSColor(getInitParam().indicatorVeryLowFPSColor);
      performanceDataService.setIndicatorLowFPS(getInitParam().indicatorLowFPS);
      performanceDataService.setIndicatorLowFPSColor(getInitParam().indicatorLowFPSColor);
      performanceDataService.setIndicatorHighFPS(getInitParam().indicatorHighFPS);
      performanceDataService.setIndicatorHighFPSColor(getInitParam().indicatorHighFPSColor);
      performanceDataService.setIndicatorLowPing(getInitParam().indicatorLowPing);
      performanceDataService.setIndicatorLowPingColor(getInitParam().indicatorLowPingColor);
      performanceDataService.setIndicatorHighPing(getInitParam().indicatorHighPing);
      performanceDataService.setIndicatorHighPingColor(getInitParam().indicatorHighPingColor);
      performanceDataService.setIndicatorVeryHighPing(getInitParam().indicatorVeryHighPing);
      performanceDataService.setIndicatorVeryHighPingColor(getInitParam().indicatorVeryHighPingColor);
    }
  }
}
