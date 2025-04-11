package alternativa.tanks.models.battle.gui.gui.statistics.messages {
  import alternativa.tanks.models.battle.battlefield.common.MessageLine;
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.tanks.models.battle.gui.userlabel.BattleActionUserLabel;
  import alternativa.tanks.models.battle.gui.userlabel.BattleChatUserLabel;
  import controls.Label;
  import flash.display.Bitmap;
  import flash.utils.Dictionary;

  public class ActionOutputLine extends MessageLine {
    private static var aslBluePlayerDeliverFlagIcon:Class = ActionOutputLine_aslBluePlayerDeliverFlagIcon;
    private static var aslBluePlayerDropFlagIcon:Class = ActionOutputLine_aslBluePlayerDropFlagIcon;
    private static var aslBluePlayerPickFlagIcon:Class = ActionOutputLine_aslBluePlayerPickFlagIcon;
    private static var aslRedPlayerDeliverFlagIcon:Class = ActionOutputLine_aslRedPlayerDeliverFlagIcon;
    private static var aslRedPlayerDropFlagIcon:Class = ActionOutputLine_aslRedPlayerDropFlagIcon;
    private static var aslRedPlayerPickFlagIcon:Class = ActionOutputLine_aslRedPlayerPickFlagIcon;
    private static var cpPointBlueNeutralIcon:Class = ActionOutputLine_cpPointBlueNeutralIcon;
    private static var cpPointNeutralBlueIcon:Class = ActionOutputLine_cpPointNeutralBlueIcon;
    private static var cpPointNeutralRedIcon:Class = ActionOutputLine_cpPointNeutralRedIcon;
    private static var cpPointRedNeutralIcon:Class = ActionOutputLine_cpPointRedNeutralIcon;
    private static var ctfBluePlayerBringbackBlueflagIcon:Class = ActionOutputLine_ctfBluePlayerBringbackBlueflagIcon;
    private static var ctfBluePlayerDeliverRedflagIcon:Class = ActionOutputLine_ctfBluePlayerDeliverRedflagIcon;
    private static var ctfBluePlayerDropRedflagIcon:Class = ActionOutputLine_ctfBluePlayerDropRedflagIcon;
    private static var ctfBluePlayerPickRedflagIcon:Class = ActionOutputLine_ctfBluePlayerPickRedflagIcon;
    private static var ctfRedPlayerBringbackRedflagIcon:Class = ActionOutputLine_ctfRedPlayerBringbackRedflagIcon;
    private static var ctfRedPlayerDeliverBlueflagIcon:Class = ActionOutputLine_ctfRedPlayerDeliverBlueflagIcon;
    private static var ctfRedPlayerDropBlueflagIcon:Class = ActionOutputLine_ctfRedPlayerDropBlueflagIcon;
    private static var ctfRedPlayerPickBlueflagIcon:Class = ActionOutputLine_ctfRedPlayerPickBlueflagIcon;
    private static var playerChangeEquipmentIcon:Class = ActionOutputLine_playerChangeEquipmentIcon;
    private static var playerGoldBoxIcon:Class = ActionOutputLine_playerGoldBoxIcon;
    private static var playerJoinTheBattleIcon:Class = ActionOutputLine_playerJoinTheBattleIcon;
    private static var playerLeaveTheBattleIcon:Class = ActionOutputLine_playerLeaveTheBattleIcon;
    private static var playerSelfDestroyIcon:Class = ActionOutputLine_playerSelfDestroyIcon;
    private static var rgbPlayerDeliverBallIcon:Class = ActionOutputLine_rgbPlayerDeliverBallIcon;
    private static var rgbPlayerLooseBallIcon:Class = ActionOutputLine_rgbPlayerLooseBallIcon;
    private static var rgbPlayerPickBallIcon:Class = ActionOutputLine_rgbPlayerPickBallIcon;
    private static var rgbPlayerThrewBallIcon:Class = ActionOutputLine_rgbPlayerThrewBallIcon;
    private static var action2icon:Dictionary = new Dictionary();

    action2icon[UserAction.ASL_BLUE_PLAYER_DELIVER_FLAG] = new aslBluePlayerDeliverFlagIcon().bitmapData;
    action2icon[UserAction.ASL_BLUE_PLAYER_DROP_FLAG] = new aslBluePlayerDropFlagIcon().bitmapData;
    action2icon[UserAction.ASL_BLUE_PLAYER_PICK_FLAG] = new aslBluePlayerPickFlagIcon().bitmapData;
    action2icon[UserAction.ASL_RED_PLAYER_DELIVER_FLAG] = new aslRedPlayerDeliverFlagIcon().bitmapData;
    action2icon[UserAction.ASL_RED_PLAYER_DROP_FLAG] = new aslRedPlayerDropFlagIcon().bitmapData;
    action2icon[UserAction.ASL_RED_PLAYER_PICK_FLAG] = new aslRedPlayerPickFlagIcon().bitmapData;
    action2icon[UserAction.CP_POINT_BLUE_NEUTRAL] = new cpPointBlueNeutralIcon().bitmapData;
    action2icon[UserAction.CP_POINT_NEUTRAL_BLUE] = new cpPointNeutralBlueIcon().bitmapData;
    action2icon[UserAction.CP_POINT_NEUTRAL_RED] = new cpPointNeutralRedIcon().bitmapData;
    action2icon[UserAction.CP_POINT_RED_NEUTRAL] = new cpPointRedNeutralIcon().bitmapData;
    action2icon[UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG] = new ctfBluePlayerBringbackBlueflagIcon().bitmapData;
    action2icon[UserAction.CTF_BLUE_PLAYER_DELIVER_REDFLAG] = new ctfBluePlayerDeliverRedflagIcon().bitmapData;
    action2icon[UserAction.CTF_BLUE_PLAYER_DROP_REDFLAG] = new ctfBluePlayerDropRedflagIcon().bitmapData;
    action2icon[UserAction.CTF_BLUE_PLAYER_PICK_REDFLAG] = new ctfBluePlayerPickRedflagIcon().bitmapData;
    action2icon[UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG] = new ctfRedPlayerBringbackRedflagIcon().bitmapData;
    action2icon[UserAction.CTF_RED_PLAYER_DELIVER_BLUEFLAG] = new ctfRedPlayerDeliverBlueflagIcon().bitmapData;
    action2icon[UserAction.CTF_RED_PLAYER_DROP_BLUEFLAG] = new ctfRedPlayerDropBlueflagIcon().bitmapData;
    action2icon[UserAction.CTF_RED_PLAYER_PICK_BLUEFLAG] = new ctfRedPlayerPickBlueflagIcon().bitmapData;
    action2icon[UserAction.PLAYER_CHANGE_EQUIPMENT] = new playerChangeEquipmentIcon().bitmapData;
    action2icon[UserAction.PLAYER_GOLD_BOX] = new playerGoldBoxIcon().bitmapData;
    action2icon[UserAction.PLAYER_JOIN_THE_BATTLE] = new playerJoinTheBattleIcon().bitmapData;
    action2icon[UserAction.PLAYER_LEAVE_THE_BATTLE] = new playerLeaveTheBattleIcon().bitmapData;
    action2icon[UserAction.PLAYER_SELF_DESTROY] = new playerSelfDestroyIcon().bitmapData;
    action2icon[UserAction.RGB_PLAYER_DELIVER_BALL] = new rgbPlayerDeliverBallIcon().bitmapData;
    action2icon[UserAction.RGB_PLAYER_LOOSE_BALL] = new rgbPlayerLooseBallIcon().bitmapData;
    action2icon[UserAction.RGB_PLAYER_PICK_BALL] = new rgbPlayerPickBallIcon().bitmapData;
    action2icon[UserAction.RGB_PLAYER_THREW_BALL] = new rgbPlayerThrewBallIcon().bitmapData;

    private var userLabel:BattleChatUserLabel;
    private var label:Label;

    public function ActionOutputLine() {
      super();
    }

    public static function userAction(param1:ShortUserInfo, param2:UserAction, param3:ShortUserInfo) : ActionOutputLine {
      var local4:ActionOutputLine = new ActionOutputLine();
      local4.createUserLabel(param1);
      local4.createActionIcon(param2,6);
      if(param3 != null) {
        local4.createUserLabel(param1);
      }
      return local4;
    }

    public static function simple(param1:UserAction) : ActionOutputLine {
      var local2:ActionOutputLine = new ActionOutputLine();
      local2.createActionIcon(param1,0);
      return local2;
    }

    public static function pointAction(param1:String, param2:UserAction) : ActionOutputLine {
      var local3:ActionOutputLine = new ActionOutputLine();
      local3.createActionTextLabel(param1);
      local3.createActionIcon(param2,6);
      return local3;
    }

    private function createActionTextLabel(param1:String) : void {
      this.label = new Label();
      this.label.text = param1;
      this.label.x = width + 4;
      this.label.y = 5;
      shadowContainer.addChild(this.label);
    }

    private function createUserLabel(param1:ShortUserInfo) : void {
      this.userLabel = new BattleActionUserLabel(param1.userId);
      this.userLabel.setUidColor(MessageColor.getUserNameColor(param1.teamType,false),true);
      this.userLabel.x = width + 4;
      this.userLabel.y = 5;
      addChild(this.userLabel);
    }

    private function createActionIcon(param1:UserAction, param2:int) : void {
      var local3:Bitmap = null;
      local3 = new Bitmap(action2icon[param1]);
      local3.x = width + param2;
      shadowContainer.addChild(local3);
    }
  }
}
