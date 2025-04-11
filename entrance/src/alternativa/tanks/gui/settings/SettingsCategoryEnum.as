package alternativa.tanks.gui.settings {
  import alternativa.tanks.AbstractEnum;

  public class SettingsCategoryEnum extends AbstractEnum {
    private static var _values:Vector.<SettingsCategoryEnum>;

    public static const GRAPHIC:SettingsCategoryEnum = new SettingsCategoryEnum(0,"GRAPHIC");
    public static const ACCOUNT:SettingsCategoryEnum = new SettingsCategoryEnum(1,"ACCOUNT");
    public static const SOUND:SettingsCategoryEnum = new SettingsCategoryEnum(2,"SOUND");
    public static const GAME:SettingsCategoryEnum = new SettingsCategoryEnum(3,"GAME");
    public static const CONTROL:SettingsCategoryEnum = new SettingsCategoryEnum(4,"CONTROL");

    public function SettingsCategoryEnum(param1:int, param2:String) {
      super(param1,param2);
    }

    public static function get values() : Vector.<SettingsCategoryEnum> {
      if(!_values) {
        _values = new Vector.<SettingsCategoryEnum>(5,true);
        _values[GRAPHIC.value] = GRAPHIC;
        _values[ACCOUNT.value] = ACCOUNT;
        _values[SOUND.value] = SOUND;
        _values[GAME.value] = GAME;
        _values[CONTROL.value] = CONTROL;
      }
      return _values;
    }
  }
}
