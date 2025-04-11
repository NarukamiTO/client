package alternativa.tanks.service.garage {
  import alternativa.tanks.gui.IGarageWindow;

  public interface GarageService {
    function getView() : IGarageWindow;
    function registerView(param1:IGarageWindow) : void;
    function init(param1:Number, param2:Number, param3:Number, param4:Number) : void;
    function unregisterView() : void;
    function getCameraPitch() : Number;
    function getCameraAltitude() : Number;
    function getCameraDistance() : Number;
    function getCameraFieldOfView() : Number;
  }
}
