package alternativa.tanks.model {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.gui.communication.CommunicationPanel;
  import flash.display.DisplayObjectContainer;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.chat.models.CommunicationPanelModelBase;
  import projects.tanks.client.chat.models.ICommunicationPanelModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.UserPropertiesServiceEvent;

  [ModelInfo]
  public class CommunicationPanelModel extends CommunicationPanelModelBase implements ICommunicationPanelModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private var panel:CommunicationPanel;

    public function CommunicationPanelModel() {
      super();
    }

    private static function get layer() : DisplayObjectContainer {
      return display.systemLayer;
    }

    public function objectLoaded() : void {
      if(userPropertiesService.isInited()) {
        this.addCommunicationPanel();
      } else {
        userPropertiesService.addEventListener(UserPropertiesServiceEvent.ON_INIT_USER_PROPERTIES,this.onInitUserPropertiesService);
      }
    }

    private function onInitUserPropertiesService(param1:UserPropertiesServiceEvent) : void {
      userPropertiesService.removeEventListener(UserPropertiesServiceEvent.ON_INIT_USER_PROPERTIES,this.onInitUserPropertiesService);
      this.addCommunicationPanel();
    }

    private function addCommunicationPanel() : void {
      this.panel = new CommunicationPanel();
      layer.addChild(this.panel);
    }

    public function objectUnloaded() : void {
      userPropertiesService.removeEventListener(UserPropertiesServiceEvent.ON_INIT_USER_PROPERTIES,this.onInitUserPropertiesService);
      layer.removeChild(this.panel);
    }
  }
}
