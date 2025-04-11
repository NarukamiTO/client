package projects.tanks.client.battlefield.models.drone {
  public interface IDroneIndicatorModelBase {
    function notReady() : void;
    function ready() : void;
    function reload(param1:int) : void;
    function setBatteriesAmount(param1:int) : void;
  }
}
