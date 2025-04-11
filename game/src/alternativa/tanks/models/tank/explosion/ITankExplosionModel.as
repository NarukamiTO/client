package alternativa.tanks.models.tank.explosion {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.sfx.LightAnimation;
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface ITankExplosionModel {
    function createExplosionEffects(param1:IGameObject, param2:Tank, param3:LightAnimation) : void;
  }
}
