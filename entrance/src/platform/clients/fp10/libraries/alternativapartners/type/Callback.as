package platform.clients.fp10.libraries.alternativapartners.type {
  public class Callback {
    private var _onSuccess:Function;
    private var _onFailure:Function;

    public function Callback(param1:Function, param2:Function = null) {
      super();
      this._onSuccess = param1;
      this._onFailure = param2;
    }

    public function get onSuccess() : Function {
      return this._onSuccess;
    }

    public function get onFailure() : Function {
      return this._onFailure;
    }
  }
}
