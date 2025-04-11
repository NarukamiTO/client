package alternativa.tanks.gui.notinclan.clanslist {
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.DeleteIndicator;
  import alternativa.tanks.gui.notinclan.dialogs.ClanDialog;
  import alternativa.tanks.models.clan.info.ClanInfoDelayed;
  import alternativa.tanks.models.clan.info.IClanInfoModel;
  import alternativa.tanks.models.user.ClanUserService;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import controls.base.LabelBase;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import forms.userlabel.UserLabel;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;

  public class ClanInfoLabel extends DiscreteSprite {
    [Inject]
    public static var clanUserService:ClanUserService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    private var nameLabel:LabelBase;
    private var tagLabel:LabelBase;
    private var clanCreatorLabel:UserLabel;
    private var usersCountLabel:LabelBase;
    private var creationDateLabel:LabelBase;

    protected var cancelIndicator:DeleteIndicator;

    public var clanId:Long;

    private var _width:Number = 0;

    public function ClanInfoLabel(param1:Long) {
      super();
      this.clanId = param1;
      var local2:IGameObject = clanUserService.getObjectById(param1);
      if(local2 != null) {
        this.onModelInfoLoaded();
      } else {
        ClanInfoDelayed.getInstance().addEventListener(ClanInfoDelayed.EVENT_PREFIX + param1.toString(),this.onModelInfoLoaded);
      }
    }

    protected function onModelInfoLoaded(param1:Event = null) : void {
      ClanInfoDelayed.getInstance().removeEventListener(ClanInfoDelayed.EVENT_PREFIX + this.clanId.toString(),this.onModelInfoLoaded);
      var local2:IGameObject = clanUserService.getObjectById(this.clanId);
      var local3:IClanInfoModel = local2.adapt(IClanInfoModel) as IClanInfoModel;
      this.nameLabel = this.createLabel();
      this.nameLabel.text = local3.getClanName();
      addChild(this.nameLabel);
      this.tagLabel = this.createLabel();
      this.tagLabel.text = local3.getClanTag();
      addChild(this.tagLabel);
      this.clanCreatorLabel = new UserLabel(local3.getCreatorId(),false);
      addChild(this.clanCreatorLabel);
      this.usersCountLabel = this.createLabel();
      this.usersCountLabel.text = local3.getUsersCount().toString();
      addChild(this.usersCountLabel);
      this.creationDateLabel = this.createLabel();
      this.creationDateLabel.text = DateFormatter.formatDateToLocalized(new Date(local3.getCreateTime()));
      addChild(this.creationDateLabel);
      this.cancelIndicator = new DeleteIndicator();
      addChild(this.cancelIndicator);
      this.cancelIndicator.visible = false;
      this.cancelIndicator.addEventListener(MouseEvent.CLICK,this.onCancelClick,false,0,true);
      addEventListener(MouseEvent.ROLL_OVER,this.onRollOver,false,0,true);
      addEventListener(MouseEvent.ROLL_OUT,this.onRollOut,false,0,true);
      this.resize();
      this.onRollOut();
    }

    private function createLabel() : LabelBase {
      var local1:LabelBase = new LabelBase();
      local1.align = TextFormatAlign.LEFT;
      local1.autoSize = TextFieldAutoSize.LEFT;
      local1.color = ColorConstants.GREEN_LABEL;
      return local1;
    }

    public function onRollOut(param1:MouseEvent = null) : void {
      if(parent != null) {
        ClansListRenderer(parent).onRollOut();
        this.hideIndicators();
      }
    }

    public function onRollOver(param1:MouseEvent = null) : void {
      if(parent != null) {
        ClansListRenderer(parent).onRollOver();
        this.showIndicators();
      }
    }

    public function showIndicators() : void {
      this.cancelIndicator.visible = true;
    }

    public function hideIndicators() : void {
      this.cancelIndicator.visible = false;
    }

    public function resize() : void {
      if(this.nameLabel == null) {
        return;
      }
      var local1:Vector.<Number> = ClansListHeader.tabs;
      var local2:Number = this.width - 2 * ClanDialog.MARGIN;
      this.nameLabel.x = 0;
      this.nameLabel.width = local2 * local1[0];
      this.tagLabel.x = this.nameLabel.x + local2 * local1[0] + 5;
      this.tagLabel.width = local2 * local1[1];
      this.clanCreatorLabel.x = this.tagLabel.x + local2 * local1[1] + 5;
      this.usersCountLabel.x = this.clanCreatorLabel.x + local2 * local1[2] + 5;
      this.usersCountLabel.width = local2 * local1[3];
      this.creationDateLabel.x = this.usersCountLabel.x + local2 * local1[3] + 3;
      this.creationDateLabel.width = local2 * local1[4];
      this.setIndicatorPosition();
      graphics.clear();
      graphics.beginFill(16711680,0);
      graphics.drawRect(0,0,local2,20);
      graphics.endFill();
    }

    private function setIndicatorPosition() : void {
      if(this.cancelIndicator != null) {
        this.cancelIndicator.x = this.width - this.cancelIndicator.width - 8;
        this.cancelIndicator.y = 1;
      }
    }

    protected function onCancelClick(param1:MouseEvent) : void {
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.resize();
    }
  }
}
