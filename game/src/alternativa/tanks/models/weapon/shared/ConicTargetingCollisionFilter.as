package alternativa.tanks.models.weapon.shared {
  import alternativa.physics.Body;
  import alternativa.physics.collision.IRayCollisionFilter;
  import flash.utils.Dictionary;

  public class ConicTargetingCollisionFilter implements IRayCollisionFilter {
    public var shooter:Body;

    private var targets:Dictionary = new Dictionary();
    private var invalidTargets:Dictionary = new Dictionary();

    public function ConicTargetingCollisionFilter() {
      super();
    }

    public function considerBody(param1:Body) : Boolean {
      return this.shooter != param1 && this.targets[param1] == null && this.invalidTargets[param1] == null;
    }

    public function addTarget(param1:Body) : void {
      this.targets[param1] = true;
    }

    public function addInvalidTarget(param1:Body) : void {
      this.invalidTargets[param1] = true;
    }

    public function clearTargets() : void {
      var local1:* = undefined;
      for(local1 in this.targets) {
        delete this.targets[local1];
      }
    }

    public function clearInvalidTargets() : void {
      var local1:* = undefined;
      for(local1 in this.invalidTargets) {
        delete this.invalidTargets[local1];
      }
    }
  }
}
