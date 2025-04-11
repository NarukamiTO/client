package projects.tanks.client.clans.user.incomingnotificator {
  import alternativa.types.Long;

  public interface IClanUserIncomingNotificatorModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
