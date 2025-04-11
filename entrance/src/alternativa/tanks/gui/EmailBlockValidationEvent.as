package alternativa.tanks.gui {
  import flash.events.Event;

  public class EmailBlockValidationEvent extends Event {
    public static const EMAIL_VALIDATED_EVENT:String = "ThanksForPurchaseWindowEmailValidationEventEMAIL_VALIDATED_EVENT";

    public var email:String;
    public var isValid:Boolean;

    public function EmailBlockValidationEvent(param1:String, param2:String, param3:Boolean) {
      super(param1,true,false);
      this.email = param2;
      this.isValid = param3;
    }
  }
}
