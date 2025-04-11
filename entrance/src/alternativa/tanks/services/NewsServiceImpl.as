package alternativa.tanks.services {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import projects.tanks.client.chat.models.news.showing.NewsItemData;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class NewsServiceImpl extends EventDispatcher implements NewsService {
    [Inject]
    public static var storageService:IStorageService;

    private static const READ_NEWS:String = "NEWS_SERVICE_READ_NEWS";

    private var newsItems:Vector.<NewsItemData>;
    private var newsItemsAddingCallback:Function;
    private var hasUnreadNewsCallback:Function;

    public function NewsServiceImpl() {
      super();
    }

    public function setInitialNewsItems(param1:Vector.<NewsItemData>) : void {
      this.newsItems = param1.concat();
      if(this.newsItemsAddingCallback != null) {
        this.newsItemsAddingCallback(param1);
      }
      if(this.hasUnreadNewsCallback != null && this.hasUnreadNews()) {
        this.hasUnreadNewsCallback();
      }
    }

    public function addNewsItem(param1:NewsItemData) : void {
      var local2:NewsServiceEvent = null;
      if(this.newsItems == null) {
        this.newsItems = new Vector.<NewsItemData>();
      }
      this.newsItems.unshift(param1);
      if(this.newsItemsAddingCallback != null) {
        local2 = new NewsServiceEvent(NewsServiceEvent.NEWS_ITEM_IS_SENT);
        local2.setNewsItem(param1);
        dispatchEvent(local2);
      }
    }

    public function setIsViewed(param1:Long) : void {
      var local2:Object = storageService.getStorage().data[READ_NEWS];
      if(local2 == null) {
        local2 = {};
      }
      local2[param1.toString()] = "";
      storageService.getStorage().data[READ_NEWS] = local2;
    }

    public function removeNewsItem(param1:Long) : void {
      var local2:NewsServiceEvent = new NewsServiceEvent(NewsServiceEvent.NEWS_ITEM_IS_REMOVED);
      local2.setNewsId(param1);
      dispatchEvent(local2);
    }

    public function setNewsAddingCallback(param1:Function) : void {
      if(this.newsItems != null) {
        param1(this.newsItems);
      } else {
        this.newsItemsAddingCallback = param1;
      }
    }

    public function setHasUnreadNewsCallback(param1:Function) : void {
      if(this.newsItems == null) {
        this.hasUnreadNewsCallback = param1;
      } else if(this.hasUnreadNews()) {
        param1();
      }
    }

    private function hasUnreadNews() : Boolean {
      var local1:NewsItemData = null;
      for each(local1 in this.newsItems) {
        if(!this.isViewed(local1)) {
          return true;
        }
      }
      return false;
    }

    public function isViewed(param1:NewsItemData) : Boolean {
      var local2:Object = storageService.getStorage().data[READ_NEWS];
      if(!local2) {
        return false;
      }
      return local2.hasOwnProperty(param1.id.toString());
    }

    public function clearExpiredReadNews() : void {
      var local3:String = null;
      var local4:NewsItemData = null;
      var local1:Object = storageService.getStorage().data[READ_NEWS];
      if(!local1) {
        return;
      }
      var local2:Object = {};
      for(local3 in local1) {
        for each(local4 in this.newsItems) {
          if(local3 == local4.id.toString()) {
            local2[local3] = "";
            break;
          }
        }
      }
      storageService.getStorage().data[READ_NEWS] = local2;
    }

    public function resetNewsAddingCallback() : void {
      this.newsItemsAddingCallback = null;
    }

    public function resetHasUnreadNewsCallback() : void {
      this.hasUnreadNewsCallback = null;
    }

    public function cleanup() : void {
      this.newsItems = null;
    }

    public function getUnreadNewsItems() : Vector.<NewsItemData> {
      var local3:NewsItemData = null;
      var local1:Object = storageService.getStorage().data[READ_NEWS];
      if(local1 == null) {
        return this.newsItems;
      }
      var local2:Vector.<NewsItemData> = new Vector.<NewsItemData>();
      for each(local3 in this.newsItems) {
        if(!this.isNewsAlreadyRead(local1,local3)) {
          local2.push(local3);
        }
      }
      return local2;
    }

    private function isNewsAlreadyRead(param1:Object, param2:NewsItemData) : Boolean {
      return param1.hasOwnProperty(param2.id.toString());
    }
  }
}
