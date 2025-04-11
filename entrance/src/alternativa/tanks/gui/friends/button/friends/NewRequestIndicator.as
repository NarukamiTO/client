package alternativa.tanks.gui.friends.button.friends {
  import alternativa.tanks.service.referrals.notification.NewReferralsNotifierService;
  import alternativa.tanks.service.referrals.notification.NewReferralsNotifierServiceEvent;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.NewFriendEvent;

  public class NewRequestIndicator extends Sprite {
    [Inject]
    public static var friendInfoService:IFriendInfoService;

    [Inject]
    public static var newReferralsNotifierService:NewReferralsNotifierService;
    public static var attentionIconClass:Class = NewRequestIndicator_attentionIconClass;

    private static var attentionIconBitmapData:BitmapData = Bitmap(new attentionIconClass()).bitmapData;

    public function NewRequestIndicator() {
      super();
      this.init();
    }

    private function init() : void {
      addChild(new Bitmap(attentionIconBitmapData));
      this.updateVisible();
      friendInfoService.addEventListener(NewFriendEvent.ACCEPTED_CHANGE,this.onUpdateAcceptedCounter);
      friendInfoService.addEventListener(NewFriendEvent.INCOMING_CHANGE,this.onUpdateIncomingCounter);
      newReferralsNotifierService.addEventListener(NewReferralsNotifierServiceEvent.REFERRAL_ADDED,this.referralsAdded);
      newReferralsNotifierService.addEventListener(NewReferralsNotifierServiceEvent.NEW_REFERRALS_COUNT_UPDATED,this.newReferralsCountUpdated);
    }

    private function newReferralsCountUpdated(param1:NewReferralsNotifierServiceEvent) : void {
      this.updateVisible();
    }

    private function referralsAdded(param1:NewReferralsNotifierServiceEvent) : void {
      this.updateVisible();
    }

    private function onUpdateIncomingCounter(param1:NewFriendEvent) : void {
      this.updateVisible();
    }

    private function onUpdateAcceptedCounter(param1:NewFriendEvent) : void {
      this.updateVisible();
    }

    private function updateVisible() : void {
      visible = friendInfoService.newAcceptedFriendsLength + friendInfoService.newIncomingFriendsLength + newReferralsNotifierService.getNewReferralsCount() > 0;
    }
  }
}
