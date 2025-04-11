package alternativa.tanks.models.battle.rugby {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.models.battle.ctf.FlagMessage;
  import controls.chat.MessageColor;
  import flash.utils.Dictionary;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class RugbyMessages {
    [Inject]
    public static var localeService:ILocaleService;

    public static const TAKE:String = "take";
    public static const LOST:String = "lost";
    public static const GOAL:String = "goal";

    private var readyToFaceOff:FlagMessage = FlagMessage.fromTextId(TanksLocale.TEXT_RUGBY_READY_TO_FACE_OFF,MessageColor.YELLOW);
    private var facedOffMessage:FlagMessage = FlagMessage.fromTextId(TanksLocale.TEXT_RUGBY_FACE_OFF,MessageColor.YELLOW);
    private var blueMessages:Dictionary = new Dictionary();
    private var redMessages:Dictionary = new Dictionary();
    private var battleLogMessages:Dictionary = new Dictionary();

    public function RugbyMessages() {
      super();
      this.battleLogMessages[TAKE] = localeService.getText(TanksLocale.TEXT_RUGBY_BALL_TAKEN_USER);
      this.battleLogMessages[LOST] = localeService.getText(TanksLocale.TEXT_RUGBY_BALL_LOST_USER);
      this.battleLogMessages[GOAL] = localeService.getText(TanksLocale.TEXT_RUGBY_GOAL_USER);
      this.redMessages[TAKE] = FlagMessage.fromTextId(TanksLocale.TEXT_RUGBY_BALL_TAKEN_RED,MessageColor.RED);
      this.redMessages[LOST] = FlagMessage.fromTextId(TanksLocale.TEXT_RUGBY_BALL_LOST_RED,MessageColor.RED);
      this.redMessages[GOAL] = FlagMessage.fromTextId(TanksLocale.TEXT_RUGBY_GOAL_RED,MessageColor.RED);
      this.blueMessages[TAKE] = FlagMessage.fromTextId(TanksLocale.TEXT_RUGBY_BALL_TAKEN_BLUE,MessageColor.BLUE);
      this.blueMessages[LOST] = FlagMessage.fromTextId(TanksLocale.TEXT_RUGBY_BALL_LOST_BLUE,MessageColor.BLUE);
      this.blueMessages[GOAL] = FlagMessage.fromTextId(TanksLocale.TEXT_RUGBY_GOAL_BLUE,MessageColor.BLUE);
    }

    public function getFacedOffMessage() : FlagMessage {
      return this.facedOffMessage;
    }

    public function getBattleLogMessage(param1:String) : String {
      return this.battleLogMessages[param1];
    }

    public function getMessage(param1:String, param2:BattleTeam) : FlagMessage {
      var local3:Dictionary = param2 == BattleTeam.RED ? this.redMessages : this.blueMessages;
      return local3[param1];
    }

    public function getReadyToFaceOffMessage() : FlagMessage {
      return this.readyToFaceOff;
    }
  }
}
