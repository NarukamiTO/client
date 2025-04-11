package alternativa.tanks.model.socialnetwork {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.socialnetwork.ISocialNetworkPanelService;
  import alternativa.tanks.service.socialnetwork.SocialNetworkServiceEvent;
  import flash.external.ExternalInterface;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.socialnetwork.ISocialNetworkPanelModelBase;
  import projects.tanks.client.panel.model.socialnetwork.SocialNetworkPanelModelBase;
  import projects.tanks.client.panel.model.socialnetwork.SocialNetworkPanelParams;
  import projects.tanks.clients.flash.commons.models.externalauth.ExternalAuthApi;
  import projects.tanks.clients.flash.commons.services.nameutils.SocialNetworkNameUtils;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import services.alertservice.AlertAnswer;

  [ModelInfo]
  public class SocialNetworkPanelModel extends SocialNetworkPanelModelBase implements ISocialNetworkPanelModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var socialNetworkService:ISocialNetworkPanelService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var alertService:IAlertService;

    public function SocialNetworkPanelModel() {
      super();
    }

    private static function goToURL(param1:String) : void {
      if(ExternalInterface.available) {
        ExternalInterface.call("newPopup",param1);
      } else {
        navigateToURL(new URLRequest(param1));
      }
    }

    public function objectLoaded() : void {
      this.initSocialNetworks();
      socialNetworkService.addEventListener(SocialNetworkServiceEvent.CREATE_LINK,getFunctionWrapper(this.onCreateLink));
      socialNetworkService.addEventListener(SocialNetworkServiceEvent.UNLINK,getFunctionWrapper(this.onUnlink));
    }

    private function initSocialNetworks() : void {
      var local1:SocialNetworkPanelParams = null;
      socialNetworkService.passwordCreated = getInitParam().passwordCreated;
      for each(local1 in getInitParam().socialNetworkParams) {
        socialNetworkService.setSnEnabledInCurrentLocale(local1.snId,local1.enabled);
        socialNetworkService.setSnLinkExists(local1.snId,local1.linkExists);
      }
    }

    public function objectUnloaded() : void {
      socialNetworkService.removeEventListener(SocialNetworkServiceEvent.CREATE_LINK,getFunctionWrapper(this.onCreateLink));
      socialNetworkService.removeEventListener(SocialNetworkServiceEvent.UNLINK,getFunctionWrapper(this.onUnlink));
    }

    private function onUnlink(param1:SocialNetworkServiceEvent) : void {
      if(socialNetworkService.passwordCreated) {
        server.removeLink(param1.socialNetworkId);
      } else {
        alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_ACCOUNT_CANT_BE_UNLINKED,SocialNetworkNameUtils.makeSocialNetworkNameFromId(param1.socialNetworkId)),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
      }
    }

    private function onCreateLink(param1:SocialNetworkServiceEvent) : void {
      var local2:String = this.getAuthorizationUrl(param1.socialNetworkId);
      if(Boolean(local2)) {
        goToURL(local2);
      } else {
        ExternalAuthApi(object.adapt(ExternalAuthApi)).initLogin(param1.socialNetworkId);
      }
    }

    private function getAuthorizationUrl(param1:String) : String {
      var local2:SocialNetworkPanelParams = null;
      for each(local2 in getInitParam().socialNetworkParams) {
        if(local2.snId == param1) {
          return local2.authorizationUrl;
        }
      }
      return null;
    }

    public function validationFailed() : void {
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_ACCOUNT_LINKING_ERROR),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    public function linkAlreadyExists(param1:String) : void {
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_ACCOUNT_ALREADY_LINKED,SocialNetworkNameUtils.makeSocialNetworkNameFromId(param1)),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    public function linkCreated(param1:String) : void {
      socialNetworkService.linkSuccess(param1);
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_ACCOUNT_SUCCESS_LINKED),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    public function unlinkSuccess(param1:String) : void {
      socialNetworkService.unlinkSucces(param1);
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_ACCOUNT_UNLINKED,SocialNetworkNameUtils.makeSocialNetworkNameFromId(param1)),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }
  }
}
