package forms.userlabel {
  import alternativa.types.Long;
  import flash.display.Bitmap;
  import flash.utils.Dictionary;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class ChatUserLabel extends UserLabel {
    public static const CHAT_MODERATOR_STATUS_ICON_CONT_WIDTH:int = 16;

    private static const cmStatusIconClass:Class = ChatUserLabel_cmStatusIconClass;
    private static const goldBattleStatusIconClass:Class = ChatUserLabel_goldBattleStatusIconClass;
    private static const silverBattleStatusIconClass:Class = ChatUserLabel_silverBattleStatusIconClass;
    private static const bronzeBattleStatusIconClass:Class = ChatUserLabel_bronzeBattleStatusIconClass;
    private static const goldStatusIconClass:Class = ChatUserLabel_goldStatusIconClass;
    private static const silverStatusIconClass:Class = ChatUserLabel_silverStatusIconClass;
    private static const bronzeStatusIconClass:Class = ChatUserLabel_bronzeStatusIconClass;
    private static const eventGoldStatusIconClass:Class = ChatUserLabel_eventGoldStatusIconClass;
    private static const eventSilverStatusIconClass:Class = ChatUserLabel_eventSilverStatusIconClass;
    private static const eventBronzeStatusIconClass:Class = ChatUserLabel_eventBronzeStatusIconClass;
    private static const bitmapDatas:Dictionary = new Dictionary();

    bitmapDatas[ChatModeratorLevel.COMMUNITY_MANAGER] = new cmStatusIconClass().bitmapData;
    bitmapDatas[ChatModeratorLevel.BATTLE_ADMINISTRATOR] = new goldBattleStatusIconClass().bitmapData;
    bitmapDatas[ChatModeratorLevel.BATTLE_MODERATOR] = new silverBattleStatusIconClass().bitmapData;
    bitmapDatas[ChatModeratorLevel.BATTLE_CANDIDATE] = new bronzeBattleStatusIconClass().bitmapData;
    bitmapDatas[ChatModeratorLevel.ADMINISTRATOR] = new goldStatusIconClass().bitmapData;
    bitmapDatas[ChatModeratorLevel.MODERATOR] = new silverStatusIconClass().bitmapData;
    bitmapDatas[ChatModeratorLevel.CANDIDATE] = new bronzeStatusIconClass().bitmapData;
    bitmapDatas[ChatModeratorLevel.EVENT_CHAT_ADMIN] = new eventGoldStatusIconClass().bitmapData;
    bitmapDatas[ChatModeratorLevel.EVENT_CHAT_MODERATOR] = new eventSilverStatusIconClass().bitmapData;
    bitmapDatas[ChatModeratorLevel.EVENT_CHAT_CANDIDATE] = new eventBronzeStatusIconClass().bitmapData;

    protected var _chatModeratorLevel:ChatModeratorLevel;
    protected var _needDrawAdditionalIcons:Boolean = this._chatModeratorLevel != ChatModeratorLevel.NONE;

    public function ChatUserLabel(param1:Long, param2:Boolean = true) {
      super(param1,param2);
    }

    override protected function createAdditionalIcons() : void {
      var local1:Bitmap = null;
      if(this._needDrawAdditionalIcons) {
        local1 = new Bitmap(bitmapDatas[this._chatModeratorLevel]);
        local1.x = RANK_ICON_CONT_WIDTH + 1;
        local1.y = 3;
        shadowContainer.addChild(local1);
      }
    }

    override protected function getAdditionalIconsWidth() : Number {
      return this._needDrawAdditionalIcons ? CHAT_MODERATOR_STATUS_ICON_CONT_WIDTH : 0;
    }
  }
}
