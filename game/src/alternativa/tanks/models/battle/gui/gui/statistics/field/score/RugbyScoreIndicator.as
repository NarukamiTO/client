package alternativa.tanks.models.battle.gui.gui.statistics.field.score {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.ComplexTeamScoreIndicator;

  public class RugbyScoreIndicator extends ComplexTeamScoreIndicator implements TeamScoreIndicator {
    private static var redScoreClass:Class = RugbyScoreIndicator_redScoreClass;
    private static var blueScoreClass:Class = RugbyScoreIndicator_blueScoreClass;
    private static var flagBlueLostClass:Class = RugbyScoreIndicator_flagBlueLostClass;
    private static var flagRedLostClass:Class = RugbyScoreIndicator_flagRedLostClass;
    private static var flagFlashClass:Class = RugbyScoreIndicator_flagFlashClass;

    public function RugbyScoreIndicator() {
      super(new blueScoreClass(),new flagBlueLostClass(),new flagFlashClass(),new redScoreClass(),new flagRedLostClass(),new flagFlashClass());
    }
  }
}
