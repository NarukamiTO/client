package alternativa.tanks.gui.communication.tabs.chat {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.chat.*;
  import alternativa.tanks.gui.chat.dropdown.ChatDropDownList;
  import alternativa.tanks.gui.communication.tabs.*;
  import alternativa.tanks.model.chat.ShowChat;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import fl.controls.LabelButton;
  import fl.controls.ScrollBar;
  import fl.events.ScrollEvent;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.text.GridFitType;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.ui.Keyboard;
  import flash.utils.Timer;
  import forms.ColorConstants;
  import forms.events.LoginFormEvent;
  import forms.userlabel.UserLabelClickWithCtrlEvent;
  import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;
  import projects.tanks.client.chat.types.MessageType;
  import projects.tanks.client.chat.types.UserStatus;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
  import projects.tanks.clients.flash.commons.services.validate.ValidateService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser.IBlockUserService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import services.contextmenu.ContextMenuServiceEvent;
  import services.contextmenu.IContextMenuService;
  import utils.ScrollStyleUtils;

  public class ChatTab extends AbstractCommunicationPanelTab implements ShowChat {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var contextMenuService:IContextMenuService;

    [Inject]
    public static var blockUserService:IBlockUserService;

    [Inject]
    public static var storageService:IStorageService;

    private static const ADDITIONAL_SCROLL_AREA_HEIGHT:Number = 7;
    private static const UNAVAILABLE_TIMER_PERIOD:int = 1000;
    private static const LAST_MESSAGE_SHARED_KEY:String = "lobbyChatLastMessageKey";
    private static const LAST_CHAT_CHANNEL_KEY:String = "lastChatChannelKey";
    private static const BLOCK_COMMAND_PATTERN:RegExp = /^\s*\/block\s+(\S+)/i;
    private static const UNBLOCK_COMMAND_PATTERN:RegExp = /^\s*\/unblock\s+(\S+)/i;
    private static const ADDRESS_PATTERN:RegExp = new RegExp("^" + ValidateService.PLAIN_UID_PATTERN + "(: |; )","i");
    private static const REPLY_PATTERN:RegExp = /^re(: |; )(.*)/i;
    private static const ADDRESS_MESSAGE_PATTERN:RegExp = /^([^:;]*)(: |; )(.*)/;
    private static const UNBLOCKALL_COMMAND_PATTERN:RegExp = /^\s*\/unblockall/i;
    private static const BLOCKLIST_COMMAND_PATTERN:RegExp = /^\s*\/blocklist/i;
    private static const SHOWIP_COMMAND_PATTERN:RegExp = /^\s*\/showip/i;
    private static const HIDEIP_COMMAND_PATTERN:RegExp = /^\s*\/hideip/i;

    public static const SEND_BUTTON_WIDTH:int = 80;

    private var inner:TankWindowInner = new TankWindowInner(100,100,TankWindowInner.GREEN);
    private var inputControl:TankInputBase = new TankInputBase();
    private var input:TextField;
    private var disabledChatLabel:LabelBase = new LabelBase();
    private var addressMode:ChatAddressMode = ChatAddressMode.PUBLIC_TO_ALL;
    private var isChatEnabled:Boolean;
    private var isChatAvailable:Boolean = true;
    private var selectedUid:String = "";
    private var previousSelectedUid:String;
    private var delayTimer:Timer;
    private var sendButton:DefaultButtonBase = new DefaultButtonBase();
    private var _selfUid:String;
    private var lastRespondent:String;
    private var systemUserStatus:UserStatus = new UserStatus(ChatModeratorLevel.NONE,"",0,"System",null);
    private var emptyUserStatus:UserStatus = new UserStatus(ChatModeratorLevel.NONE,"",0,"",null);
    private var _lastMessageTime:Number = 0;
    private var symbolCost:int;
    private var messageCost:int;
    private var coloredTextFormat:TextFormat;
    private var standardTextFormat:TextFormat;
    private var _typingAntifloodEnabled:Boolean;
    private var privateMessagesEnabled:Boolean;
    private var message:String = "";
    private var channels:Vector.<String>;
    private var currentChannel:String;

    public var output:ChatOutput;

    public function ChatTab(param1:Boolean) {
      super();
      this.privateMessagesEnabled = param1;
      this.output = new ChatOutput(param1);
    }

    public function set selfUid(param1:String) : void {
      this._selfUid = param1;
      this.output.selfUid = this._selfUid;
    }

    public function init() : void {
      this.input = this.inputControl.textField;
      this.input.maxChars = 299;
      addChild(this.inner);
      this.inner.x = this.inner.y = 11;
      this.inner.showBlink = true;
      this.input.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyPressed);
      this.input.addEventListener(MouseEvent.CLICK,this.onInputClick);
      this.sendButton.addEventListener(MouseEvent.CLICK,this.sendMessage);
      addChild(this.inputControl);
      addChild(this.disabledChatLabel);
      this.disabledChatLabel.mouseEnabled = false;
      this.disabledChatLabel.color = ColorConstants.LIST_LABEL_HINT;
      this.disabledChatLabel.text = localeService.getText(TanksLocale.TEXT_DISABLED_CHAT_LABEL_TEXT);
      addChild(this.output);
      this.output.move(15,15);
      ScrollStyleUtils.setGreenStyle(this.output);
      this.output.addEventListener(UserLabelClickWithCtrlEvent.USER_LABEL_CLICK_WITH_CTRL_EVENT,this.onClickWithCtrlUserLabel);
      this.output.addEventListener(ScrollEvent.SCROLL,this.onScroll);
      this.output.verticalScrollBar.addEventListener(Event.ENTER_FRAME,this.updateScrollOnEnterFrame);
      this.inputControl.addEventListener(LoginFormEvent.TEXT_CHANGED,this.processMessageTyping);
      contextMenuService.addEventListener(ContextMenuServiceEvent.WRITE_IN_PUBLIC,this.onClickWriteInChatContextMenu);
      contextMenuService.addEventListener(ContextMenuServiceEvent.WRITE_IN_PRIVATE,this.onClickWriteInChatContextMenu);
      this.sendButton.width = SEND_BUTTON_WIDTH;
      this.sendButton.label = localeService.getText(TanksLocale.TEXT_CHAT_PANEL_BUTTON_SEND);
      addChild(this.sendButton);
      var local1:Timer = new Timer(UNAVAILABLE_TIMER_PERIOD);
      local1.addEventListener(TimerEvent.TIMER,this.onAntifloodTimer);
      local1.start();
      this.input.gridFitType = GridFitType.SUBPIXEL;
      this.coloredTextFormat = new TextFormat();
      this.coloredTextFormat.color = 16728642;
      this.standardTextFormat = new TextFormat();
      this.standardTextFormat.color = 16777215;
      if(Boolean(storageService.getStorage().data[LAST_MESSAGE_SHARED_KEY])) {
        this._lastMessageTime = storageService.getStorage().data[LAST_MESSAGE_SHARED_KEY];
      } else {
        this._lastMessageTime = 0;
      }
    }

    override public function render() : void {
      this.init();
      this.output.scrollDown();
    }

    private function onClickWithCtrlUserLabel(param1:UserLabelClickWithCtrlEvent) : void {
      this.pasteUidToInput(param1.uid,param1.shiftPressed ? ChatAddressMode.PRIVATE : ChatAddressMode.PUBLIC_ADDRESSED);
    }

    private function onClickWriteInChatContextMenu(param1:ContextMenuServiceEvent) : void {
      this.pasteUidToInput(param1.uid,param1.type == ContextMenuServiceEvent.WRITE_IN_PUBLIC ? ChatAddressMode.PUBLIC_ADDRESSED : ChatAddressMode.PRIVATE);
    }

    private function onAntifloodTimer(param1:TimerEvent) : void {
      this.updateTypingAntiflood();
    }

    private function updateScrollOnEnterFrame(param1:Event) : void {
      var local4:Sprite = null;
      var local5:Sprite = null;
      var local2:ScrollBar = this.output.verticalScrollBar;
      var local3:int = 0;
      while(local3 < local2.numChildren) {
        local4 = Sprite(local2.getChildAt(local3));
        if(local4.hitArea != null) {
          local5 = local4.hitArea;
          local5.graphics.clear();
        } else {
          local5 = new Sprite();
          local5.mouseEnabled = false;
          local4.hitArea = local5;
          this.output.addChild(local5);
        }
        local5.graphics.beginFill(0,0);
        if(local4 is LabelButton) {
          local5.graphics.drawRect(local2.x - ADDITIONAL_SCROLL_AREA_HEIGHT,local4.y - 14,local4.width + ADDITIONAL_SCROLL_AREA_HEIGHT,local4.height + 28);
        } else {
          local5.graphics.drawRect(local2.x - ADDITIONAL_SCROLL_AREA_HEIGHT,local4.y,local4.width + ADDITIONAL_SCROLL_AREA_HEIGHT,local4.height);
        }
        local5.graphics.endFill();
        local3++;
      }
    }

    private function onInputClick(param1:MouseEvent) : void {
      if(stage.focus == null) {
        stage.focus = this.input;
      }
    }

    private function onScroll(param1:ScrollEvent) : void {
      this.output.deltaWidth = 18;
      this.output.setSize(this.inner.width + 1,this.inner.height - 8);
      this.output.removeEventListener(ScrollEvent.SCROLL,this.onScroll);
      this.output.wasScrolled = true;
    }

    private function processMessageTyping(param1:Event) : void {
      var local2:String = null;
      var local3:Array = null;
      if(this.input.text.search(REPLY_PATTERN) != -1) {
        if(this.lastRespondent == null) {
          this.input.text = "";
          return;
        }
        local3 = this.input.text.match(REPLY_PATTERN);
        this.addressMode = ChatAddressModeUtil.parseAddressMode(local3[1]);
        this.message = local3[2];
        this.input.text = this.lastRespondent + local3[1] + this.message;
        this.selectedUid = this.lastRespondent;
        this.input.setSelection(this.input.length,this.input.length);
      } else if(this.input.text.search(ADDRESS_PATTERN) != -1) {
        local3 = this.input.text.match(ADDRESS_MESSAGE_PATTERN);
        this.selectedUid = local3[1];
        local2 = local3[2];
        this.message = local3[3];
        this.addressMode = ChatAddressModeUtil.parseAddressMode(local2);
      } else {
        this.addressMode = ChatAddressMode.PUBLIC_TO_ALL;
        this.selectedUid = "";
        this.message = this.input.text;
      }
      this.highlightUidInChat(this.selectedUid,false);
      this.updateTypingAntiflood();
    }

    private function pasteUidToInput(param1:String, param2:ChatAddressMode) : void {
      this.addressMode = param2;
      this.input.text = param1 + ChatAddressModeUtil.getAddressMarker(param2) + this.message;
      stage.focus = this.input;
      this.input.setSelection(this.input.length,this.input.length);
      this.selectedUid = param1;
      this.highlightUidInChat(this.selectedUid,false);
      this.updateTypingAntiflood();
    }

    private function highlightUidInChat(param1:String, param2:Boolean) : void {
      if(param2 || this.previousSelectedUid != param1) {
        this.previousSelectedUid = param1;
        this.output.highlightUids(param1);
      }
    }

    private function onKeyPressed(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.ENTER) {
        this.send();
      }
    }

    private function sendMessage(param1:MouseEvent) : void {
      this.send();
    }

    private function processLocalChatCommand(param1:String) : Boolean {
      var local3:String = null;
      var local4:Array = null;
      var local5:int = 0;
      var local2:String = null;
      if(param1.search(BLOCK_COMMAND_PATTERN) != -1) {
        local3 = param1.replace(BLOCK_COMMAND_PATTERN,"$1");
        blockUserService.blockUser(local3);
        local2 = localeService.getText(TanksLocale.TEXT_CHAT_PANEL_COMMAND_BLOCK,local3);
        this.input.text = "/block ";
      } else if(param1.search(UNBLOCK_COMMAND_PATTERN) != -1) {
        local3 = param1.replace(UNBLOCK_COMMAND_PATTERN,"$1");
        blockUserService.unblockUser(local3);
        local2 = localeService.getText(TanksLocale.TEXT_CHAT_PANEL_COMMAND_UNBLOCK,local3);
        this.input.text = "/unblock ";
      } else if(param1.search(UNBLOCKALL_COMMAND_PATTERN) != -1) {
        blockUserService.unblockAll();
        local2 = localeService.getText(TanksLocale.TEXT_CHAT_PANEL_COMMAND_UNBLOCK_ALL);
        this.input.text = "";
      } else if(param1.search(BLOCKLIST_COMMAND_PATTERN) != -1) {
        local4 = blockUserService.getBlockList();
        if(local4.length > 0) {
          local2 = "\n" + localeService.getText(TanksLocale.TEXT_CHAT_PANEL_COMMAND_BLOCK_LIST) + "\n—————————————\n";
          local5 = 0;
          while(local5 < local4.length) {
            local2 += String(local5 + 1) + ": " + local4[local5] + "\n";
            local5++;
          }
        } else {
          local2 = "...";
        }
        this.input.text = "";
      } else if(param1.search(SHOWIP_COMMAND_PATTERN) != -1) {
        this.output.setShowIPMode(true);
        local2 = "show IP";
      } else if(param1.search(HIDEIP_COMMAND_PATTERN) != -1) {
        this.output.setShowIPMode(false);
        local2 = "hide IP";
      }
      if(local2 != null) {
        this.addMessageToCurrentChannel(this.systemUserStatus,this.emptyUserStatus,local2,null,MessageType.SYSTEM);
        return true;
      }
      return false;
    }

    private function send() : void {
      if(!this.isChatAvailable) {
        return;
      }
      if(this.input.text == "") {
        return;
      }
      var local1:String = this.message;
      this.message = "";
      if(this.processLocalChatCommand(this.input.text)) {
        return;
      }
      if(ChatAddressModeUtil.isPersonal(this.addressMode)) {
        dispatchEvent(new SendChatMessageEvent(local1,this.addressMode,this.selectedUid));
        this.input.text = this.selectedUid + ChatAddressModeUtil.getAddressMarker(this.addressMode);
      } else {
        dispatchEvent(new SendChatMessageEvent(local1,ChatAddressMode.PUBLIC_TO_ALL));
        this.input.text = "";
      }
      this.lastMessageTime = new Date().getTime();
      this.input.setSelection(this.input.length,this.input.length);
      this.output.scrollDown();
    }

    override public function resize(param1:int, param2:int) : void {
      x = 1;
      y = 37;
      this.inner.width = param1;
      this.inner.height = param2 - 35;
      this.sendButton.y = param2 - 20;
      this.sendButton.x = param1 - SEND_BUTTON_WIDTH + 11;
      this.inputControl.x = 11;
      this.inputControl.y = this.sendButton.y;
      this.inputControl.width = this.sendButton.x - 16;
      this.disabledChatLabel.x = this.inputControl.x + 3;
      this.disabledChatLabel.y = this.inputControl.y + 7;
      this.output.setSize(this.inner.width + 1,this.inner.height - 8);
      if(this.delayTimer == null) {
        this.delayTimer = new Timer(200,1);
        this.delayTimer.addEventListener(TimerEvent.TIMER,this.correctResize);
      }
      this.delayTimer.reset();
      this.delayTimer.start();
    }

    private function correctResize(param1:TimerEvent = null) : void {
      this.output.setSize(this.inner.width + 1,this.inner.height - 8);
      this.delayTimer.removeEventListener(TimerEvent.TIMER,this.correctResize);
      this.delayTimer = null;
    }

    public function addMessageToCurrentChannel(param1:UserStatus, param2:UserStatus, param3:String, param4:ChatAddressMode = null, param5:MessageType = null, param6:Boolean = false) : void {
      this.addMessage(param1,param2,this.currentChannel,param3,param4,param5,param6);
    }

    public function addMessage(param1:UserStatus, param2:UserStatus, param3:String, param4:String, param5:ChatAddressMode = null, param6:MessageType = null, param7:Boolean = false) : void {
      if(param6 == null) {
        param6 = MessageType.USER;
      }
      if(param6 == MessageType.WARNING) {
        param7 = true;
      }
      if(param1 == null) {
        param1 = this.emptyUserStatus;
      }
      if(param2 == null) {
        param2 = this.emptyUserStatus;
      }
      if(blockUserService.isBlocked(param1.uid)) {
        return;
      }
      this.output.addMessage(param1,param2,param5,param3,param4,param6,param7,isActive);
      if(param3 == this.currentChannel) {
        this.output.highlightUidsInLastMessage(this.selectedUid);
        if(param2.uid == this._selfUid) {
          this.lastRespondent = param1.uid;
        }
      }
    }

    override public function hide() : void {
      if(this.delayTimer != null) {
        this.delayTimer.stop();
        this.delayTimer.removeEventListener(TimerEvent.TIMER,this.correctResize);
      }
      if(this.input != null) {
        this.input.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyPressed);
        this.input.removeEventListener(MouseEvent.CLICK,this.onInputClick);
      }
      if(this.sendButton != null) {
        this.sendButton.removeEventListener(MouseEvent.CLICK,this.sendMessage);
      }
      if(this.output != null) {
        this.output.verticalScrollBar.removeEventListener(Event.ENTER_FRAME,this.updateScrollOnEnterFrame);
        this.output.removeEventListener(ScrollEvent.SCROLL,this.onScroll);
        this.output.removeEventListener(UserLabelClickWithCtrlEvent.USER_LABEL_CLICK_WITH_CTRL_EVENT,this.onClickWithCtrlUserLabel);
      }
      if(this.inputControl != null) {
        this.inputControl.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.processMessageTyping);
      }
      contextMenuService.removeEventListener(ContextMenuServiceEvent.WRITE_IN_PUBLIC,this.onClickWriteInChatContextMenu);
      contextMenuService.removeEventListener(ContextMenuServiceEvent.WRITE_IN_PRIVATE,this.onClickWriteInChatContextMenu);
    }

    public function cleanOutUsersMessages(param1:String) : void {
      this.output.cleanOutUsersMessages(param1);
    }

    public function setShowChat(param1:Boolean) : void {
      this.output.visible = param1;
      if(!param1) {
        this.inputControl.value = "";
      }
      this.isChatEnabled = param1;
      this.updateSendButtonLabel();
      this.updateDisabledChatLabel();
      dispatchEvent(new ChatTabEvent(param1 ? ChatTabEvent.SHOW_CHAT : ChatTabEvent.HIDE_CHAT));
    }

    private function updateSendButtonLabel() : void {
      if(this.isChatEnabled && !this.isChatAvailable) {
        this.sendButton.enable = false;
      } else {
        this.sendButton.label = localeService.getText(TanksLocale.TEXT_CHAT_PANEL_BUTTON_SEND);
        this.sendButton.enable = this.isChatEnabled;
      }
    }

    private function updateDisabledChatLabel() : void {
      if(this.isChatEnabled && !this.isChatAvailable) {
        this.disabledChatLabel.text = localeService.getText(TanksLocale.TEXT_TYPING_SPEED_BANNED);
        this.disabledChatLabel.visible = true;
        this.inputControl.enable = false;
      } else {
        this.inputControl.enable = this.isChatEnabled;
        this.disabledChatLabel.visible = !this.isChatEnabled;
      }
    }

    private function updateTypingAntiflood() : void {
      var local7:Number = NaN;
      var local8:int = 0;
      if(!this._typingAntifloodEnabled || !this.input) {
        return;
      }
      var local1:String = this.input.text;
      var local2:int = ChatAddressModeUtil.isPersonal(this.addressMode) ? this.selectedUid.length + 2 : 0;
      var local3:int = ChatAddressModeUtil.isPersonal(this.addressMode) ? local1.length - local2 : local1.length;
      var local4:int = local3 * this.symbolCost + this.messageCost;
      var local5:Number = Number(new Date().getTime());
      var local6:Number = this._lastMessageTime + local4;
      if(!this.isCommand(local1) && local5 < local6) {
        local7 = local6 - local5;
        this.sendButton.label = this.getUnbanTime(local7);
        this.sendButton.enable = false;
        local8 = local7 / this.symbolCost;
        if(local8 >= local3) {
          if(local2 < local1.length) {
            this.input.setTextFormat(this.coloredTextFormat,local2,local1.length);
          }
        } else if(local8 != 0) {
          this.input.setTextFormat(this.standardTextFormat);
          this.input.setTextFormat(this.coloredTextFormat,Math.min(local1.length + local2 - local8,local1.length - 1),local1.length);
        }
        this.isChatAvailable = false;
      } else {
        this.input.setTextFormat(this.standardTextFormat);
        this.isChatAvailable = true;
      }
      this.updateSendButtonLabel();
    }

    private function getUnbanTime(param1:Number) : String {
      var local2:Number = int(param1 / 1000);
      var local3:Number = int(local2 / 60);
      var local4:Number = local2 % 60;
      var local5:String = local4.toString();
      if(local5.length < 2) {
        local5 = "0" + local5;
      }
      return local3.toString() + ":" + local5;
    }

    private function isCommand(param1:String) : Boolean {
      return param1.search(/^\s*\//i) != -1;
    }

    public function set lastMessageTime(param1:Number) : void {
      this._lastMessageTime = param1;
      storageService.getStorage().data[LAST_MESSAGE_SHARED_KEY] = param1;
      this.updateTypingAntiflood();
    }

    public function updateTypingAntifloodParams(param1:int, param2:int) : void {
      this.symbolCost = param1;
      this.messageCost = param2;
      this.updateTypingAntiflood();
    }

    public function set typingAntifloodEnabled(param1:Boolean) : void {
      this._typingAntifloodEnabled = param1;
    }

    public function getCurrentChannel() : String {
      return this.currentChannel;
    }

    public function setCurrentChannel(param1:String) : void {
      this.currentChannel = param1;
      this.output.switchToChannel(isActive,this.currentChannel);
      this.highlightUidInChat(this.selectedUid,true);
      this.output.highlightUidsInLastMessage(this.selectedUid);
    }

    public function getChannels() : Vector.<String> {
      return this.channels;
    }

    public function setChannels(param1:Vector.<String>) : void {
      this.channels = param1;
    }

    public function onChangeChannel(param1:Event) : void {
      this.setCurrentChannel((param1.target as ChatDropDownList).selectedItem.gameName);
      storageService.getStorage().data[LAST_CHAT_CHANNEL_KEY] = this.currentChannel;
    }

    public function restoreCurrentChannel() : void {
      var local1:String = storageService.getStorage().data[LAST_CHAT_CHANNEL_KEY];
      var local2:int = 0;
      while(local2 < this.channels.length) {
        if(local1 == this.channels[local2]) {
          this.setCurrentChannel(local1);
          dispatchEvent(new ChangeChatChannelEvent(this.currentChannel));
          return;
        }
        local2++;
      }
      this.setCurrentChannel(this.channels[0]);
      storageService.getStorage().data[LAST_CHAT_CHANNEL_KEY] = this.currentChannel;
      dispatchEvent(new ChangeChatChannelEvent(this.currentChannel));
    }
  }
}
