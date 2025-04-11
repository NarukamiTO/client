package alternativa.tanks.gui.payment.controls.exchange {
  import flash.events.Event;

  public class ExchangeGroupEvent extends Event {
    public static const PROCEED:String = "ExchangeGroupEvent.proceed";
    public static const RETURN:String = "ExchangeGroupEvent.return";

    public function ExchangeGroupEvent(param1:String) {
      super(param1);
    }
  }
}
