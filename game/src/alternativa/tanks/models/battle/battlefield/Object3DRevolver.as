package alternativa.tanks.models.battle.battlefield {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.Renderer;

  public class Object3DRevolver implements Renderer {
    private static const eulerAngles:Vector3 = new Vector3();

    private var object:Object3D;
    private var axis:Vector3;
    private var angularSpeed:Number;
    private var orientation:Quaternion = new Quaternion();

    public function Object3DRevolver(param1:Object3D, param2:Vector3, param3:Number) {
      super();
      this.object = param1;
      this.axis = param2.clone().normalize();
      this.angularSpeed = param3 / 1000;
      this.orientation.setFromEulerAnglesXYZ(param1.rotationX,param1.rotationY,param1.rotationZ);
    }

    public function setAxis(param1:Number, param2:Number, param3:Number) : void {
      this.axis.reset(param1,param2,param3).normalize();
    }

    public function setAngularSpeed(param1:Number) : void {
      this.angularSpeed = param1 / 1000;
    }

    public function render(param1:int, param2:int) : void {
      if(this.angularSpeed != 0) {
        this.orientation.addScaledVector(this.axis,this.angularSpeed * param2);
        this.orientation.getEulerAngles(eulerAngles);
        this.object.rotationX = eulerAngles.x;
        this.object.rotationY = eulerAngles.y;
        this.object.rotationZ = eulerAngles.z;
      }
    }
  }
}
