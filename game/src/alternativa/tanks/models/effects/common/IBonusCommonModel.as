package alternativa.tanks.models.effects.common {
  import alternativa.tanks.bonuses.Bonus;
  import alternativa.types.Long;

  [ModelInterface]
  public interface IBonusCommonModel {
    function getBonus(param1:Long) : Bonus;
  }
}
