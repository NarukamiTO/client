package projects.tanks.client.battlefield.models.user.reloader {
  public interface ITankReloaderModelBase {
    function die(param1:int) : void;
    function onDeathScheduled(param1:int) : void;
    function onReload() : void;
  }
}
