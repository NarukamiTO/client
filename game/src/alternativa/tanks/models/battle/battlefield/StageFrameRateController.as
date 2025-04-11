package alternativa.tanks.models.battle.battlefield {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.LogicUnit;
  import flash.display.Stage;
  import flash.display.StageQuality;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;

  public class StageFrameRateController extends BattleRunnerProvider implements LogicUnit {
    [Inject]
    public static var clientLog:IClientLog;

    [Inject]
    public static var display:IDisplay;

    private static const MAX_HARDWARE_FRAME_RATE:Number = 60;
    private static const MAX_SOFTWARE_FRAME_RATE:Number = 40;
    private static const MIN_FRAMERATE:int = 10;
    private static const FRAME_RATE_ADJUST_INTERVAL:int = 30;

    private var stage:Stage;
    private var timeStatistics:TimeStatistics;
    private var maxFrameRate:int;
    private var frameCounter:int;
    private var initialFrameRate:Number;
    private var initialStageQuality:String;
    private var adaptiveFPSEnabled:Boolean;

    public function StageFrameRateController(param1:Stage, param2:BattleRunner, param3:TimeStatistics) {
      super();
      this.stage = param1;
      this.timeStatistics = param3;
      this.setMaxFrameRate();
      this.saveStageParams();
      this.setInitialStageParams();
    }

    private function saveStageParams() : void {
      this.initialFrameRate = this.stage.frameRate;
      this.initialStageQuality = this.stage.quality;
    }

    private function setInitialStageParams() : void {
      this.stage.frameRate = this.maxFrameRate;
      if(GPUCapabilities.gpuEnabled) {
        this.stage.quality = StageQuality.MEDIUM;
      } else {
        this.stage.quality = StageQuality.LOW;
      }
    }

    public function restoreStageParams() : void {
      this.stage.frameRate = this.initialFrameRate;
      this.stage.quality = this.initialStageQuality;
    }

    private function setMaxFrameRate() : void {
      if(GPUCapabilities.gpuEnabled) {
        this.maxFrameRate = MAX_HARDWARE_FRAME_RATE;
      } else {
        this.maxFrameRate = MAX_SOFTWARE_FRAME_RATE;
      }
    }

    public function setAdaptiveFrameRate(param1:Boolean) : void {
      if(param1) {
        this.enableAdaptiveFrameRate();
      } else {
        this.disableAdaptiveFrameRate();
      }
    }

    private function enableAdaptiveFrameRate() : void {
      if(!this.adaptiveFPSEnabled) {
        getBattleRunner().addLogicUnit(this);
        this.adaptiveFPSEnabled = true;
      }
    }

    private function disableAdaptiveFrameRate() : void {
      if(this.adaptiveFPSEnabled) {
        getBattleRunner().removeLogicUnit(this);
        this.adaptiveFPSEnabled = false;
        this.stage.frameRate = this.maxFrameRate;
      }
    }

    public function runLogic(param1:int, param2:int) : void {
      ++this.frameCounter;
      if(this.frameCounter == FRAME_RATE_ADJUST_INTERVAL) {
        this.frameCounter = 0;
        if(this.currentFpsIsTooLow()) {
          this.decreaseStageFrameRate();
        } else {
          this.increaseStageFrameRate();
        }
      }
    }

    private function currentFpsIsTooLow() : Boolean {
      return this.timeStatistics.fps < display.stage.frameRate - 1;
    }

    private function decreaseStageFrameRate() : void {
      display.stage.frameRate = this.timeStatistics.fps < MIN_FRAMERATE ? MIN_FRAMERATE : this.timeStatistics.fps;
    }

    private function increaseStageFrameRate() : void {
      var local1:Number = display.stage.frameRate + 1;
      display.stage.frameRate = local1 > this.maxFrameRate ? this.maxFrameRate : local1;
    }
  }
}
