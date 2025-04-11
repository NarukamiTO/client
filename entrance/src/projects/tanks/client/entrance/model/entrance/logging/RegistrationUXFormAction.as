package projects.tanks.client.entrance.model.entrance.logging {
  public class RegistrationUXFormAction {
    public static const CORRECT_PASSWORD_TYPED:RegistrationUXFormAction = new RegistrationUXFormAction(0,"CORRECT_PASSWORD_TYPED");
    public static const CORRECT_PASSWORD_CONFIRMATION_TYPED:RegistrationUXFormAction = new RegistrationUXFormAction(1,"CORRECT_PASSWORD_CONFIRMATION_TYPED");
    public static const CORRECT_USERNAME_TYPED:RegistrationUXFormAction = new RegistrationUXFormAction(2,"CORRECT_USERNAME_TYPED");
    public static const BUSY_USERNAME_TYPED:RegistrationUXFormAction = new RegistrationUXFormAction(3,"BUSY_USERNAME_TYPED");
    public static const FORBIDDEN_USERNAME_TYPED:RegistrationUXFormAction = new RegistrationUXFormAction(4,"FORBIDDEN_USERNAME_TYPED");
    public static const FORBIDDEN_CHARACTERS_TYPED:RegistrationUXFormAction = new RegistrationUXFormAction(5,"FORBIDDEN_CHARACTERS_TYPED");
    public static const FORBIDDEN_LETTERS_TYPED:RegistrationUXFormAction = new RegistrationUXFormAction(6,"FORBIDDEN_LETTERS_TYPED");
    public static const USERNAME_OFFER_ACCEPTED:RegistrationUXFormAction = new RegistrationUXFormAction(7,"USERNAME_OFFER_ACCEPTED");
    public static const SOCIAL_BUTTON_CLICKED:RegistrationUXFormAction = new RegistrationUXFormAction(8,"SOCIAL_BUTTON_CLICKED");
    public static const USER_AGREEMENT_ACCEPTED:RegistrationUXFormAction = new RegistrationUXFormAction(9,"USER_AGREEMENT_ACCEPTED");

    private var _value:int;
    private var _name:String;

    public function RegistrationUXFormAction(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<RegistrationUXFormAction> {
      var local1:Vector.<RegistrationUXFormAction> = new Vector.<RegistrationUXFormAction>();
      local1.push(CORRECT_PASSWORD_TYPED);
      local1.push(CORRECT_PASSWORD_CONFIRMATION_TYPED);
      local1.push(CORRECT_USERNAME_TYPED);
      local1.push(BUSY_USERNAME_TYPED);
      local1.push(FORBIDDEN_USERNAME_TYPED);
      local1.push(FORBIDDEN_CHARACTERS_TYPED);
      local1.push(FORBIDDEN_LETTERS_TYPED);
      local1.push(USERNAME_OFFER_ACCEPTED);
      local1.push(SOCIAL_BUTTON_CLICKED);
      local1.push(USER_AGREEMENT_ACCEPTED);
      return local1;
    }

    public function toString() : String {
      return "RegistrationUXFormAction [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
