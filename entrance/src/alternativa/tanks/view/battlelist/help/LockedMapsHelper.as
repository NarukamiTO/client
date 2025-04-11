package alternativa.tanks.view.battlelist.help {
  import alternativa.tanks.view.battlelist.LocaleBattleList;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class LockedMapsHelper extends BubbleHelper {
    public function LockedMapsHelper() {
      super();
      text = LocaleBattleList.battleSelectLockedMapHelperName;
      arrowLehgth = LocaleBattleList.battleSelectLockedMapHelperArrowLength;
      arrowAlign = HelperAlign.MIDDLE_LEFT;
      _showLimit = 5;
    }
  }
}
