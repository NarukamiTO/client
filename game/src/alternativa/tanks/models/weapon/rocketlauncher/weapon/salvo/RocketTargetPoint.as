package alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;

  public class RocketTargetPoint {
    private var lost:Boolean;
    private var tank:Tank;
    private var localPoint:Vector3 = new Vector3();

    public function RocketTargetPoint() {
      super();
    }

    public function setTank(param1:Tank) : void {
      this.tank = param1;
      this.lost = false;
    }

    public function setLocalPoint(param1:Vector3) : void {
      this.localPoint.copy(param1);
      this.lost = false;
    }

    public function resetTarget() : void {
      this.tank = null;
      this.lost = false;
    }

    public function isAlive() : Boolean {
      return this.hasTarget() && this.tank.state == ClientTankState.ACTIVE;
    }

    public function isSameTank(param1:Tank) : Boolean {
      return param1 == this.tank;
    }

    public function hasTarget() : Boolean {
      return this.tank != null && this.tank.getBody() != null;
    }

    public function getTank() : Tank {
      return this.tank;
    }

    public function getLocalPoint() : Vector3 {
      return this.localPoint;
    }

    public function isLost() : Boolean {
      return this.lost;
    }

    public function markAsLost() : void {
      this.lost = true;
    }
  }
}
