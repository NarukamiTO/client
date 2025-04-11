package projects.tanks.client.battlefield.models.battle.battlefield.meteors {
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IMeteorStormModelBase {
    function meteorNotification() : void;
    function spawnMeteor(param1:Vector3d, param2:Vector3d, param3:int) : void;
  }
}
