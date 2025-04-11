package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;

  public interface UserPaymentActionsService extends IEventDispatcher {
    function openPayment(param1:String) : void;
    function closePayment(param1:String) : void;
    function selectCountry(param1:String) : void;
    function choosePaymode(param1:Long, param2:Long) : void;
    function chooseItem(param1:Long) : void;
    function proceed(param1:Long, param2:Long) : void;
  }
}
