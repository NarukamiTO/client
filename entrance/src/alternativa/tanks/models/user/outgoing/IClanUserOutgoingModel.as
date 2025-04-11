package alternativa.tanks.models.user.outgoing {
  import alternativa.types.Long;

  [ModelInterface]
  public interface IClanUserOutgoingModel {
    function getOutgoingClans() : Vector.<Long>;
  }
}
