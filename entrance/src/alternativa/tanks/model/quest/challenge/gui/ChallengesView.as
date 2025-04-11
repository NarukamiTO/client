package alternativa.tanks.model.quest.challenge.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.challenge.battlepass.notifier.BattlePassPurchaseService;
  import alternativa.tanks.model.quest.challenge.stars.StarsInfoService;
  import alternativa.tanks.model.quest.common.MissionsWindowsService;
  import controls.Label;
  import controls.TankWindowInner;
  import controls.buttons.h30px.H30ButtonSkin;
  import controls.buttons.h30px.OrangeMediumButton;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerWithIcon;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.resource.BatchResourceLoader;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.client.panel.model.challenge.rewarding.Tier;
  import projects.tanks.client.panel.model.challenge.rewarding.TierItem;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
  import projects.tanks.clients.flash.commons.models.challenge.shopitems.ChallengeShopItems;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;

  public class ChallengesView extends Sprite {
    [Inject]
    public static var challengeInfoService:ChallengeInfoService;

    [Inject]
    public static var challengeShopItems:ChallengeShopItems;

    [Inject]
    public static var starsInfoService:StarsInfoService;

    [Inject]
    public static var battlePassPurchaseService:BattlePassPurchaseService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var missionsWindowService:MissionsWindowsService;

    [Inject]
    public static var partnerService:IPartnerService;

    private static const goldenStarClass:Class = ChallengesView_goldenStarClass;
    private static const goldenStarBitmapData:BitmapData = new goldenStarClass().bitmapData;
    private static const silverStarClass:Class = ChallengesView_silverStarClass;
    private static const silverStarBitmapData:BitmapData = new silverStarClass().bitmapData;
    private static const goldenStarBgClass:Class = ChallengesView_goldenStarBgClass;
    private static const goldenStarBgBitmapData:BitmapData = new goldenStarBgClass().bitmapData;
    private static const silverStarBgClass:Class = ChallengesView_silverStarBgClass;
    private static const silverStarBgBitmapData:BitmapData = new silverStarBgClass().bitmapData;

    private static var GAP:int = 3;
    private static var TIER_LIST_WIDTH:int = 724;
    private static var TIER_LIST_HEIGHT:int = 335;
    private static var DESCRIPTION_LABEL_WIDTH:int = 520;
    private static var BUY_BUTTON_WIDTH:int = 180;

    private var tierView:TierNumberView = new TierNumberView();
    private var progressView:ChallengesProgressView = new ChallengesProgressView();
    private var tierList:TierList = new TierList();
    private var buyButton:OrangeMediumButton = new OrangeMediumButton();
    private var timer:CountDownTimer = new CountDownTimer();
    private var descriptionLabel:Label = new Label();
    private var tiersInfo:Vector.<Tier>;
    private var showBuyButton:Boolean;

    public function ChallengesView() {
      super();
      this.initTierLabel();
      this.initStarLabels();
      this.initProgressBar();
      this.initTimerLabel();
      this.initTiersList();
      this.initBuyButton();
      this.initDescriptionLabel();
      this.showBuyButton = !partnerService.isRunningInsidePartnerEnvironment() || !partnerService.hasPaymentAction();
      this.initView();
    }

    public function refreshTierListView() : void {
      this.initResourcesLoading();
    }

    private function initResourcesLoading() : void {
      var tier:Tier = null;
      var freeItem:TierItem = null;
      var battlePassItem:TierItem = null;
      var resources:Vector.<Resource> = new Vector.<Resource>();
      for each(tier in this.tiersInfo) {
        freeItem = tier.freeItem;
        if(freeItem != null) {
          this.addToLoad(freeItem.preview,resources);
        }
        battlePassItem = tier.battlePassItem;
        if(battlePassItem != null) {
          this.addToLoad(battlePassItem.preview,resources);
        }
      }
      if(resources.length > 0) {
        new BatchResourceLoader(function():void {
          refresh();
        }).load(resources);
      } else {
        this.refresh();
      }
    }

    public function setTiersInfo(param1:Vector.<Tier>) : void {
      this.tiersInfo = param1;
    }

    private function refresh() : void {
      var local1:int = int(starsInfoService.getStars());
      if(this.tiersInfo == null || this.tiersInfo.length == 0) {
        return;
      }
      var local2:int = this.getCurrentTierIndex(local1);
      var local3:int = this.tiersInfo[local2].stars;
      var local4:int = local2 == 0 ? 0 : this.tiersInfo[local2 - 1].stars;
      var local5:int = local1 >= local3 ? 100 : int((local1 - local4) * 100 / (local3 - local4));
      this.tierView.level = local2 + 1;
      this.tierList.setTiers(this.tiersInfo,local2,local5);
      this.progressView.setProgress(local5,local1,local3);
      if(this.showBuyButton) {
        this.updateBuyButton(local5 == 100);
      }
    }

    public function getUserTierIndex(param1:int) : int {
      var local2:int = 0;
      while(local2 < this.tiersInfo.length - 1) {
        if(this.tiersInfo[local2].stars >= param1) {
          return local2 + 1;
        }
        local2++;
      }
      return this.tiersInfo.length;
    }

    private function getCurrentTierIndex(param1:int) : int {
      var local2:int = 0;
      while(local2 < this.tiersInfo.length - 1) {
        if(this.tiersInfo[local2].stars > param1) {
          return local2;
        }
        local2++;
      }
      return this.tiersInfo.length - 1;
    }

    private function addToLoad(param1:ImageResource, param2:Vector.<Resource>) : void {
      if(param1.isLazy && !param1.isLoaded && param2.indexOf(param1) < 0) {
        param2.push(param1);
      }
    }

    private function initTiersList() : void {
      this.tierList.x = this.progressView.x;
      this.tierList.y = this.progressView.y + this.progressView.height + 8;
      this.tierList.width = TIER_LIST_WIDTH;
      this.tierList.height = TIER_LIST_HEIGHT;
      addChild(this.tierList);
    }

    private function initBuyButton() : void {
      this.buyButton.labelSize = H30ButtonSkin.DEFAULT_LABEL_SIZE;
      this.buyButton.labelHeight = H30ButtonSkin.DEFAULT_LABEL_HEIGHT;
      this.buyButton.labelPositionY = H30ButtonSkin.DEFAULT_LABEL_Y - 2;
      this.buyButton.width = BUY_BUTTON_WIDTH;
      this.buyButton.y = 378;
      this.buyButton.visible = false;
      this.buyButton.buttonMode = true;
      this.buyButton.useHandCursor = true;
      addChild(this.buyButton);
    }

    private function updateBuyButton(param1:Boolean) : void {
      var local2:Boolean = Boolean(battlePassPurchaseService.isPurchased());
      var local3:Boolean = Boolean(userInfoService.hasPremium(userInfoService.getCurrentUserId()));
      if(!local2) {
        this.buyButton.label = localeService.getText(TanksLocale.TEXT_CHALLENGE_BUY_BATTLE_PASS);
        this.buyButton.visible = true;
        this.descriptionLabel.text = localeService.getText(TanksLocale.TEXT_CHALLENGE_BUY_BATTLE_PASS_TIP);
        this.alignDescriptionLabel();
        return;
      }
      if(param1) {
        this.buyButton.visible = false;
        this.descriptionLabel.text = localeService.getText(TanksLocale.TEXT_CHALLENGE_FINISH);
        this.alignDescriptionLabel();
        return;
      }
      if(!local3) {
        this.buyButton.label = localeService.getText(TanksLocale.TEXT_CHALLENGE_BUY_PREMIUM);
        this.buyButton.visible = true;
        this.descriptionLabel.text = localeService.getText(TanksLocale.TEXT_CHALLENGE_BUY_PREMIUM_TIP);
        this.alignDescriptionLabel();
        return;
      }
      this.buyButton.visible = true;
      this.buyButton.label = localeService.getText(TanksLocale.TEXT_CHALLENGE_BUY_STARS);
      this.descriptionLabel.text = localeService.getText(TanksLocale.TEXT_CHALLENGE_BUY_STARS_TIP);
      this.alignDescriptionLabel();
    }

    private function alignDescriptionLabel() : void {
      this.descriptionLabel.x = this.buyButton.visible ? this.buyButton.width + GAP * 2 : this.buyButton.x;
    }

    private function initDescriptionLabel() : void {
      this.descriptionLabel.width = DESCRIPTION_LABEL_WIDTH;
      this.descriptionLabel.y = this.buyButton.y + GAP;
      this.descriptionLabel.visible = true;
      addChild(this.descriptionLabel);
    }

    public function initView() : void {
      this.buyButton.addEventListener(MouseEvent.CLICK,this.onBuyButtonClick);
    }

    private function onBuyButtonClick(param1:MouseEvent) : void {
      var local2:Boolean = Boolean(battlePassPurchaseService.isPurchased());
      var local3:Boolean = Boolean(userInfoService.hasPremium(userInfoService.getCurrentUserId()));
      if(!local2 && challengeShopItems.battlePass != null) {
        paymentDisplayService.openPaymentForShopItem(challengeShopItems.battlePass);
      } else if(!local3) {
        paymentDisplayService.openPaymentAt(ShopCategoryEnum.PREMIUM);
      } else {
        paymentDisplayService.openPaymentForShopItem(challengeShopItems.starsBundle);
      }
    }

    private function initTierLabel() : void {
      addChild(this.tierView);
    }

    private function initStarLabels() : void {
      var local1:Bitmap = new Bitmap(silverStarBgBitmapData);
      local1.y = this.tierView.height + GAP;
      var local2:Bitmap = new Bitmap(silverStarBitmapData);
      local2.y = local1.y + (local1.height - local2.height) / 2;
      local2.x = (local1.width - local2.width) / 2;
      addChild(local1);
      addChild(local2);
      var local3:Bitmap = new Bitmap(goldenStarBgBitmapData);
      local3.y = local1.y + local1.height + GAP;
      var local4:Bitmap = new Bitmap(goldenStarBitmapData);
      local4.y = local3.y + (local3.height - local4.height) / 2;
      local4.x = (local3.width - local4.width) / 2;
      addChild(local3);
      addChild(local4);
    }

    private function initProgressBar() : void {
      this.progressView.x = this.tierView.width + 7;
      this.progressView.y = 1;
      addChild(this.progressView);
    }

    private function initTimerLabel() : void {
      var local1:TankWindowInner = new TankWindowInner(131,25);
      local1.x = this.progressView.x + this.progressView.width + 8;
      var local2:CountDownTimerWithIcon = new CountDownTimerWithIcon(false);
      local2.start(this.timer);
      local2.x = 10;
      local2.y = 5;
      local1.addChild(local2);
      addChild(local1);
      this.timer.stop();
      this.timer.start(challengeInfoService.getEndTime());
    }

    public function clear() : void {
      if(this.timer != null) {
        this.timer.destroy();
        this.timer = null;
      }
      this.tierList.destroy();
      this.buyButton.removeEventListener(MouseEvent.CLICK,this.onBuyButtonClick);
    }
  }
}
