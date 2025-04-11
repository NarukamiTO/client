package alternativa.tanks.controller.commands {
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.tanks.controller.events.NavigationEvent;
  import alternativa.tanks.model.EntranceUrlParamsModel;
  import flash.utils.Dictionary;
  import org.robotlegs.mvcs.Command;
  import platform.client.fp10.core.service.address.AddressService;

  public class ParseUrlParamsCommand extends Command {
    [Inject]
    public var paramsModel:EntranceUrlParamsModel;

    [Inject]
    public var launcherParams:ILauncherParams;

    [Inject]
    public var addressService:AddressService;

    public function ParseUrlParamsCommand() {
      super();
    }

    override public function execute() : void {
      this.paramsModel.entranceHash = this.parseEntranceHash();
      this.paramsModel.singleUseHash = this.parseSingleUseHash();
      this.paramsModel.domain = this.addressService != null ? this.addressService.getBaseURL() : "";
      this.paramsModel.passedCallsign = this.launcherParams.getParameter("user");
      this.paramsModel.passedPassword = this.launcherParams.getParameter("password");
      this.paramsModel.emailConfirmHash = this.parseEmailConfirmHash();
      this.paramsModel.emailChangeHash = this.parseEmailChangeHash();
      this.paramsModel.email = this.parseEmail();
      this.paramsModel.referralHash = this.parseReferralHash();
      this.paramsModel.tutorialHash = this.parseTutorialHash();
      this.paramsModel.changeUidHash = this.parseChangeUidHash();
      dispatch(new NavigationEvent(NavigationEvent.GO_TO_STAND_ALONE_CAPTCHA));
    }

    private function parseChangeUidHash() : String {
      var local1:String = this.getAddressParams()["changeUidHash"];
      if(local1 == null) {
        local1 = this.launcherParams.getParameter("changeUidHash");
      }
      return local1;
    }

    private function parseTutorialHash() : String {
      var local1:String = this.getAddressParams()["tutorial"];
      if(local1 == null) {
        local1 = this.launcherParams.getParameter("tutorial");
      }
      return local1;
    }

    private function parseReferralHash() : String {
      var local1:String = this.getAddressParams()["friend"];
      if(local1 == null) {
        local1 = this.launcherParams.getParameter("friend");
      }
      return local1;
    }

    private function parseEmail() : String {
      var local1:String = this.getAddressParams()["userEmail"];
      if(local1 == null) {
        local1 = this.launcherParams.getParameter("userEmail");
      }
      return local1;
    }

    private function parseEntranceHash() : String {
      var local1:String = this.getAddressParams()["hash"];
      if(local1 == null) {
        local1 = this.launcherParams.getParameter("hash");
      }
      return local1;
    }

    private function parseSingleUseHash() : String {
      var local1:String = this.getAddressParams()["singleUseHash"];
      if(local1 == null) {
        local1 = this.launcherParams.getParameter("singleUseHash");
      }
      return local1;
    }

    private function parseEmailConfirmHash() : String {
      var local1:String = this.getAddressParams()["emailConfirmHash"];
      if(local1 == null) {
        local1 = this.launcherParams.getParameter("emailConfirmHash");
      }
      return local1;
    }

    private function parseEmailChangeHash() : String {
      var local1:String = this.getAddressParams()["emailChangeHash"];
      if(local1 == null) {
        local1 = this.launcherParams.getParameter("emailChangeHash");
      }
      return local1;
    }

    private function getAddressParams() : Dictionary {
      var local2:String = null;
      var local3:Array = null;
      var local4:int = 0;
      var local5:Array = null;
      var local1:Dictionary = new Dictionary();
      if(this.addressService != null) {
        local2 = this.addressService.getValue();
        if(local2 != null) {
          local3 = local2.split("&");
          local4 = 0;
          while(local4 < local3.length) {
            local5 = (local3[local4] as String).split("=");
            local1[local5[0]] = local5[1];
            local4++;
          }
        }
      }
      return local1;
    }
  }
}
