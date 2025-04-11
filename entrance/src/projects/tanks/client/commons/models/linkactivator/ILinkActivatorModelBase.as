package projects.tanks.client.commons.models.linkactivator {
  import alternativa.types.Long;

  public interface ILinkActivatorModelBase {
    function alive(param1:Long) : void;
    function battleNotFound() : void;
    function dead(param1:Long) : void;
  }
}
