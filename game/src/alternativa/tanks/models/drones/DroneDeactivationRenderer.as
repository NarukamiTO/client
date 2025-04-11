package alternativa.tanks.models.drones {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.service.settings.ISettingsService;

  public class DroneDeactivationRenderer extends AbstractDroneRenderer {
    private const EFFECT_DURATION_MS:* = 2000;

    private var initLocalPosition:* = new Vector3();
    private var localPosition:* = new Vector3();

    public function DroneDeactivationRenderer(param1:Boolean, param2:TankSkin, param3:Drone, param4:BattleService, param5:ISettingsService) {
      super(param1,param2,param3,param4,param5);
    }

    override public function render(param1:int, param2:int) : void {
      var local3:* = undefined;
      local3 = 1 - (param1 - startTime) / this.EFFECT_DURATION_MS;
      if(local3 <= 0) {
        this.stop();
        return;
      }
      targetAlpha = local3;
      this.localPosition.copy(basePosition);
      this.localPosition.x *= local3;
      this.localPosition.y *= local3;
      this.localPosition.z *= local3;
      getTurretMatrix().transformVector(this.localPosition,drone.getPosition());
      setPositionAndRotation(param1,param2);
      updateVisibility();
    }

    override public function start() : void {
      super.start();
      getTurretMatrix().invert().transformVector(drone.getPosition(),this.initLocalPosition);
    }

    override public function stop() : void {
      super.stop();
      drone.getObject3D().visible = false;
    }
  }
}
