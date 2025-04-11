package projects.tanks.client.clans.user.accepted {
  import alternativa.types.Long;

  public interface IClanUserAcceptedModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
