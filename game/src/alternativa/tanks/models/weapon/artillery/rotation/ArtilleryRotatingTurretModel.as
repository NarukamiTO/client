package alternativa.tanks.models.weapon.artillery.rotation {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.InitTankPart;
  import alternativa.tanks.models.weapon.artillery.IArtilleryModel;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation.ArtilleryRotatingTurretModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation.IArtilleryRotatingTurretModelBase;

  [ModelInfo]
  public class ArtilleryRotatingTurretModel extends ArtilleryRotatingTurretModelBase implements IArtilleryRotatingTurretModelBase, InitTankPart {
    public function ArtilleryRotatingTurretModel() {
      super();
    }

    public function initTankPart(param1:Tank) : void {
      var local2:IArtilleryModel = IArtilleryModel(object.adapt(IArtilleryModel));
      param1.getWeaponMount().setBarrelElevation(local2.getDefaultElevation());
    }
  }
}
