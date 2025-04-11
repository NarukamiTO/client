package alternativa.tanks.models.weapon.common {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapons.targeting.TargetingResult;

  public class HitInfo {
    public var distance:Number;
    public var body:Body;
    public var position:Vector3 = new Vector3();
    public var direction:Vector3 = new Vector3();
    public var normal:Vector3 = new Vector3();

    public function HitInfo() {
      super();
    }

    public function setResult(param1:AllGlobalGunParams, param2:TargetingResult) : void {
      if(param2.hasAnyHit()) {
        this.setHit(param1.barrelOrigin,param2.getDirection(),param2.getSingleHit());
      } else {
        this.setMiss(param2.getDirection());
      }
    }

    private function setHit(param1:Vector3, param2:Vector3, param3:RayHit) : void {
      this.distance = param3.t;
      this.body = param3.shape.body;
      this.normal.copy(param3.normal);
      this.direction.copy(param2);
      this.position.copy(param1).addScaled(param3.t,param2);
    }

    private function setMiss(param1:Vector3) : void {
      this.direction.copy(param1);
      this.body = null;
    }
  }
}
