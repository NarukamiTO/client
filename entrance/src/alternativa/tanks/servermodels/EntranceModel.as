package alternativa.tanks.servermodels {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.service.IEntranceClientFacade;
  import alternativa.tanks.service.IEntranceServerFacade;
  import flash.events.Event;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.model.ObjectUnloadPostListener;
  import projects.tanks.client.entrance.model.entrance.entrance.EntranceModelBase;
  import projects.tanks.client.entrance.model.entrance.entrance.IEntranceModelBase;
  import projects.tanks.clients.flash.commons.models.captcha.IServerCaptcha;

  [ModelInfo]
  public class EntranceModel extends EntranceModelBase implements IEntranceModelBase, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, ObjectUnloadPostListener {
    [Inject]
    public static var serverFacade:IEntranceServerFacade;

    [Inject]
    public static var clientFacade:IEntranceClientFacade;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var loaderWindow:ILoaderWindowService;

    public function EntranceModel() {
      super();
    }

    public function objectLoaded() : void {
      clientFacade.showView();
      clientFacade.antiAddictionEnabled = getInitParam().antiAddictionEnabled;
      display.stage.dispatchEvent(new Event("EntranceModel.objectLoaded",true));
    }

    public function objectLoadedPost() : void {
      serverFacade.entranceObject = object;
      clientFacade.entranceObject = object;
      IServerCaptcha(object.adapt(IServerCaptcha)).bindFacade(clientFacade);
    }

    public function objectUnloaded() : void {
      IServerCaptcha(object.adapt(IServerCaptcha)).unbindFacade();
      loaderWindow.show();
    }

    public function objectUnloadedPost() : void {
      clientFacade.hideView();
    }
  }
}
