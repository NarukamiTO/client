package alternativa.tanks.service.referrals.buttonhelper {
  import alternativa.tanks.gui.friends.list.refferals.referalbuttons.LinkReferralButton;
  import alternativa.tanks.gui.friends.list.refferals.referalbuttons.OkReferralButton;
  import alternativa.tanks.gui.friends.list.refferals.referalbuttons.VkReferralButton;
  import forms.stat.ReferralWindowBigButton;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.commons.socialnetwork.SocialNetworkEnum;

  public class ReferralsButtonHelperServiceImpl implements ReferralsButtonHelperService {
    [Inject]
    public static var partnerService:IPartnerService;

    public function ReferralsButtonHelperServiceImpl() {
      super();
    }

    public function getReferralInviteButton() : ReferralWindowBigButton {
      if(partnerService.isRunningInsidePartnerEnvironment()) {
        switch(partnerService.getEnvironmentPartnerId()) {
          case SocialNetworkEnum.VKONTAKTE_INTERNAL.name.toLocaleLowerCase():
            return new VkReferralButton();
          case SocialNetworkEnum.ODNOKLASSNIKI_INTERNAL.name.toLocaleLowerCase():
            return new OkReferralButton();
        }
      }
      return new LinkReferralButton();
    }
  }
}
