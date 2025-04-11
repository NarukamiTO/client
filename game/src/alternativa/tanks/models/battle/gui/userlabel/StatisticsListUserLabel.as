package alternativa.tanks.models.battle.gui.userlabel {
  import alternativa.tanks.models.battle.gui.gui.statistics.table.StatisticsData;
  import filters.Filters;

  public class StatisticsListUserLabel extends BattleChatUserLabel {
    public function StatisticsListUserLabel(param1:StatisticsData) {
      super(param1.id,false);
      setUid(param1.uid);
      setRank(param1.rank);
    }

    [Obfuscation(rename="false")]
    override protected function getShadowFilters() : Array {
      return null;
    }

    [Obfuscation(rename="false")]
    override protected function getShadowFiltersOnOver() : Array {
      return Filters.SHADOW_FILTERS;
    }

    [Obfuscation(rename="false")]
    override protected function createAdditionalIcons() : void {
    }

    [Obfuscation(rename="false")]
    override protected function getAdditionalIconsWidth() : Number {
      return 0;
    }
  }
}
