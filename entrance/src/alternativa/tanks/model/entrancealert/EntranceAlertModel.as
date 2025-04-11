package alternativa.tanks.model.entrancealert {
  import alternativa.tanks.gui.EntranceAlertWindow;
  import platform.client.fp10.core.resource.types.LocalizedImageResource;
  import projects.tanks.client.panel.model.alerts.entrancealert.EntranceAlertModelBase;
  import projects.tanks.client.panel.model.alerts.entrancealert.IEntranceAlertModelBase;

  [ModelInfo]
  public class EntranceAlertModel extends EntranceAlertModelBase implements IEntranceAlertModelBase {
    public function EntranceAlertModel() {
      super();
    }

    public function showAlert(param1:LocalizedImageResource, param2:String, param3:String) : void {
      new EntranceAlertWindow(param1,param2,param3);
    }
  }
}
