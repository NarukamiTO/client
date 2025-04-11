package alternativa.tanks.gui.friends.list.refferals {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.friends.FriendsWindow;
  import alternativa.tanks.gui.friends.IFriendsListState;
  import alternativa.tanks.service.referrals.ReferralsService;
  import alternativa.tanks.service.referrals.ReferralsServiceEvent;
  import alternativa.tanks.service.referrals.buttonhelper.ReferralsButtonHelperService;
  import alternativa.tanks.service.referrals.notification.NewReferralsNotifierService;
  import assets.Diamond;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;
  import forms.stat.ReferralWindowBigButton;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.panel.model.referrals.ReferralIncomeData;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ReferralForm extends Sprite implements IFriendsListState {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var referralService:ReferralsService;

    [Inject]
    public static var partnerService:IPartnerService;

    [Inject]
    public static var newReferralsNotifierService:NewReferralsNotifierService;

    [Inject]
    public static var referralsButtonHelperService:ReferralsButtonHelperService;

    private static const MARGIN:int = 9;
    private static const TEXT_CONTROL_HEIGHT:int = 26;

    private var countLabel:LabelBase = new LabelBase();
    private var crystalLabel:LabelBase = new LabelBase();
    private var inviteReferralButton:ReferralWindowBigButton;
    private var referralStatList:ReferralStatList = new ReferralStatList();

    public function ReferralForm() {
      super();
      this.addCountLabel();
      this.addCrystalLabel();
      this.addReferralStatList();
      this.inviteReferralButton = referralsButtonHelperService.getReferralInviteButton();
      addChild(this.inviteReferralButton);
    }

    private function addCountLabel() : void {
      var local1:LabelBase = null;
      local1 = new LabelBase();
      local1.text = localeService.getText(TanksLocale.TEXT_REFERAL_WINDOW_COUNT_LABEL);
      addChild(local1);
      var local2:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      local2.width = 80;
      local2.height = TEXT_CONTROL_HEIGHT;
      local2.x = local1.x + local1.width + FriendsWindow.WINDOW_MARGIN;
      addChild(local2);
      local1.y = local2.height - local1.height >> 1;
      this.countLabel.x = local2.x + local2.width - MARGIN - this.countLabel.width;
      this.countLabel.y = local1.y;
      this.countLabel.autoSize = TextFieldAutoSize.RIGHT;
      this.countLabel.color = ColorConstants.GREEN_TEXT;
      this.countLabel.text = "0";
      addChild(this.countLabel);
    }

    private function addCrystalLabel() : void {
      var local1:LabelBase = new LabelBase();
      local1.text = localeService.getText(TanksLocale.TEXT_REFERAL_WINDOW_SUMMARY_LABEL);
      addChild(local1);
      var local2:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      local2.width = 100;
      local2.height = TEXT_CONTROL_HEIGHT;
      local2.x = FriendsWindow.WINDOW_WIDTH - FriendsWindow.WINDOW_MARGIN * 2 - local2.width;
      addChild(local2);
      local1.x = local2.x - MARGIN - local1.width;
      local1.y = local2.height - local1.height >> 1;
      var local3:Diamond = new Diamond();
      local3.x = local2.x + local2.width - MARGIN - local3.width;
      local3.y = local2.height - local3.height >> 1;
      addChild(local3);
      this.crystalLabel.autoSize = TextFieldAutoSize.RIGHT;
      this.crystalLabel.color = ColorConstants.GREEN_TEXT;
      this.crystalLabel.x = local3.x - 2 - this.crystalLabel.width;
      this.crystalLabel.y = local1.y;
      this.crystalLabel.text = "0";
      addChild(this.crystalLabel);
    }

    private function addReferralStatList() : void {
      this.referralStatList.y = this.countLabel.y + TEXT_CONTROL_HEIGHT + 4;
      addChild(this.referralStatList);
    }

    private function referralsDataIsUpdated(param1:ReferralsServiceEvent) : void {
      var local2:Vector.<ReferralIncomeData> = referralService.getReferrals();
      this.countLabel.text = local2.length.toString();
      this.crystalLabel.text = this.calculateCrystalsSum(local2).toString();
      this.referralStatList.addReferrals(local2);
    }

    private function calculateCrystalsSum(param1:Vector.<ReferralIncomeData>) : int {
      var local3:ReferralIncomeData = null;
      var local2:int = 0;
      for each(local3 in param1) {
        local2 += local3.income;
      }
      return local2;
    }

    public function initList() : void {
      referralService.addEventListener(ReferralsServiceEvent.DATA_UPDATED,this.referralsDataIsUpdated);
      referralService.requestUpdatingReferralsData();
      newReferralsNotifierService.resetNewReferralsCount();
    }

    public function hide() : void {
      if(parent.contains(this)) {
        parent.removeChild(this);
        this.referralStatList.hide();
      }
      referralService.removeEventListener(ReferralsServiceEvent.DATA_UPDATED,this.referralsDataIsUpdated);
    }

    public function resize(param1:Number, param2:Number) : void {
      var local3:int = int(param2) - this.inviteReferralButton.height;
      var local4:int = int(param1);
      this.referralStatList.resize(local4,local3);
      this.inviteReferralButton.y = param2 - 10;
      this.inviteReferralButton.x = local4 - this.inviteReferralButton.width >> 1;
    }

    public function filter(param1:String, param2:String) : void {
    }

    public function resetFilter() : void {
    }
  }
}
