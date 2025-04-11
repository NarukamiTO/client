package projects.tanks.clients.flash.commons.services.serverhalt {
  public interface IServerHaltService {
    function setServerHalt(param1:Boolean) : void;
    function get isServerHalt() : Boolean;
  }
}
