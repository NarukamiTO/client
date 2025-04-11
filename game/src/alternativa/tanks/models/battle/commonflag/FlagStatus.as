package alternativa.tanks.models.battle.commonflag {
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;

  public class FlagStatus {
    public var position:Vector3 = new Vector3();
    public var rotation:Quaternion = new Quaternion();

    public function FlagStatus() {
      super();
    }

    public function apply(param1:Vector3, param2:Quaternion) : void {
      this.position.copy(param1);
      this.rotation.copy(param2);
    }

    public function applyPos(param1:Vector3) : * {
      this.position.copy(param1);
    }

    public function copy(param1:FlagStatus) : * {
      this.apply(param1.position,param1.rotation);
    }

    public function copyTo(param1:FlagStatus) : * {
      param1.apply(this.position,this.rotation);
    }

    public function interpolate(param1:FlagStatus, param2:FlagStatus, param3:Number) : * {
      this.position.x = param1.position.x + param3 * (param2.position.x - param1.position.x);
      this.position.y = param1.position.y + param3 * (param2.position.y - param1.position.y);
      this.position.z = param1.position.z + param3 * (param2.position.z - param1.position.z);
      this.rotation.slerp(param1.rotation,param2.rotation,param3);
    }
  }
}
