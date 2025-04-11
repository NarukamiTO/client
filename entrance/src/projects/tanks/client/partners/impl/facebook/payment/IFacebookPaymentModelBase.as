package projects.tanks.client.partners.impl.facebook.payment {
  import alternativa.types.Long;

  public interface IFacebookPaymentModelBase {
    function receivePaymentTransaction(param1:Long, param2:String) : void;
  }
}
