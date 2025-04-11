package alternativa.tanks.view.battleinfo {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.view.battlelist.forms.ProBattlePassAlert;
  import base.DiscreteSprite;
  import controls.BigButton;
  import flash.display.DisplayObjectContainer;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import forms.TankWindowWithHeader;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.IUserProBattleService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.ProBattleEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class AbstractBattleInfoView extends DiscreteSprite {
    [Inject]
    public static var achievementService:IAchievementService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var userProBattleService:IUserProBattleService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    private static const MIN_FLASH_WIDTH:int = 970;
    private static const MIN_FLASH_HEIGHT:int = 530;
    private static const HEADER_HEIGHT:int = 60;

    private var _timeOutResize:uint;
    private var _buyAbonementButton:BigButton;

    protected var initParams:BattleInfoBaseParams;
    protected var _window:TankWindowWithHeader;
    protected var proBattlePassAlert:ProBattlePassAlert;

    public var battleInfoParamsView:BattleInfoParamsView;

    public function AbstractBattleInfoView() {
      super();
      this._window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_BATTLE_INFO);
      addChild(this._window);
      this.battleInfoParamsView = new BattleInfoParamsView();
      addChild(this.battleInfoParamsView);
      this.createUserList();
      this._buyAbonementButton = new BigButton();
      this._buyAbonementButton.label = LocaleBattleInfo.buyAbonementButtonLabel;
      this._buyAbonementButton.visible = false;
      addChild(this._buyAbonementButton);
      this.proBattlePassAlert = new ProBattlePassAlert(LocaleBattleInfo.proBattleAlertLabel);
      addChild(this.proBattlePassAlert);
      this.addControlsToPanel();
      this.resize();
    }

    protected function createUserList() : void {
    }

    protected function addControlsToPanel() : void {
    }

    protected function setEvents() : void {
      display.stage.addEventListener(Event.RESIZE,this.onResize);
      userProBattleService.addEventListener(ProBattleEvent.OVER,this.onAbonementOver);
      this.battleInfoParamsView.addEventListener(BattleInfoViewEvent.ENTER_SPECTATOR,this.onEnterSpectator);
      this._buyAbonementButton.addEventListener(MouseEvent.CLICK,this.onBuyAbonementClick);
    }

    protected function removeEvents() : void {
      display.stage.removeEventListener(Event.RESIZE,this.onResize);
      userProBattleService.removeEventListener(ProBattleEvent.OVER,this.onAbonementOver);
      this.battleInfoParamsView.removeEventListener(BattleInfoViewEvent.ENTER_SPECTATOR,this.onEnterSpectator);
      this._buyAbonementButton.removeEventListener(MouseEvent.CLICK,this.onBuyAbonementClick);
    }

    private function onAbonementOver(param1:ProBattleEvent) : void {
      this.showProBattlePassAlert();
      this.resize();
    }

    public function update(param1:BattleInfoBaseParams) : void {
      this.initParams = param1;
    }

    public function show() : void {
      if(!this.container.contains(this)) {
        battleInfoService.setCurrentSelectionBattle(this.initParams.battle.id,this.initParams.createParams.rankRange.min,this.initParams.createParams.rankRange.max);
        this.setEvents();
        this.container.addChild(this);
        this.resize();
      }
    }

    public function hide() : void {
      if(this.container.contains(this)) {
        battleInfoService.resetCurrentSelectionBattleId();
        this.removeEvents();
        this.container.removeChild(this);
        achievementService.setBattleStartButtonTargetPoint(new Point());
      }
    }

    public function destroy() : void {
      this.removeEvents();
      clearTimeout(this._timeOutResize);
      this._window = null;
      this.battleInfoParamsView.destroy();
      this.battleInfoParamsView = null;
      this.proBattlePassAlert = null;
      this.initParams = null;
    }

    public function lock() : void {
      mouseEnabled = false;
      mouseChildren = false;
    }

    public function unlock() : void {
      mouseEnabled = true;
      mouseChildren = true;
    }

    protected function resize(param1:Boolean = true) : void {
      var local2:Number = int(Math.max(MIN_FLASH_WIDTH,display.stage.stageWidth)) / 3;
      var local3:Number = Math.max(display.stage.stageHeight - HEADER_HEIGHT,MIN_FLASH_HEIGHT);
      this._window.width = local2;
      this._window.height = local3;
      this.x = local2 * 2;
      this.y = HEADER_HEIGHT;
      this.battleInfoParamsView.width = local2 - 22;
      this.battleInfoParamsView.height = int(local3 * 0.4);
      this.battleInfoParamsView.x = this.battleInfoParamsView.y = 11;
      this.resizeUserList(local2,local3);
      this.proBattlePassAlert.width = local2 - 30;
      this.proBattlePassAlert.x = 15;
      this.proBattlePassAlert.y = local3 - 85 - 55;
      this._buyAbonementButton.width = Math.min(130,int((local2 - 110) / 2));
      this._buyAbonementButton.x = local2 - this._buyAbonementButton.width - 11;
      this._buyAbonementButton.y = local3 - 61;
      this.resizeControlsPanel(local2,local3);
      this.updateAchievementPosition();
      if(param1) {
        this.resizeWithDelay();
      } else {
        this.invalidateDataProviders();
      }
    }

    protected function invalidateDataProviders() : void {
    }

    protected function resizeControlsPanel(param1:Number, param2:Number) : void {
    }

    protected function resizeUserList(param1:Number, param2:Number) : void {
    }

    public function resizeWithDelay(param1:int = 200) : void {
      clearTimeout(this._timeOutResize);
      this._timeOutResize = setTimeout(this.onResizeWithDelay,param1);
    }

    private function onResizeWithDelay() : void {
      this.resize(false);
    }

    protected function updateAchievementPosition() : void {
    }

    public function showProBattlePassAlert() : void {
      this.proBattlePassAlert.visible = true;
      this._buyAbonementButton.visible = true;
    }

    public function hideNoSupplies() : void {
      this.proBattlePassAlert.visible = false;
      this._buyAbonementButton.visible = false;
    }

    public function updateScore(param1:BattleTeam, param2:int) : void {
    }

    private function onResize(param1:Event) : void {
      this.resize();
    }

    private function onEnterSpectator(param1:BattleInfoViewEvent) : void {
      dispatchEvent(param1.clone());
    }

    private function onBuyAbonementClick(param1:MouseEvent) : void {
      modalLoaderService.show();
      dispatchEvent(new BattleInfoViewEvent(BattleInfoViewEvent.BUY_PRO_ABONEMENT));
    }

    public function updateInBattleState() : void {
      this.proBattlePassAlert.visible = false;
      this._buyAbonementButton.visible = false;
      if(this.initParams.createParams.proBattle && !userProBattleService.hasAbonement() && !clanUserInfoService.giveBonusesClan) {
        this.showProBattlePassAlert();
      } else {
        this.hideNoSupplies();
      }
      this.battleInfoParamsView.updateSpectatorButton();
      this.resize(true);
      this.updateAchievementPosition();
    }

    private function get container() : DisplayObjectContainer {
      return display.systemLayer;
    }

    public function invalidateUserList() : void {
      this.resizeWithDelay(500);
    }

    public function updateBattleName() : void {
      this.battleInfoParamsView.updateNameAndFormat();
    }
  }
}
