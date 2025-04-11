package projects.tanks.client.panel.model.rulesupdate.showing {
  public class RulesUpdateShowingCC {
    private var _bottomText:String;
    private var _showAcceptRulesAlert:Boolean;
    private var _topText:String;

    public function RulesUpdateShowingCC(param1:String = null, param2:Boolean = false, param3:String = null) {
      super();
      this._bottomText = param1;
      this._showAcceptRulesAlert = param2;
      this._topText = param3;
    }

    public function get bottomText() : String {
      return this._bottomText;
    }

    public function set bottomText(param1:String) : void {
      this._bottomText = param1;
    }

    public function get showAcceptRulesAlert() : Boolean {
      return this._showAcceptRulesAlert;
    }

    public function set showAcceptRulesAlert(param1:Boolean) : void {
      this._showAcceptRulesAlert = param1;
    }

    public function get topText() : String {
      return this._topText;
    }

    public function set topText(param1:String) : void {
      this._topText = param1;
    }

    public function toString() : String {
      var local1:String = "RulesUpdateShowingCC [";
      local1 += "bottomText = " + this.bottomText + " ";
      local1 += "showAcceptRulesAlert = " + this.showAcceptRulesAlert + " ";
      local1 += "topText = " + this.topText + " ";
      return local1 + "]";
    }
  }
}
