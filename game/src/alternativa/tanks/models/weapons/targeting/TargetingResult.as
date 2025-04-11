package alternativa.tanks.models.weapons.targeting {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleUtils;

  public class TargetingResult {
    private var direction:Vector3 = new Vector3();
    private var staticHit:RayHit;
    private var hits:Vector.<RayHit>;

    public function TargetingResult() {
      super();
    }

    public function hasStaticHit() : Boolean {
      return this.staticHit != null;
    }

    public function getStaticHit() : RayHit {
      return this.staticHit;
    }

    public function getDirection() : Vector3 {
      return this.direction;
    }

    public function getHits() : Vector.<RayHit> {
      return this.hits;
    }

    public function hasTankHit() : Boolean {
      return this.hits.length > 0;
    }

    public function hasAnyHit() : Boolean {
      return this.staticHit != null || this.hits.length > 0;
    }

    public function setData(param1:Vector3, param2:Vector.<RayHit>) : void {
      var local3:RayHit = null;
      this.direction.copy(param1);
      this.hits = param2.concat();
      this.staticHit = null;
      if(this.hits.length > 0) {
        local3 = this.hits[this.hits.length - 1];
        if(!BattleUtils.isTankBody(local3.shape.body)) {
          this.staticHit = this.hits.pop();
        }
      }
    }

    public function getSingleHit() : RayHit {
      if(this.staticHit != null) {
        return this.staticHit;
      }
      return this.hits[0];
    }
  }
}
