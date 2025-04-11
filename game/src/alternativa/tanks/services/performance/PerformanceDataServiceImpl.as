package alternativa.tanks.services.performance {
  public class PerformanceDataServiceImpl implements PerformanceDataService {
    private var _qualityFPSThreshold:Number;
    private var _qualityRatioThreshold:Number;
    private var _qualityIdleTime:Number;
    private var _qualityTestTime:Number;
    private var _qualityVisualizationSpeed:Number;
    private var _qualityMaxAttempts:int;
    private var _alertFPSThreshold:Number;
    private var _alertFPSRatioThreshold:Number;
    private var _alertPingThreshold:Number;
    private var _alertPingRatioThreshold:Number;
    private var _alertMinTestTime:Number;
    private var _indicatorVeryLowFPS:int;
    private var _indicatorVeryLowFPSColor:String;
    private var _indicatorLowFPS:int;
    private var _indicatorLowFPSColor:String;
    private var _indicatorHighFPS:int;
    private var _indicatorHighFPSColor:String;
    private var _indicatorLowPing:int;
    private var _indicatorLowPingColor:String;
    private var _indicatorHighPing:int;
    private var _indicatorHighPingColor:String;
    private var _indicatorVeryHighPing:int;
    private var _indicatorVeryHighPingColor:String;

    public function PerformanceDataServiceImpl() {
      super();
    }

    public function getQualityFPSThreshold() : Number {
      return this._qualityFPSThreshold;
    }

    public function setQualityFPSThreshold(param1:Number) : void {
      this._qualityFPSThreshold = param1;
    }

    public function getQualityRatioThreshold() : Number {
      return this._qualityRatioThreshold;
    }

    public function setQualityRatioThreshold(param1:Number) : void {
      this._qualityRatioThreshold = param1;
    }

    public function getQualityIdleTime() : Number {
      return this._qualityIdleTime;
    }

    public function setQualityIdleTime(param1:Number) : void {
      this._qualityIdleTime = param1;
    }

    public function getQualityTestTime() : Number {
      return this._qualityTestTime;
    }

    public function setQualityTestTime(param1:Number) : void {
      this._qualityTestTime = param1;
    }

    public function getQualityVisualizationSpeed() : Number {
      return this._qualityVisualizationSpeed;
    }

    public function setQualityVisualizationSpeed(param1:Number) : void {
      this._qualityVisualizationSpeed = param1;
    }

    public function getQualityMaxAttempts() : int {
      return this._qualityMaxAttempts;
    }

    public function setQualityMaxAttempts(param1:int) : void {
      this._qualityMaxAttempts = param1;
    }

    public function getAlertFPSThreshold() : Number {
      return this._alertFPSThreshold;
    }

    public function setAlertFPSThreshold(param1:Number) : void {
      this._alertFPSThreshold = param1;
    }

    public function getAlertFPSRatioThreshold() : Number {
      return this._alertFPSRatioThreshold;
    }

    public function setAlertFPSRatioThreshold(param1:Number) : void {
      this._alertFPSRatioThreshold = param1;
    }

    public function getAlertPingThreshold() : Number {
      return this._alertPingThreshold;
    }

    public function setAlertPingThreshold(param1:Number) : void {
      this._alertPingThreshold = param1;
    }

    public function getAlertPingRatioThreshold() : Number {
      return this._alertPingRatioThreshold;
    }

    public function setAlertPingRatioThreshold(param1:Number) : void {
      this._alertPingRatioThreshold = param1;
    }

    public function getAlertMinTestTime() : Number {
      return this._alertMinTestTime;
    }

    public function setAlertMinTestTime(param1:Number) : void {
      this._alertMinTestTime = param1;
    }

    public function getIndicatorVeryLowFPS() : int {
      return this._indicatorVeryLowFPS;
    }

    public function setIndicatorVeryLowFPS(param1:int) : void {
      this._indicatorVeryLowFPS = param1;
    }

    public function getIndicatorVeryLowFPSColor() : String {
      return this._indicatorVeryLowFPSColor;
    }

    public function setIndicatorVeryLowFPSColor(param1:String) : void {
      this._indicatorVeryLowFPSColor = param1;
    }

    public function getIndicatorLowFPS() : int {
      return this._indicatorLowFPS;
    }

    public function setIndicatorLowFPS(param1:int) : void {
      this._indicatorLowFPS = param1;
    }

    public function getIndicatorLowFPSColor() : String {
      return this._indicatorLowFPSColor;
    }

    public function setIndicatorLowFPSColor(param1:String) : void {
      this._indicatorLowFPSColor = param1;
    }

    public function getIndicatorHighFPS() : int {
      return this._indicatorHighFPS;
    }

    public function setIndicatorHighFPS(param1:int) : void {
      this._indicatorHighFPS = param1;
    }

    public function getIndicatorHighFPSColor() : String {
      return this._indicatorHighFPSColor;
    }

    public function setIndicatorHighFPSColor(param1:String) : void {
      this._indicatorHighFPSColor = param1;
    }

    public function getIndicatorLowPing() : int {
      return this._indicatorLowPing;
    }

    public function setIndicatorLowPing(param1:int) : void {
      this._indicatorLowPing = param1;
    }

    public function getIndicatorLowPingColor() : String {
      return this._indicatorLowPingColor;
    }

    public function setIndicatorLowPingColor(param1:String) : void {
      this._indicatorLowPingColor = param1;
    }

    public function getIndicatorHighPing() : int {
      return this._indicatorHighPing;
    }

    public function setIndicatorHighPing(param1:int) : void {
      this._indicatorHighPing = param1;
    }

    public function getIndicatorHighPingColor() : String {
      return this._indicatorHighPingColor;
    }

    public function setIndicatorHighPingColor(param1:String) : void {
      this._indicatorHighPingColor = param1;
    }

    public function getIndicatorVeryHighPing() : int {
      return this._indicatorVeryHighPing;
    }

    public function setIndicatorVeryHighPing(param1:int) : void {
      this._indicatorVeryHighPing = param1;
    }

    public function getIndicatorVeryHighPingColor() : String {
      return this._indicatorVeryHighPingColor;
    }

    public function setIndicatorVeryHighPingColor(param1:String) : void {
      this._indicatorVeryHighPingColor = param1;
    }
  }
}
