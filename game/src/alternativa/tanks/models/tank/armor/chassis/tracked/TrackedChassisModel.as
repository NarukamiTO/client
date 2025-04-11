package alternativa.tanks.models.tank.armor.chassis.tracked {
  import projects.tanks.client.battlefield.models.tankparts.armor.chassis.tracked.ITrackedChassisModelBase;
  import projects.tanks.client.battlefield.models.tankparts.armor.chassis.tracked.TrackedChassisModelBase;

  [ModelInfo]
  public class TrackedChassisModel extends TrackedChassisModelBase implements ITrackedChassisModelBase, ITrackedChassis {
    public function TrackedChassisModel() {
      super();
    }

    public function getDamping() : Number {
      return getInitParam().damping;
    }
  }
}
