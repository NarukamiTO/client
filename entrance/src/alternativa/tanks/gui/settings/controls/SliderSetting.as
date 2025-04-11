package alternativa.tanks.gui.settings.controls {
  import alternativa.tanks.service.settings.SettingEnum;
  import controls.Slider;

  public class SliderSetting extends Slider implements SettingControl {
    private var setting:SettingEnum;

    public function SliderSetting(param1:SettingEnum) {
      super();
      this.setting = param1;
    }

    public function getSetting() : SettingEnum {
      return this.setting;
    }

    public function getSettingValue() : Object {
      return value * 100;
    }
  }
}
