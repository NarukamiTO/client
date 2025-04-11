package alternativa.tanks.view.battlelist.forms {
  import alternativa.tanks.service.money.IMoneyListener;
  import alternativa.tanks.service.money.IMoneyService;
  import assets.Diamond;
  import controls.base.BigButtonBase;
  import controls.base.LabelBase;
  import controls.buttons.ButtonStates;
  import flash.events.Event;
  import flash.filters.DropShadowFilter;

  public class BattleBigButton extends BigButtonBase implements IMoneyListener {
    [Inject]
    public static var moneyService:IMoneyService;

    private var diamond:Diamond = new Diamond();
    private var costLabel:LabelBase = new LabelBase();
    private var _cost:int = 0;

    public function BattleBigButton() {
      super();
      addChild(this.diamond);
      addChild(this.costLabel);
      this.diamond.visible = this.costLabel.visible = false;
      label = "";
      addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      this.diamond.filters = this.costLabel.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
    }

    private function onRemoveFromStage(param1:Event) : void {
      moneyService.removeListener(this);
    }

    private function onAddToStage(param1:Event) : void {
      moneyService.addListener(this);
      this.updateColor();
    }

    public function crystalsChanged(param1:int) : void {
      this.updateColor();
    }

    override public function set width(param1:Number) : void {
      super.width = param1;
      _info.width = _label.width = _width - 4;
      if(_icon.bitmapData != null) {
        _icon.x = 6;
        _icon.y = int(25 - _icon.height / 2);
        _label.width = _width - 8 - _icon.width;
        _label.x = _icon.width + 4;
        _label.y = this._cost == 0 ? 16 : 6;
      }
      if(this._cost > 0) {
        this.diamond.visible = this.costLabel.visible = true;
        this.diamond.x = _icon.width + 4 + (_label.width - _label.textWidth) / 2;
        this.diamond.y = 26;
        this.costLabel.y = 22;
        this.costLabel.text = String(this._cost);
        this.costLabel.x = this.diamond.x + this.diamond.width;
        this.updateColor();
      } else {
        this.diamond.visible = this.costLabel.visible = false;
      }
    }

    private function updateColor() : void {
      if(this._cost > moneyService.crystal) {
        this.costLabel.color = 16731648;
      } else {
        this.costLabel.color = 16777215;
      }
    }

    public function set cost(param1:int) : void {
      this._cost = param1;
      this.width = _width;
    }

    override protected function onStateChanged() : void {
      super.onStateChanged();
      var local1:int = getState() == ButtonStates.DOWN ? 1 : 0;
      _label.y = (this._cost == 0 ? 16 : 6) + local1;
      this.diamond.y = 26;
      this.costLabel.y = 22 + local1;
    }
  }
}
