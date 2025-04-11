package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface BattleFacilities {
    function register(param1:IGameObject) : void;
    function unregister(param1:IGameObject) : void;
    function addCheckZone(param1:IGameObject, param2:Vector3, param3:Number, param4:Boolean) : void;
    function addDynamicCheckZone(param1:IGameObject, param2:Tank, param3:Number, param4:Boolean) : void;
    function removeCheckZone(param1:IGameObject) : void;
  }
}
