package alternativa.tanks.gui.settings.tabs {
  import alternativa.tanks.gui.settings.SettingsWindow;
  import alternativa.tanks.gui.settings.controls.GridLayout;
  import alternativa.tanks.service.settings.SettingEnum;
  import controls.TankWindowInner;
  import controls.checkbox.CheckBoxBase;
  import flash.events.MouseEvent;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class GraphicSettingsTab extends SettingsTabView {
    private var performanceInner:TankWindowInner;
    private var cbShowFPS:CheckBoxBase;
    private var cbAdaptiveFPS:CheckBoxBase;
    private var cbShowSkyBox:CheckBoxBase;
    private var cbAntialiasing:CheckBoxBase;
    private var cbDynamicLighting:CheckBoxBase;
    private var cbMipMapping:CheckBoxBase;
    private var cbFog:CheckBoxBase;
    private var cbTankShadow:CheckBoxBase;
    private var cbDynamicShadows:CheckBoxBase;
    private var cbSoftParticles:CheckBoxBase;
    private var cbDust:CheckBoxBase;
    private var cbSSAO:CheckBoxBase;
    private var cbGraphicsAutoQuality:CheckBoxBase;

    public function GraphicSettingsTab() {
      var local2:int = 0;
      super();
      this.performanceInner = new TankWindowInner(0,0,TankWindowInner.TRANSPARENT);
      this.performanceInner.width = SettingsWindow.TAB_VIEW_MAX_WIDTH;
      this.performanceInner.x = this.performanceInner.y = 0;
      addChild(this.performanceInner);
      this.cbShowFPS = createCheckBox(SettingEnum.SHOW_FPS,localeService.getText(TanksLocale.TEXT_SETTINGS_SHOW_FPS_CHECKBOX),settingsService.showFPS);
      addChild(this.cbShowFPS);
      this.cbAdaptiveFPS = createCheckBox(SettingEnum.ADAPTIVE_FPS,localeService.getText(TanksLocale.TEXT_SETTINGS_ENABLE_ADAPTIVE_FPS_CHECKBOX_LABEL_TEXT),settingsService.adaptiveFPS);
      addChild(this.cbAdaptiveFPS);
      this.cbShowSkyBox = createCheckBox(SettingEnum.SHOW_SKY_BOX,localeService.getText(TanksLocale.TEXT_SETTINGS_SHOW_SKYBOX_CHECKBOX_LABEL_TEXT),settingsService.showSkyBox);
      addChild(this.cbShowSkyBox);
      this.cbMipMapping = createCheckBox(SettingEnum.MIPMAPPING,localeService.getText(TanksLocale.TEXT_SETTINGS_MIPMAPPING_LABEL_TEXT),settingsService.mipMapping);
      addChild(this.cbMipMapping);
      var local1:GridLayout = new GridLayout(MARGIN,MARGIN,SettingsWindow.TAB_VIEW_MAX_WIDTH * 0.5,this.cbShowFPS.height + MARGIN);
      if(this.gpuAvailable()) {
        this.cbFog = createCheckBox(SettingEnum.FOG,localeService.getText(TanksLocale.TEXT_SETTINGS_FOG_LABEL_TEXT),settingsService.fog);
        addChild(this.cbFog);
        this.cbTankShadow = createCheckBox(SettingEnum.SHADOWS_UNDER_TANK,localeService.getText(TanksLocale.TEXT_SETTINGS_SHADOWS_LABEL_TEXT),settingsService.shadows);
        addChild(this.cbTankShadow);
        this.cbDynamicShadows = createCheckBox(SettingEnum.DYNAMIC_SHADOWS,localeService.getText(TanksLocale.TEXT_SETTINGS_DYNAMIC_SHADOWS_LABEL_TEXT),settingsService.dynamicShadows);
        addChild(this.cbDynamicShadows);
        this.cbSoftParticles = createCheckBox(SettingEnum.SOFT_PARTICLES,localeService.getText(TanksLocale.TEXT_SETTINGS_SOFT_PARTICLES_LABEL_TEXT),settingsService.softParticles);
        addChild(this.cbSoftParticles);
        this.cbSoftParticles.addEventListener(MouseEvent.CLICK,this.onSoftParticlesClick);
        this.cbDust = createCheckBox(SettingEnum.DUST,localeService.getText(TanksLocale.TEXT_SETTINGS_DUST_LABEL_TEXT),settingsService.dust);
        addChild(this.cbDust);
        this.cbSSAO = createCheckBox(SettingEnum.SSAO,localeService.getText(TanksLocale.TEXT_SETTINGS_SSAO),settingsService.ssao);
        addChild(this.cbSSAO);
        this.cbAntialiasing = createCheckBox(SettingEnum.ANTIALIASING,localeService.getText(TanksLocale.TEXT_SETTINGS_ANTIALIASING),settingsService.antialiasing);
        addChild(this.cbAntialiasing);
        this.cbDynamicLighting = createCheckBox(SettingEnum.DYNAMIC_LIGHTING,localeService.getText(TanksLocale.TEXT_SETTINGS_DYNAMIC_LIGHTING),settingsService.dynamicLighting);
        addChild(this.cbDynamicLighting);
        this.createGraphicsAutoQualityCheckBox();
        local2 = this.layoutPerformanceFull(local1);
        if(this.cbGraphicsAutoQuality.checked) {
          local2 = this.cbGraphicsAutoQuality.y + this.cbGraphicsAutoQuality.height;
        }
      } else {
        local2 = this.layoutPerformanceConstrained(local1);
      }
      this.performanceInner.height = local2 + MARGIN;
    }

    private function gpuAvailable() : Boolean {
      return GPUCapabilities.gpuEnabled && !GPUCapabilities.constrained;
    }

    private function onSoftParticlesClick(param1:MouseEvent) : void {
      this.checkDustAvailable();
    }

    private function checkDustAvailable() : void {
      this.cbDust.visible = Boolean(this.cbSoftParticles) && !this.cbGraphicsAutoQuality.checked && this.cbSoftParticles.checked;
    }

    private function createGraphicsAutoQualityCheckBox() : void {
      this.cbGraphicsAutoQuality = createCheckBox(SettingEnum.GRAPHICS_AUTO_QUALITY,localeService.getText(TanksLocale.TEXT_SETTINGS_GRAPHICS_AUTO_QUALITY),settingsService.graphicsAutoQuality);
      addChild(this.cbGraphicsAutoQuality);
      this.onGraphicsAutQualityClick();
      this.cbGraphicsAutoQuality.addEventListener(MouseEvent.CLICK,this.onGraphicsAutQualityClick);
    }

    private function onGraphicsAutQualityClick(param1:MouseEvent = null) : void {
      var local2:Boolean = !this.cbGraphicsAutoQuality.checked;
      this.cbFog.visible = local2;
      this.cbTankShadow.visible = local2;
      this.cbDynamicShadows.visible = local2;
      this.cbSoftParticles.visible = local2;
      this.cbSSAO.visible = local2;
      this.cbDynamicLighting.visible = local2;
      this.cbAntialiasing.visible = local2;
      this.performanceInner.height = local2 ? 7 * this.cbShowFPS.height + 8 * MARGIN : 3 * this.cbShowFPS.height + 4 * MARGIN;
      this.checkDustAvailable();
    }

    private function layoutPerformanceConstrained(param1:GridLayout) : int {
      return param1.layout([[this.cbShowFPS,this.cbAdaptiveFPS],[this.cbShowSkyBox,this.cbMipMapping]]);
    }

    private function layoutPerformanceFull(param1:GridLayout) : int {
      return param1.layout([[this.cbShowFPS,this.cbAdaptiveFPS],[this.cbShowSkyBox,this.cbMipMapping],[this.cbGraphicsAutoQuality],[this.cbDynamicShadows,this.cbSSAO],[this.cbDynamicLighting,this.cbFog],[this.cbTankShadow,this.cbAntialiasing],[this.cbSoftParticles,this.cbDust]]);
    }

    override public function destroy() : void {
      if(this.gpuAvailable()) {
        this.cbGraphicsAutoQuality.removeEventListener(MouseEvent.CLICK,this.onGraphicsAutQualityClick);
        this.cbSoftParticles.removeEventListener(MouseEvent.CLICK,this.onSoftParticlesClick);
      }
      super.destroy();
    }
  }
}
