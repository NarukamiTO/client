package projects.tanks.client.battlefield.models.drone.demoman {
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IDroneExplosionModelBase {
    function addExplosionEffect(param1:Vector3d, param2:Number) : void;
  }
}
