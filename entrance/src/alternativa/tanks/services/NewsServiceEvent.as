package alternativa.tanks.services {
  import alternativa.types.Long;
  import flash.events.Event;
  import projects.tanks.client.chat.models.news.showing.NewsItemData;

  public class NewsServiceEvent extends Event {
    public static const NEWS_ITEM_IS_SENT:String = "NewsServiceEvent.NEWS_ITEM_IS_SENT";
    public static const NEWS_ITEM_IS_REMOVED:String = "NewsServiceEvent.NEWS_ITEM_IS_REMOVED";

    private var newsItem:NewsItemData;
    private var newsId:Long;

    public function NewsServiceEvent(param1:String) {
      super(param1,true,false);
    }

    public function getNewsItem() : NewsItemData {
      return this.newsItem;
    }

    public function setNewsItem(param1:NewsItemData) : void {
      this.newsItem = param1;
    }

    public function getNewsId() : Long {
      return this.newsId;
    }

    public function setNewsId(param1:Long) : void {
      this.newsId = param1;
    }
  }
}
