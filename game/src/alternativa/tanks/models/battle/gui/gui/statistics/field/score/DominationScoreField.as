package alternativa.tanks.models.battle.gui.gui.statistics.field.score {
  import assets.icons.BattleInfoIcons;

  public class DominationScoreField extends TeamScoreFieldBase implements TeamScoreIndicator {
    private static const ICON_WIDTH:int = 21;
    private static const ICON_Y:int = 9;

    private var icon:BattleInfoIcons;

    public function DominationScoreField() {
      super();
      this.icon = new BattleInfoIcons();
      this.icon.type = BattleInfoIcons.TEAM_SCORE_BIG;
      addChild(this.icon);
      this.icon.y = ICON_Y;
    }

    override protected function calculateWidth() : int {
      var local1:int = 5;
      var local2:int = labelRed.width > labelBlue.width ? int(labelRed.width) : int(labelBlue.width);
      labelRed.x = local1 + local1 + (local2 - labelRed.width >> 1);
      this.icon.x = labelRed.x + local2 + local1;
      labelBlue.x = this.icon.x + ICON_WIDTH + local1 + (local2 - labelBlue.width >> 1);
      return labelBlue.x + local2 + local1 + local1;
    }
  }
}
