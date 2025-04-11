package alternativa.tanks.gui.clanchat {
  import alternativa.tanks.gui.chat.LobbyChatUserLabel;
  import projects.tanks.client.chat.types.UserStatus;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class ClanChatUserLabel extends LobbyChatUserLabel {
    public function ClanChatUserLabel(param1:UserStatus, param2:String) {
      super(param1,false,param2,false);
      _writeInPublicChat = true;
      _chatModeratorLevel = ChatModeratorLevel.NONE;
      inviteBattleEnable = false;
      showClanProfile = false;
    }
  }
}
