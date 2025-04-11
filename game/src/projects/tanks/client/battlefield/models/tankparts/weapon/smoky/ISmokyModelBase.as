package projects.tanks.client.battlefield.models.tankparts.weapon.smoky {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface ISmokyModelBase {
    function localCriticalHit(param1:IGameObject) : void;
    function shoot(param1:IGameObject) : void;
    function shootStatic(param1:IGameObject, param2:Vector3d) : void;
    function shootTarget(param1:IGameObject, param2:IGameObject, param3:Vector3d, param4:Number, param5:Boolean) : void;
  }
}
