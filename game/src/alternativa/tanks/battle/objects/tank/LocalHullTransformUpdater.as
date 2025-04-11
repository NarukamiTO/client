package alternativa.tanks.battle.objects.tank {
  import alternativa.math.Vector3;

  public class LocalHullTransformUpdater implements HullTransformUpdater {
    private static const position:Vector3 = new Vector3();
    private static const eulerAngles:Vector3 = new Vector3();

    public var tank:Tank;

    public function LocalHullTransformUpdater(param1:Tank) {
      super();
      this.tank = param1;
    }

    public function reset() : void {
    }

    public function update(param1:Number) : void {
      position.copy(this.tank.skinCenterOffset);
      position.transform4(this.tank.interpolatedTransform);
      this.tank.interpolatedOrientation.getEulerAngles(eulerAngles);
      this.tank.getSkin().updateHullTransform(position,eulerAngles);
    }
  }
}
