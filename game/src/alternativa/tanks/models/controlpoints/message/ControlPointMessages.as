package alternativa.tanks.models.controlpoints.message {
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import flash.utils.Dictionary;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ControlPointMessages {
    public static const weCapturedPoint:ControlPointMessage = new ControlPointMessage(MessageColor.POSITIVE,TanksLocale.TEXT_DOM_WE_CAPTURED_POINT);
    public static const enemyCapturedPoint:ControlPointMessage = new ControlPointMessage(MessageColor.NEGATIVE,TanksLocale.TEXT_DOM_ENEMIES_CAPTURED_POINT);
    public static const weLostPoint:ControlPointMessage = new ControlPointMessage(MessageColor.NEGATIVE,TanksLocale.TEXT_DOM_WE_LOST_POINT);
    public static const enemyLostPoint:ControlPointMessage = new ControlPointMessage(MessageColor.POSITIVE,TanksLocale.TEXT_DOM_ENEMIES_LOST_POINT);

    private static const blueCapturedPoint:ControlPointMessage = new ControlPointMessage(MessageColor.BLUE,TanksLocale.TEXT_DOM_BLUE_CAPTURED_POINT);
    private static const redCapturedPoint:ControlPointMessage = new ControlPointMessage(MessageColor.RED,TanksLocale.TEXT_DOM_RED_CAPTURED_POINT);
    private static const captureMessages:Dictionary = new Dictionary();
    private static const blueLostPoint:ControlPointMessage = new ControlPointMessage(MessageColor.BLUE,TanksLocale.TEXT_DOM_BLUE_LOST_POINT);
    private static const redLostPoint:ControlPointMessage = new ControlPointMessage(MessageColor.RED,TanksLocale.TEXT_DOM_RED_LOST_POINT);
    private static const lostMessages:Dictionary = new Dictionary();

    captureMessages[BattleTeam.BLUE] = blueCapturedPoint;
    captureMessages[BattleTeam.RED] = redCapturedPoint;
    lostMessages[BattleTeam.BLUE] = blueLostPoint;
    lostMessages[BattleTeam.RED] = redLostPoint;

    public function ControlPointMessages() {
      super();
    }

    public static function getCaptureMessage(param1:BattleTeam) : ControlPointMessage {
      return captureMessages[param1];
    }

    public static function getLostMessage(param1:BattleTeam) : ControlPointMessage {
      return lostMessages[param1];
    }
  }
}
