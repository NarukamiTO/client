package alternativa.tanks.gui.category {
  import base.DiscreteSprite;
  import flash.events.MouseEvent;
  import flash.utils.Dictionary;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  public class CategoryButtonsList extends DiscreteSprite {
    private static const SPACE_BETWEEN_BUTTON:int = 5;

    private var selectedCategory:ItemViewCategoryEnum;
    private var buttons:Vector.<ItemCategoryButton> = new Vector.<ItemCategoryButton>();
    private var categoryToButton:Dictionary = new Dictionary();
    private var textMaxButtonWidth:int;
    private var iconAndTextMaxButtonWidth:int;
    private var maxWidth:int = 100;

    public function CategoryButtonsList() {
      super();
      this.addButton(ItemViewCategoryEnum.WEAPON);
      this.addButton(ItemViewCategoryEnum.ARMOR);
      this.addButton(ItemViewCategoryEnum.DRONE);
      this.addButton(ItemViewCategoryEnum.RESISTANCE);
      this.addButton(ItemViewCategoryEnum.PAINT);
      this.addButton(ItemViewCategoryEnum.INVENTORY);
      this.addButton(ItemViewCategoryEnum.KIT);
      this.addButton(ItemViewCategoryEnum.SPECIAL);
      this.addButton(ItemViewCategoryEnum.GIVEN_PRESENTS);
      this.buttons[0].enabled = false;
      this.selectedCategory = this.buttons[0].getCategory();
      this.calculateWidth();
    }

    public function select(param1:ItemViewCategoryEnum) : void {
      this.categoryToButton[this.selectedCategory].enabled = true;
      this.categoryToButton[param1].enabled = false;
      this.selectedCategory = param1;
      dispatchEvent(new CategoryButtonsListEvent(CategoryButtonsListEvent.CATEGORY_SELECTED,this.selectedCategory));
    }

    public function getSelectedCategory() : ItemViewCategoryEnum {
      return this.selectedCategory;
    }

    public function setCategoryButtonVisibility(param1:ItemViewCategoryEnum, param2:Boolean) : void {
      this.categoryToButton[param1].visible = param2;
      this.calculateWidth();
    }

    public function getCategoryButtonVisibility(param1:ItemViewCategoryEnum) : Boolean {
      return this.categoryToButton[param1].visible;
    }

    public function showNewItemIndicator(param1:ItemViewCategoryEnum) : void {
      this.categoryToButton[param1].showNewItemIndicator();
    }

    public function hideNewItemIndicator(param1:ItemViewCategoryEnum) : void {
      this.categoryToButton[param1].hideNewItemIndicator();
    }

    public function showDiscountIndicator(param1:ItemViewCategoryEnum) : void {
      this.categoryToButton[param1].showDiscountIndicator();
    }

    public function hideDiscountIndicator(param1:ItemViewCategoryEnum) : void {
      this.categoryToButton[param1].hideDiscountIndicator();
    }

    private function addButton(param1:ItemViewCategoryEnum) : void {
      var local2:ItemCategoryButton = new ItemCategoryButton(param1);
      this.buttons.push(local2);
      this.categoryToButton[param1] = local2;
      local2.addEventListener(MouseEvent.CLICK,this.onButtonClick);
      addChild(local2);
    }

    private function calculateWidth() : void {
      var local1:ItemCategoryButton = null;
      this.textMaxButtonWidth = this.iconAndTextMaxButtonWidth = 0;
      for each(local1 in this.buttons) {
        if(local1.visible) {
          local1.setTextState();
          this.textMaxButtonWidth = Math.max(this.textMaxButtonWidth,local1.width);
          local1.setIconTextState();
          this.iconAndTextMaxButtonWidth = Math.max(this.iconAndTextMaxButtonWidth,local1.width);
        }
      }
      this.selectLod();
    }

    override public function get width() : Number {
      return this.maxWidth;
    }

    override public function set width(param1:Number) : void {
      this.maxWidth = param1;
      this.selectLod();
    }

    private function selectLod() : void {
      var local3:ItemCategoryButton = null;
      var local4:int = 0;
      var local1:int = 0;
      var local2:int = 0;
      for each(local3 in this.buttons) {
        if(local3.visible) {
          local2++;
        }
      }
      local4 = (this.maxWidth - (local2 - 1) * SPACE_BETWEEN_BUTTON) / local2;
      if(local4 >= this.iconAndTextMaxButtonWidth) {
        local4 = Math.min(local4,this.iconAndTextMaxButtonWidth + 7);
      } else if(local4 >= this.textMaxButtonWidth) {
        local4 = Math.min(local4,this.textMaxButtonWidth + 14);
      }
      for each(local3 in this.buttons) {
        if(local3.visible) {
          if(this.iconAndTextMaxButtonWidth <= local4) {
            local3.setIconTextState();
            local3.width = local4;
          } else if(this.textMaxButtonWidth <= local4) {
            local3.setTextState();
            local3.width = local4;
          } else {
            local3.setIconState();
          }
          local3.x = local1;
          local1 += local3.width;
          local1 += SPACE_BETWEEN_BUTTON;
        }
      }
    }

    private function onButtonClick(param1:MouseEvent) : void {
      if(param1.target is ItemCategoryButton) {
        this.select(ItemCategoryButton(param1.target).getCategory());
      }
    }

    public function destroy() : void {
      var local1:ItemCategoryButton = null;
      for each(local1 in this.buttons) {
        local1.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
      }
      this.buttons = null;
      this.categoryToButton = null;
    }

    public function findVisibleCategory() : ItemViewCategoryEnum {
      var local1:ItemCategoryButton = null;
      for each(local1 in this.buttons) {
        if(local1.visible) {
          return local1.getCategory();
        }
      }
      throw new Error("No category to show");
    }
  }
}
