package alternativa.tanks.gui.payment.forms.mobile {
  import flash.events.Event;

  public class PhoneNumberValidationEvent extends Event {
    public static const VALIDATE:String = "PhoneNumberValidationEvent.EVENT";

    private var phoneNumber:String;

    public function PhoneNumberValidationEvent(param1:String) {
      super(VALIDATE,true);
      this.phoneNumber = param1;
    }

    public function getPhoneNumber() : String {
      return this.phoneNumber;
    }
  }
}
