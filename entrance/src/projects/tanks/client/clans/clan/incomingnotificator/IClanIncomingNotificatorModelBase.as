package projects.tanks.client.clans.clan.incomingnotificator {
  import alternativa.types.Long;

  public interface IClanIncomingNotificatorModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
