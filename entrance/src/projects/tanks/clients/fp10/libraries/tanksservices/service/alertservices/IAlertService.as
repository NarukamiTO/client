package projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices {
  import flash.display.Sprite;
  import flash.events.IEventDispatcher;

  public interface IAlertService extends IEventDispatcher {
    function showAlert(param1:String, param2:Vector.<String>) : void;
    function showAlertWithCustomButtons(param1:String, param2:Vector.<String>, param3:Vector.<Sprite>) : void;
    function showOkAlert(param1:String) : void;
    function showAlertById(param1:int) : void;
  }
}
