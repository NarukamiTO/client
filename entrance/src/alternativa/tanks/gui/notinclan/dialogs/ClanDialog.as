package alternativa.tanks.gui.notinclan.dialogs {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.ClanActionsManager;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.IClanActionListener;
  import alternativa.tanks.models.service.ClanService;
  import controls.base.DefaultButtonBase;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.TankWindowWithHeader;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class ClanDialog extends DialogWindow implements IClanActionListener {
    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var localeService:ILocaleService;

    public static const MARGIN:Number = 11;
    public static const SMALL_MARGIN:Number = 7;

    protected var closeButton:DefaultButtonBase;
    protected var window:TankWindowWithHeader;

    private var _width:Number;
    private var _height:Number;

    public function ClanDialog() {
      super();
      ClanActionsManager.addActionsUpdateListener(this);
      this.window = TankWindowWithHeader.createWindow(this.getImageHeaderId());
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      this.closeButton = new DefaultButtonBase();
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseClick);
      addChild(this.window);
      addChild(this.closeButton);
      this.window.width = this.width;
      this.window.height = this.height;
      this.closeButton.x = this.width - this.closeButton.width - MARGIN;
      this.closeButton.y = this.height - this.closeButton.height - MARGIN;
      dialogService.addDialog(this);
    }

    protected function getImageHeaderId() : String {
      return "";
    }

    protected function onAddedToStage(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    protected function onCloseClick(param1:MouseEvent) : void {
      display.stage.focus = null;
      this.destroy();
    }

    public function destroy() : void {
      ClanActionsManager.removeActionsListener(this);
      dialogService.removeDialog(this);
      this.removeEvents();
    }

    protected function removeEvents() : void {
    }

    override public function get width() : Number {
      return 0;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
    }

    override public function get height() : Number {
      return 0;
    }

    override public function set height(param1:Number) : void {
      this._height = param1;
    }

    public function updateActions() : void {
    }

    override public function forciblyClose() : void {
      display.stage.focus = null;
      this.destroy();
    }
  }
}
