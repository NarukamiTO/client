package alternativa.tanks.gui.crystalbutton {
  import alternativa.tanks.service.money.IMoneyListener;
  import alternativa.tanks.service.money.IMoneyService;
  import controls.base.ThreeLineBigButton;
  import flash.display.Bitmap;
  import flash.events.Event;

  public class CrystalButton extends ThreeLineBigButton implements IMoneyListener {
    [Inject]
    public static var moneyService:IMoneyService;

    private var _discountIcon:Bitmap = UpgradeSaleIcon.createInstance();

    protected var crystalLabel:CrystalLabel = new CrystalLabel();
    protected var crystals:int;

    public function CrystalButton(param1:String = "", param2:int = 0, param3:int = 120) {
      super();
      this.width = param3;
      infoContainer.addChild(this.crystalLabel);
      setText(param1);
      this.setCost(param2);
      this.show();
      addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
    }

    private function onRemoveFromStage(param1:Event) : void {
      moneyService.removeListener(this);
    }

    private function onAddToStage(param1:Event) : void {
      moneyService.addListener(this);
      this.updateCrystalColor();
    }

    public function setCost(param1:int) : void {
      this.crystals = param1;
      this.crystalLabel.setCost(param1);
      this.crystalLabel.x = (_width - this.crystalLabel.width) * 0.5;
      this.updateCrystalColor();
    }

    public function getPrice() : int {
      return this.crystals;
    }

    protected function show() : void {
      super.showInTwoRows(captionLabel,this.crystalLabel);
    }

    public function setSale(param1:Boolean) : void {
      addChild(this._discountIcon);
      this.alignDiscount();
      this._discountIcon.visible = param1;
    }

    public function crystalsChanged(param1:int) : void {
      this.updateCrystalColor();
    }

    private function updateCrystalColor() : void {
      if(moneyService.crystal < this.crystals) {
        this.crystalLabel.setColor(16731648);
      } else if(this.crystals == 0) {
        this.crystalLabel.setColor(11206400);
      } else {
        this.crystalLabel.setColor(16777215);
      }
    }

    override public function set enabled(param1:Boolean) : void {
      super.enabled = param1;
      this.alignDiscount();
    }

    private function alignDiscount() : void {
      if(enabled) {
        this._discountIcon.x = 3;
        this._discountIcon.y = height - this._discountIcon.height - 3;
      } else {
        this._discountIcon.x = 2;
        this._discountIcon.y = height - this._discountIcon.height - 1;
      }
    }
  }
}
