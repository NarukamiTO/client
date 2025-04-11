package alternativa.tanks.gui.settings.tabs.control {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.gui.settings.SettingsWindow;
  import alternativa.tanks.gui.settings.tabs.ScrollableSettingsTabView;
  import alternativa.tanks.service.settings.SettingEnum;
  import base.DiscreteSprite;
  import controls.Slider;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import controls.containers.VerticalStackPanel;
  import forms.events.SliderEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;

  public class ControlSettingsTab extends ScrollableSettingsTabView {
    [Inject]
    public static var fullScreenService:FullscreenService;

    [Inject]
    public static var display:IDisplay;

    public static const MIN_SENSITIVITY_MOUSE:int = 1;
    public static const MAX_SENSITIVITY_MOUSE:int = 20;

    private var mouseSensitivity:Slider;

    public function ControlSettingsTab() {
      super();
      var local1:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,SettingsWindow.TAB_VIEW_MAX_HEIGHT,TankWindowInner.TRANSPARENT);
      addChildAt(local1,0);
      var local2:VerticalStackPanel = new VerticalStackPanel();
      local2.setMargin(MARGIN);
      local2.x = MARGIN;
      local2.y = TOP_MARGIN_FOR_SCROLL_TAB;
      if(fullScreenService.isMouseLockEnabled()) {
        local2.addItem(this.createMouseControlPanel());
      }
      local2.addItem(createCheckBox(SettingEnum.INVERSE_BACK_DRIVING,localeService.getText(TanksLocale.TEXT_SETTINGS_INVERSE_TURN_CONTROL_CHECKBOX_LABEL_TEXT),settingsService.inverseBackDriving));
      local2.addItem(new KeyBindingsPanel());
      addItem(local2);
    }

    private function createMouseControlPanel() : DiscreteSprite {
      var local1:VerticalStackPanel = new VerticalStackPanel();
      local1.setMargin(MARGIN);
      local1.addItem(createCheckBox(SettingEnum.MOUSE_CONTROL,localeService.getText(TanksLocale.TEXT_SETTINGS_MOUSE_CONTROL_CHECKBOX),settingsService.mouseControl));
      local1.addItem(this.createMouseSensitivityBlock());
      local1.addItem(createCheckBox(SettingEnum.MOUSE_Y_INVERSE,localeService.getText(TanksLocale.TEXT_SETTINGS_MOUSE_INVERSION_CHECKBOX_LABEL),settingsService.mouseYInverse));
      local1.addItem(createCheckBox(SettingEnum.MOUSE_Y_INVERSE_SHAFT_AIM,localeService.getText(TanksLocale.TEXT_SETTINGS_MOUSE_SHAFT_SCOPE_VERTICAL_INVERSION),settingsService.mouseYInverseShaftAim));
      return local1;
    }

    private function createMouseSensitivityBlock() : DiscreteSprite {
      var local1:DiscreteSprite = new DiscreteSprite();
      var local2:LabelBase = new LabelBase();
      local2.text = localeService.getText(TanksLocale.TEXT_SETTINGS_MOUSE_SENSITIVITY_CHECKBOX_LABEL) + ":";
      local1.addChild(local2);
      this.mouseSensitivity = new Slider();
      this.mouseSensitivity.maxValue = MAX_SENSITIVITY_MOUSE;
      this.mouseSensitivity.minValue = MIN_SENSITIVITY_MOUSE;
      this.mouseSensitivity.tickInterval = 1;
      this.mouseSensitivity.width = SettingsWindow.TAB_VIEW_MAX_WIDTH - MARGIN * 4 - local2.width;
      this.mouseSensitivity.x = local2.width + MARGIN;
      this.mouseSensitivity.value = settingsService.mouseSensitivity;
      this.mouseSensitivity.addEventListener(SliderEvent.CHANGE_VALUE,this.onChangeMouseSensitivity);
      local2.y = Math.round((this.mouseSensitivity.height - local2.textHeight) * 0.5) - 2;
      local1.addChild(this.mouseSensitivity);
      return local1;
    }

    private function onChangeMouseSensitivity(param1:SliderEvent) : void {
      settingsService.setClientSetting(SettingEnum.MOUSE_SENSITIVITY,this.mouseSensitivity.value);
    }

    override public function destroy() : void {
      if(fullScreenService.isMouseLockEnabled()) {
        this.mouseSensitivity.removeEventListener(SliderEvent.CHANGE_VALUE,this.onChangeMouseSensitivity);
      }
      super.destroy();
    }
  }
}
