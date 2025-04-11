package alternativa.tanks.models.drones {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.service.settings.ISettingsService;
  import flash.utils.getTimer;

  public class DroneOnGoRenderer extends AbstractDroneRenderer {
    private var speed:Number = 0;
    private var targetPosition:* = new Vector3();
    private var positionDelta:* = new Vector3();
    private var localTargetPosition:* = new Vector3();

    private const DISTANCE_THRESHOLD:* = 10;
    private const MAX_DRONE_SPEED:* = 5;

    public function DroneOnGoRenderer(param1:Boolean, param2:TankSkin, param3:Drone, param4:BattleService, param5:ISettingsService) {
      super(param1,param2,param3,param4,param5);
    }

    override public function render(param1:int, param2:int) : void {
      var local3:Number = NaN;
      local3 = param2 * 0.001;
      var local4:Number = 0.1;
      var local5:* = local3 > local4 ? local4 : local3;
      var local6:* = getTimer() - startTime;
      this.localTargetPosition.copy(basePosition);
      getTurretMatrix().transformVector(this.localTargetPosition,this.targetPosition);
      this.positionDelta.diff(this.targetPosition,drone.getPosition());
      local3 = Number(this.positionDelta.length());
      if(local3 > this.DISTANCE_THRESHOLD) {
        this.speed = (local3 - this.DISTANCE_THRESHOLD) * this.MAX_DRONE_SPEED;
      }
      var local7:* = this.speed * local5;
      if(local7 > local3) {
        local7 = local3;
      }
      this.positionDelta.normalize().scale(local7);
      drone.getPosition().add(this.positionDelta);
      setPositionAndRotation(param1,param2);
      var local8:Number = local6 > 2000 ? 1 : local6 / 2000;
      drone.getObject3D().z = drone.getObject3D().z + local8 * Math.sin(param1 / 1000) * 10;
      updateVisibility();
    }

    override public function start() : void {
      super.start();
      targetAlpha = 1;
      alpha = 1;
    }
  }
}
