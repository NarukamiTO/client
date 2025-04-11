package projects.tanks.clients.fp10.libraries.tanksservices.service.helper {
  import flash.utils.Timer;

  public class HelperTimer extends Timer {
    private var _helper:Helper;

    public function HelperTimer(param1:Number, param2:int) {
      super(param1,param2);
    }

    public function get helper() : Helper {
      return this._helper;
    }

    public function set helper(param1:Helper) : void {
      this._helper = param1;
    }
  }
}
