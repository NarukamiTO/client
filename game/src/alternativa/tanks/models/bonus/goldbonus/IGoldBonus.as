package alternativa.tanks.models.bonus.goldbonus {
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;

  [ModelInterface]
  public interface IGoldBonus {
    function getRegions() : Vector.<BonusRegionData>;
  }
}
