package alternativa.tanks.models.battle.facilities {
  import alternativa.tanks.battle.BattleUtils;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity.FacilitySphericalZoneCC;
  import projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity.FacilitySphericalZoneModelBase;
  import projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity.IFacilitySphericalZoneModelBase;

  [ModelInfo]
  public class FacilitySphericalZoneModel extends FacilitySphericalZoneModelBase implements IFacilitySphericalZoneModelBase, FacilitySphericalZone, ObjectLoadListener {
    public function FacilitySphericalZoneModel() {
      super();
    }

    public function objectLoaded() : void {
      this.convertConstructorDataToClientScale();
    }

    private function convertConstructorDataToClientScale() : void {
      var local1:FacilitySphericalZoneCC = getInitParam();
      local1.radius = BattleUtils.toClientScale(local1.radius);
      local1.centerOffsetZ = BattleUtils.toClientScale(local1.centerOffsetZ);
    }

    public function getRadius() : Number {
      return getInitParam().radius;
    }

    public function getCenterOffsetZ() : Number {
      return getInitParam().centerOffsetZ;
    }
  }
}
