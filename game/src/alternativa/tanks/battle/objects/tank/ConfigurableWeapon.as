package alternativa.tanks.battle.objects.tank {
  public interface ConfigurableWeapon extends Weapon {
    function updateRange(param1:Number) : void;
    function setBuffedMode(param1:Boolean) : void;
  }
}
