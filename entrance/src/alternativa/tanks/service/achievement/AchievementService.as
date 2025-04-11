package alternativa.tanks.service.achievement {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.gui.CongratulationsWindowPresent;
  import alternativa.tanks.help.achievements.BattleFightButtonHelper;
  import alternativa.tanks.help.achievements.BattleStartButtonHelper;
  import alternativa.tanks.help.achievements.DonateButtonHelper;
  import alternativa.tanks.help.achievements.FirstBattleCreateHelper;
  import alternativa.tanks.help.achievements.FirstBattleFightHelper;
  import alternativa.tanks.help.achievements.FirstPurchaseHelper;
  import alternativa.tanks.help.achievements.PurchaseButtonHelper;
  import alternativa.tanks.help.achievements.SetEmailHelper;
  import alternativa.tanks.service.clan.ClanPanelNotificationService;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.Event;
  import flash.geom.Point;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.achievements.model.Achievement;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.clients.flash.commons.services.layout.LobbyLayoutService;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class AchievementService implements IAchievementService {
    [Inject]
    public static var helpService:IHelpService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var partnersService:IPartnerService;

    [Inject]
    public static var clanPanelNotification:ClanPanelNotificationService;

    private static const bitmapPresent:Class = AchievementService_bitmapPresent;
    private static const present:BitmapData = (new bitmapPresent() as Bitmap).bitmapData;

    private const HELPER_GROUP_KEY:String = "GarageModel";

    private var battle:FirstBattleCreateHelper;
    private var battleButtonStart:BattleStartButtonHelper;
    private var fight:FirstBattleFightHelper;
    private var fightButton:BattleFightButtonHelper;
    private var donateButton:DonateButtonHelper;
    private var purchase:FirstPurchaseHelper;
    private var purchaseButton:PurchaseButtonHelper;
    private var email:SetEmailHelper;
    private var currentAchievements:Vector.<Achievement>;
    private var panelPartition:int = 0;
    private var inBattle:Boolean;
    private var createFormVisible:Boolean = false;

    public function AchievementService() {
      super();
      this.init();
    }

    private static function isLoadedServiceObject() : Boolean {
      return LobbyLayoutService(lobbyLayoutService).getServiceGameObject() != null;
    }

    private function init() : void {
      this.battle = new FirstBattleCreateHelper();
      this.battleButtonStart = new BattleStartButtonHelper();
      this.fight = new FirstBattleFightHelper();
      this.fightButton = new BattleFightButtonHelper();
      this.donateButton = new DonateButtonHelper();
      this.purchase = new FirstPurchaseHelper();
      this.purchaseButton = new PurchaseButtonHelper();
      this.email = new SetEmailHelper();
      var local1:IHelpService = IHelpService(OSGi.getInstance().getService(IHelpService));
      local1.registerHelper(this.HELPER_GROUP_KEY,800,this.battle,false);
      local1.registerHelper(this.HELPER_GROUP_KEY,802,this.fight,false);
      local1.registerHelper(this.HELPER_GROUP_KEY,803,this.fightButton,false);
      local1.registerHelper(this.HELPER_GROUP_KEY,805,this.donateButton,false);
      local1.registerHelper(this.HELPER_GROUP_KEY,806,this.purchase,false);
      local1.registerHelper(this.HELPER_GROUP_KEY,807,this.purchaseButton,false);
      local1.registerHelper(this.HELPER_GROUP_KEY,809,this.email,false);
      local1.registerHelper(this.HELPER_GROUP_KEY,811,this.battleButtonStart,false);
      this.currentAchievements = new Vector.<Achievement>();
    }

    public function setAchievements(param1:Vector.<Achievement>) : void {
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.endSwitch);
      if(lobbyLayoutService.getCurrentState() == LayoutState.BATTLE) {
        this.hideAllBubbles(true);
      }
      this.currentAchievements = new Vector.<Achievement>();
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        if(!(param1[local3] == Achievement.FIRST_REFERRAL && Boolean(partnersService.isRunningInsidePartnerEnvironment()))) {
          this.currentAchievements.push(param1[local3]);
        }
        local3++;
      }
      if(this.currentAchievements.length != 0) {
        this.showCurrentAchievementBubbles();
        this.alignHelpers();
        display.stage.addEventListener(Event.RESIZE,this.alignHelpers);
      }
    }

    private function endSwitch(param1:LobbyLayoutServiceEvent) : void {
      if(param1.state != LayoutState.BATTLE) {
        this.inBattle = false;
        this.showCurrentAchievementBubbles();
      }
    }

    public function setGarageBuyButtonTargetPoint(param1:Point) : void {
      this.purchaseButton.targetPoint = param1;
      this.showCurrentAchievementBubbles();
      this.alignHelpers();
    }

    public function setBattleStartButtonTargetPoint(param1:Point) : void {
      this.fightButton.targetPoint = param1;
      this.showCurrentAchievementBubbles();
      this.alignHelpers();
    }

    public function setPaymentResumeButtonTargetPoint(param1:Point) : void {
      this.donateButton.targetPoint = param1;
      this.showCurrentAchievementBubbles();
      this.alignHelpers();
    }

    public function hideAllBubbles(param1:Boolean) : void {
      var local2:int = 800;
      while(local2 < 812) {
        helpService.hideHelper(this.HELPER_GROUP_KEY,local2);
        local2++;
      }
      helpService.hideHelp();
      this.inBattle = param1;
    }

    public function showStartButtonHelper() : void {
      this.createFormVisible = true;
      this.showCurrentAchievementBubbles();
    }

    public function hideStartButtonHelper() : void {
      this.createFormVisible = false;
      this.showCurrentAchievementBubbles();
    }

    public function completeAchievement(param1:Achievement, param2:String, param3:int) : void {
      this.removeAchievement(param1);
      this.hideAllBubbles(this.inBattle);
      var local4:CongratulationsWindowPresent = new CongratulationsWindowPresent(present,null,param2);
    }

    private function removeAchievement(param1:Achievement) : void {
      if(this.currentAchievements.indexOf(param1) != -1) {
        this.currentAchievements.splice(this.currentAchievements.indexOf(param1),1);
      }
    }

    public function removeGarageButtonAchievement() : void {
      this.removeAchievement(Achievement.FIRST_PURCHASE);
      helpService.manuallyShutDownHelper(this.purchaseButton);
    }

    public function activateAchievement(param1:Achievement) : void {
      if(!(param1 == Achievement.FIRST_REFERRAL && Boolean(partnersService.isRunningInsidePartnerEnvironment()))) {
        this.currentAchievements.push(param1);
      }
      this.showCurrentAchievementBubbles();
      this.alignHelpers();
    }

    private function showCurrentAchievementBubbles() : void {
      var local3:Achievement = null;
      if(this.inBattle || !isLoadedServiceObject() || Boolean(lobbyLayoutService.inBattle())) {
        return;
      }
      var local1:int = 800;
      while(local1 < 812) {
        helpService.hideHelper(this.HELPER_GROUP_KEY,local1);
        local1++;
      }
      var local2:int = 0;
      while(local2 < this.currentAchievements.length) {
        local3 = this.currentAchievements[local2];
        switch(local3) {
          case Achievement.FIRST_PURCHASE:
            if(this.panelPartition == 1 && this.purchaseButton.targetPoint.x != 0) {
              helpService.showHelper(this.HELPER_GROUP_KEY,807,true);
            } else if(this.panelPartition != 1) {
              helpService.showHelperIfAble(this.HELPER_GROUP_KEY,806,true);
            }
            break;
          case Achievement.FIGHT_FIRST_BATTLE:
            if(this.panelPartition == 0) {
              helpService.showHelperIfAble(this.HELPER_GROUP_KEY,803,true);
            } else {
              helpService.showHelperIfAble(this.HELPER_GROUP_KEY,802,true);
            }
            break;
          case Achievement.FIRST_REFERRAL:
            helpService.showHelper(this.HELPER_GROUP_KEY,808,true);
            break;
        }
        local2++;
      }
    }

    private function alignHelpers(param1:Event = null) : void {
      var local2:int = int(Math.max(970,display.stage.stageWidth));
      var local3:int = int(Math.max(580,display.stage.stageHeight));
      var local4:int = this.getClanButtonWidth();
      if(partnersService.isRunningInsidePartnerEnvironment()) {
        local4 -= 28;
      }
      this.battle.targetPoint = new Point(local2 - 295 - local4,30);
      this.battleButtonStart.targetPoint = new Point(local2 - 35,local3 - 30);
      this.fight.targetPoint = new Point(local2 - 292 - local4,30);
      this.purchase.targetPoint = new Point(local2 - 180 - local4,30);
      this.email.targetPoint = new Point(local2 - 110,30);
    }

    private function getClanButtonWidth() : int {
      return !!clanPanelNotification.clanButtonVisible ? 90 : 0;
    }
  }
}
