package alternativa.tanks.models.battle.gui.chat {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.model.chat.ShowChat;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import alternativa.tanks.models.battle.gui.chat.cmdhandlers.BlockCommandHandler;
  import alternativa.tanks.models.battle.gui.chat.cmdhandlers.IChatCommandHandler;
  import alternativa.tanks.models.battle.gui.chat.cmdhandlers.UnblockCommandHandler;
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.tanks.models.statistics.IClientUserInfo;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.tanks.services.battleinput.BattleInputLockType;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.types.Long;
  import controls.chat.BattleChatInput;
  import controls.chat.ChatInputType;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.KeyboardEvent;
  import flash.text.TextField;
  import flash.ui.Keyboard;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser.IBlockUserService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;

  [Event(name="sendMessage",type="alternativa.tanks.models.battle.gui.chat.BattleChatEvent")]
  public class BattleChat extends Sprite implements ShowChat {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleInputLockService:BattleInputService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var blockUserService:IBlockUserService;

    [Inject]
    public static var battleGuiService:BattleGUIService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var userInfoService:BattleUserInfoService;

    [Inject]
    public static var fullscreenService:FullscreenService;

    private const CMD_BLOCK:String = "/block";
    private const CMD_UNBLOCK:String = "/unblock";
    private const FULL_SCREEN:String = "fullScreen";
    private const FULL_SCREEN_INTERACTIVE_ACCEPTED:String = "fullScreenInteractiveAccepted";

    private var commandHandlers:Object;
    private var spectatorList:SpectatorList;
    private var _alwaysShow:Boolean;
    private var inputControl:BattleChatInput;
    private var input:TextField;
    private var output:BattleChatOutput;
    private var _chatOpened:Boolean;
    private var _locked:Boolean;
    private var _teamOnly:Boolean;
    private var _team:BattleTeam;
    private var _object:IGameObject;

    public function BattleChat() {
      super();
      this.init();
    }

    public function set alwaysShow(param1:Boolean) : void {
      if(this._alwaysShow != param1) {
        this._alwaysShow = param1;
        if(!this._chatOpened) {
          this.output.visible = this._alwaysShow;
        }
      }
    }

    public function set locked(param1:Boolean) : void {
      this._locked = param1;
    }

    public function get chatOpened() : Boolean {
      return this._chatOpened;
    }

    public function addUserMessage(param1:Long, param2:BattleTeam, param3:String, param4:Boolean, param5:Boolean) : void {
      var local6:String = null;
      if(!param5) {
        local6 = userInfoService.getUserName(param1);
        if(blockUserService.isBlocked(local6)) {
          return;
        }
      }
      this.output.addLine(param1,param2,param3,param4,param5);
      this.onResize();
    }

    public function addSystemMessage(param1:String) : void {
      this.output.addSystemMessage(param1);
      this.onResize();
    }

    public function clear() : void {
      this.output.clear();
    }

    public function openChat() : void {
      var local1:ShortUserInfo = null;
      if(!(this._chatOpened || this._locked)) {
        this.output.visible = true;
        this.spectatorList.visible = this.spectatorList.getText().length > 0;
        if(!battleInfoService.isSpectatorMode()) {
          local1 = IClientUserInfo(this._object.adapt(IClientUserInfo)).getShortUserInfo(userPropertiesService.userId);
          this._team = local1.teamType;
        }
        this.addEventListeners();
        this._chatOpened = true;
        this.input.text = "";
        this.inputControl.visible = true;
        display.stage.focus = this.input;
        this.onResize();
        battleInputLockService.lock(BattleInputLockType.CHAT);
        battleEventDispatcher.dispatchEvent(new ChatEvent(ChatEvent.OPEN));
        this.setInputTeam();
      }
    }

    public function setBattleObject(param1:IGameObject) : void {
      this._object = param1;
      this._teamOnly = true;
    }

    private function setInputTeam() : void {
      if(battleInfoService.isSpectatorMode()) {
        if(this._teamOnly) {
          this.inputControl.setInputType(ChatInputType.YELLOW);
          this.inputControl.setChannelText(localeService.getText(TanksLocale.TEXT_CHAT_LABEL_SPECTATORS));
        } else {
          this.inputControl.setInputType(ChatInputType.STANDART);
          this.inputControl.setChannelText(localeService.getText(TanksLocale.TEXT_CHAT_LABEL_ALL));
        }
        return;
      }
      if(this._teamOnly && this._team != BattleTeam.NONE) {
        if(this._team == BattleTeam.BLUE) {
          this.inputControl.setInputType(ChatInputType.BLUE);
        } else {
          this.inputControl.setInputType(ChatInputType.RED);
        }
        this.inputControl.setChannelText(localeService.getText(TanksLocale.TEXT_CHAT_LABEL_TEAM));
      } else {
        this.inputControl.setInputType(ChatInputType.STANDART);
        this.inputControl.setChannelText(localeService.getText(TanksLocale.TEXT_CHAT_LABEL_ALL));
      }
    }

    private function changeChannel() : void {
      this._teamOnly = !this._teamOnly;
      this.setInputTeam();
    }

    public function closeChat() : void {
      if(this._chatOpened) {
        this.output.visible = this._alwaysShow;
        this.spectatorList.visible = false;
        this.spectatorList.setText("");
        if(this.inputControl.visible) {
          this.removeEventListeners();
          this._chatOpened = false;
          this.inputControl.visible = false;
          this.clearChatInputFocus();
          this.output.minimize();
          this.onResize();
        }
        battleInputLockService.unlock(BattleInputLockType.CHAT);
        battleEventDispatcher.dispatchEvent(new ChatEvent(ChatEvent.CLOSE));
      }
    }

    private function init() : void {
      this.inputControl = new BattleChatInput();
      this.inputControl.tabEnabled = false;
      this.inputControl.tabChildren = false;
      this.inputControl.x = 10;
      addChild(this.inputControl);
      this.input = this.inputControl.textField;
      this.input.maxChars = 299;
      this.input.addEventListener(KeyboardEvent.KEY_UP,this.onInputKeyUp);
      this.input.addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
      this.output = new BattleChatOutput();
      this.output.visible = this._alwaysShow;
      this.output.tabEnabled = false;
      this.output.tabChildren = false;
      this.output.x = 10;
      addChild(this.output);
      this.spectatorList = new SpectatorList();
      this.spectatorList.x = 10;
      this.spectatorList.visible = false;
      addChild(this.spectatorList);
      this.initCommandHandlers();
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
    }

    private function initCommandHandlers() : void {
      this.commandHandlers = {};
      this.commandHandlers[this.CMD_BLOCK] = new BlockCommandHandler(this.output);
      this.commandHandlers[this.CMD_UNBLOCK] = new UnblockCommandHandler(this.output);
    }

    public function setSpectatorList(param1:String) : void {
      this.spectatorList.setText(param1);
    }

    [Obfuscation(rename="false")]
    public function setShowChat(param1:Boolean) : void {
      this.alwaysShow = param1;
    }

    private function addEventListeners() : void {
      this.input.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
      if(fullscreenService.isAvailable()) {
        display.stage.addEventListener(this.FULL_SCREEN,this.onFullscreen);
        display.stage.addEventListener(this.FULL_SCREEN_INTERACTIVE_ACCEPTED,this.onFullscreen);
      }
    }

    private function removeEventListeners() : void {
      this.input.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
      if(fullscreenService.isAvailable()) {
        display.stage.removeEventListener(this.FULL_SCREEN,this.onFullscreen);
        display.stage.removeEventListener(this.FULL_SCREEN_INTERACTIVE_ACCEPTED,this.onFullscreen);
      }
    }

    private function onAddedToStage(param1:Event) : void {
      this.inputControl.visible = false;
      stage.addEventListener(Event.RESIZE,this.onResize);
      this.onResize(null);
    }

    private function onRemovedFromStage(param1:Event) : void {
      stage.removeEventListener(Event.RESIZE,this.onResize);
    }

    private function onResize(param1:Event = null) : void {
      var local2:Number = NaN;
      if(this._chatOpened) {
        this.output.maximize();
      }
      var local3:int = int(0.25 * display.stage.stageWidth);
      var local4:int = int(battleGuiService.getPositionXInventory());
      if(local4 != 0 && this.inputControl.x + local3 + 10 > local4) {
        local3 = local4 - this.inputControl.x - 10;
      }
      this.inputControl.width = local3;
      this.inputControl.y = display.stage.stageHeight - this.inputControl.height - 130;
      local2 = this.inputControl.y - this.output.height - 10;
      if(local2 < 50) {
        while(local2 < 50) {
          local2 += this.output.height;
          this.output.removeFirstMessage();
          local2 -= this.output.height;
        }
      }
      this.output.y = local2;
      this.spectatorList.setLabelWidth(0.25 * display.stage.stageWidth);
      this.spectatorList.y = local2 - 120;
      if(this._chatOpened) {
        this.setInputTeam();
      }
    }

    private function onInputKeyUp(param1:KeyboardEvent) : void {
      if(this.inputControl.visible) {
        if(param1.keyCode == Keyboard.ENTER) {
          if(this.input.text != "") {
            if(!this.handleCommand(this.input.text) && hasEventListener(BattleChatEvent.SEND_MESSAGE)) {
              dispatchEvent(new BattleChatEvent(BattleChatEvent.SEND_MESSAGE,this.input.text,this._teamOnly));
            }
            this.input.text = "";
          }
          param1.keyCode = 0;
          this.closeChat();
        }
        if(AlertUtils.isCancelKey(param1.keyCode)) {
          param1.keyCode = 0;
          this.closeChat();
        }
        if(param1.keyCode == Keyboard.TAB) {
          this.changeChannel();
        }
      }
    }

    private function handleCommand(param1:String) : Boolean {
      if(param1.charAt(0) != "/") {
        return false;
      }
      var local2:Array = param1.split(/\s+/);
      if(local2.length == 0) {
        return false;
      }
      var local3:String = local2.shift();
      var local4:IChatCommandHandler = this.commandHandlers[local3];
      if(local4 == null) {
        return false;
      }
      local4.handleCommand(local2);
      return true;
    }

    private function onFocusIn(param1:FocusEvent) : void {
      if(!this._chatOpened) {
        this.clearChatInputFocus();
      }
    }

    private function onFocusOut(param1:FocusEvent) : void {
      if(stage && this.input && this.inputControl && Boolean(this.inputControl.visible)) {
        stage.focus = this.input;
      } else {
        this.closeChat();
      }
    }

    private function onFullscreen(param1:Event) : void {
      if(this._chatOpened) {
        stage.focus = this.input;
      }
    }

    private function clearChatInputFocus() : void {
      if(display.stage.focus == this.input) {
        display.stage.focus = null;
      }
    }
  }
}
