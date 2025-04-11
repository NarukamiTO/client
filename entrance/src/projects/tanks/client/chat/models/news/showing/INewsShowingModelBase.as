package projects.tanks.client.chat.models.news.showing {
  import alternativa.types.Long;

  public interface INewsShowingModelBase {
    function removeNewsItem(param1:Long) : void;
    function sendNewsItem(param1:NewsItemData) : void;
  }
}
