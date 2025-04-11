package alternativa.tanks.camera {
  import alternativa.math.Vector3;

  public class CameraShaker {
    private var maxAngle:Number = 1.5707963267948966;
    private var direction:Vector3 = new Vector3();
    private var maxTime:int = 500;
    private var time:int;
    private var maxRadius:Number = 50;
    private var radius:Number = 0;
    private var e1:Vector3 = new Vector3();
    private var e2:Vector3 = new Vector3();

    public function CameraShaker() {
      super();
    }

    public function setMaxTime(param1:int) : void {
      this.maxTime = param1;
    }

    public function start() : void {
      this.time = this.maxTime;
      this.radius = this.maxRadius;
      this.direction.reset(1 - 2 * Math.random(),1 - 2 * Math.random(),1 - 2 * Math.random()).normalize();
      this.calculateBasisVectors();
    }

    public function isActive() : Boolean {
      return this.time > 0;
    }

    public function getCameraPosition(param1:Vector3, param2:Vector3) : void {
      param2.copy(param1);
      if(this.time > 0) {
        param2.addScaled(this.radius,this.direction);
      }
    }

    public function update(param1:int) : void {
      if(this.time > 0) {
        this.time -= param1;
        if(this.time > 0) {
          this.calculateNewDirection();
          this.calculateBasisVectors();
          this.calculateRadius(this.time);
        }
      }
    }

    private function calculateRadius(param1:int) : void {
      var local2:Number = Math.cos(Math.PI * (this.maxTime - param1) / this.maxTime);
      this.radius = this.maxRadius * 0.5 * (1 + local2);
    }

    private function calculateNewDirection() : void {
      var local1:Number = this.maxAngle * Math.random();
      var local2:Number = -Math.cos(local1);
      var local3:Number = Math.sin(local1);
      local1 = 2 * Math.PI * Math.random();
      var local4:Number = local3 * Math.cos(local1);
      var local5:Number = local3 * Math.sin(local1);
      var local6:Number = local2 * this.direction.x + local4 * this.e1.x + local5 * this.e2.x;
      var local7:Number = local2 * this.direction.y + local4 * this.e1.y + local5 * this.e2.y;
      var local8:Number = local2 * this.direction.z + local4 * this.e1.z + local5 * this.e2.z;
      this.direction.reset(local6,local7,local8).normalize();
    }

    private function calculateBasisVectors() : void {
      var local1:int = 0;
      var local2:Number = this.direction.x < 0 ? -this.direction.x : this.direction.x;
      var local3:Number = this.direction.y < 0 ? -this.direction.y : this.direction.y;
      if(local3 > local2) {
        local2 = local3;
        local1 = 1;
      }
      local3 = this.direction.z < 0 ? -this.direction.z : this.direction.z;
      if(local3 > local2) {
        local1 = 2;
      }
      switch(local1) {
        case 0:
          this.e1.x = 0;
          this.e1.y = this.direction.z;
          this.e1.z = -this.direction.y;
          break;
        case 1:
          this.e1.x = -this.direction.z;
          this.e1.y = 0;
          this.e1.z = this.direction.x;
          break;
        case 2:
          this.e1.x = this.direction.y;
          this.e1.y = -this.direction.x;
          this.e1.z = 0;
      }
      this.e1.normalize();
      this.e2.cross2(this.direction,this.e1);
    }
  }
}
