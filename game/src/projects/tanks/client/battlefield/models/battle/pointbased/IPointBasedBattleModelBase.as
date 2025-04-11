package projects.tanks.client.battlefield.models.battle.pointbased {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlagFlyingData;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IPointBasedBattleModelBase {
    function dropFlag(param1:int, param2:Vector3d) : void;
    function dropFlyingFlag(param1:int, param2:int, param3:ClientFlagFlyingData) : void;
    function exileFlag(param1:int) : void;
    function flagDelivered(param1:int, param2:int, param3:Long) : void;
    function flagTaken(param1:int, param2:Long) : void;
    function returnFlagToBase(param1:int, param2:IGameObject) : void;
    function throwFlyingFlag(param1:int, param2:ClientFlagFlyingData) : void;
  }
}
