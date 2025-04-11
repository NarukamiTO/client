package alternativa.tanks.models.battle.gui.gui.statistics.messages {
  public class UserAction {
    public static const ASL_BLUE_PLAYER_DELIVER_FLAG:UserAction = new UserAction(1);
    public static const ASL_BLUE_PLAYER_DROP_FLAG:UserAction = new UserAction(2);
    public static const ASL_BLUE_PLAYER_PICK_FLAG:UserAction = new UserAction(3);
    public static const ASL_RED_PLAYER_DELIVER_FLAG:UserAction = new UserAction(4);
    public static const ASL_RED_PLAYER_DROP_FLAG:UserAction = new UserAction(5);
    public static const ASL_RED_PLAYER_PICK_FLAG:UserAction = new UserAction(6);
    public static const CP_POINT_BLUE_NEUTRAL:UserAction = new UserAction(7);
    public static const CP_POINT_NEUTRAL_BLUE:UserAction = new UserAction(8);
    public static const CP_POINT_NEUTRAL_RED:UserAction = new UserAction(9);
    public static const CP_POINT_RED_NEUTRAL:UserAction = new UserAction(10);
    public static const CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG:UserAction = new UserAction(11);
    public static const CTF_BLUE_PLAYER_DELIVER_REDFLAG:UserAction = new UserAction(12);
    public static const CTF_BLUE_PLAYER_DROP_REDFLAG:UserAction = new UserAction(13);
    public static const CTF_BLUE_PLAYER_PICK_REDFLAG:UserAction = new UserAction(14);
    public static const CTF_RED_PLAYER_BRINGBACK_REDFLAG:UserAction = new UserAction(15);
    public static const CTF_RED_PLAYER_DELIVER_BLUEFLAG:UserAction = new UserAction(16);
    public static const CTF_RED_PLAYER_DROP_BLUEFLAG:UserAction = new UserAction(17);
    public static const CTF_RED_PLAYER_PICK_BLUEFLAG:UserAction = new UserAction(18);
    public static const PLAYER_CHANGE_EQUIPMENT:UserAction = new UserAction(19);
    public static const PLAYER_GOLD_BOX:UserAction = new UserAction(20);
    public static const PLAYER_JOIN_THE_BATTLE:UserAction = new UserAction(21);
    public static const PLAYER_LEAVE_THE_BATTLE:UserAction = new UserAction(22);
    public static const PLAYER_SELF_DESTROY:UserAction = new UserAction(23);
    public static const RGB_PLAYER_DELIVER_BALL:UserAction = new UserAction(24);
    public static const RGB_PLAYER_LOOSE_BALL:UserAction = new UserAction(25);
    public static const RGB_PLAYER_PICK_BALL:UserAction = new UserAction(26);
    public static const RGB_PLAYER_THREW_BALL:UserAction = new UserAction(27);

    internal var id:int;

    public function UserAction(param1:int) {
      super();
      this.id = param1;
    }
  }
}
