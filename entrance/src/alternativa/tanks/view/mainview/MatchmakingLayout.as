package alternativa.tanks.view.mainview {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.controllers.mainview.MatchmakingGroupEvent;
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.service.matchmaking.MatchmakingGroupInviteService;
  import alternativa.tanks.view.mainview.grouplist.GroupList;
  import alternativa.tanks.view.matchmaking.quest.QuestButton;
  import alternativa.types.Long;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.buttons.IconButton;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.utils.Dictionary;
  import forms.TankWindowWithHeader;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MatchmakingUserData;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MountItemsUserData;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.UserPropertiesServiceEvent;
  import services.buttonbar.IButtonBarService;

  public class MatchmakingLayout extends Sprite {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var groupInviteService:MatchmakingGroupInviteService;

    [Inject]
    public static var buttonBarService:IButtonBarService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var matchmakingGroupService:MatchmakingGroupService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var achievementService:IAchievementService;

    private static const MIN_FLASH_WIDTH:int = 970;
    private static const MIN_FLASH_HEIGHT:int = 530;
    private static const HEADER_HEIGHT:int = 60;
    private static const DAILY_QUEST_BUTTON_TYPE:int = 10;
    private static const groupIconClass:Class = MatchmakingLayout_groupIconClass;

    private var window:TankWindowWithHeader;
    private var inner:TankWindowInner;
    private var groupButton:IconButton = new IconButton(localeService.getText(TanksLocale.TEXT_GROUP_BUTTON),groupIconClass);
    private var dailyQuestButton:IconButton = new QuestButton();
    private var leaveGroupButton:DefaultButtonBase = new DefaultButtonBase();
    private var groupView:GroupList = new GroupList();
    private var buttonsPanel:BattleTypesPanel;
    private var withGroupView:Boolean = false;
    private var isLeader:Boolean;

    public function MatchmakingLayout(param1:Dictionary, param2:HolidayParams, param3:int) {
      super();
      this.buttonsPanel = new BattleTypesPanel(param1,param2,param3);
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_BATTLES);
      addChild(this.window);
      this.inner = new TankWindowInner(100,100,TankWindowInner.GREEN);
      this.inner.showBlink = true;
      this.inner.x = 11;
      this.inner.y = 48;
      addChild(this.inner);
      this.dailyQuestButton.visible = userPropertiesService.isQuestsAvailableByRank();
      this.dailyQuestButton.x = 11;
      this.dailyQuestButton.y = 11;
      this.dailyQuestButton.width = 95;
      addChild(this.dailyQuestButton);
      this.dailyQuestButton.addEventListener(MouseEvent.CLICK,this.onDailyQuestButtonClick);
      this.groupButton.x = this.dailyQuestButton.visible ? this.dailyQuestButton.x + this.dailyQuestButton.width + 5 : 11;
      this.groupButton.y = this.dailyQuestButton.y;
      this.groupButton.width = 95;
      addChild(this.groupButton);
      this.groupButton.visible = userPropertiesService.canUseGroup();
      this.groupButton.addEventListener(MouseEvent.CLICK,this.onCreateGroupClick);
      this.buttonsPanel.setSpectatorsButtonVisible(userPropertiesService.hasSpectatorPermissions());
      this.leaveGroupButton.y = 11;
      this.leaveGroupButton.width = 110;
      this.leaveGroupButton.label = localeService.getText(TanksLocale.TEXT_LEAVE_GROUP_BUTTON);
      addChild(this.leaveGroupButton);
      this.leaveGroupButton.addEventListener(MouseEvent.CLICK,this.onLeaveGroupClick);
      this.leaveGroupButton.visible = false;
      this.inner.addChild(this.groupView);
      this.groupView.x = 11;
      this.groupView.y = 12;
      this.groupView.visible = false;
      this.inner.addChild(this.buttonsPanel);
      userPropertiesService.addEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.onUpdateRank);
      userPropertiesService.addEventListener(UserPropertiesServiceEvent.ON_INIT_USER_PROPERTIES,this.onInitProperties);
    }

    private function onInitProperties(param1:UserPropertiesServiceEvent) : void {
      userPropertiesService.removeEventListener(UserPropertiesServiceEvent.ON_INIT_USER_PROPERTIES,this.onInitProperties);
      this.groupButton.visible = userPropertiesService.canUseGroup();
      this.buttonsPanel.setSpectatorsButtonVisible(userPropertiesService.hasSpectatorPermissions());
    }

    private function onUpdateRank(param1:UserPropertiesServiceEvent) : void {
      if(userPropertiesService.isQuestsAvailableByRank()) {
        userPropertiesService.removeEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.onUpdateRank);
        this.dailyQuestButton.visible = true;
        this.groupButton.x = this.dailyQuestButton.x + this.dailyQuestButton.width + 5;
      }
      this.groupButton.visible = userPropertiesService.canUseGroup();
    }

    public function show() : void {
      if(!this.getContainer().contains(this)) {
        this.resize();
        this.setEvents();
        this.getContainer().addChild(this);
      }
    }

    public function hide() : void {
      if(this.getContainer().contains(this)) {
        this.removeEvents();
        this.hideGroupView();
        this.getContainer().removeChild(this);
        achievementService.setBattleStartButtonTargetPoint(new Point(-1000,-1000));
      }
    }

    public function showGroupView(param1:Vector.<MatchmakingUserData>, param2:Boolean) : void {
      this.withGroupView = true;
      this.leaveGroupButton.visible = true;
      this.groupButton.enabled = false;
      this.groupView.fillMembersList(param1);
      this.groupView.visible = true;
      this.isLeader = param2;
      this.buttonsPanel.userEntersGroup(param2 && this.allUsersReadyForBattle(param1));
      this.resize();
    }

    public function hideGroupView() : void {
      this.withGroupView = false;
      this.leaveGroupButton.visible = false;
      this.groupButton.enabled = true;
      this.groupView.removeAllUsers();
      this.groupView.visible = false;
      this.buttonsPanel.userLeavesGroup();
      this.resize();
    }

    public function addUserToGroup(param1:MatchmakingUserData) : void {
      this.groupView.addUser(param1);
    }

    public function removeUserFromGroup(param1:Long) : void {
      this.groupView.removeUser(param1);
      this.tryUnlockBattleButtons();
    }

    public function showUserReady(param1:Long) : void {
      this.groupView.showUserReady(param1);
      this.tryUnlockBattleButtons();
    }

    private function tryUnlockBattleButtons() : void {
      if(this.groupView.isEveryoneReady() && this.isLeader) {
        this.buttonsPanel.unlockBattleButtons();
      }
    }

    public function showUserNotReady(param1:Long) : void {
      this.groupView.showUserNotReady(param1);
      this.buttonsPanel.lockBattleButtons();
    }

    public function updateMountedItem(param1:MountItemsUserData) : void {
      this.groupView.updateMountedItem(param1);
    }

    private function onCreateGroupClick(param1:MouseEvent) : void {
      this.groupButton.enabled = false;
      dispatchEvent(new MatchmakingGroupEvent(MatchmakingGroupEvent.CREATE));
    }

    private function onDailyQuestButtonClick(param1:MouseEvent) : void {
      buttonBarService.change(DAILY_QUEST_BUTTON_TYPE);
    }

    private function onLeaveGroupClick(param1:MouseEvent) : void {
      matchmakingGroupService.removeUsers();
      this.leaveGroupButton.enabled = false;
      dispatchEvent(new MatchmakingGroupEvent(MatchmakingGroupEvent.LEAVE));
    }

    private function setEvents() : void {
      this.getStage().addEventListener(Event.RESIZE,this.onResize);
    }

    private function removeEvents() : void {
      this.getStage().removeEventListener(Event.RESIZE,this.onResize);
    }

    private function onResize(param1:Event) : void {
      this.resize();
    }

    private function resize() : void {
      var local1:int = Math.max(MIN_FLASH_WIDTH,this.getStage().stageWidth) / 3 * 2;
      var local2:int = Math.max(this.getStage().stageHeight - HEADER_HEIGHT,MIN_FLASH_HEIGHT);
      this.window.width = local1;
      this.window.height = local2;
      this.x = local1 / 2;
      this.y = HEADER_HEIGHT;
      this.inner.width = local1 - 22;
      this.inner.height = local2 - 63;
      this.leaveGroupButton.x = this.window.width - this.leaveGroupButton.width - 11;
      this.groupView.resize(local1 - 44,125);
      this.buttonsPanel.resize(local1 - 17,local2 - 69 - (this.withGroupView ? 137 : 0));
      this.buttonsPanel.x = 0;
      this.buttonsPanel.y = this.withGroupView ? 135 : 3;
    }

    private function getContainer() : DisplayObjectContainer {
      return display.systemLayer;
    }

    private function getStage() : Stage {
      return display.stage;
    }

    private function allUsersReadyForBattle(param1:Vector.<MatchmakingUserData>) : Boolean {
      var local2:MatchmakingUserData = null;
      for each(local2 in param1) {
        if(!local2.userIsReady) {
          return false;
        }
      }
      return true;
    }
  }
}
