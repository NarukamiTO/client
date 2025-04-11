package alternativa.tanks.models.battle.gui.gui.statistics.field.score {
  import flash.display.Bitmap;

  public class ASScoreIndicator extends SimpleTeamScoreIndicator {
    private static var redScoreClass:Class = ASScoreIndicator_redScoreClass;
    private static var blueScoreClass:Class = ASScoreIndicator_blueScoreClass;

    public function ASScoreIndicator() {
      super();
    }

    override protected function getRedScoreIcon() : Bitmap {
      return new redScoreClass();
    }

    override protected function getBlueScoreIcon() : Bitmap {
      return new blueScoreClass();
    }
  }
}
