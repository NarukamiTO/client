package projects.tanks.client.clans.clan.incoming {
  import alternativa.types.Long;

  public interface IClanIncomingModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
