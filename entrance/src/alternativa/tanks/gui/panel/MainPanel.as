package alternativa.tanks.gui.panel {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.model.challenge.battlepass.notifier.BattlePassPurchaseService;
  import alternativa.tanks.model.quest.common.MissionsWindowsService;
  import alternativa.tanks.service.clan.ClanPanelNotificationService;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  import forms.ranks.BigRankIcon;
  import forms.ranks.RankIcon;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class MainPanel extends Sprite {
    [Inject]
    public static var reconnectService:ReconnectService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var premiumService:PremiumService;

    [Inject]
    public static var partnerService:IPartnerService;

    [Inject]
    public static var userChangeGameScreenService:UserChangeGameScreenService;

    [Inject]
    public static var clanPanelNotification:ClanPanelNotificationService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var challengeInfoService:ChallengeInfoService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var battlePassPurchaseService:BattlePassPurchaseService;

    [Inject]
    public static var missionsWindowsService:MissionsWindowsService;

    private static const PLAYER_INFO_OFFSET:int = 58;

    public var rankIcon:RankIcon = new BigRankIcon();
    public var playerInfo:PlayerInfo = new PlayerInfo();
    public var buttonBar:ButtonBar;

    private var starsCashLabel:StarsCashLabel;

    public function MainPanel() {
      super();
      this.buttonBar = new ButtonBar();
      addEventListener(Event.ADDED_TO_STAGE,this.configUI);
      premiumService.addEventListener(Event.CHANGE,this.onPremiumChanged);
      if(!partnerService.isRunningInsidePartnerEnvironment() || Boolean(partnerService.hasRatings())) {
        this.playerInfo.addEventListener(MouseEvent.CLICK,this.onUserInfoClick);
        this.rankIcon.addEventListener(MouseEvent.CLICK,this.onUserInfoClick);
        this.playerInfo.addEventListener(MouseEvent.MOUSE_OVER,this.onUserInfoMouseOver);
        this.playerInfo.addEventListener(MouseEvent.MOUSE_OUT,this.onUserInfoMouseOut);
        this.rankIcon.addEventListener(MouseEvent.MOUSE_OVER,this.onUserInfoMouseOver);
        this.rankIcon.addEventListener(MouseEvent.MOUSE_OUT,this.onUserInfoMouseOut);
      }
    }

    private function onUserInfoMouseOut(param1:MouseEvent) : void {
      Mouse.cursor = MouseCursor.AUTO;
    }

    private function onUserInfoMouseOver(param1:MouseEvent) : void {
      if(this.isMouseCursorUnderRankAndScoreElements(param1)) {
        Mouse.cursor = MouseCursor.BUTTON;
      }
    }

    private function onUserInfoClick(param1:MouseEvent) : void {
      var local2:URLRequest = null;
      if(this.isMouseCursorUnderRankAndScoreElements(param1)) {
        userChangeGameScreenService.showUserStatistics();
        local2 = new URLRequest(userPropertiesService.getUserProfileUrl(this.playerInfo.playerName));
        navigateToURL(local2,"_blank");
      }
    }

    private function isMouseCursorUnderRankAndScoreElements(param1:MouseEvent) : Boolean {
      return param1.stageX < this.playerInfo.indicators.crystalInfo.x + PLAYER_INFO_OFFSET;
    }

    private function configUI(param1:Event) : void {
      this.y = 3;
      addChild(this.rankIcon);
      addChild(this.playerInfo);
      if(challengeInfoService.isInTime()) {
        this.starsCashLabel = new StarsCashLabel();
        this.starsCashLabel.addEventListener(MouseEvent.CLICK,this.onStarsLabelClick);
        addChild(this.starsCashLabel);
      }
      addChild(this.buttonBar);
      removeEventListener(Event.ADDED_TO_STAGE,this.configUI);
      stage.addEventListener(Event.RESIZE,this.onResize);
      this.onResize();
    }

    private function onStarsLabelClick(param1:MouseEvent) : void {
      missionsWindowsService.openInTab(QuestTypeEnum.CHALLENGE);
    }

    private function onResize(param1:Event = null) : void {
      this.resize();
    }

    public function resize() : void {
      var local1:int = int(Math.max(970,display.stage.stageWidth));
      this.playerInfo.x = 15;
      var local2:int = 0;
      if(challengeInfoService.isInTime()) {
        local2 = this.starsCashLabel.width + 4;
        this.starsCashLabel.x = local1 - this.starsCashLabel.width - 4 - this.buttonBar.width - 4;
      }
      this.playerInfo.width = local1 - this.buttonBar.width + 13 - this.playerInfo.x - local2;
      this.buttonBar.x = local1 - this.buttonBar.width - 2;
      this.buttonBar.draw();
    }

    public function hide() : void {
      stage.removeEventListener(Event.RESIZE,this.onResize);
      this.playerInfo.removeEventListener(MouseEvent.CLICK,this.onUserInfoClick);
      this.rankIcon.removeEventListener(MouseEvent.CLICK,this.onUserInfoClick);
      this.playerInfo.removeEventListener(MouseEvent.MOUSE_OVER,this.onUserInfoMouseOver);
      this.playerInfo.removeEventListener(MouseEvent.MOUSE_OUT,this.onUserInfoMouseOut);
      this.rankIcon.removeEventListener(MouseEvent.MOUSE_OVER,this.onUserInfoMouseOver);
      this.rankIcon.removeEventListener(MouseEvent.MOUSE_OUT,this.onUserInfoMouseOut);
      if(this.starsCashLabel != null) {
        this.starsCashLabel.removeEventListener(MouseEvent.CLICK,this.onStarsLabelClick);
        this.starsCashLabel.destroy();
      }
    }

    public function set rank(param1:int) : void {
      this.playerInfo.rank = param1;
      this.rankIcon.init(premiumService.hasPremium(),param1);
      this.alignRankIcon();
    }

    private function onPremiumChanged(param1:Event) : void {
      this.rankIcon.init(premiumService.hasPremium(),userPropertiesService.rank);
      this.alignRankIcon();
    }

    private function alignRankIcon() : void {
      this.rankIcon.y = 29 - (this.rankIcon.height >> 1);
      this.rankIcon.x = 38 - (this.rankIcon.width >> 1);
    }

    public function destroy() : void {
      premiumService.removeEventListener(Event.CHANGE,this.onPremiumChanged);
    }
  }
}
