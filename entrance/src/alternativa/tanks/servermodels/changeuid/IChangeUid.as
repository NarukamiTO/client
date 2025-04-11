package alternativa.tanks.servermodels.changeuid {
  [ModelInterface]
  public interface IChangeUid {
    function checkChangeUidHash(param1:String, param2:String) : void;
    function changeUidAndPassword(param1:String, param2:String) : void;
    function changeUid(param1:String) : void;
  }
}
