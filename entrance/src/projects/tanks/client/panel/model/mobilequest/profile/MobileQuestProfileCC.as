package projects.tanks.client.panel.model.mobilequest.profile {
  import alternativa.types.Long;

  public class MobileQuestProfileCC {
    private var _currentStep:int;
    private var _eventMember:Boolean;
    private var _remainingTimeInSec:Long;

    public function MobileQuestProfileCC(param1:int = 0, param2:Boolean = false, param3:Long = null) {
      super();
      this._currentStep = param1;
      this._eventMember = param2;
      this._remainingTimeInSec = param3;
    }

    public function get currentStep() : int {
      return this._currentStep;
    }

    public function set currentStep(param1:int) : void {
      this._currentStep = param1;
    }

    public function get eventMember() : Boolean {
      return this._eventMember;
    }

    public function set eventMember(param1:Boolean) : void {
      this._eventMember = param1;
    }

    public function get remainingTimeInSec() : Long {
      return this._remainingTimeInSec;
    }

    public function set remainingTimeInSec(param1:Long) : void {
      this._remainingTimeInSec = param1;
    }

    public function toString() : String {
      var local1:String = "MobileQuestProfileCC [";
      local1 += "currentStep = " + this.currentStep + " ";
      local1 += "eventMember = " + this.eventMember + " ";
      local1 += "remainingTimeInSec = " + this.remainingTimeInSec + " ";
      return local1 + "]";
    }
  }
}
