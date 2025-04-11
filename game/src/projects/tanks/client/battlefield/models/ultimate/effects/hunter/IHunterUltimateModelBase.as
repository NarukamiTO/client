package projects.tanks.client.battlefield.models.ultimate.effects.hunter {
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IHunterUltimateModelBase {
    function cancel() : void;
    function dispel(param1:Vector.<Vector3d>) : void;
    function startCharging() : void;
    function stopCharging() : void;
  }
}
