package alternativa.tanks.models.user.incoming {
  import alternativa.types.Long;

  [ModelInterface]
  public interface IClanUserIncomingModel {
    function getIncomingClans() : Vector.<Long>;
  }
}
