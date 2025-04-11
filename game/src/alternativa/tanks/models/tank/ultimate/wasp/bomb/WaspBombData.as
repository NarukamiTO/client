package alternativa.tanks.models.tank.ultimate.wasp.bomb {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;

  public class WaspBombData implements LocalTankPositionProvider {
    public var localTank:Tank = null;

    public function WaspBombData() {
      super();
    }

    public function getLocalTankPosition(param1:Vector3) : void {
      if(this.localTank != null && this.localTank.state != ClientTankState.DEAD) {
        this.localTank.getPhysicsPosition(param1);
      }
    }
  }
}
