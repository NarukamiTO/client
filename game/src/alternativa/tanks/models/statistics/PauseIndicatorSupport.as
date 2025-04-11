package alternativa.tanks.models.statistics {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.PauseDeactivationEvent;
  import alternativa.tanks.battle.events.ShowPauseIndicatorEvent;
  import alternativa.tanks.models.battle.gui.indicators.PauseIndicator;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import flash.events.Event;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class PauseIndicatorSupport implements AutoClosable, BattleEventListener, LogicUnit {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var battleGUIService:BattleGUIService;

    private var pauseIndicator:PauseIndicator;
    private var isShow:Boolean;
    private var idleTimeoutEndTime:int;

    public function PauseIndicatorSupport() {
      super();
      this.init();
    }

    private function init() : void {
      battleEventDispatcher.addBattleEventListener(PauseDeactivationEvent,this);
      battleEventDispatcher.addBattleEventListener(ShowPauseIndicatorEvent,this);
      this.pauseIndicator = new PauseIndicator(localeService.getText(TanksLocale.TEXT_REARM_PAUSE_1),localeService.getText(TanksLocale.TEXT_REARM_PAUSE_2),localeService.getText(TanksLocale.TEXT_REARM_PAUSE_3));
    }

    public function handleBattleEvent(param1:Object) : void {
      if(param1 is PauseDeactivationEvent) {
        this.onPauseDeactivated();
      } else if(param1 is ShowPauseIndicatorEvent) {
        this.onShowPauseIndicator(ShowPauseIndicatorEvent(param1));
      }
    }

    private function onShowPauseIndicator(param1:ShowPauseIndicatorEvent) : void {
      if(this.isShow) {
        return;
      }
      this.isShow = true;
      this.showPauseIndicator();
      this.idleTimeoutEndTime = getTimer() + param1.idleTimeLeft;
      battleService.getBattleRunner().addLogicUnit(this);
    }

    private function showPauseIndicator() : void {
      if(this.pauseIndicator.parent == null) {
        battleGUIService.getViewportContainer().addChild(this.pauseIndicator);
        display.stage.addEventListener(Event.RESIZE,this.onStageResize);
        this.setPosition();
      }
    }

    private function onStageResize(param1:Event) : void {
      this.setPosition();
    }

    private function setPosition() : void {
      this.pauseIndicator.x = display.stage.stageWidth - this.pauseIndicator.width >> 1;
      this.pauseIndicator.y = display.stage.stageHeight - this.pauseIndicator.height >> 1;
    }

    private function onPauseDeactivated() : void {
      if(!this.isShow) {
        return;
      }
      this.isShow = false;
      this.hidePauseIndicator();
      battleService.getBattleRunner().removeLogicUnit(this);
    }

    private function hidePauseIndicator() : void {
      if(this.pauseIndicator.parent != null) {
        this.pauseIndicator.parent.removeChild(this.pauseIndicator);
        display.stage.removeEventListener(Event.RESIZE,this.onStageResize);
      }
    }

    public function runLogic(param1:int, param2:int) : void {
      this.pauseIndicator.seconds = Math.max((this.idleTimeoutEndTime - param1) / 1000,0);
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.hidePauseIndicator();
      battleEventDispatcher.removeBattleEventListener(ShowPauseIndicatorEvent,this);
      battleEventDispatcher.removeBattleEventListener(PauseDeactivationEvent,this);
    }
  }
}
