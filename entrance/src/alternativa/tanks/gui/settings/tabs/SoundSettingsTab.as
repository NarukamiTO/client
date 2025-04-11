package alternativa.tanks.gui.settings.tabs {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.gui.settings.SettingsWindow;
  import alternativa.tanks.service.settings.SettingEnum;
  import controls.Slider;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import controls.checkbox.CheckBoxBase;
  import forms.events.SliderEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.LocaleServiceLangValues;

  public class SoundSettingsTab extends SettingsTabView {
    [Inject]
    public static var display:IDisplay;

    private var volumeLevel:Slider;
    private var bgSound:CheckBoxBase;

    public function SoundSettingsTab() {
      super();
      var local1:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,0,TankWindowInner.TRANSPARENT);
      var local2:LabelBase = new LabelBase();
      local1.addChild(local2);
      local2.text = localeService.getText(TanksLocale.TEXT_SETTINGS_SOUND_VOLUME_LABEL_TEXT);
      local2.x = MARGIN;
      this.volumeLevel = new Slider();
      this.volumeLevel.maxValue = 100;
      this.volumeLevel.minValue = 0;
      this.volumeLevel.tickInterval = 5;
      this.volumeLevel.x = local2.x + local2.textWidth + MARGIN;
      this.volumeLevel.y = MARGIN;
      this.volumeLevel.width = SettingsWindow.TAB_VIEW_MAX_WIDTH - 2 * MARGIN - local2.width - 1;
      if(localeService.language == LocaleServiceLangValues.CN) {
        this.volumeLevel.width -= 4;
      }
      this.volume = settingsService.soundVolume;
      this.volumeLevel.addEventListener(SliderEvent.CHANGE_VALUE,this.onChangeVolume);
      local1.addChild(this.volumeLevel);
      this.bgSound = createCheckBox(SettingEnum.BG_SOUND,localeService.getText(TanksLocale.TEXT_SETTINGS_BACKGROUND_SOUND_CHECKBOX_LABEL_TEXT),settingsService.bgSound,MARGIN,0);
      this.bgSound.x = MARGIN;
      this.bgSound.y = MARGIN + this.volumeLevel.y + this.volumeLevel.height;
      local1.addChild(this.bgSound);
      local1.height = MARGIN + this.bgSound.y + this.bgSound.height;
      local2.y = this.volumeLevel.y + Math.round((this.volumeLevel.height - local2.textHeight) * 0.5) - 2;
      addChild(local1);
    }

    private function onChangeVolume(param1:SliderEvent) : void {
      settingsService.soundVolume = this.volume;
    }

    override public function hide() : void {
      super.hide();
    }

    public function getBgSound() : Boolean {
      return this.bgSound.checked;
    }

    public function setBgSound(param1:Boolean) : void {
      this.bgSound.checked = param1;
    }

    public function get volume() : Number {
      return this.volumeLevel.value / 100;
    }

    public function set volume(param1:Number) : void {
      this.volumeLevel.value = int(param1 * 100);
    }

    override public function destroy() : void {
      this.volumeLevel.removeEventListener(SliderEvent.CHANGE_VALUE,this.onChangeVolume);
      super.destroy();
    }
  }
}
