package alternativa.tanks.model.news {
  import alternativa.tanks.gui.news.NewsAlertWindow;
  import alternativa.tanks.services.NewsService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.chat.models.news.showing.INewsShowingModelBase;
  import projects.tanks.client.chat.models.news.showing.NewsItemData;
  import projects.tanks.client.chat.models.news.showing.NewsShowingModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.serverrestarttime.OnceADayActionService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.UserPropertiesServiceEvent;

  [ModelInfo]
  public class NewsShowingModel extends NewsShowingModelBase implements INewsShowingModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var newsService:NewsService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var onceADayActionService:OnceADayActionService;

    [Inject]
    public static var dialogService:IDialogsService;

    private static const NEWS_ALERT_ACTION:String = "NEWS_ALERT";

    public function NewsShowingModel() {
      super();
    }

    public function objectLoadedPost() : void {
      var local1:Vector.<NewsItemData> = getInitParam().newsItems;
      if(local1.length > 0) {
        newsService.setInitialNewsItems(local1);
        this.prepareShowAlert();
      }
    }

    private function prepareShowAlert() : void {
      if(Boolean(onceADayActionService.verifyAndSaveAction(NEWS_ALERT_ACTION)) && userPropertiesService.rank > 1) {
        if(userPropertiesService.isInited()) {
          this.showNewsAlert();
        } else {
          userPropertiesService.addEventListener(UserPropertiesServiceEvent.ON_INIT_USER_PROPERTIES,this.showNewsAlert);
        }
      }
    }

    private function showNewsAlert(param1:UserPropertiesServiceEvent = null) : void {
      var local3:NewsAlertWindow = null;
      userPropertiesService.removeEventListener(UserPropertiesServiceEvent.ON_INIT_USER_PROPERTIES,this.showNewsAlert);
      var local2:Vector.<NewsItemData> = newsService.getUnreadNewsItems();
      if(local2.length > 0) {
        local3 = new NewsAlertWindow(local2);
        dialogService.enqueueDialog(local3);
      }
    }

    public function sendNewsItem(param1:NewsItemData) : void {
      newsService.addNewsItem(param1);
    }

    public function removeNewsItem(param1:Long) : void {
      newsService.removeNewsItem(param1);
    }

    public function objectUnloaded() : void {
      userPropertiesService.removeEventListener(UserPropertiesServiceEvent.ON_INIT_USER_PROPERTIES,this.showNewsAlert);
      newsService.cleanup();
    }
  }
}
