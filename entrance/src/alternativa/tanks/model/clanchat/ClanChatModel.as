package alternativa.tanks.model.clanchat {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanchat.SendChatMessageEvent;
  import alternativa.tanks.gui.communication.tabs.clanchat.ClanChatTab;
  import alternativa.tanks.gui.communication.tabs.clanchat.ClanChatViewEvent;
  import alternativa.tanks.gui.communication.tabs.clanchat.IClanChatView;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.utils.LinksInterceptor;
  import alternativa.types.Long;
  import flash.events.TextEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.chat.models.clanchat.clanchat.ClanChatModelBase;
  import projects.tanks.client.chat.models.clanchat.clanchat.IClanChatModelBase;
  import projects.tanks.client.chat.types.BattleChatLink;
  import projects.tanks.client.chat.types.ChatMessage;
  import projects.tanks.client.chat.types.MessageType;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;

  [ModelInfo]
  public class ClanChatModel extends ClanChatModelBase implements IClanChatModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var clanChatView:IClanChatView;

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

    private static const LOG_CHANNEL_NAME:String = "chat";

    private const HTML_PATTERN:RegExp = /(<)(.*?)(>)/gi;
    private const BATTLE_ID_REG_EXP:RegExp = /^([0-9a-f]{16})$/gi;

    private var htmlFlag:Boolean = false;
    private var sharpLinks:Array;
    private var battleId2Data:Dictionary;
    private var clanChat:ClanChatTab;

    public function ClanChatModel() {
      super();
    }

    public function objectLoadedPost() : void {
      this.battleId2Data = new Dictionary();
      this.clanChat = new ClanChatTab();
      this.clanChat.selfUid = getInitParam().selfName;
      this.clanChat.addEventListener(SendChatMessageEvent.SEND_CHAT_MESSAGE,getFunctionWrapper(this.onSendChatMessage));
      this.clanChat.addEventListener(TextEvent.LINK,getFunctionWrapper(this.onTextLink));
      if(getInitParam().inClan) {
        clanChatView.setClanChat(this.clanChat);
      } else {
        clanChatView.addEventListener(ClanChatViewEvent.UPDATE_CLAN_CHAT_VIEW,this.onClanChatViewNeedsUpdating);
      }
      trackerService.trackEvent(LOG_CHANNEL_NAME,"ChatStart","");
      this.prepareSharpLink();
    }

    private function onClanChatViewNeedsUpdating(param1:ClanChatViewEvent) : void {
      clanChatView.setClanChat(this.clanChat);
    }

    public function objectUnloaded() : void {
      clanChatView.removeEventListener(ClanChatViewEvent.UPDATE_CLAN_CHAT_VIEW,this.onClanChatViewNeedsUpdating);
      this.battleId2Data = null;
      this.clanChat.removeEventListener(SendChatMessageEvent.SEND_CHAT_MESSAGE,getFunctionWrapper(this.onSendChatMessage));
      this.clanChat.removeEventListener(TextEvent.LINK,getFunctionWrapper(this.onTextLink));
      this.clanChat.hide();
    }

    private function onSendChatMessage(param1:SendChatMessageEvent) : void {
      server.sendMessage(param1.recipientUid,param1.message);
    }

    public function showMessagesHistory(param1:Vector.<ChatMessage>) : void {
      var local2:ChatMessage = null;
      for each(local2 in param1) {
        this.showMessage(local2);
      }
    }

    public function receiveMessage(param1:ChatMessage) : void {
      this.showMessage(param1);
      this.clanChat.sendNotificationNewMessageAdded();
    }

    private function showMessage(param1:ChatMessage) : void {
      var local4:BattleChatLink = null;
      var local5:LinksInterceptor = null;
      var local6:BattleInfoData = null;
      var local2:String = param1.text;
      clientLog.log(LOG_CHANNEL_NAME,"showMessages : %1",local2);
      this.htmlFlag = false;
      var local3:int = int(local2.search(this.HTML_PATTERN));
      if(local3 > -1) {
        if(param1.messageType == MessageType.USER) {
          local2 = local2.replace(this.HTML_PATTERN,"&lt;$2&gt;");
        }
        this.htmlFlag = true;
      }
      local2 += " ";
      if(param1.messageType == MessageType.USER) {
        local5 = new LinksInterceptor(new Vector.<String>());
        local2 = local5.checkLinks(local2);
        this.htmlFlag = local5.htmlFlag;
      }
      for each(local4 in param1.battleLinks) {
        local6 = new BattleInfoData();
        local6.battleId = Long.fromHexString(local4.battleIdHex);
        this.battleId2Data[local4.battleIdHex] = local6;
        local2 = local2.replace("#battle|" + local4.battleIdHex,"<u><a href=\'event:" + local4.battleIdHex + "\'>" + BattleInfoUtils.buildBattleName(local4.battleName,local4.battleMode) + "</a></u>");
        this.htmlFlag = true;
      }
      local2 = this.replaceSharpLinks(local2);
      this.clanChat.addMessage(param1,local2,this.htmlFlag);
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
      navigateToURL(new URLRequest(param1),"_blank");
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
  }
}
