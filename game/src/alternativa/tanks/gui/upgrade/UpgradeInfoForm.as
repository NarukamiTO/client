package alternativa.tanks.gui.upgrade {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.ItemInfoPanelBitmaps;
  import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
  import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import base.DiscreteSprite;
  import controls.labels.MouseDisabledLabel;
  import flash.display.Bitmap;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;

  public class UpgradeInfoForm extends DiscreteSprite {
    [Inject]
    public static var propertyService:ItemPropertyParamsService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const arrowClass:Class = UpgradeInfoForm_arrowClass;
    private static const ICON_X:int = 10;
    private static const PROPERTY_NAME_X:int = 47;
    private static const CURRENT_VALUE_X:int = 228;
    private static const ARROW_X:int = 308;
    private static const DELTA_VALUE_X:int = 310;
    private static const NEXT_VALUE_X:int = 373;
    private static const Y:int = 14;

    private var propertyNameLabel:MouseDisabledLabel = new MouseDisabledLabel();
    private var propertyValueLabel:MouseDisabledLabel = new MouseDisabledLabel();
    private var propertyDeltaLabel:MouseDisabledLabel = new MouseDisabledLabel();
    private var propertyNextValueLabel:MouseDisabledLabel = new MouseDisabledLabel();
    private var propertyParams:ItemPropertyParams;
    private var propertyValue:UpgradableItemPropertyValue;
    private var icon:Bitmap;
    private var upgradeLayer:Sprite = new DiscreteSprite();
    private var upgradableItemParams:UpgradableItemParams;
    private var arrow:Bitmap;
    private var valueWidth:int;

    public function UpgradeInfoForm(param1:UpgradableItemParams, param2:UpgradableItemPropertyValue) {
      super();
      this.upgradableItemParams = param1;
      this.propertyValue = param2;
      this.propertyParams = propertyService.getParams(param2.getProperty());
      this.icon = this.propertyParams.createBitmap();
      var local3:Bitmap = new Bitmap(ItemInfoPanelBitmaps.backIcon);
      local3.x = ICON_X;
      local3.y = 1;
      this.putOnLine(local3,Y);
      this.icon.x = (local3.width - this.icon.width >> 1) + local3.x + 1;
      this.icon.y = (local3.height - this.icon.height >> 1) + local3.y + 1;
      addChild(local3);
      addChild(this.icon);
      addChild(this.propertyNameLabel);
      this.propertyNameLabel.text = this.propertyParams.name + ":";
      this.propertyNameLabel.x = PROPERTY_NAME_X;
      this.putOnLine(this.propertyNameLabel,Y);
      addChild(this.propertyValueLabel);
      this.propertyValueLabel.x = CURRENT_VALUE_X;
      addChild(this.upgradeLayer);
      if(param2.isUpgradable()) {
        this.arrow = new arrowClass();
        this.putOnLine(this.arrow,Y);
        this.arrow.x = ARROW_X;
        this.upgradeLayer.addChild(this.arrow);
        this.upgradeLayer.addChild(this.propertyDeltaLabel);
        this.propertyDeltaLabel.x = DELTA_VALUE_X;
      }
      this.upgradeLayer.addChild(this.propertyNextValueLabel);
      this.propertyNextValueLabel.x = NEXT_VALUE_X;
      this.updateForm();
    }

    public function getPropertyNameWidth() : int {
      return this.propertyNameLabel.width;
    }

    public function getValueMaxWidth() : int {
      this.propertyValueLabel.text = this.propertyValue.getValue(0);
      var local1:int = int(this.propertyValueLabel.width);
      this.propertyValueLabel.text = this.propertyValue.getValue(this.upgradableItemParams.getLevelsCount());
      return Math.max(local1,this.propertyValueLabel.width);
    }

    public function getWidth() : int {
      if(this.upgradableItemParams.isFullUpgraded()) {
        return this.propertyValueLabel.x + this.valueWidth + 10;
      }
      return this.propertyNextValueLabel.x + this.valueWidth + 10;
    }

    public function align(param1:int, param2:int) : void {
      this.propertyValueLabel.x = this.propertyNameLabel.x + param1 + 20;
      var local3:int = this.propertyValueLabel.x + param2 + 20;
      this.valueWidth = param2;
      if(Boolean(this.arrow)) {
        this.arrow.x = local3;
        this.propertyDeltaLabel.x = local3 + 2;
      }
      this.propertyNextValueLabel.x = local3 + 65;
      this.updateForm();
    }

    internal function updateForm() : void {
      this.updateColor();
      var local1:int = this.upgradableItemParams.getLevel();
      this.propertyValueLabel.text = this.propertyValue.getValue(local1);
      this.putOnLine(this.propertyValueLabel,Y);
      if(this.upgradableItemParams.isFullUpgraded()) {
        removeDisplayObject(this.upgradeLayer);
      } else {
        this.propertyNextValueLabel.text = this.propertyValue.getValue(local1 + 1);
        this.putOnLine(this.propertyNextValueLabel,Y);
        this.propertyDeltaLabel.text = this.propertyValue.getDelta(local1);
        this.putOnLine(this.propertyDeltaLabel,Y);
      }
    }

    private function updateColor() : void {
      this.propertyValueLabel.textColor = UpgradeColors.getColor(this.upgradableItemParams,this.propertyValue);
      this.propertyNextValueLabel.textColor = UpgradeColors.getNextColor(this.upgradableItemParams,this.propertyValue);
    }

    protected function putOnLine(param1:DisplayObject, param2:int) : void {
      param1.y = int(param2 - param1.height * 0.5);
    }
  }
}
