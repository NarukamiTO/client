package controls.statassets {
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import forms.events.StatListEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class StatHeader extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    protected var tabs:Vector.<Number>;
    protected var headers:Vector.<String>;
    protected var _currentSort:int = 8;
    protected var _oldSort:int = 8;
    protected var _width:int = 800;

    public function StatHeader() {
      var local1:StatHeaderButton = null;
      var local2:int = 0;
      this.tabs = new Vector.<Number>();
      super();
      this.headers = Vector.<String>([localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_NUMBER),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_RANK),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_CALLSIGN),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_SCORE),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_KILLS),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_DEATHS),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_RATIO),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_WEALTH),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_RATING)]);
      local2 = 0;
      while(local2 < 9) {
        local1 = new StatHeaderButton(local2 < 1 || local2 > 2);
        local1.label = this.headers[local2];
        local1.height = 18;
        local1.numSort = local2;
        addChild(local1);
        if(local2 > 0) {
          local1.addEventListener(MouseEvent.CLICK,this.changeSort);
        }
        local2++;
      }
      this.draw();
    }

    override public function set width(param1:Number) : void {
      this._width = Math.floor(param1);
      this.draw();
    }

    protected function draw() : void {
      var local1:StatHeaderButton = null;
      var local2:int = int(this._width - 365);
      this.tabs = Vector.<Number>([0,55,180,local2,local2 + 60,local2 + 130,local2 + 180,local2 + 220,local2 + 285,this._width - 1]);
      var local3:int = 0;
      while(local3 < 9) {
        local1 = getChildAt(local3) as StatHeaderButton;
        local1.width = this.tabs[local3 + 1] - this.tabs[local3] - 2;
        local1.x = this.tabs[local3];
        local1.selected = local3 == this._currentSort;
        local3++;
      }
    }

    protected function changeSort(param1:MouseEvent) : void {
      var local2:StatHeaderButton = param1.currentTarget as StatHeaderButton;
      this._currentSort = local2.numSort;
      if(this._currentSort != this._oldSort) {
        this.draw();
        dispatchEvent(new StatListEvent(this._currentSort));
        this._oldSort = this._currentSort;
      }
    }
  }
}
