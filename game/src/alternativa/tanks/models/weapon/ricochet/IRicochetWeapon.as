package alternativa.tanks.models.weapon.ricochet {
  import alternativa.tanks.battle.objects.tank.Weapon;

  public interface IRicochetWeapon extends Weapon {
    function setBuffedMode(param1:Boolean) : void;
  }
}
