package projects.tanks.clients.fp10.libraries.tanksservices.model.uidcheck {
  [ModelInterface]
  public interface UidCheckService {
    function getMaxLength() : int;
    function exist(param1:String, param2:Function) : void;
    function validate(param1:String, param2:Function) : void;
  }
}
