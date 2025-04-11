package projects.tanks.client.clans.user.incoming {
  import alternativa.types.Long;

  public interface IClanUserIncomingModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
