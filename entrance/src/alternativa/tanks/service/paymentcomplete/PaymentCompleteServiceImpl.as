package alternativa.tanks.service.paymentcomplete {
  import flash.events.EventDispatcher;

  public class PaymentCompleteServiceImpl extends EventDispatcher implements PaymentCompleteService {
    public function PaymentCompleteServiceImpl() {
      super();
    }

    public function paymentCompleted() : void {
      dispatchEvent(new PaymentCompleteEvent());
    }
  }
}
