package alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.score.TeamScoreIndicator;

  public class CTFScoreIndicator extends ComplexTeamScoreIndicator implements TeamScoreIndicator {
    private static var flagBlueClass:Class = CTFScoreIndicator_flagBlueClass;
    private static var flagRedClass:Class = CTFScoreIndicator_flagRedClass;
    private static var flagBlueLostClass:Class = CTFScoreIndicator_flagBlueLostClass;
    private static var flagRedLostClass:Class = CTFScoreIndicator_flagRedLostClass;
    private static var flagFlashClass:Class = CTFScoreIndicator_flagFlashClass;

    public function CTFScoreIndicator() {
      super(new flagBlueClass(),new flagBlueLostClass(),new flagFlashClass(),new flagRedClass(),new flagRedLostClass(),new flagFlashClass());
    }
  }
}
