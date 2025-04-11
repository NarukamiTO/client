package alternativa.tanks.model.item.modification {
  import alternativa.types.Long;

  [ModelInterface]
  public interface IModification {
    function getBaseItemId() : Long;
    function getModificationIndex() : int;
  }
}
