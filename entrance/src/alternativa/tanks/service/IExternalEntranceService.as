package alternativa.tanks.service {
  public interface IExternalEntranceService {
    function get vkontakteEnabled() : Boolean;
    function get facebookEnabled() : Boolean;
    function get googleEnabled() : Boolean;
    function setEnabled(param1:String, param2:Boolean) : void;
  }
}
