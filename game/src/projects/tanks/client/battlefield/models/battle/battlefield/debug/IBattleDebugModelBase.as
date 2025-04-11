package projects.tanks.client.battlefield.models.battle.battlefield.debug {
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IBattleDebugModelBase {
    function addFrame(param1:Number, param2:int, param3:Vector.<Vector3d>, param4:int) : void;
    function addGizmo(param1:Number, param2:int, param3:Vector3d, param4:Vector3d, param5:int) : void;
    function addMarker(param1:Number, param2:int, param3:Vector3d, param4:int) : void;
  }
}
