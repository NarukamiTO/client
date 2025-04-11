package projects.tanks.client.battleservice.model.performance {
  public class PerformanceCC {
    private var _alertFPSRatioThreshold:Number;
    private var _alertFPSThreshold:Number;
    private var _alertMinTestTime:Number;
    private var _alertPingRatioThreshold:Number;
    private var _alertPingThreshold:Number;
    private var _indicatorHighFPS:int;
    private var _indicatorHighFPSColor:String;
    private var _indicatorHighPing:int;
    private var _indicatorHighPingColor:String;
    private var _indicatorLowFPS:int;
    private var _indicatorLowFPSColor:String;
    private var _indicatorLowPing:int;
    private var _indicatorLowPingColor:String;
    private var _indicatorVeryHighPing:int;
    private var _indicatorVeryHighPingColor:String;
    private var _indicatorVeryLowFPS:int;
    private var _indicatorVeryLowFPSColor:String;
    private var _qualityFPSThreshold:Number;
    private var _qualityIdleTime:Number;
    private var _qualityMaxAttempts:int;
    private var _qualityRatioThreshold:Number;
    private var _qualityTestTime:Number;
    private var _qualityVisualizationSpeed:Number;

    public function PerformanceCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:int = 0, param7:String = null, param8:int = 0, param9:String = null, param10:int = 0, param11:String = null, param12:int = 0, param13:String = null, param14:int = 0, param15:String = null, param16:int = 0, param17:String = null, param18:Number = 0, param19:Number = 0, param20:int = 0, param21:Number = 0, param22:Number = 0, param23:Number = 0) {
      super();
      this._alertFPSRatioThreshold = param1;
      this._alertFPSThreshold = param2;
      this._alertMinTestTime = param3;
      this._alertPingRatioThreshold = param4;
      this._alertPingThreshold = param5;
      this._indicatorHighFPS = param6;
      this._indicatorHighFPSColor = param7;
      this._indicatorHighPing = param8;
      this._indicatorHighPingColor = param9;
      this._indicatorLowFPS = param10;
      this._indicatorLowFPSColor = param11;
      this._indicatorLowPing = param12;
      this._indicatorLowPingColor = param13;
      this._indicatorVeryHighPing = param14;
      this._indicatorVeryHighPingColor = param15;
      this._indicatorVeryLowFPS = param16;
      this._indicatorVeryLowFPSColor = param17;
      this._qualityFPSThreshold = param18;
      this._qualityIdleTime = param19;
      this._qualityMaxAttempts = param20;
      this._qualityRatioThreshold = param21;
      this._qualityTestTime = param22;
      this._qualityVisualizationSpeed = param23;
    }

    public function get alertFPSRatioThreshold() : Number {
      return this._alertFPSRatioThreshold;
    }

    public function set alertFPSRatioThreshold(param1:Number) : void {
      this._alertFPSRatioThreshold = param1;
    }

    public function get alertFPSThreshold() : Number {
      return this._alertFPSThreshold;
    }

    public function set alertFPSThreshold(param1:Number) : void {
      this._alertFPSThreshold = param1;
    }

    public function get alertMinTestTime() : Number {
      return this._alertMinTestTime;
    }

    public function set alertMinTestTime(param1:Number) : void {
      this._alertMinTestTime = param1;
    }

    public function get alertPingRatioThreshold() : Number {
      return this._alertPingRatioThreshold;
    }

    public function set alertPingRatioThreshold(param1:Number) : void {
      this._alertPingRatioThreshold = param1;
    }

    public function get alertPingThreshold() : Number {
      return this._alertPingThreshold;
    }

    public function set alertPingThreshold(param1:Number) : void {
      this._alertPingThreshold = param1;
    }

    public function get indicatorHighFPS() : int {
      return this._indicatorHighFPS;
    }

    public function set indicatorHighFPS(param1:int) : void {
      this._indicatorHighFPS = param1;
    }

    public function get indicatorHighFPSColor() : String {
      return this._indicatorHighFPSColor;
    }

    public function set indicatorHighFPSColor(param1:String) : void {
      this._indicatorHighFPSColor = param1;
    }

    public function get indicatorHighPing() : int {
      return this._indicatorHighPing;
    }

    public function set indicatorHighPing(param1:int) : void {
      this._indicatorHighPing = param1;
    }

    public function get indicatorHighPingColor() : String {
      return this._indicatorHighPingColor;
    }

    public function set indicatorHighPingColor(param1:String) : void {
      this._indicatorHighPingColor = param1;
    }

    public function get indicatorLowFPS() : int {
      return this._indicatorLowFPS;
    }

    public function set indicatorLowFPS(param1:int) : void {
      this._indicatorLowFPS = param1;
    }

    public function get indicatorLowFPSColor() : String {
      return this._indicatorLowFPSColor;
    }

    public function set indicatorLowFPSColor(param1:String) : void {
      this._indicatorLowFPSColor = param1;
    }

    public function get indicatorLowPing() : int {
      return this._indicatorLowPing;
    }

    public function set indicatorLowPing(param1:int) : void {
      this._indicatorLowPing = param1;
    }

    public function get indicatorLowPingColor() : String {
      return this._indicatorLowPingColor;
    }

    public function set indicatorLowPingColor(param1:String) : void {
      this._indicatorLowPingColor = param1;
    }

    public function get indicatorVeryHighPing() : int {
      return this._indicatorVeryHighPing;
    }

    public function set indicatorVeryHighPing(param1:int) : void {
      this._indicatorVeryHighPing = param1;
    }

    public function get indicatorVeryHighPingColor() : String {
      return this._indicatorVeryHighPingColor;
    }

    public function set indicatorVeryHighPingColor(param1:String) : void {
      this._indicatorVeryHighPingColor = param1;
    }

    public function get indicatorVeryLowFPS() : int {
      return this._indicatorVeryLowFPS;
    }

    public function set indicatorVeryLowFPS(param1:int) : void {
      this._indicatorVeryLowFPS = param1;
    }

    public function get indicatorVeryLowFPSColor() : String {
      return this._indicatorVeryLowFPSColor;
    }

    public function set indicatorVeryLowFPSColor(param1:String) : void {
      this._indicatorVeryLowFPSColor = param1;
    }

    public function get qualityFPSThreshold() : Number {
      return this._qualityFPSThreshold;
    }

    public function set qualityFPSThreshold(param1:Number) : void {
      this._qualityFPSThreshold = param1;
    }

    public function get qualityIdleTime() : Number {
      return this._qualityIdleTime;
    }

    public function set qualityIdleTime(param1:Number) : void {
      this._qualityIdleTime = param1;
    }

    public function get qualityMaxAttempts() : int {
      return this._qualityMaxAttempts;
    }

    public function set qualityMaxAttempts(param1:int) : void {
      this._qualityMaxAttempts = param1;
    }

    public function get qualityRatioThreshold() : Number {
      return this._qualityRatioThreshold;
    }

    public function set qualityRatioThreshold(param1:Number) : void {
      this._qualityRatioThreshold = param1;
    }

    public function get qualityTestTime() : Number {
      return this._qualityTestTime;
    }

    public function set qualityTestTime(param1:Number) : void {
      this._qualityTestTime = param1;
    }

    public function get qualityVisualizationSpeed() : Number {
      return this._qualityVisualizationSpeed;
    }

    public function set qualityVisualizationSpeed(param1:Number) : void {
      this._qualityVisualizationSpeed = param1;
    }

    public function toString() : String {
      var local1:String = "PerformanceCC [";
      local1 += "alertFPSRatioThreshold = " + this.alertFPSRatioThreshold + " ";
      local1 += "alertFPSThreshold = " + this.alertFPSThreshold + " ";
      local1 += "alertMinTestTime = " + this.alertMinTestTime + " ";
      local1 += "alertPingRatioThreshold = " + this.alertPingRatioThreshold + " ";
      local1 += "alertPingThreshold = " + this.alertPingThreshold + " ";
      local1 += "indicatorHighFPS = " + this.indicatorHighFPS + " ";
      local1 += "indicatorHighFPSColor = " + this.indicatorHighFPSColor + " ";
      local1 += "indicatorHighPing = " + this.indicatorHighPing + " ";
      local1 += "indicatorHighPingColor = " + this.indicatorHighPingColor + " ";
      local1 += "indicatorLowFPS = " + this.indicatorLowFPS + " ";
      local1 += "indicatorLowFPSColor = " + this.indicatorLowFPSColor + " ";
      local1 += "indicatorLowPing = " + this.indicatorLowPing + " ";
      local1 += "indicatorLowPingColor = " + this.indicatorLowPingColor + " ";
      local1 += "indicatorVeryHighPing = " + this.indicatorVeryHighPing + " ";
      local1 += "indicatorVeryHighPingColor = " + this.indicatorVeryHighPingColor + " ";
      local1 += "indicatorVeryLowFPS = " + this.indicatorVeryLowFPS + " ";
      local1 += "indicatorVeryLowFPSColor = " + this.indicatorVeryLowFPSColor + " ";
      local1 += "qualityFPSThreshold = " + this.qualityFPSThreshold + " ";
      local1 += "qualityIdleTime = " + this.qualityIdleTime + " ";
      local1 += "qualityMaxAttempts = " + this.qualityMaxAttempts + " ";
      local1 += "qualityRatioThreshold = " + this.qualityRatioThreshold + " ";
      local1 += "qualityTestTime = " + this.qualityTestTime + " ";
      local1 += "qualityVisualizationSpeed = " + this.qualityVisualizationSpeed + " ";
      return local1 + "]";
    }
  }
}
