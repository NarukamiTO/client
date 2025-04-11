package alternativa.tanks.gui.friends.list.renderer {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.friends.FriendActionIndicator;
  import alternativa.tanks.gui.friends.list.renderer.background.RendererBackGroundIncomingList;
  import controls.base.LabelBase;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.ColorConstants;
  import forms.userlabel.UserLabel;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import services.contextmenu.IContextMenuService;

  public class FriendsIncomingListRenderer extends CellRenderer {
    [Inject]
    public static var contextMenuService:IContextMenuService;

    [Inject]
    public static var localeService:ILocaleService;

    private var _labelsContainer:DisplayObject;
    private var _userLabel:UserLabel;
    private var _acceptRequestIndicator:FriendActionIndicator;
    private var _rejectRequestIndicator:FriendActionIndicator;
    private var _isNewLabel:LabelBase;

    public function FriendsIncomingListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      _data = param1;
      mouseEnabled = false;
      mouseChildren = true;
      buttonMode = useHandCursor = false;
      var local2:RendererBackGroundIncomingList = new RendererBackGroundIncomingList(false);
      var local3:RendererBackGroundIncomingList = new RendererBackGroundIncomingList(true);
      setStyle("upSkin",local2);
      setStyle("downSkin",local2);
      setStyle("overSkin",local2);
      setStyle("selectedUpSkin",local3);
      setStyle("selectedOverSkin",local3);
      setStyle("selectedDownSkin",local3);
      this._labelsContainer = this.createLabels(_data);
      if(this._acceptRequestIndicator == null) {
        this._acceptRequestIndicator = new FriendActionIndicator(FriendActionIndicator.YES);
        addChild(this._acceptRequestIndicator);
      }
      this._acceptRequestIndicator.visible = false;
      if(this._rejectRequestIndicator == null) {
        this._rejectRequestIndicator = new FriendActionIndicator(FriendActionIndicator.NO);
        addChild(this._rejectRequestIndicator);
      }
      this._rejectRequestIndicator.visible = false;
      if(this._isNewLabel == null) {
        this._isNewLabel = new LabelBase();
        this._isNewLabel.text = localeService.getText(TanksLocale.TEXT_FRIENDS_NEW) + "!";
        this._isNewLabel.height = 18;
        this._isNewLabel.y = -1;
        this._isNewLabel.color = ColorConstants.GREEN_LABEL;
        addChild(this._isNewLabel);
        this._isNewLabel.mouseEnabled = false;
      }
      this._isNewLabel.visible = _data.isNew;
      this.addEventListener(Event.RESIZE,this.onResize,false,0,true);
      this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver,false,0,true);
      this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut,false,0,true);
      this.resize();
      this._acceptRequestIndicator.addEventListener(MouseEvent.CLICK,this.onClickAcceptRequest,false,0,true);
      this._rejectRequestIndicator.addEventListener(MouseEvent.CLICK,this.onClickRejectRequest,false,0,true);
    }

    private function onResize(param1:Event) : void {
      this.resize();
    }

    private function resize() : void {
      this._rejectRequestIndicator.x = _width - this._rejectRequestIndicator.width - 6;
      this._acceptRequestIndicator.x = this._rejectRequestIndicator.x - this._acceptRequestIndicator.width - 1;
      this._isNewLabel.x = _width - this._isNewLabel.width - 6;
    }

    private function createLabels(param1:Object) : Sprite {
      var local2:Sprite = new Sprite();
      if(param1.id != null) {
        this._userLabel = new UserLabel(param1.id);
        this._userLabel.x = -3;
        this._userLabel.y = -1;
        local2.addChild(this._userLabel);
        this._userLabel.setUidColor(ColorConstants.GREEN_LABEL);
      }
      return local2;
    }

    private function onRollOver(param1:MouseEvent) : void {
      this._acceptRequestIndicator.visible = true;
      this._rejectRequestIndicator.visible = true;
      if(Boolean(_data.isNew)) {
        this._isNewLabel.visible = false;
      }
      super.selected = true;
    }

    private function onRollOut(param1:MouseEvent) : void {
      this._acceptRequestIndicator.visible = false;
      this._rejectRequestIndicator.visible = false;
      if(Boolean(_data.isNew)) {
        this._isNewLabel.visible = true;
      }
      super.selected = false;
    }

    private function onClickAcceptRequest(param1:MouseEvent) : void {
      contextMenuService.acceptRequest(this._userLabel.userId,this._userLabel.uid);
    }

    private function onClickRejectRequest(param1:MouseEvent) : void {
      contextMenuService.rejectRequest(this._userLabel.userId,this._userLabel.uid);
    }

    override public function set listData(param1:ListData) : void {
      _listData = param1;
      label = _listData.label;
      if(this._labelsContainer != null) {
        setStyle("icon",this._labelsContainer);
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
