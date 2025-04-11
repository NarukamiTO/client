package forms.events {
  import flash.events.Event;

  public class MainButtonBarEvents extends Event {
    public static const SHOP:String = "SHOP";
    public static const BATTLE:String = "Battle";
    public static const GARAGE:String = "Garage";
    public static const CLAN:String = "Clan";
    public static const FRIENDS:String = "Friends";
    public static const SOUND:String = "Sound";
    public static const SETTINGS:String = "Settings";
    public static const HELP:String = "Help";
    public static const CLOSE:String = "Close";
    public static const FULL_SCREEN:String = "FullScreen";
    public static const QUESTS:String = "Quests";
    public static const PANEL_BUTTON_PRESSED:String = "Close";

    private var types:Array = [SHOP,BATTLE,GARAGE,SETTINGS,SOUND,HELP,CLOSE,FRIENDS,FULL_SCREEN,QUESTS,CLAN];
    private var _typeButton:String;

    public function MainButtonBarEvents(param1:int) {
      super(MainButtonBarEvents.PANEL_BUTTON_PRESSED,true,false);
      this._typeButton = this.types[param1 - 1];
    }

    public function get typeButton() : String {
      return this._typeButton;
    }
  }
}
