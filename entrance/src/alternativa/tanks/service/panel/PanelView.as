package alternativa.tanks.service.panel {
  import alternativa.tanks.gui.panel.MainPanel;
  import flash.events.EventDispatcher;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import services.alertservice.AlertAnswer;

  public class PanelView extends EventDispatcher implements IPanelView {
    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var userChangeGameScreenService:UserChangeGameScreenService;

    private var panel:MainPanel;

    public function PanelView() {
      super();
    }

    public function setPanel() : void {
      this.panel = new MainPanel();
      dispatchEvent(new PanelInitedEvent());
    }

    public function getPanel() : MainPanel {
      return this.panel;
    }

    public function lock() : void {
      this.panel.mouseEnabled = false;
      this.panel.mouseChildren = false;
    }

    public function unlock() : void {
      this.panel.mouseEnabled = true;
      this.panel.mouseChildren = true;
    }

    public function showAlert(param1:String) : void {
      alertService.showAlert(param1,Vector.<String>([AlertAnswer.OK]));
    }
  }
}
