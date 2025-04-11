package alternativa.tanks.models.weapon.gauss.state.targetselection {
  import alternativa.math.Vector3;
  import alternativa.types.Long;

  public class LockResult {
    public var targetId:Long;
    public var globalLockPoint:* = new Vector3();
    public var localLockPoint:* = new Vector3();

    public function LockResult() {
      super();
    }

    public function update(param1:Long, param2:Vector3, param3:Vector3) : * {
      this.targetId = param1;
      this.globalLockPoint.copy(param2);
      this.localLockPoint.copy(param3);
    }

    public function copy(param1:LockResult) : * {
      this.targetId = param1.targetId;
      this.globalLockPoint.copy(param1.globalLockPoint);
      this.localLockPoint.copy(param1.localLockPoint);
    }
  }
}
