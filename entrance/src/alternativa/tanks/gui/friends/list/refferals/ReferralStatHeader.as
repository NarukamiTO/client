package alternativa.tanks.gui.friends.list.refferals {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.statassets.*;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import forms.events.StatListEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ReferralStatHeader extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    protected var tabs:Vector.<Number>;
    protected var headers:Vector.<String>;
    protected var _currentSort:int = 1;
    protected var _oldSort:int = 1;
    protected var _width:int = 800;

    public function ReferralStatHeader() {
      var local2:StatHeaderButton = null;
      this.tabs = new Vector.<Number>();
      super();
      this.headers = Vector.<String>([localeService.getText(TanksLocale.TEXT_REFERAL_STATISTICS_HEADER_CALLSIGN),localeService.getText(TanksLocale.TEXT_REFERAL_STATISTICS_HEADER_INCOME)]);
      var local1:int = 0;
      while(local1 < 2) {
        local2 = new StatHeaderButton(local1 == 1);
        local2.label = this.headers[local1];
        local2.height = 18;
        local2.numSort = local1;
        local2.addEventListener(MouseEvent.CLICK,this.changeSort);
        addChild(local2);
        local1++;
      }
      this.draw();
    }

    protected function draw() : void {
      var local1:StatHeaderButton = null;
      this.tabs = Vector.<Number>([0,this._width - 120,this._width - 1]);
      var local2:int = 0;
      while(local2 < 2) {
        local1 = getChildAt(local2) as StatHeaderButton;
        local1.width = this.tabs[local2 + 1] - this.tabs[local2] - 2;
        local1.x = this.tabs[local2];
        local1.selected = local2 == this._currentSort;
        local2++;
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

    override public function set width(param1:Number) : void {
      this._width = Math.floor(param1);
      this.draw();
    }

    override public function get width() : Number {
      return this._width;
    }

    public function setDefaultSort() : void {
      this._oldSort = 1;
    }
  }
}
