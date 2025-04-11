package alternativa.tanks.gui.settings.tabs.game {
  import alternativa.tanks.gui.settings.SettingsWindow;
  import alternativa.tanks.gui.settings.tabs.SettingsTabView;
  import alternativa.tanks.gui.settings.tabs.SoundSettingsTab;
  import alternativa.tanks.service.settings.SettingEnum;
  import controls.Label;
  import controls.TankWindowInner;
  import controls.checkbox.CheckBoxBase;
  import controls.containers.StackPanel;
  import controls.containers.VerticalStackPanel;
  import flash.events.MouseEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;

  public class GameSettingsTab extends SettingsTabView {
    [Inject]
    public static var battleInviteService:IBattleInviteService;

    private var cbReceivePersonalMessagesOnlyFromFriends:CheckBoxBase;
    private var cbReceiveBattleInvite:CheckBoxBase;
    private var soundTab:SoundSettingsTab;

    public function GameSettingsTab(param1:Boolean) {
      super();
      var local2:VerticalStackPanel = new VerticalStackPanel();
      local2.x = MARGIN;
      local2.y = MARGIN;
      local2.setMargin(MARGIN);
      local2.addItem(createCheckBox(SettingEnum.SHOW_DAMAGE,localeService.getText(TanksLocale.TEXT_SHOW_DAMAGE),settingsService.showDamage));
      local2.addItem(createCheckBox(SettingEnum.SHOW_DROP_ZONES,localeService.getText(TanksLocale.TEXT_SETTINGS_SHOW_DROP_ZONES_LABEL_TEXT),settingsService.showDropZones));
      local2.addItem(createCheckBox(SettingEnum.ALTERNATE_CAMERA,localeService.getText(TanksLocale.TEXT_SETTINGS_ALTERNATE_CAMERA_LABEL_TEXT),settingsService.alternateCamera));
      local2.addItem(createCheckBox(SettingEnum.SHOW_LOCAL_DRONE,localeService.getText(TanksLocale.TEXT_SETTINGS_SHOW_LOCAL_DRONE),settingsService.showLocalDrone));
      local2.addItem(createCheckBox(SettingEnum.RECEIVE_PRESENTS,localeService.getText(TanksLocale.TEXT_SETTINGS_RECEIVE_PRESENTS),settingsService.receivePresents));
      var local3:VerticalStackPanel = new VerticalStackPanel();
      local3.setMargin(MARGIN);
      local3.y = MARGIN;
      local3.x = SettingsWindow.TAB_VIEW_MAX_WIDTH * 0.5;
      this.cbReceivePersonalMessagesOnlyFromFriends = this.createCheckBoxWithoutAutoSave(localeService.getText(TanksLocale.TEXT_SETTINGS_MESSAGE_ONLY_FROM_FRIENDS),param1);
      this.cbReceivePersonalMessagesOnlyFromFriends.addEventListener(MouseEvent.CLICK,this.onReceivePersonalMessagesOnlyFromFriendsClick);
      local3.addItem(this.cbReceivePersonalMessagesOnlyFromFriends);
      local3.addItem(createCheckBox(SettingEnum.SHOW_CHAT,localeService.getText(TanksLocale.TEXT_SETTINGS_SHOW_CHAT_CHECKBOX_LABEL_TEXT),settingsService.showChat));
      this.cbReceiveBattleInvite = this.createCheckBoxWithoutAutoSave(localeService.getText(TanksLocale.TEXT_SHOW_NOTIFICATIONS_LABEL),battleInviteService.receiveBattleInvite);
      this.cbReceiveBattleInvite.addEventListener(MouseEvent.CLICK,this.onReceiveBattleInviteClick);
      local3.addItem(this.cbReceiveBattleInvite);
      local3.addItem(createCheckBox(SettingEnum.SHOW_REMOTE_DRONES,localeService.getText(TanksLocale.TEXT_SETTINGS_SHOW_REMOTE_DRONES),settingsService.showRemoteDrones));
      var local4:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,local2.height + 2 * MARGIN,TankWindowInner.TRANSPARENT);
      local4.addChild(local2);
      local4.addChild(local3);
      addChild(local4);
      var local5:StackPanel = this.createSoundPanel();
      local5.y = local4.y + local4.height + MARGIN_BEFORE_PARTITION_LABEL;
      addChild(local5);
    }

    private function createSoundPanel() : StackPanel {
      var local1:VerticalStackPanel = new VerticalStackPanel();
      local1.setMargin(MARGIN_AFTER_PARTITION_LABEL);
      var local2:Label = new Label();
      local2.text = localeService.getText(TanksLocale.TEXT_SETTINGS_SOUND_VOLUME_LABEL_TEXT);
      local1.addItem(local2);
      this.soundTab = new SoundSettingsTab();
      local1.addItem(this.soundTab);
      return local1;
    }

    private function onReceiveBattleInviteClick(param1:MouseEvent) : void {
      battleInviteService.receiveBattleInvite = this.cbReceiveBattleInvite.checked;
    }

    private function onReceivePersonalMessagesOnlyFromFriendsClick(param1:MouseEvent) : void {
      dispatchEvent(new ReceivePersonalMessagesSettingEvent(ReceivePersonalMessagesSettingEvent.RECEIVE_PERSONAL_MESSAGES_CHANGE,this.cbReceivePersonalMessagesOnlyFromFriends.checked));
    }

    protected function createCheckBoxWithoutAutoSave(param1:String, param2:Boolean, param3:int = 0, param4:int = 0) : CheckBoxBase {
      var local5:CheckBoxBase = new CheckBoxBase();
      local5.checked = param2;
      local5.x = param3;
      local5.y = param4;
      local5.label = param1;
      return local5;
    }

    override public function destroy() : void {
      this.cbReceiveBattleInvite.removeEventListener(MouseEvent.CLICK,this.onReceiveBattleInviteClick);
      this.cbReceivePersonalMessagesOnlyFromFriends.removeEventListener(MouseEvent.CLICK,this.onReceivePersonalMessagesOnlyFromFriendsClick);
      this.soundTab.destroy();
      super.destroy();
    }
  }
}
