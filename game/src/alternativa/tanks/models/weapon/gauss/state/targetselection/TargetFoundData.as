package alternativa.tanks.models.weapon.gauss.state.targetselection {
  public class TargetFoundData {
    private var _lockResult:LockResult;
    private var _isNewTarget:Boolean;

    public function TargetFoundData(param1:LockResult, param2:Boolean) {
      super();
      this._lockResult = param1;
      this._isNewTarget = param2;
    }

    public function get lockResult() : LockResult {
      return this._lockResult;
    }

    public function get isNewTarget() : Boolean {
      return this._isNewTarget;
    }
  }
}
