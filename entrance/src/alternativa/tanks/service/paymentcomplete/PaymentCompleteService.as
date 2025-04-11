package alternativa.tanks.service.paymentcomplete {
  import flash.events.IEventDispatcher;

  public interface PaymentCompleteService extends IEventDispatcher {
    function paymentCompleted() : void;
  }
}
