package alternativa.tanks.models.battle.facilities {
  import alternativa.engine3d.core.Object3D;

  public class CommonFacilityData {
    public var object3d:Object3D;
    public var isDispelled:Boolean = false;

    public function CommonFacilityData(param1:Object3D) {
      super();
      this.object3d = param1;
    }
  }
}
