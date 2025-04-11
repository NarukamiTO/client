package alternativa.tanks.models.clan.accepted {
  import alternativa.types.Long;

  [ModelInterface]
  public interface IClanAcceptedModel {
    function getAcceptedUsers() : Vector.<Long>;
  }
}
