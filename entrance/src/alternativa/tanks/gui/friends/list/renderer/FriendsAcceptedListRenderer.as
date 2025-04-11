package alternativa.tanks.gui.friends.list.renderer {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.friends.FriendActionIndicator;
  import alternativa.tanks.gui.friends.battleLink.BattleLink;
  import alternativa.tanks.gui.friends.list.renderer.background.RendererBackGroundAcceptedList;
  import controls.base.LabelBase;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import forms.ColorConstants;
  import forms.contextmenu.BattleInviteContextMenuLabel;
  import forms.userlabel.UserLabel;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
  import services.contextmenu.IContextMenuService;

  public class FriendsAcceptedListRenderer extends CellRenderer {
    [Inject]
    public static var battleLinkActivatorService:IBattleLinkActivatorService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var contextMenuService:IContextMenuService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    public static const ROW_HEIGHT:int = 18;
    public static const ICON_RIGHT_OFFSET:int = 195;

    private static var gradientGreenIconClass:Class = FriendsAcceptedListRenderer_gradientGreenIconClass;
    private static var gradientGreenBitmapData:BitmapData = Bitmap(new gradientGreenIconClass()).bitmapData;
    private static var gradientGreyIconClass:Class = FriendsAcceptedListRenderer_gradientGreyIconClass;
    private static var gradientGreyBitmapData:BitmapData = Bitmap(new gradientGreyIconClass()).bitmapData;
    private static var socialFriendClass:Class = FriendsAcceptedListRenderer_socialFriendClass;
    private static var socialFriendBitmapData:BitmapData = Bitmap(new socialFriendClass()).bitmapData;
    private static var referralFriendClass:Class = FriendsAcceptedListRenderer_referralFriendClass;
    private static var referralFriendBitmapData:BitmapData = Bitmap(new referralFriendClass()).bitmapData;

    private var labelsContainer:DisplayObject;
    private var userLabel:UserLabel;
    private var battleLink:BattleLink;
    private var removeFriendsIndicator:FriendActionIndicator;
    private var isNewLabel:LabelBase;
    private var gradientGreen:Bitmap;
    private var gradientGrey:Bitmap;
    private var battleInviteIcon:Bitmap;
    private var socialFriendIcon:Bitmap;
    private var referralFriendIcon:Bitmap;

    public function FriendsAcceptedListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      _data = param1;
      mouseEnabled = false;
      mouseChildren = true;
      buttonMode = useHandCursor = false;
      this.labelsContainer = this.createLabels(_data);
      var local2:DisplayObject = new RendererBackGroundAcceptedList(this.userLabel.online);
      var local3:DisplayObject = new RendererBackGroundAcceptedList(this.userLabel.online,true);
      setStyle("upSkin",local2);
      setStyle("downSkin",local2);
      setStyle("overSkin",local2);
      setStyle("selectedUpSkin",local3);
      setStyle("selectedOverSkin",local3);
      setStyle("selectedDownSkin",local3);
    }

    private function createLabels(param1:Object) : Sprite {
      var local2:Sprite = new Sprite();
      if(param1.id != null) {
        if(this.battleInviteIcon == null) {
          this.battleInviteIcon = new Bitmap(BattleInviteContextMenuLabel.battleInviteBitmapData);
        }
        this.battleInviteIcon.x = 0;
        this.battleInviteIcon.y = (ROW_HEIGHT - this.battleInviteIcon.height) / 2;
        this.battleInviteIcon.visible = false;
        local2.addChild(this.battleInviteIcon);
        this.userLabel = new UserLabel(param1.id);
        this.userLabel.inviteBattleEnable = true;
        this.userLabel.x = this.battleInviteIcon.x + this.battleInviteIcon.width + 4;
        this.userLabel.y = 0;
        local2.addChild(this.userLabel);
        if(Boolean(param1.isNew)) {
          if(this.userLabel.online) {
            if(this.gradientGreen == null) {
              this.gradientGreen = new Bitmap(gradientGreenBitmapData);
            }
            this.gradientGreen.visible = true;
            local2.addChild(this.gradientGreen);
          } else {
            if(this.gradientGrey == null) {
              this.gradientGrey = new Bitmap(gradientGreyBitmapData);
            }
            this.gradientGrey.visible = true;
            local2.addChild(this.gradientGrey);
          }
          if(this.isNewLabel == null) {
            this.isNewLabel = new LabelBase();
            this.isNewLabel.text = localeService.getText(TanksLocale.TEXT_FRIENDS_NEW_FRIEND);
            this.isNewLabel.color = ColorConstants.GREEN_LABEL;
            this.isNewLabel.mouseEnabled = false;
          }
          this.isNewLabel.visible = true;
          this.isNewLabel.x = 223 - this.isNewLabel.width;
          this.isNewLabel.y = 0;
          local2.addChild(this.isNewLabel);
          if(this.gradientGreen != null) {
            this.gradientGreen.x = this.isNewLabel.x - 7;
          }
          if(this.gradientGrey != null) {
            this.gradientGrey.x = this.isNewLabel.x - 7;
          }
        } else {
          if(this.isNewLabel != null) {
            this.isNewLabel.visible = false;
          }
          if(this.gradientGreen != null) {
            this.gradientGreen.visible = false;
          }
          if(this.gradientGrey != null) {
            this.gradientGrey.visible = false;
          }
        }
        if(this.removeFriendsIndicator != null) {
          this.removeFriendsIndicator.removeEventListener(MouseEvent.CLICK,this.onClickRemoveFriend);
        }
        if(this.removeFriendsIndicator == null) {
          this.removeFriendsIndicator = new FriendActionIndicator(FriendActionIndicator.NO);
        }
        this.removeFriendsIndicator.visible = false;
        this.removeFriendsIndicator.x = 223 - this.removeFriendsIndicator.width;
        this.removeFriendsIndicator.y = 0;
        this.removeFriendsIndicator.addEventListener(MouseEvent.CLICK,this.onClickRemoveFriend,false,0,true);
        local2.addChild(this.removeFriendsIndicator);
        if(this.battleLink != null) {
          this.battleLink.removeEvents();
          this.battleLink.labelCont.removeEventListener(MouseEvent.CLICK,this.onBattleLinkClick);
        }
        this.battleLink = new BattleLink(param1.id);
        this.battleLink.labelCont.addEventListener(MouseEvent.CLICK,this.onBattleLinkClick,false,0,true);
        local2.addChild(this.battleLink);
        this.battleLink.x = 233;
        this.socialFriendIcon = new Bitmap(socialFriendBitmapData);
        this.socialFriendIcon.y = 5;
        this.socialFriendIcon.visible = Boolean(param1.isSNFriend) && !param1.isNew;
        local2.addChild(this.socialFriendIcon);
        this.referralFriendIcon = new Bitmap(referralFriendBitmapData);
        this.referralFriendIcon.y = 5;
        this.referralFriendIcon.visible = Boolean(param1.isReferral) && !param1.isNew;
        local2.addChild(this.referralFriendIcon);
        this.arrangeIcons();
        this.updateStatusOnline();
        this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver,false,0,true);
        this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut,false,0,true);
      }
      return local2;
    }

    private function arrangeIcons() : void {
      if(this.socialFriendIcon.visible) {
        this.socialFriendIcon.x = ICON_RIGHT_OFFSET - (this.socialFriendIcon.width >> 1);
        if(this.referralFriendIcon.visible) {
          this.referralFriendIcon.x = this.socialFriendIcon.x - 15;
        }
      } else {
        this.referralFriendIcon.x = ICON_RIGHT_OFFSET - (this.referralFriendIcon.width >> 1);
      }
    }

    private function updateStatusOnline() : void {
      _data.online = this.userLabel.online;
      this.userLabel.setUidColor(this.userLabel.online ? ColorConstants.GREEN_LABEL : ColorConstants.ACCESS_LABEL,true);
      this.battleInviteIcon.visible = this.userLabel.online && Boolean(_data.availableInvite);
    }

    private function onRollOver(param1:MouseEvent) : void {
      this.removeFriendsIndicator.visible = true;
      if(Boolean(_data.isNew)) {
        if(this.isNewLabel != null) {
          this.isNewLabel.visible = false;
        }
        if(this.userLabel.online) {
          if(this.gradientGreen != null) {
            this.gradientGreen.visible = false;
          }
        } else if(this.gradientGrey != null) {
          this.gradientGrey.visible = false;
        }
      }
      super.selected = true;
    }

    private function onRollOut(param1:MouseEvent) : void {
      this.removeFriendsIndicator.visible = false;
      if(Boolean(_data.isNew)) {
        if(this.isNewLabel != null) {
          this.isNewLabel.visible = true;
        }
        if(this.userLabel.online) {
          if(this.gradientGreen != null) {
            this.gradientGreen.visible = true;
          }
        } else if(this.gradientGrey != null) {
          this.gradientGrey.visible = true;
        }
      }
      super.selected = false;
    }

    private function onClickRemoveFriend(param1:MouseEvent) : void {
      contextMenuService.removeFromFriends(this.userLabel.userId,this.userLabel.uid);
    }

    private function onBattleLinkClick(param1:MouseEvent) : void {
      if(this.battleLink.hasData() && this.battleLink.data.isClickable()) {
        battleLinkActivatorService.navigateToBattleUrl(this.battleLink.data.getBattleData());
      }
    }

    override public function set listData(param1:ListData) : void {
      _listData = param1;
      label = _listData.label;
      if(this.labelsContainer != null) {
        setStyle("icon",this.labelsContainer);
      }
    }

    override protected function drawBackground() : void {
      var local1:String = enabled ? mouseState : "disabled";
      if(selected) {
        local1 = "selected" + local1.substr(0,1).toUpperCase() + local1.substr(1);
      }
      local1 += "Skin";
      var local2:DisplayObject = background;
      background = getDisplayObjectInstance(getStyleValue(local1));
      addChildAt(background,0);
      if(local2 != null && local2 != background) {
        removeChild(local2);
      }
    }

    override public function set selected(param1:Boolean) : void {
    }
  }
}
