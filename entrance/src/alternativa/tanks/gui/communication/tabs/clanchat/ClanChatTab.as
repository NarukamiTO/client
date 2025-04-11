package alternativa.tanks.gui.communication.tabs.clanchat {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.chat.ChatAddressModeUtil;
  import alternativa.tanks.gui.clanchat.*;
  import alternativa.tanks.gui.communication.tabs.AbstractCommunicationPanelTab;
  import alternativa.tanks.gui.communication.tabs.chat.ChatTab;
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
  import flash.text.GridFitType;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.ui.Keyboard;
  import forms.ColorConstants;
  import forms.events.LoginFormEvent;
  import forms.userlabel.UserLabelClickWithCtrlEvent;
  import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;
  import projects.tanks.client.chat.types.ChatMessage;
  import projects.tanks.client.chat.types.MessageType;
  import projects.tanks.client.chat.types.UserStatus;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
  import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
  import projects.tanks.clients.flash.commons.services.validate.ValidateService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser.IBlockUserService;
  import services.contextmenu.ContextMenuServiceEvent;
  import services.contextmenu.IContextMenuService;
  import utils.ScrollStyleUtils;

  public class ClanChatTab extends AbstractCommunicationPanelTab {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var contextMenuService:IContextMenuService;

    [Inject]
    public static var blockUserService:IBlockUserService;

    private static const ADDITIONAL_SCROLL_AREA_HEIGHT:Number = 7;
    private static const BLOCK_COMMAND_PATTERN:RegExp = /^\s*\/block\s+(\S+)/i;
    private static const UNBLOCK_COMMAND_PATTERN:RegExp = /^\s*\/unblock\s+(\S+)/i;
    private static const ADDRESS_PATTERN:RegExp = new RegExp("^" + ValidateService.PLAIN_UID_PATTERN + "(: |; )","i");
    private static const REPLY_PATTERN:RegExp = /^re(: |; )(.*)/i;
    private static const ADDRESS_MESSAGE_PATTERN:RegExp = /^([^:;]*)(: |; )(.*)/;
    private static const UNBLOCKALL_COMMAND_PATTERN:RegExp = /^\s*\/unblockall/i;
    private static const BLOCKLIST_COMMAND_PATTERN:RegExp = /^\s*\/blocklist/i;
    private static const SHOWIP_COMMAND_PATTERN:RegExp = /^\s*\/showip/i;
    private static const HIDEIP_COMMAND_PATTERN:RegExp = /^\s*\/hideip/i;

    private var inner:TankWindowInner = new TankWindowInner(100,100,TankWindowInner.GREEN);
    private var inputControl:TankInputBase = new TankInputBase();
    private var input:TextField;
    private var disabledChatLabel:LabelBase = new LabelBase();
    private var addressMode:ChatAddressMode = ChatAddressMode.PUBLIC_TO_ALL;
    private var selectedUid:String = "";
    private var previousSelectedUid:String;
    private var sendButton:DefaultButtonBase = new DefaultButtonBase();
    private var _selfUid:String;
    private var lastRespondent:String;
    private var systemUserStatus:UserStatus = new UserStatus(ChatModeratorLevel.NONE,"",0,"System",null);
    private var emptyUserStatus:UserStatus = new UserStatus(ChatModeratorLevel.NONE,"",0,"",null);
    private var message:String = "";
    private var currentDate:Date;

    public var output:ChatOutput;

    public function ClanChatTab() {
      super();
      this.output = new ChatOutput();
    }

    public function set selfUid(param1:String) : void {
      this._selfUid = param1;
      this.output.selfUid = this._selfUid;
    }

    override public function render() : void {
      this.init();
      this.output.scrollDown();
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
      this.sendButton.width = ChatTab.SEND_BUTTON_WIDTH;
      this.sendButton.label = localeService.getText(TanksLocale.TEXT_CHAT_PANEL_BUTTON_SEND);
      addChild(this.sendButton);
      this.input.gridFitType = GridFitType.SUBPIXEL;
      var local1:TextFormat = new TextFormat();
      local1.color = 16728642;
      var local2:TextFormat = new TextFormat();
      local2.color = 16777215;
    }

    private function onClickWithCtrlUserLabel(param1:UserLabelClickWithCtrlEvent) : void {
      this.pasteUidToInput(param1.uid,param1.shiftPressed ? ChatAddressMode.PRIVATE : ChatAddressMode.PUBLIC_ADDRESSED);
    }

    private function onClickWriteInChatContextMenu(param1:ContextMenuServiceEvent) : void {
      this.pasteUidToInput(param1.uid,param1.type == ContextMenuServiceEvent.WRITE_IN_PUBLIC ? ChatAddressMode.PUBLIC_ADDRESSED : ChatAddressMode.PRIVATE);
    }

    private function pasteUidToInput(param1:String, param2:ChatAddressMode) : void {
      this.addressMode = param2;
      this.input.text = param1 + ChatAddressModeUtil.getAddressMarker(param2) + this.message;
      stage.focus = this.input;
      this.input.setSelection(this.input.length,this.input.length);
      this.selectedUid = param1;
      this.highlightUidInChat(this.selectedUid);
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
      this.highlightUidInChat(this.selectedUid);
    }

    private function highlightUidInChat(param1:String) : void {
      if(this.previousSelectedUid != param1) {
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
      var local6:ChatMessage = null;
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
        this.output.showIPMode = true;
        local2 = "show IP";
      } else if(param1.search(HIDEIP_COMMAND_PATTERN) != -1) {
        this.output.showIPMode = false;
        local2 = "hide IP";
      }
      if(local2 != null) {
        local6 = new ChatMessage();
        local6.addressMode = ChatAddressMode.PRIVATE;
        local6.sourceUser = this.systemUserStatus;
        local6.targetUser = this.emptyUserStatus;
        local6.messageType = MessageType.SYSTEM;
        local6.text = local2;
        this.addMessage(local6,local2);
        return true;
      }
      return false;
    }

    private function send() : void {
      if(this.input.text == "") {
        return;
      }
      var local1:String = this.message;
      this.message = "";
      if(this.processLocalChatCommand(this.input.text)) {
        return;
      }
      if(ChatAddressModeUtil.isPersonal(this.addressMode)) {
        dispatchEvent(new SendChatMessageEvent(local1,this.selectedUid));
        this.input.text = this.selectedUid + ChatAddressModeUtil.getAddressMarker(this.addressMode);
      } else {
        dispatchEvent(new SendChatMessageEvent(local1));
        this.input.text = "";
      }
      this.input.setSelection(this.input.length,this.input.length);
      this.output.scrollDown();
    }

    override public function resize(param1:int, param2:int) : void {
      x = 1;
      y = 37;
      this.inner.width = param1;
      this.inner.height = param2 - 35;
      this.sendButton.y = param2 - 20;
      this.sendButton.x = param1 - ChatTab.SEND_BUTTON_WIDTH + 11;
      this.inputControl.x = 11;
      this.inputControl.y = this.sendButton.y;
      this.inputControl.width = this.sendButton.x - 16;
      this.disabledChatLabel.x = this.inputControl.x + 3;
      this.disabledChatLabel.y = this.inputControl.y + 7;
      this.output.setSize(this.inner.width + 1,this.inner.height - 8);
    }

    public function addMessage(param1:ChatMessage, param2:String, param3:Boolean = false) : void {
      var local8:Date = null;
      var local4:MessageType = param1.messageType;
      if(local4 == null) {
        local4 = MessageType.USER;
      }
      if(local4 == MessageType.WARNING) {
        param3 = true;
      }
      var local5:UserStatus = param1.sourceUser;
      if(local5 == null) {
        local5 = this.emptyUserStatus;
      }
      var local6:UserStatus = param1.targetUser;
      if(local6 == null) {
        local6 = this.emptyUserStatus;
      }
      if(blockUserService.isBlocked(local5.uid)) {
        return;
      }
      var local7:Date = new Date(new Date().getTime() - param1.timePassedInSec * 1000);
      if(this.currentDate == null) {
        this.currentDate = new Date(local7.getFullYear(),local7.getMonth(),local7.getDate());
        this.output.addLine(this.emptyUserStatus,this.emptyUserStatus,ChatAddressMode.PUBLIC_TO_ALL,this.getDateText(),this.currentDate,MessageType.SYSTEM,true,isActive);
      } else {
        local8 = new Date(this.currentDate.getFullYear(),this.currentDate.getMonth(),this.currentDate.getDate() + 1);
        if(local7.getTime() >= local8.getTime()) {
          this.currentDate.setFullYear(local7.getFullYear(),local7.getMonth(),local7.getDate());
          this.output.addLine(this.emptyUserStatus,this.emptyUserStatus,ChatAddressMode.PUBLIC_TO_ALL,this.getDateText(),this.currentDate,MessageType.SYSTEM,true,isActive);
        }
      }
      this.output.addLine(local5,local6,param1.addressMode,param2,local7,local4,param3,isActive);
      this.output.highlightUidsInLastMessage(this.selectedUid);
      if(local6.uid == this._selfUid) {
        this.lastRespondent = local5.uid;
      }
    }

    public function sendNotificationNewMessageAdded() : void {
      dispatchEvent(new ClanChatTabNewMessageEvent());
    }

    private function getDateText() : String {
      return "<p style=\'text-align: center;\'>" + DateFormatter.formatDateToLocalized(this.currentDate) + "</p>";
    }

    override public function hide() : void {
      contextMenuService.removeEventListener(ContextMenuServiceEvent.WRITE_IN_PUBLIC,this.onClickWriteInChatContextMenu);
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
    }
  }
}
