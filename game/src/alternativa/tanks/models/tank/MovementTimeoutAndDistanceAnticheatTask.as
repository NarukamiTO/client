package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.Tank;
  import flash.utils.getTimer;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class MovementTimeoutAndDistanceAnticheatTask implements LogicUnit {
    private var tank:Tank;
    private var correctTankCallback:Function;
    private var lastTankCorrectionTime:uint;
    private var lastTankPosition:Vector3d;
    private var lastTankOrientation:Vector3d;
    private var timeoutUntilCorrection:int;
    private var distanceUntilCorrectionSqr:int;

    public function MovementTimeoutAndDistanceAnticheatTask(param1:Tank, param2:Function, param3:int, param4:int) {
      super();
      this.lastTankCorrectionTime = 0;
      this.tank = param1;
      this.correctTankCallback = param2;
      this.timeoutUntilCorrection = param3;
      this.distanceUntilCorrectionSqr = param4 * param4;
    }

    public function runLogic(param1:int, param2:int) : void {
      if(Boolean(this.canCorrect()) && (this.needCorrectionBecauseOfDistance() || this.needCorrectionBecauseOfTime(param1))) {
        this.lastTankCorrectionTime = getTimer();
        this.correctTankCallback(this.lastTankPosition,this.lastTankOrientation);
      }
    }

    private function canCorrect() : Vector3d {
      return this.lastTankPosition;
    }

    private function needCorrectionBecauseOfTime(param1:int) : Boolean {
      return param1 - this.lastTankCorrectionTime > this.timeoutUntilCorrection;
    }

    private function needCorrectionBecauseOfDistance() : Boolean {
      if(Boolean(this.lastTankPosition)) {
        return MoveCommandUtils.calculateDistanceSqr(this.tank.getBody().state.position,this.lastTankPosition) > this.distanceUntilCorrectionSqr;
      }
      return false;
    }

    public function updateLatestServerTankPosition(param1:Vector3d, param2:Vector3d) : void {
      this.lastTankCorrectionTime = getTimer();
      this.lastTankPosition = param1;
      this.lastTankOrientation = param2;
    }
  }
}
