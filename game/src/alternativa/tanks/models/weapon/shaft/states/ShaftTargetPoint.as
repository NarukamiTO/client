package alternativa.tanks.models.weapon.shaft.states {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;

  public class ShaftTargetPoint {
    private var tank:Tank;
    private var globalPoint:Vector3 = new Vector3();
    private var localPoint:Vector3 = new Vector3();

    public function ShaftTargetPoint() {
      super();
    }

    public function setTargetPoint(param1:Vector3, param2:Tank = null) : void {
      this.globalPoint.copy(param1);
      this.tank = param2;
      if(this.hasTank()) {
        this.localPoint.copy(param1);
        BattleUtils.globalToLocal(param2.getBody(),this.localPoint);
      }
    }

    public function hasTank() : Boolean {
      return this.tank != null && this.tank.getBody() != null;
    }

    public function getTank() : Tank {
      return this.tank;
    }

    public function getGlobalPoint() : Vector3 {
      return this.globalPoint;
    }

    public function getLocalPoint() : Vector3 {
      return this.localPoint;
    }

    public function reset() : void {
      this.tank = null;
      this.globalPoint.reset();
      this.localPoint.reset();
    }
  }
}
