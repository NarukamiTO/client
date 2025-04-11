package alternativa.tanks.battle {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.PerformanceController;
  import alternativa.tanks.services.performance.PerformanceDataService;
  import flash.display.Stage;
  import flash.events.Event;

  public class PerformanceControllerWithThrottling extends PerformanceController {
    [Inject]
    public static var performanceDataService:PerformanceDataService;

    private var stage:Stage;
    private var inited:Boolean = false;

    public function PerformanceControllerWithThrottling() {
      super();
    }

    private function init() : void {
      if(!this.inited) {
        addFeature(PerformanceController.SHADOWS,performanceDataService.getQualityVisualizationSpeed(),true);
        addFeature(PerformanceController.SHADOW_MAP,performanceDataService.getQualityVisualizationSpeed(),false);
        addFeature(PerformanceController.DEFERRED_LIGHTING,performanceDataService.getQualityVisualizationSpeed(),false);
        addFeature(PerformanceController.FOG,performanceDataService.getQualityVisualizationSpeed(),true);
        addFeature(PerformanceController.SOFT_TRANSPARENCY,performanceDataService.getQualityVisualizationSpeed(),false);
        addFeature(PerformanceController.SSAO,performanceDataService.getQualityVisualizationSpeed(),false);
        addFeature(PerformanceController.ANTI_ALIAS,performanceDataService.getQualityVisualizationSpeed(),false);
        this.inited = true;
      }
    }

    public function start1(param1:Stage, param2:Camera3D, param3:String) : void {
      this.init();
      this.stage = param1;
      param1.addEventListener(Event.ACTIVATE,this.onActivate);
      param1.addEventListener(Event.DEACTIVATE,this.onDeactivate);
      start(param1,param2,performanceDataService.getQualityFPSThreshold(),performanceDataService.getQualityRatioThreshold(),performanceDataService.getQualityIdleTime(),performanceDataService.getQualityTestTime(),performanceDataService.getQualityMaxAttempts(),param3);
    }

    private function onActivate(param1:Event) : void {
      block = false;
    }

    private function onDeactivate(param1:Event) : void {
      block = true;
    }

    [Obfuscation(rename="false")]
    override public function stop() : void {
      super.stop();
      this.stage.removeEventListener(Event.ACTIVATE,this.onActivate);
      this.stage.removeEventListener(Event.DEACTIVATE,this.onDeactivate);
      this.stage = null;
    }
  }
}
