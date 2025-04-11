package forms.events {
  import flash.events.Event;

  public class FormEvent extends Event {
    public static const FORM_DESTOY:String = "FormEventFormDestoy";

    public function FormEvent(param1:String) {
      super(param1);
    }
  }
}
