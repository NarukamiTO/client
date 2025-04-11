package projects.tanks.client.panel.model.alerts.entrancealert {
  import platform.client.fp10.core.resource.types.LocalizedImageResource;

  public interface IEntranceAlertModelBase {
    function showAlert(param1:LocalizedImageResource, param2:String, param3:String) : void;
  }
}
