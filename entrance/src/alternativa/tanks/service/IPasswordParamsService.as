package alternativa.tanks.service {
  public interface IPasswordParamsService {
    function get forbiddenPasswords() : Array;
    function set forbiddenPasswords(param1:Array) : void;
    function get maxPasswordLength() : int;
    function set maxPasswordLength(param1:int) : void;
    function get minPasswordLength() : int;
    function set minPasswordLength(param1:int) : void;
    function isPasswordForbidden(param1:String) : Boolean;
  }
}
