package alternativa.tanks.service.socialnetwork {
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;

  public class SocialNetworkPanelService extends EventDispatcher implements ISocialNetworkPanelService {
    private var _passwordCreated:Boolean;
    private var _snEnabled:Dictionary = new Dictionary();
    private var _snLinkExists:Dictionary = new Dictionary();

    public function SocialNetworkPanelService() {
      super();
    }

    public function get passwordCreated() : Boolean {
      return this._passwordCreated;
    }

    public function set passwordCreated(param1:Boolean) : void {
      this._passwordCreated = param1;
    }

    public function setSnEnabledInCurrentLocale(param1:String, param2:Boolean) : void {
      this._snEnabled[param1] = param2;
    }

    public function snEnabledInCurrentLocale(param1:String) : Boolean {
      if(Boolean(this._snEnabled[param1])) {
        return this._snEnabled[param1];
      }
      return false;
    }

    public function setSnLinkExists(param1:String, param2:Boolean) : void {
      this._snLinkExists[param1] = param2;
    }

    public function snLinkExists(param1:String) : Boolean {
      if(Boolean(this._snLinkExists[param1])) {
        return this._snLinkExists[param1];
      }
      return false;
    }

    public function createLink(param1:String) : void {
      dispatchEvent(new SocialNetworkServiceEvent(SocialNetworkServiceEvent.CREATE_LINK,param1));
    }

    public function unlink(param1:String) : void {
      dispatchEvent(new SocialNetworkServiceEvent(SocialNetworkServiceEvent.UNLINK,param1));
    }

    public function linkSuccess(param1:String) : void {
      this._snLinkExists[param1] = true;
      dispatchEvent(new SocialNetworkServiceEvent(SocialNetworkServiceEvent.LINK_SUCCESS,param1));
    }

    public function unlinkSucces(param1:String) : void {
      this._snLinkExists[param1] = false;
      dispatchEvent(new SocialNetworkServiceEvent(SocialNetworkServiceEvent.UNLINK_SUCCESS,param1));
    }
  }
}
