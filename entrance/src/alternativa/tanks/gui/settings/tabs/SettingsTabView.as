package alternativa.tanks.gui.settings.tabs {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.settings.controls.CheckBoxSetting;
  import alternativa.tanks.gui.settings.controls.SettingControl;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.SettingEnum;
  import base.DiscreteSprite;
  import flash.display.DisplayObject;
  import flash.events.MouseEvent;

  public class SettingsTabView extends DiscreteSprite {
    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var localeService:ILocaleService;

    public static const MARGIN:int = 8;
    public static const MARGIN_BEFORE_PARTITION_LABEL:int = 10;
    public static const MARGIN_AFTER_PARTITION_LABEL:int = 3;

    protected var settingsWithEvent:Vector.<DisplayObject> = new Vector.<DisplayObject>();

    public function SettingsTabView() {
      super();
    }

    public function show() : void {
    }

    public function hide() : void {
    }

    protected function createCheckBox(param1:SettingEnum, param2:String, param3:Boolean, param4:int = 0, param5:int = 0) : CheckBoxSetting {
      var local6:CheckBoxSetting = new CheckBoxSetting(param1,param2);
      local6.checked = param3;
      local6.addEventListener(MouseEvent.CLICK,this.onControlClick);
      local6.x = param4;
      local6.y = param5;
      this.settingsWithEvent.push(local6);
      local6.label = param2;
      return local6;
    }

    protected function onControlClick(param1:MouseEvent) : void {
      var local2:SettingControl = null;
      if(param1.currentTarget is SettingControl) {
        local2 = SettingControl(param1.currentTarget);
        settingsService.setClientSetting(local2.getSetting(),local2.getSettingValue());
      }
    }

    public function destroy() : void {
      var local1:DisplayObject = null;
      for each(local1 in this.settingsWithEvent) {
        local1.removeEventListener(MouseEvent.CLICK,this.onControlClick);
      }
    }
  }
}
