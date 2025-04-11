package alternativa.tanks.services {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import projects.tanks.client.chat.models.news.showing.NewsItemData;

  public interface NewsService extends IEventDispatcher {
    function setInitialNewsItems(param1:Vector.<NewsItemData>) : void;
    function addNewsItem(param1:NewsItemData) : void;
    function removeNewsItem(param1:Long) : void;
    function setIsViewed(param1:Long) : void;
    function isViewed(param1:NewsItemData) : Boolean;
    function setNewsAddingCallback(param1:Function) : void;
    function resetNewsAddingCallback() : void;
    function setHasUnreadNewsCallback(param1:Function) : void;
    function resetHasUnreadNewsCallback() : void;
    function clearExpiredReadNews() : void;
    function cleanup() : void;
    function getUnreadNewsItems() : Vector.<NewsItemData>;
  }
}
