package alternativa.tanks.service.settings.keybinding {
  import flash.events.Event;

  public class KeyBindingChangeEvent extends Event {
    public static const KEY_BINDING_CHANGE:String = "action changed: ";

    private var action:GameActionEnum;

    public function KeyBindingChangeEvent(param1:String, param2:GameActionEnum) {
      super(param1,true,false);
      this.action = param2;
    }

    public function getAction() : GameActionEnum {
      return this.action;
    }
  }
}
