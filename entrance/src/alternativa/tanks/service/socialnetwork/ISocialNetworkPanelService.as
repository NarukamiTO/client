package alternativa.tanks.service.socialnetwork {
  import flash.events.IEventDispatcher;

  public interface ISocialNetworkPanelService extends IEventDispatcher {
    function get passwordCreated() : Boolean;
    function set passwordCreated(param1:Boolean) : void;
    function setSnLinkExists(param1:String, param2:Boolean) : void;
    function setSnEnabledInCurrentLocale(param1:String, param2:Boolean) : void;
    function snEnabledInCurrentLocale(param1:String) : Boolean;
    function snLinkExists(param1:String) : Boolean;
    function createLink(param1:String) : void;
    function unlink(param1:String) : void;
    function linkSuccess(param1:String) : void;
    function unlinkSucces(param1:String) : void;
  }
}
