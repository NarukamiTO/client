package alternativa.tanks.gui.category {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.friends.button.friends.NewRequestIndicator;
  import controls.buttons.IconButton;
  import flash.display.Bitmap;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ItemCategoryButton extends IconButton {
    public static const specialIconClass:Class = ItemCategoryButton_specialIconClass;
    public static const weaponIconClass:Class = ItemCategoryButton_weaponIconClass;
    public static const armorIconClass:Class = ItemCategoryButton_armorIconClass;
    public static const colorIconClass:Class = ItemCategoryButton_colorIconClass;
    public static const kitIconClass:Class = ItemCategoryButton_kitIconClass;
    public static const inventoryIconClass:Class = ItemCategoryButton_inventoryIconClass;
    public static const discountIconClass:Class = ItemCategoryButton_discountIconClass;
    public static const givenPresentsIconClass:Class = ItemCategoryButton_givenPresentsIconClass;
    public static const resistanceIconClass:Class = ItemCategoryButton_resistanceIconClass;

    private static const droneIconClass:Class = ItemCategoryButton_droneIconClass;

    private var category:ItemViewCategoryEnum;
    private var _newItemIndicator:Bitmap;
    private var _discountIndicator:Bitmap;
    private var _width:int;

    public function ItemCategoryButton(param1:ItemViewCategoryEnum) {
      var local3:String = null;
      var local4:Class = null;
      this._newItemIndicator = new NewRequestIndicator.attentionIconClass();
      this._discountIndicator = new discountIconClass();
      var local2:ILocaleService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
      switch(param1) {
        case ItemViewCategoryEnum.SPECIAL:
          local3 = local2.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_SPECIAL);
          local4 = specialIconClass;
          break;
        case ItemViewCategoryEnum.WEAPON:
          local3 = local2.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_TURRETS);
          local4 = weaponIconClass;
          break;
        case ItemViewCategoryEnum.ARMOR:
          local3 = local2.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_HULLS);
          local4 = armorIconClass;
          break;
        case ItemViewCategoryEnum.PAINT:
          local3 = local2.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_PAINTS);
          local4 = colorIconClass;
          break;
        case ItemViewCategoryEnum.KIT:
          local3 = local2.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_KITS);
          local4 = kitIconClass;
          break;
        case ItemViewCategoryEnum.INVENTORY:
          local3 = local2.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_SUPPLIES);
          local4 = inventoryIconClass;
          break;
        case ItemViewCategoryEnum.RESISTANCE:
          local3 = local2.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_RESISTANCE_MODULES);
          local4 = resistanceIconClass;
          break;
        case ItemViewCategoryEnum.GIVEN_PRESENTS:
          local3 = local2.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_PRESENTS);
          local4 = givenPresentsIconClass;
          break;
        case ItemViewCategoryEnum.DRONE:
          local3 = local2.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_DRONES);
          local4 = droneIconClass;
      }
      super(local3,local4);
      enabled = true;
      this.category = param1;
      addChild(this._newItemIndicator);
      this._newItemIndicator.y = -5;
      this._newItemIndicator.visible = false;
      addChild(this._discountIndicator);
      this._discountIndicator.y = -5;
      this._discountIndicator.visible = false;
      alignIcon();
    }

    public function getCategory() : ItemViewCategoryEnum {
      return this.category;
    }

    public function setIconState() : void {
      icon.visible = true;
      _label.visible = false;
      this.width = 30;
    }

    public function setTextState() : void {
      icon.visible = false;
      _label.visible = true;
      this.width = 6 + _label.width + 6;
    }

    public function setIconTextState() : void {
      icon.visible = true;
      _label.visible = true;
      this.width = 27 + _label.width + 6;
    }

    public function showNewItemIndicator() : void {
      this._newItemIndicator.visible = true;
    }

    public function hideNewItemIndicator() : void {
      this._newItemIndicator.visible = false;
    }

    public function showDiscountIndicator() : void {
      this._discountIndicator.visible = true;
    }

    public function hideDiscountIndicator() : void {
      this._discountIndicator.visible = false;
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      if(_label.visible) {
        if(Boolean(icon) && Boolean(icon.visible)) {
          _label.x = 21 + (this._width - 21 - _label.width >> 1);
        } else {
          _label.x = this._width - _label.width >> 1;
        }
      }
      this._newItemIndicator.x = param1 - (this._newItemIndicator.width >> 1) - 4;
      this._discountIndicator.x = param1 - (this._discountIndicator.width >> 1) - 4;
      super.width = this._width;
    }
  }
}
