package alternativa.tanks.gui.settings {
  import flash.events.Event;

  public class SelectTabEvent extends Event {
    public static var SELECT_SETTING_TAB:String = "SelectTabEvent";

    private var selectedCategory:SettingsCategoryEnum;

    public function SelectTabEvent(param1:SettingsCategoryEnum) {
      super(SELECT_SETTING_TAB);
      this.selectedCategory = param1;
    }

    public function getSelectedCategory() : SettingsCategoryEnum {
      return this.selectedCategory;
    }
  }
}
