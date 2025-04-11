package alternativa.tanks.gui.communication.tabs.news {
  import flash.events.Event;

  public class NewsTabNewsItemAddedEvent extends Event {
    public static const NEWS_ITEM_ADDED:String = "NewsTabNewsItemAddedEvent.NEWS_ITEM_ADDED";

    public function NewsTabNewsItemAddedEvent() {
      super(NEWS_ITEM_ADDED,true);
    }
  }
}
