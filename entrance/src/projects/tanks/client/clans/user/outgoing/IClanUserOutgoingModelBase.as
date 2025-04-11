package projects.tanks.client.clans.user.outgoing {
  import alternativa.types.Long;

  public interface IClanUserOutgoingModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
