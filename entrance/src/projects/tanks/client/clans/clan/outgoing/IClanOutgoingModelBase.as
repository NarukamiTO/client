package projects.tanks.client.clans.clan.outgoing {
  import alternativa.types.Long;

  public interface IClanOutgoingModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
