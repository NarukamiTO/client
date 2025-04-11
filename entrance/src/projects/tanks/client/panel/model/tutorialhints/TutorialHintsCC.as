package projects.tanks.client.panel.model.tutorialhints {
  public class TutorialHintsCC {
    private var _tutorialHintsData:TutorialHintsData;

    public function TutorialHintsCC(param1:TutorialHintsData = null) {
      super();
      this._tutorialHintsData = param1;
    }

    public function get tutorialHintsData() : TutorialHintsData {
      return this._tutorialHintsData;
    }

    public function set tutorialHintsData(param1:TutorialHintsData) : void {
      this._tutorialHintsData = param1;
    }

    public function toString() : String {
      var local1:String = "TutorialHintsCC [";
      local1 += "tutorialHintsData = " + this.tutorialHintsData + " ";
      return local1 + "]";
    }
  }
}
