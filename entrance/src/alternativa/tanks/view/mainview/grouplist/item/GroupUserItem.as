package alternativa.tanks.view.mainview.grouplist.item {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.matchmaking.MatchmakingGroupInviteService;
  import alternativa.tanks.view.mainview.grouplist.header.GroupHeader;
  import controls.base.LabelBase;
  import controls.dropdownlist.DeleteEvent;
  import controls.dropdownlist.DeleteIndicator;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import forms.userlabel.UserLabel;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;

  public class GroupUserItem extends Sprite {
    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var matchmakingGroupService:MatchmakingGroupService;

    [Inject]
    public static var inviteService:MatchmakingGroupInviteService;

    [Inject]
    public static var localeService:ILocaleService;

    private var itemWidth:Number = 0;
    private var userLabel:UserLabel;
    private var weaponLabel:LabelBase;
    private var armorLabel:LabelBase;
    private var deleteIndicator:DeleteIndicator;
    private var deleteCanBeVisible:Boolean;

    public function GroupUserItem(param1:Object) {
      super();
      if(Boolean(param1.isInviteSlot)) {
        this.createInviteSlot();
        return;
      }
      this.userLabel = new UserLabel(param1.id);
      this.userLabel.inviteBattleEnable = false;
      this.userLabel.showClanProfile = false;
      this.userLabel.x = -4;
      this.userLabel.y = 1;
      addChild(this.userLabel);
      this.weaponLabel = this.createItemLabel(param1.weaponName);
      this.armorLabel = this.createItemLabel(param1.armorName);
      addChild(this.weaponLabel);
      addChild(this.armorLabel);
      this.deleteCanBeVisible = Boolean(matchmakingGroupService.isGroupInviteEnabled()) && param1.id != userInfoService.getCurrentUserId();
      if(this.deleteCanBeVisible) {
        this.deleteIndicator = new DeleteIndicator(param1);
        this.deleteIndicator.visible = false;
        this.deleteIndicator.y = 1;
        addEventListener(DeleteEvent.REMOVED,this.onClickDelete);
        addChild(this.deleteIndicator);
      }
    }

    private function createInviteSlot() : void {
      var local1:LabelBase = this.createItemLabel(localeService.getText(TanksLocale.TEXT_GROUP_INVITE_BUTTON));
      local1.buttonMode = true;
      local1.y += 1;
      local1.addEventListener(MouseEvent.CLICK,this.onInviteClick,false,0,true);
      addChild(local1);
    }

    private function onInviteClick(param1:MouseEvent) : void {
      inviteService.openInviteWindow();
    }

    private function onClickDelete(param1:DeleteEvent) : void {
      removeEventListener(DeleteEvent.REMOVED,this.onClickDelete);
      removeChild(this.deleteIndicator);
    }

    private function createItemLabel(param1:String) : LabelBase {
      var local2:LabelBase = new LabelBase();
      local2.color = ColorConstants.GREEN_LABEL;
      local2.autoSize = TextFieldAutoSize.LEFT;
      local2.align = TextFormatAlign.LEFT;
      local2.text = param1;
      local2.y = 1;
      return local2;
    }

    override public function set width(param1:Number) : void {
      this.itemWidth = param1;
      this.resize();
    }

    override public function get width() : Number {
      return this.itemWidth;
    }

    public function showDeleteIndicator() : void {
      if(this.deleteCanBeVisible) {
        this.deleteIndicator.visible = true;
      }
    }

    public function hideDeleteIndicator() : void {
      if(this.deleteCanBeVisible) {
        this.deleteIndicator.visible = false;
      }
    }

    private function resize() : void {
      var local1:int = 4;
      if(this.weaponLabel != null) {
        this.weaponLabel.x = GroupHeader.HEADER_INFOS[1].x - local1;
        this.armorLabel.x = GroupHeader.HEADER_INFOS[2].x - local1;
      }
      if(this.deleteCanBeVisible) {
        this.deleteIndicator.x = this.itemWidth - this.deleteIndicator.width - 7;
      }
      this.redraw();
    }

    private function redraw() : void {
      graphics.clear();
      graphics.beginFill(0,0);
      graphics.drawRect(0,0,this.itemWidth,20);
      graphics.endFill();
    }
  }
}
