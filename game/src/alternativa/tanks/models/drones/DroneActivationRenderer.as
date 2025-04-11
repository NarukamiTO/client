package alternativa.tanks.models.drones {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.service.settings.ISettingsService;

  public class DroneActivationRenderer extends AbstractDroneRenderer {
    private const EFFECT_DURATION_MS:* = 2000;

    private var localPosition:* = new Vector3();

    public function DroneActivationRenderer(param1:Boolean, param2:TankSkin, param3:Drone, param4:BattleService, param5:ISettingsService) {
      super(param1,param2,param3,param4,param5);
    }

    override public function render(param1:int, param2:int) : void {
      var local3:* = (param1 - startTime) / this.EFFECT_DURATION_MS;
      if(local3 >= 1) {
        drone.transitToActiveState();
        return;
      }
      targetAlpha = -(local3 - 1) * (local3 - 1) + 1;
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
      drone.getObject3D().visible = true;
      if(isLocal) {
        drone.getObject3D().rotationZ = battleService.getBattleScene3D().getCamera().rotationZ;
      }
    }
  }
}
