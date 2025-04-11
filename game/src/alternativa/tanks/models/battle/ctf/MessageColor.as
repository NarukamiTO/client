package alternativa.tanks.models.battle.ctf {
  import forms.ColorConstants;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class MessageColor {
    public static const POSITIVE:uint = 65280;
    public static const NEGATIVE:uint = 16776960;
    public static const BLUE:uint = ColorConstants.USER_TITLE_BLUE;
    public static const RED:uint = ColorConstants.USER_TITLE_RED;
    public static const DEFAULT:uint = 65280;
    public static const YELLOW:uint = 16776960;
    public static const ORANGE:uint = 16750081;
    public static const WHITE:uint = 14540253;

    public function MessageColor() {
      super();
    }

    public static function getUserNameColor(param1:BattleTeam, param2:Boolean) : uint {
      if(param2) {
        return MessageColor.YELLOW;
      }
      switch(param1) {
        case BattleTeam.BLUE:
          return MessageColor.BLUE;
        case BattleTeam.RED:
          return MessageColor.RED;
        default:
          return MessageColor.DEFAULT;
      }
    }

    public static function getTextColor(param1:BattleTeam, param2:Boolean, param3:Boolean) : uint {
      if(!param2) {
        return MessageColor.WHITE;
      }
      if(param3) {
        return 16777071;
      }
      switch(param1) {
        case BattleTeam.BLUE:
          return 10013694;
        case BattleTeam.RED:
          return 16685208;
        default:
          return MessageColor.DEFAULT;
      }
    }
  }
}
