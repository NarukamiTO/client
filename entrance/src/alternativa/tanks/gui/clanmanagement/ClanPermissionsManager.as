package alternativa.tanks.gui.clanmanagement {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.ContextMenuPermissionLabel;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.IClanActionListener;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.IClanPositionListener;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.members.HeaderClanMemberList;
  import alternativa.tanks.models.clan.membersdata.ClanMembersDataService;
  import alternativa.tanks.models.clan.permission.IClanPermissionsModel;
  import alternativa.tanks.models.service.ClanService;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import controls.TankWindow;
  import controls.TankWindowInner;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import projects.tanks.client.clans.clan.clanmembersdata.UserData;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.KeyUpListenerPriority;

  public class ClanPermissionsManager extends DiscreteSprite implements IClanPositionListener, IClanActionListener {
    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var clanMembersDataService:ClanMembersDataService;

    private static var menu:ClanPermissionsManager;

    public static var permissionsModel:IClanPermissionsModel;

    private static var currentId:Long;
    private static var positionUpdateListeners:Vector.<IClanPositionListener> = new Vector.<IClanPositionListener>();

    private static const MARGIN:int = 6;

    private var window:TankWindow;
    private var windowInner:TankWindowInner;
    private var id:Long;
    private var numPositions:int = 0;

    public function ClanPermissionsManager(param1:Long, param2:Long) {
      super();
      this.id = param1;
      currentId = param2;
      this.window = new TankWindow();
      addChild(this.window);
      this.windowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.windowInner.x = MARGIN;
      this.windowInner.y = MARGIN;
      this.window.addChild(this.windowInner);
      this.createPermissions(clanMembersDataService.getPermission(param2));
      addPositionUpdateListener(this);
      ClanActionsManager.addActionsUpdateListener(this);
      addEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
      display.stage.addEventListener(MouseEvent.CLICK,this.onContextMenuClick);
      display.stage.addEventListener(Event.DEACTIVATE,this.onContextMenuDeactivate);
      display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,KeyUpListenerPriority.CONTEXT_MENU);
    }

    public static function resize(param1:int) : void {
      if(menu != null) {
        menu.resize(param1);
      }
    }

    public static function setScreenPosition(param1:ContextMenuPermissionLabel) : void {
      var local2:Point = null;
      if(menu != null && menu.id == param1.userId) {
        local2 = param1.localToGlobal(new Point(0,0));
        menu.setScreenPosition(local2);
      }
    }

    public static function addPositionUpdateListener(param1:IClanPositionListener) : void {
      positionUpdateListeners.push(param1);
    }

    public static function removePositionListener(param1:IClanPositionListener) : void {
      var local2:int = int(positionUpdateListeners.indexOf(param1));
      if(local2 >= 0) {
        positionUpdateListeners.splice(local2,1);
      }
    }

    public static function removePositionListeners() : void {
      positionUpdateListeners = new Vector.<IClanPositionListener>();
    }

    public static function updatePositions(param1:UserData) : void {
      var local2:IClanPositionListener = null;
      for each(local2 in positionUpdateListeners) {
        if(local2.userId == param1.userId) {
          local2.dataChanged(param1);
        }
      }
      ClanActionsManager.updateActions();
    }

    public static function show(param1:Long, param2:Long, param3:ContextMenuPermissionLabel) : void {
      if(menu != null) {
        remove();
      }
      menu = new ClanPermissionsManager(param1,param2);
      menu.setScreenPosition(param3.localToGlobal(new Point(0,0)));
      menu.resize(HeaderClanMemberList.getPositionColumnWidth());
      display.stage.addChild(menu);
    }

    private static function remove() : void {
      menu.parent.removeChild(menu);
      menu.removeListeners();
      menu = null;
    }

    private static function permissionByValue(param1:int) : ClanPermission {
      var local2:ClanPermission = null;
      for each(local2 in ClanPermission.values) {
        if(local2.value == param1) {
          return local2;
        }
      }
      return null;
    }

    public static function removeListeners() : void {
      positionUpdateListeners = new Vector.<IClanPositionListener>();
    }

    private function onContextMenuClick(param1:MouseEvent) : void {
      if(param1.target.parent != null && param1.target.parent as ContextMenuPermissionLabel == null) {
        remove();
      }
    }

    private function onContextMenuDeactivate(param1:Event) : void {
      remove();
    }

    private function mouseOut(param1:MouseEvent) : void {
      remove();
    }

    private function onKeyUp(param1:KeyboardEvent) : void {
      if(AlertUtils.isCancelKey(param1.keyCode)) {
        param1.stopImmediatePropagation();
        remove();
      }
    }

    public function dataChanged(param1:UserData) : void {
      remove();
    }

    public function updateActions() : void {
      remove();
    }

    private function createPermissions(param1:ClanPermission) : void {
      var local4:ContextMenuPermissionLabel = null;
      var local2:int = 0;
      var local3:int = param1.value + 1;
      while(local3 < ClanPermission.values.length - 1) {
        local4 = ContextMenuPermissionLabel.createPositionLabel(permissionByValue(local3));
        local4.y = local2;
        local4.addEventListener(MouseEvent.CLICK,this.onPickPosition,false,0,true);
        this.windowInner.addChild(local4);
        local2 += ContextMenuPermissionLabel.HEIGHT;
        ++this.numPositions;
        local3++;
      }
    }

    private function onPickPosition(param1:MouseEvent) : void {
      var local2:ContextMenuPermissionLabel = null;
      if(Boolean(clanUserInfoService.hasAction(ClanAction.PERMISSION_DISTRIBUTION)) && param1.target.parent != null && param1.target.parent as ContextMenuPermissionLabel != null) {
        local2 = param1.target.parent as ContextMenuPermissionLabel;
        permissionsModel.setPosition(menu.id,local2.permission);
        remove();
      }
    }

    public function setScreenPosition(param1:Point) : void {
      menu.x = param1.x - MARGIN;
      menu.y = param1.y - MARGIN;
      if(menu.y > display.stage.height - 60 - menu.height) {
        menu.y = display.stage.height - 60 - menu.height;
      }
    }

    public function resize(param1:int) : void {
      var local3:ContextMenuPermissionLabel = null;
      this.windowInner.width = param1;
      this.windowInner.height = ContextMenuPermissionLabel.HEIGHT * this.numPositions;
      var local2:int = 0;
      while(local2 < this.windowInner.numChildren) {
        if(this.windowInner.getChildAt(local2) is ContextMenuPermissionLabel) {
          local3 = ContextMenuPermissionLabel(this.windowInner.getChildAt(local2));
          local3.width = this.windowInner.width;
        }
        local2++;
      }
      this.window.width = param1 + 2 * MARGIN;
      this.window.height = 2 * MARGIN + this.windowInner.height;
    }

    public function removeListeners() : void {
      removePositionListener(this);
      ClanActionsManager.removeActionsListener(this);
      removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
      display.stage.removeEventListener(MouseEvent.CLICK,this.onContextMenuClick);
      display.stage.removeEventListener(Event.DEACTIVATE,this.onContextMenuDeactivate);
      display.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
    }

    public function get userId() : Long {
      return this.id;
    }
  }
}
