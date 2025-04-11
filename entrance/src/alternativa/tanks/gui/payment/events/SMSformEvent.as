package alternativa.tanks.gui.payment.events {
  import alternativa.tanks.gui.shop.forms.SMSForm;
  import flash.events.Event;

  public class SMSformEvent extends Event {
    public static const SELECT_COUNTRY:String = "SMSformEventSelectCountry";
    public static const SELECT_OPERATOR:String = "SMSformEventSelectOperator";

    public var form:SMSForm;

    public function SMSformEvent(param1:String, param2:SMSForm) {
      super(param1,true,false);
      this.form = param2;
    }
  }
}
