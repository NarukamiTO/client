package alternativa.tanks.models.battle.battlefield.mine {
  import alternativa.math.Vector3;
  import alternativa.types.Long;

  [ModelInterface]
  public interface IBattleMinesModel {
    function getMinDistanceFromBase() : Number;
    function getMinePosition(param1:Long) : Vector3;
  }
}
