package alternativa.tanks.gui.settings.controls {
  import alternativa.tanks.service.settings.SettingEnum;

  public interface SettingControl {
    function getSetting() : SettingEnum;
    function getSettingValue() : Object;
  }
}
