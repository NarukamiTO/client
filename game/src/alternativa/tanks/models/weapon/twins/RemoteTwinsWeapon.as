package alternativa.tanks.models.weapon.twins {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsCC;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RemoteTwinsWeapon implements Weapon {
    private static const _gunParams:AllGlobalGunParams = new AllGlobalGunParams();

    private var recoilForce:Number;
    private var ammunition:TwinsAmmunition;
    private var effects:TwinsEffects;
    private var weaponPlatform:WeaponPlatform;

    public function RemoteTwinsWeapon(param1:IGameObject, param2:TwinsCC) {
      super();
      var local3:WeaponObject = new WeaponObject(param1);
      var local4:WeaponCommonData = local3.commonData();
      var local5:ITwinsSFXModel = ITwinsSFXModel(param1.adapt(ITwinsSFXModel));
      var local6:TwinsAmmunition = new TwinsAmmunition(local3,param2,local5.getSFXData());
      this.recoilForce = local4.getRecoilForce();
      this.ammunition = local6;
      this.effects = local5.getPlasmaWeaponEffects();
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
    }

    public function fire(param1:int, param2:int, param3:Vector3) : void {
      this.weaponPlatform.getAllGunParams(_gunParams,param1);
      this.createShotEffects(param1,_gunParams);
      var local4:TwinsShot = this.ammunition.getShot();
      local4.addToGame(_gunParams,param3,this.weaponPlatform.getBody(),true,param2);
    }

    public function fireDummy(param1:int) : void {
      this.weaponPlatform.getAllGunParams(_gunParams,param1);
      this.createShotEffects(param1,_gunParams);
    }

    private function createShotEffects(param1:int, param2:AllGlobalGunParams) : void {
      this.weaponPlatform.getBody().addWorldForceScaled(param2.muzzlePosition,param2.direction,-this.recoilForce);
      this.weaponPlatform.addDust(1);
      this.effects.createShotEffects(this.weaponPlatform.getTurret3D(),this.weaponPlatform.getLocalMuzzlePosition(param1));
    }

    public function destroy() : void {
    }

    public function activate() : void {
    }

    public function deactivate() : void {
    }

    public function enable() : void {
    }

    public function disable(param1:Boolean) : void {
    }

    public function reset() : void {
    }

    public function getStatus() : Number {
      return 0;
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.TWINS_RESISTANCE;
    }

    public function updateRecoilForce(param1:Number) : void {
    }

    public function fullyRecharge() : void {
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
    }

    public function stun() : void {
    }

    public function calm(param1:int) : void {
    }
  }
}
