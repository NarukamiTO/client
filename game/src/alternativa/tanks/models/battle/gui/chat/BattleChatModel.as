package alternativa.tanks.models.battle.gui.chat {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.model.chat.ChatSettingsTracker;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.types.Long;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.models.battle.gui.chat.BattleChatModelBase;
  import projects.tanks.client.battlefield.models.battle.gui.chat.IBattleChatModelBase;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import services.contextmenu.ContextMenuServiceEvent;
  import services.contextmenu.IContextMenuService;

  [ModelInfo]
  public class BattleChatModel extends BattleChatModelBase implements IBattleChatModelBase, IBattleChat, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var battleGuiService:BattleGUIService;

    [Inject]
    public static var contextMenuService:IContextMenuService;

    private var battleChat:BattleChat;
    private var teamHeaderText:String;

    private const VOTE_CMD:* = "/vote ";

    public function BattleChatModel() {
      super();
      this.battleChat = new BattleChat();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      this.battleChat.setBattleObject(object);
      this.battleChat.clear();
      this.battleChat.locked = false;
      this.battleChat.addEventListener(BattleChatEvent.SEND_MESSAGE,getFunctionWrapper(this.onSendMessage));
      battleGuiService.getGuiContainer().addChild(this.battleChat);
      display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      this.teamHeaderText = "";
      putData(ChatLocker,new ChatLocker(this.battleChat));
      putData(ChatSettingsTracker,new ChatSettingsTracker(this.battleChat));
      contextMenuService.addEventListener(ContextMenuServiceEvent.VOTE_USER,getFunctionWrapper(this.onSendCmd));
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      this.battleChat.removeEventListener(BattleChatEvent.SEND_MESSAGE,getFunctionWrapper(this.onSendMessage));
      contextMenuService.removeEventListener(ContextMenuServiceEvent.VOTE_USER,getFunctionWrapper(this.onSendCmd));
      this.battleChat.clear();
      if(this.battleChat.parent != null) {
        this.battleChat.parent.removeChild(this.battleChat);
      }
      display.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
    }

    [Obfuscation(rename="false")]
    public function addMessage(param1:Long, param2:String, param3:BattleTeam) : void {
      this.addUserMessageWithMessageLabel(param1,param2,param3);
    }

    [Obfuscation(rename="false")]
    public function addTeamMessage(param1:Long, param2:String, param3:BattleTeam) : void {
      this.addUserMessageWithMessageLabel(param1,param2,param3,true);
    }

    private function addUserMessageWithMessageLabel(param1:Long, param2:String, param3:BattleTeam, param4:Boolean = false) : void {
      var local5:Boolean = param1.low == -1 && param1.high == -1;
      this.battleChat.addUserMessage(param1,param3,param2 + "\n",param4,local5);
    }

    [Obfuscation(rename="false")]
    public function addSpectatorTeamMessage(param1:String, param2:String) : void {
      this.battleChat.addUserMessage(Long.getLong(-1,-1),BattleTeam.NONE,param2 + "\n",true,true);
    }

    [Obfuscation(rename="false")]
    public function addSystemMessage(param1:String) : void {
      this.battleChat.addSystemMessage(param1);
    }

    private function onKeyUp(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.ENTER) {
        if(battleInfoService.isSpectatorMode()) {
          this.battleChat.setSpectatorList(this.teamHeaderText);
        }
        this.battleChat.openChat();
      }
    }

    private function onSendMessage(param1:BattleChatEvent) : void {
      server.sendMessage(param1.message,param1.teamOnly);
    }

    private function onSendCmd(param1:ContextMenuServiceEvent) : void {
      server.sendMessage(this.VOTE_CMD + param1.uid,false);
    }

    [Obfuscation(rename="false")]
    public function updateTeamHeader(param1:String) : void {
      this.teamHeaderText = param1;
    }

    public function getChat() : BattleChat {
      return this.battleChat;
    }
  }
}
