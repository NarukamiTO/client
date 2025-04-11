package alternativa.tanks.gui.payment.forms.mobile {
  import flash.events.Event;

  public class PhoneNumberEvent extends Event {
    public static const CHANGED:String = "PhoneNumberEvent:Changed";

    private var phoneNumber:String;
    private var correctLength:Boolean;

    public function PhoneNumberEvent(param1:String, param2:String, param3:Boolean) {
      super(param1);
      this.phoneNumber = param2;
      this.correctLength = param3;
    }

    public function getPhoneNumber() : String {
      return this.phoneNumber;
    }

    public function isCorrectLength() : Boolean {
      return this.correctLength;
    }
  }
}
