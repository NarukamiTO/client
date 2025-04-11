package alternativa.tanks.service {
  public interface AccountService {
    function get haveVisitedTankiAlready() : Boolean;
    function set haveVisitedTankiAlready(param1:Boolean) : void;
    function get storedUserName() : String;
    function set storedUserName(param1:String) : void;
    function get entranceHash() : String;
  }
}
