package projects.tanks.client.clans.user.acceptednotificator {
  import alternativa.types.Long;

  public interface IClanUserAcceptedNotificatorModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
