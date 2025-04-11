package projects.tanks.client.clans.clan.accepted {
  import alternativa.types.Long;

  public interface IClanAcceptedModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
