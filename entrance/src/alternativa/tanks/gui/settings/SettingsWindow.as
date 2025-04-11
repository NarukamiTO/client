package alternativa.tanks.gui.settings {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.settings.tabs.GraphicSettingsTab;
  import alternativa.tanks.gui.settings.tabs.SettingsTabView;
  import alternativa.tanks.gui.settings.tabs.account.AccountSettingsTab;
  import alternativa.tanks.gui.settings.tabs.control.ControlSettingsTab;
  import alternativa.tanks.gui.settings.tabs.game.GameSettingsTab;
  import controls.base.DefaultButtonBase;
  import flash.events.MouseEvent;
  import flash.utils.Dictionary;
  import forms.TankWindowWithHeader;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;

  public class SettingsWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var helperService:IHelpService;

    [Inject]
    public static var userChangeGameScreenService:UserChangeGameScreenService;

    [Inject]
    public static var partnersService:IPartnerService;

    public static const TAB_VIEW_MAX_HEIGHT:int = WINDOW_HEIGHT - 2 * WINDOW_MARGIN - 2 * BUTTON_HEIGHT - MARGIN;
    public static const TAB_VIEW_MAX_WIDTH:int = WINDOW_WIDTH - 2 * WINDOW_MARGIN;
    public static const WINDOW_MARGIN:int = 12;
    public static const BUTTON_HEIGHT:int = 33;
    public static const BUTTON_WIDTH:int = 104;

    private static const WINDOW_WIDTH:int = 775;
    private static const WINDOW_HEIGHT:int = 560;
    private static const MARGIN:int = 8;

    private var closeButton:DefaultButtonBase;
    private var navigateTabPanel:SettingsTabButtonList;
    private var tabViews:Dictionary;
    private var currentTab:SettingsTabView = null;

    public function SettingsWindow(param1:String, param2:Boolean, param3:Boolean, param4:Boolean, param5:String, param6:String) {
      var local7:TankWindowWithHeader = null;
      var local8:Boolean = false;
      var local12:AccountSettingsTab = null;
      this.tabViews = new Dictionary();
      super();
      local7 = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_SETTINGS,WINDOW_WIDTH,WINDOW_HEIGHT);
      addChild(local7);
      this.navigateTabPanel = new SettingsTabButtonList();
      this.navigateTabPanel.addCategoryButton(SettingsCategoryEnum.GAME);
      this.navigateTabPanel.addCategoryButton(SettingsCategoryEnum.GRAPHIC);
      local8 = !partnersService.isRunningInsidePartnerEnvironment() || param4;
      if(local8) {
        this.navigateTabPanel.addCategoryButton(SettingsCategoryEnum.ACCOUNT);
      }
      this.navigateTabPanel.addCategoryButton(SettingsCategoryEnum.CONTROL);
      this.navigateTabPanel.selectTabButton(SettingsCategoryEnum.GAME);
      this.navigateTabPanel.x = this.navigateTabPanel.y = WINDOW_MARGIN;
      this.navigateTabPanel.addEventListener(SelectTabEvent.SELECT_SETTING_TAB,this.tabSelected);
      addChild(this.navigateTabPanel);
      var local9:GraphicSettingsTab = new GraphicSettingsTab();
      local9.y = this.navigateTabPanel.y + this.navigateTabPanel.height + MARGIN;
      local9.x = WINDOW_MARGIN;
      this.tabViews[SettingsCategoryEnum.GRAPHIC] = local9;
      var local10:GameSettingsTab = new GameSettingsTab(param3);
      local10.y = this.navigateTabPanel.y + this.navigateTabPanel.height + MARGIN;
      local10.x = WINDOW_MARGIN;
      this.tabViews[SettingsCategoryEnum.GAME] = local10;
      if(local8) {
        local12 = new AccountSettingsTab(param1,param2,param4,param5,param6);
        local12.y = this.navigateTabPanel.y + this.navigateTabPanel.height + MARGIN;
        local12.x = WINDOW_MARGIN;
        this.tabViews[SettingsCategoryEnum.ACCOUNT] = local12;
      }
      var local11:ControlSettingsTab = new ControlSettingsTab();
      local11.y = this.navigateTabPanel.y + this.navigateTabPanel.height + MARGIN;
      local11.x = WINDOW_MARGIN;
      this.tabViews[SettingsCategoryEnum.CONTROL] = local11;
      this.navigateTabPanel.selectTabButton(SettingsCategoryEnum.GAME);
      this.closeButton = new DefaultButtonBase();
      addChild(this.closeButton);
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      this.closeButton.x = WINDOW_WIDTH - this.closeButton.width - WINDOW_MARGIN;
      this.closeButton.y = WINDOW_HEIGHT - this.closeButton.height - WINDOW_MARGIN;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseClick);
      local7.height = WINDOW_HEIGHT;
    }

    private function tabSelected(param1:SelectTabEvent) : void {
      if(this.currentTab != null && contains(this.currentTab)) {
        this.currentTab.hide();
        removeChild(this.currentTab);
      }
      var local2:SettingsTabView = this.tabViews[param1.getSelectedCategory()];
      if(local2 != null) {
        this.currentTab = local2;
        addChild(this.currentTab);
        this.currentTab.show();
      }
    }

    public function show() : void {
      dialogService.addDialog(this);
    }

    private function onCloseClick(param1:MouseEvent = null) : void {
      this.closeSettingWindow();
    }

    private function closeSettingWindow() : void {
      helperService.hideAllHelpers();
      dispatchEvent(new SettingsWindowEvent(SettingsWindowEvent.CLOSE_SETTINGS));
    }

    public function getAccountSettings() : AccountSettingsTab {
      return this.tabViews[SettingsCategoryEnum.ACCOUNT];
    }

    override protected function cancelKeyPressed() : void {
      this.closeSettingWindow();
    }

    public function destroy() : void {
      var local1:SettingsTabView = null;
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseClick);
      userChangeGameScreenService.settingsWindowClosed();
      this.navigateTabPanel.removeEventListener(SelectTabEvent.SELECT_SETTING_TAB,this.tabSelected);
      this.navigateTabPanel.destroy();
      for each(local1 in this.tabViews) {
        local1.destroy();
      }
      dialogService.removeDialog(this);
      display.stage.focus = null;
    }
  }
}
