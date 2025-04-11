package alternativa.tanks.gui.settings.controls {
  import alternativa.tanks.gui.settings.SettingsCategoryEnum;
  import controls.buttons.IconButton;

  public class TabButton extends IconButton {
    private var category:SettingsCategoryEnum;

    public function TabButton(param1:SettingsCategoryEnum, param2:String, param3:Class) {
      super(param2,param3);
      this.category = param1;
    }

    public function getCategory() : SettingsCategoryEnum {
      return this.category;
    }
  }
}
