package alternativa.tanks.model.chat {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.startup.StartupSettings;
  import alternativa.tanks.gui.chat.CautionExternalLinkWindow;
  import alternativa.tanks.gui.chat.CautionExternalLinkWindowEvent;
  import alternativa.tanks.gui.chat.ChangeChatChannelEvent;
  import alternativa.tanks.gui.chat.SendChatMessageEvent;
  import alternativa.tanks.gui.communication.tabs.chat.ChatTab;
  import alternativa.tanks.gui.communication.tabs.chat.IChatTabView;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.utils.Antiflood;
  import alternativa.tanks.utils.LinksInterceptor;
  import alternativa.types.Long;
  import flash.events.TextEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;
  import projects.tanks.client.chat.models.chat.chat.ChatModelBase;
  import projects.tanks.client.chat.models.chat.chat.IChatModelBase;
  import projects.tanks.client.chat.types.BattleChatLink;
  import projects.tanks.client.chat.types.ChatMessage;
  import projects.tanks.client.chat.types.MessageType;
  import projects.tanks.client.chat.types.UserStatus;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;

  [ModelInfo]
  public class ChatModel extends ChatModelBase implements IChatModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var trackerService:ITrackerService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userPropertyService:IUserPropertiesService;

    [Inject]
    public static var battleLinkActivatorService:IBattleLinkActivatorService;

    [Inject]
    public static var clientLog:IClientLog;

    [Inject]
    public static var lobbyChatView:IChatTabView;

    private static const LOG_CHANNEL_NAME:String = "chat";

    private const HTML_PATTERN:RegExp = /(<)(.*?)(>)/gi;
    private const BATTLE_ID_REG_EXP:RegExp = /^([0-9a-f]{16})$/gi;

    private var chatTab:ChatTab;
    private var selfUid:String;
    private var showLinks:Boolean;
    private var linksInterceptor:LinksInterceptor;
    private var htmlFlag:Boolean = false;
    private var sharpLinks:Array;
    private var isAdmin:Boolean;
    private var antiFloodEnabled:Boolean;
    private var chatEnabled:Boolean;
    private var privateMessagesEnabled:Boolean;
    private var battleId2Data:Dictionary;
    private var chatModeratorLevel:ChatModeratorLevel;
    private var isCautionExternalLinkWindowOpened:Boolean = false;
    private var cautionExternalLinkWindow:CautionExternalLinkWindow;

    public function ChatModel() {
      super();
    }

    public function objectLoaded() : void {
      this.battleId2Data = new Dictionary();
      this.selfUid = getInitParam().selfName;
      this.showLinks = getInitParam().showLinks;
      this.isAdmin = getInitParam().admin;
      this.antiFloodEnabled = getInitParam().antifloodEnabled;
      this.chatEnabled = getInitParam().chatEnabled;
      this.chatModeratorLevel = getInitParam().chatModeratorLevel;
      this.privateMessagesEnabled = getInitParam().privateMessagesEnabled;
      this.linksInterceptor = new LinksInterceptor(getInitParam().linksWhiteList);
      this.chatTab = new ChatTab(this.privateMessagesEnabled);
      this.chatTab.selfUid = this.selfUid;
      this.chatTab.typingAntifloodEnabled = getInitParam().typingSpeedAntifloodEnabled;
      this.chatTab.setChannels(getInitParam().channels);
      if(this.chatEnabled) {
        lobbyChatView.setChatTab(this.chatTab);
        this.onShowChatTab();
        this.chatTab.restoreCurrentChannel();
      }
      if(this.antiFloodEnabled) {
        Antiflood.init(getInitParam().linksWhiteList,getInitParam().minChar,getInitParam().minWord,getInitParam().bufferSize);
      }
      putData(ChatSettingsTracker,new ChatSettingsTracker(this.chatTab));
      trackerService.trackEvent(LOG_CHANNEL_NAME,"ChatStart","");
      this.prepareSharpLink();
    }

    public function objectUnloaded() : void {
      this.battleId2Data = null;
      this.chatTab.hide();
      if(this.chatEnabled) {
        this.onHideChatTab();
      }
    }

    private function onSendChatMessage(param1:SendChatMessageEvent) : void {
      var local2:UserStatus = null;
      if(this.isAdmin || this.isPrivateMessage(param1) || !this.antiFloodEnabled || Antiflood.isNotFlood(param1.message)) {
        server.sendMessage(param1.recipientUid,param1.addressMode,this.chatTab.getCurrentChannel(),param1.message);
        if(this.antiFloodEnabled) {
          Antiflood.getMessageKeys(param1.message,true);
        }
      } else {
        local2 = new UserStatus(this.chatModeratorLevel,"",userPropertyService.rank,this.selfUid,userPropertyService.userId);
        this.chatTab.addMessageToCurrentChannel(local2,null,param1.message);
        clientLog.log(LOG_CHANNEL_NAME,"onSendChatMessage : antiFlood : %1",param1.message);
      }
    }

    private function onChangeChannel(param1:ChangeChatChannelEvent) : void {
      server.changeChannel(param1.channel);
    }

    private function isPrivateMessage(param1:SendChatMessageEvent) : Boolean {
      return param1.recipientUid != "" && param1.addressMode == ChatAddressMode.PRIVATE;
    }

    public function showMessages(param1:Vector.<ChatMessage>) : void {
      var local2:ChatMessage = null;
      var local3:String = null;
      var local4:int = 0;
      var local5:BattleChatLink = null;
      var local6:BattleInfoData = null;
      for each(local2 in param1) {
        local3 = local2.text;
        if(this.antiFloodEnabled) {
          Antiflood.getMessageKeys(local3,true);
        }
        clientLog.log(LOG_CHANNEL_NAME,"showMessages : %1",local3);
        this.htmlFlag = false;
        local4 = int(local3.search(this.HTML_PATTERN));
        if(local4 > -1) {
          if(local2.messageType == MessageType.USER) {
            local3 = local3.replace(this.HTML_PATTERN,"&lt;$2&gt;");
          }
          this.htmlFlag = true;
        }
        local3 += " ";
        if(this.showLinks && local2.messageType == MessageType.USER) {
          local3 = this.linksInterceptor.checkLinks(local3);
          this.htmlFlag = this.linksInterceptor.htmlFlag;
        }
        for each(local5 in local2.battleLinks) {
          local6 = new BattleInfoData();
          local6.battleId = Long.fromHexString(local5.battleIdHex);
          this.battleId2Data[local5.battleIdHex] = local6;
          local3 = local3.replace("#battle|" + local5.battleIdHex,"<u><a href=\'event:" + local5.battleIdHex + "\'>" + BattleInfoUtils.buildBattleName(local5.battleName,local5.battleMode) + "</a></u>");
          this.htmlFlag = true;
        }
        local3 = this.replaceSharpLinks(local3);
        if(local2.channel == null) {
          this.chatTab.addMessageToCurrentChannel(local2.sourceUser,local2.targetUser,local3,local2.addressMode,local2.messageType,this.htmlFlag);
        } else {
          this.chatTab.addMessage(local2.sourceUser,local2.targetUser,local2.channel,local3,local2.addressMode,local2.messageType,this.htmlFlag);
        }
      }
    }

    private function onShowChatTab() : void {
      this.chatTab.addEventListener(SendChatMessageEvent.SEND_CHAT_MESSAGE,getFunctionWrapper(this.onSendChatMessage));
      this.chatTab.addEventListener(ChangeChatChannelEvent.CHANGE_CHANNEL,getFunctionWrapper(this.onChangeChannel));
      this.chatTab.addEventListener(TextEvent.LINK,getFunctionWrapper(this.onTextLink));
    }

    private function onHideChatTab() : void {
      this.chatTab.removeEventListener(SendChatMessageEvent.SEND_CHAT_MESSAGE,getFunctionWrapper(this.onSendChatMessage));
      this.chatTab.removeEventListener(ChangeChatChannelEvent.CHANGE_CHANNEL,getFunctionWrapper(this.onChangeChannel));
      this.chatTab.removeEventListener(TextEvent.LINK,getFunctionWrapper(this.onTextLink));
    }

    private function onTextLink(param1:TextEvent) : void {
      var local3:String = null;
      var local2:String = param1.text;
      if(local2.search(this.BATTLE_ID_REG_EXP) > -1) {
        local3 = local2.substr(local2.length - 16);
        if(this.battleId2Data[local3] != null) {
          battleLinkActivatorService.activateBattle(this.battleId2Data[local3]);
        }
      } else {
        this.proceedExternalLink(local2);
      }
    }

    private function proceedExternalLink(param1:String) : void {
      if(this.linksInterceptor.isInWhiteList(param1)) {
        if(StartupSettings.isDesktop) {
          navigateToURL(new URLRequest(this.encodeIfNeeded(param1)),"_blank");
        } else {
          navigateToURL(new URLRequest(param1),"_blank");
        }
      } else if(!this.isCautionExternalLinkWindowOpened) {
        this.showCautionWindow(param1);
      }
    }

    private function encodeIfNeeded(param1:String) : String {
      return param1.indexOf("%") > 0 ? param1 : encodeURI(param1);
    }

    private function showCautionWindow(param1:String) : void {
      this.cautionExternalLinkWindow = new CautionExternalLinkWindow(param1);
      this.cautionExternalLinkWindow.addEventListener(CautionExternalLinkWindowEvent.CLOSING,this.onCautionWindowClose);
      this.cautionExternalLinkWindow.show();
      this.isCautionExternalLinkWindowOpened = true;
    }

    private function onCautionWindowClose(param1:CautionExternalLinkWindowEvent) : void {
      this.isCautionExternalLinkWindowOpened = false;
      this.cautionExternalLinkWindow.removeEventListener(CautionExternalLinkWindowEvent.CLOSING,this.onCautionWindowClose);
    }

    public function cleanUsersMessages(param1:String) : void {
      this.chatTab.cleanOutUsersMessages(param1);
    }

    private function prepareSharpLink() : void {
      this.sharpLinks = [localeService.getText(TanksLocale.TEXT_CHAT_SHARP_HELP).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_RULES).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_PLANS).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_RANKS).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_CLANS).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_FORUM).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_UPDATES).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_THEFT).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_FEEDBACK).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_NICK).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_NEWS).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_COMMANDS).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_WIKI).split("|")];
      var local1:int = 0;
      while(local1 < this.sharpLinks.length) {
        this.sharpLinks[local1][0] = new RegExp("#" + this.sharpLinks[local1][0],"gi");
        local1++;
      }
    }

    private function replaceSharpLinks(param1:String) : String {
      var local5:RegExp = null;
      var local2:int = 0;
      var local3:String = param1;
      var local4:int = 0;
      while(local4 < this.sharpLinks.length) {
        local5 = this.sharpLinks[local4][0];
        local2 = int(local3.search(local5));
        if(local2 > -1) {
          local3 = local3.replace(local5,"<u><a href=\'" + this.sharpLinks[local4][2] + "\' target=\'_blank\'>" + this.sharpLinks[local4][1] + "</a></u>");
          this.htmlFlag = true;
        }
        local4++;
      }
      return local3;
    }

    public function updateTypingSpeedAntifloodParams(param1:int, param2:int) : void {
      this.chatTab.updateTypingAntifloodParams(param1,param2);
    }
  }
}
