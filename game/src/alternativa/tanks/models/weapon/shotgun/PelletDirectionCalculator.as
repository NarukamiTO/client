package alternativa.tanks.models.weapon.shotgun {
  import alternativa.math.Vector3;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.aiming.ShotGunAimingCC;

  public class PelletDirectionCalculator {
    private static const horizontalVector:Vector3 = new Vector3();
    private static const verticalVector:Vector3 = new Vector3();

    private var directions:Vector.<Vector3>;
    private var result:Vector.<Vector3>;
    private var params:ShotGunAimingCC;
    private var MAX_X:Number;
    private var MAX_Y:Number;

    public function PelletDirectionCalculator(param1:ShotGunAimingCC) {
      super();
      this.MAX_X = Math.tan(param1.coneHorizontalAngle * 0.5);
      this.MAX_Y = Math.tan(param1.coneVerticalAngle * 0.5);
      this.params = param1;
      this.directions = new Vector.<Vector3>(param1.pelletCount,true);
      this.result = new Vector.<Vector3>(param1.pelletCount,true);
      var local2:int = 0;
      while(local2 < this.directions.length) {
        this.directions[local2] = new Vector3();
        this.result[local2] = new Vector3();
        local2++;
      }
    }

    public function next() : void {
      var local1:int = 0;
      while(local1 < this.directions.length) {
        this.nextPelletDirection(this.directions[local1]);
        local1++;
      }
    }

    private function nextPelletDirection(param1:Vector3) : void {
      var local2:Number = Math.random();
      var local3:Number = Math.random() * Math.PI * 2;
      param1.x = Math.cos(local3) * local2 * this.MAX_X;
      param1.y = Math.sin(local3) * local2 * this.MAX_Y;
    }

    public function getDirectionsFor(param1:Vector3, param2:Vector3) : Vector.<Vector3> {
      var local4:Vector3 = null;
      this.calculateOrtho(param1,param2);
      var local3:int = 0;
      while(local3 < this.directions.length) {
        local4 = this.directions[local3];
        this.calculateDirection(local4.x,local4.y,param2,this.result[local3]);
        local3++;
      }
      return this.result;
    }

    private function calculateDirection(param1:Number, param2:Number, param3:Vector3, param4:Vector3) : void {
      param4.reset();
      param4.addScaled(param1,horizontalVector);
      param4.addScaled(param2,verticalVector);
      param4.add(param3);
      param4.normalize();
    }

    private function calculateOrtho(param1:Vector3, param2:Vector3) : void {
      horizontalVector.copy(param1);
      verticalVector.cross2(horizontalVector,param2).normalize();
    }
  }
}
