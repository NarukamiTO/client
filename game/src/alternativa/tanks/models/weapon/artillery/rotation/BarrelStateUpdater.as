package alternativa.tanks.models.weapon.artillery.rotation {
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.controllers.BarrelElevator;
  import alternativa.tanks.utils.MathUtils;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation.BarrelElevationCommand;

  public class BarrelStateUpdater implements LogicUnit {
    private static const MAX_DIRECTION_DELTA:Number = Math.PI / 6;

    private var barrelElevator:BarrelElevator;
    private var updateCallback:Function;

    private const lastSentState:BarrelElevationCommand = new BarrelElevationCommand();

    public function BarrelStateUpdater(param1:BarrelElevator, param2:Function) {
      super();
      this.barrelElevator = param1;
      this.updateCallback = param2;
    }

    public function reset() : void {
      this.lastSentState.control = this.barrelElevator.getRealControl();
      this.lastSentState.elevation = this.barrelElevator.getBarrelPhysicsElevation();
    }

    public function runLogic(param1:int, param2:int) : void {
      if(this.barrelElevator.getRealControl() != this.lastSentState.control || this.isBigElevationDifference()) {
        this.reset();
        this.updateCallback();
      }
    }

    private function isBigElevationDifference() : Boolean {
      var local1:Number = MathUtils.clampAngleDelta(this.barrelElevator.getBarrelPhysicsElevation(),this.lastSentState.elevation);
      return Math.abs(local1) > MAX_DIRECTION_DELTA;
    }
  }
}
