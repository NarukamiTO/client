package alternativa.tanks.gui.settings.tabs.game {
  import alternativa.tanks.gui.settings.SettingEvent;

  public class ReceivePersonalMessagesSettingEvent extends SettingEvent {
    public static var RECEIVE_PERSONAL_MESSAGES_CHANGE:String = "ReceivePersonalMessagesSettingEvent";

    private var value:Boolean;

    public function ReceivePersonalMessagesSettingEvent(param1:String, param2:Boolean) {
      super(param1);
      this.value = param2;
    }

    public function getValue() : Boolean {
      return this.value;
    }
  }
}
