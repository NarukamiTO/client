package alternativa.tanks.models.user {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.type.IGameObject;

  public interface ClanUserService extends IEventDispatcher {
    function get userObject() : IGameObject;
    function set userObject(param1:IGameObject) : void;
    function getObjectById(param1:Long) : IGameObject;
    function get hasClanLicense() : Boolean;
    function set hasClanLicense(param1:Boolean) : void;
    function set licenseGarageObject(param1:IGameObject) : void;
    function get licenseGarageObject() : IGameObject;
    function get otherClan() : Boolean;
    function set otherClan(param1:Boolean) : void;
    function get showBuyLicenseButton() : Boolean;
    function set showBuyLicenseButton(param1:Boolean) : void;
    function containsClanInOutgoing(param1:String) : Boolean;
    function getIncomingClanNames(param1:String) : Boolean;
    function hideNotInClanPanel() : void;
  }
}
