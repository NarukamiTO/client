package alternativa.tanks.models.statistics {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.models.battle.gui.chat.BattleChat;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.score.BattleStatistics;
  import alternativa.tanks.models.battle.gui.gui.statistics.fps.FPSText;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.BattleMessages;
  import alternativa.tanks.models.battlemessages.BattlefieldMessages;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.spectatorservice.SpectatorService;
  import alternativa.tanks.utils.BitMask;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;
  import platform.client.fp10.core.type.AutoClosable;

  public class SpectatorScreenLayouts implements AutoClosable {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var panelView:IPanelView;

    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var spectatorService:SpectatorService;

    [Inject]
    public static var battleInput:BattleInputService;

    [Inject]
    public static var guiService:BattleGUIService;

    private static const LAYOUT_SWITCH_KEY:uint = Keyboard.BACKSLASH;
    private static const SCORE_BAR:int = 1;
    private static const FPS:int = 1 << 1;
    private static const CHAT:int = 1 << 2;
    private static const BATTLE_MESSAGES:int = 1 << 3;
    private static const BATTLEFIELD_MESSAGES:int = 1 << 4;
    private static const FIELD_STATISTICS:int = 1 << 5;
    private static const USER_TITLES:int = 1 << 6;
    private static const GUI:int = 1 << 7;
    private static const layouts:Array = [GUI | BATTLE_MESSAGES | BATTLEFIELD_MESSAGES | FIELD_STATISTICS | USER_TITLES | CHAT | SCORE_BAR | FPS,GUI | BATTLE_MESSAGES | BATTLEFIELD_MESSAGES | FIELD_STATISTICS | USER_TITLES | CHAT,GUI | BATTLE_MESSAGES | BATTLEFIELD_MESSAGES | FIELD_STATISTICS | USER_TITLES,USER_TITLES,0];

    private var chat:BattleChat;
    private var battleMessages:BattleMessages;
    private var fieldStatistics:BattleStatistics;
    private var battlefieldMessages:BattlefieldMessages;
    private var fpsIndicator:FPSText;
    private var layoutIndex:int;

    public function SpectatorScreenLayouts(param1:BattleChat, param2:BattleMessages, param3:BattlefieldMessages, param4:BattleStatistics, param5:FPSText) {
      super();
      this.chat = param1;
      this.battleMessages = param2;
      this.battlefieldMessages = param3;
      this.fieldStatistics = param4;
      this.fpsIndicator = param5;
      this.layoutIndex = 0;
      this.applyLayout(this.layoutIndex);
      display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
    }

    private function onKeyDown(param1:KeyboardEvent) : void {
      if(!battleInput.isInputLocked() && param1.keyCode == LAYOUT_SWITCH_KEY) {
        this.toggleLayout();
      }
    }

    private function toggleLayout() : void {
      this.layoutIndex = (this.layoutIndex + 1) % layouts.length;
      this.applyLayout(this.layoutIndex);
    }

    private function applyLayout(param1:int) : void {
      var local2:BitMask = null;
      local2 = new BitMask(layouts[param1]);
      panelView.getPanel().visible = local2.hasAnyBit(SCORE_BAR);
      this.fpsIndicator.visible = local2.hasAnyBit(FPS) && Boolean(settingsService.showFPS);
      this.chat.visible = local2.hasAnyBit(CHAT);
      this.battleMessages.visible = local2.hasAnyBit(BATTLE_MESSAGES);
      this.battlefieldMessages.visible = local2.hasAnyBit(BATTLEFIELD_MESSAGES);
      this.fieldStatistics.visible = local2.hasAnyBit(FIELD_STATISTICS);
      spectatorService.setUserTitlesVisible(local2.hasAnyBit(USER_TITLES));
      guiService.getGuiContainer().visible = local2.hasAnyBit(GUI);
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      panelView.getPanel().visible = true;
      this.fpsIndicator.visible = true;
      this.chat = null;
      this.battleMessages = null;
      this.battlefieldMessages = null;
      this.fieldStatistics = null;
      this.fpsIndicator = null;
    }
  }
}
