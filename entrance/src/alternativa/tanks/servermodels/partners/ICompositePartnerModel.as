package alternativa.tanks.servermodels.partners {
  [ModelInterface]
  public interface ICompositePartnerModel {
    function loadPartnerObject(param1:String) : void;
    function finishRegistration(param1:String, param2:String) : void;
    function bindAccount(param1:String, param2:String) : void;
  }
}
