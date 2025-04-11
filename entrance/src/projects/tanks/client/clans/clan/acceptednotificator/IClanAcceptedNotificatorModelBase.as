package projects.tanks.client.clans.clan.acceptednotificator {
  import alternativa.types.Long;

  public interface IClanAcceptedNotificatorModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
