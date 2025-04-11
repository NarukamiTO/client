package alternativa.tanks.models.weapon.artillery {
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryEffects;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfxData;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryCC;

  public class RemoteArtilleryWeapon extends ArtilleryWeapon {
    public function RemoteArtilleryWeapon(param1:IGameObject, param2:ArtilleryObject, param3:ArtilleryCC, param4:ArtillerySfxData, param5:ArtilleryEffects) {
      super(param1,param2,param3,param4,param5);
    }

    override public function enable() : void {
    }

    override public function disable(param1:Boolean) : void {
      stop(0,param1);
    }
  }
}
