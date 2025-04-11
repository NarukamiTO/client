package alternativa.tanks.gui.settings.controls {
  import alternativa.tanks.service.settings.SettingEnum;
  import controls.checkbox.CheckBoxBase;

  public class CheckBoxSetting extends CheckBoxBase implements SettingControl {
    private var setting:SettingEnum;

    public function CheckBoxSetting(param1:SettingEnum, param2:String) {
      super();
      this.setting = param1;
      this.label = param2;
    }

    public function getSettingValue() : Object {
      return checked;
    }

    public function getSetting() : SettingEnum {
      return this.setting;
    }
  }
}
