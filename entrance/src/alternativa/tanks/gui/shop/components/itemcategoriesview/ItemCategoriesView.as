package alternativa.tanks.gui.shop.components.itemcategoriesview {
  import alternativa.tanks.gui.shop.components.item.GridItemBase;
  import alternativa.tanks.gui.shop.components.itemscategory.ItemsCategoryView;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import controls.TankWindowInner;
  import fl.containers.ScrollPane;
  import fl.controls.ScrollPolicy;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.utils.Dictionary;
  import forms.ColorConstants;
  import utils.ScrollStyleUtils;

  public class ItemCategoriesView extends DiscreteSprite {
    private static const VERTICAL_GAP:int = 20;
    private static const AROUND_GAP:int = 25;
    private static const SCROLL_GAP:int = 5;
    private static const SCROLL_PANE_BOTTOM_PADDING:int = 15;
    private static const SCROLL_SHIFT_GAP:int = 5;
    private static const SCROLL_SPEED_MULTIPLIER:int = 3;
    private static const VERTICAL_JUMP_CALIBRATION:int = 8;

    private var scrollPane:ScrollPane;
    private var scrollContainer:Sprite;
    private var scrollPaneBottomPadding:Sprite;
    private var inner:TankWindowInner;
    private var categories:Dictionary;
    private var categoriesPosition:Vector.<ItemsCategoryView>;
    private var _width:int;
    private var _height:int;

    public function ItemCategoriesView() {
      super();
      this.categories = new Dictionary();
      this.categoriesPosition = new Vector.<ItemsCategoryView>();
      this.inner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      addChild(this.inner);
      this.scrollContainer = new Sprite();
      this.scrollPaneBottomPadding = new Sprite();
      this.scrollContainer.addChild(this.scrollPaneBottomPadding);
      this.scrollPane = new ScrollPane();
      ScrollStyleUtils.setGreenStyle(this.scrollPane);
      this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
      this.scrollPane.verticalScrollPolicy = ScrollPolicy.AUTO;
      this.scrollPane.source = this.scrollContainer;
      this.scrollPane.update();
      this.scrollPane.focusEnabled = false;
      this.scrollPane.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,true);
      addChild(this.scrollPane);
    }

    private function onMouseWheel(param1:MouseEvent) : void {
      param1.delta *= SCROLL_SPEED_MULTIPLIER;
    }

    public function render(param1:int, param2:int) : void {
      var local4:ItemsCategoryView = null;
      this._width = param1;
      this._height = param2;
      this.scrollPane.y = SCROLL_GAP;
      this.scrollPane.setSize(param1 + SCROLL_SHIFT_GAP,param2 - SCROLL_GAP * 2);
      this.inner.width = param1;
      this.inner.height = param2;
      var local3:int = -12;
      for each(local4 in this.categoriesPosition) {
        local4.x = AROUND_GAP;
        local4.render(this._width - AROUND_GAP * 2 - (this.scrollPane.verticalScrollBar.width - SCROLL_SHIFT_GAP - 1));
        local4.y = local3 + VERTICAL_GAP;
        local3 = local4.y + local4.height;
      }
      this.fixScrollPaneBottomPadding(local3);
      this.scrollPane.update();
    }

    private function fixScrollPaneBottomPadding(param1:int) : void {
      this.scrollPaneBottomPadding.graphics.lineStyle(1,ColorConstants.WHITE,0);
      this.scrollPaneBottomPadding.graphics.beginFill(ColorConstants.WHITE,0);
      this.scrollPaneBottomPadding.graphics.drawRect(0,0,1,SCROLL_PANE_BOTTOM_PADDING);
      this.scrollPaneBottomPadding.graphics.endFill();
      this.scrollPaneBottomPadding.x = AROUND_GAP;
      this.scrollPaneBottomPadding.y = param1;
    }

    public function addCategory(param1:ItemsCategoryView) : void {
      this.categories[param1.categoryId] = param1;
      this.categoriesPosition.push(param1);
      this.scrollContainer.addChild(param1);
    }

    public function addItem(param1:Long, param2:GridItemBase) : void {
      ItemsCategoryView(this.categories[param1]).addItem(param2);
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function get height() : Number {
      return this._height;
    }

    public function jumpToCategory(param1:Long) : void {
      this.scrollPane.verticalScrollPosition = this.categories[param1].y - VERTICAL_JUMP_CALIBRATION;
    }

    public function get scrollPosition() : int {
      return this.scrollPane.verticalScrollPosition;
    }

    public function set scrollPosition(param1:int) : void {
      if(Boolean(this.scrollPane.stage)) {
        this.scrollPane.verticalScrollPosition = param1;
        this.scrollPane.update();
      }
    }

    public function destroy() : void {
      var local1:ItemsCategoryView = null;
      for each(local1 in this.categories) {
        local1.destroy();
      }
      this.categories = null;
      this.categoriesPosition = null;
      this.scrollPane.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,true);
      this.scrollPane = null;
    }
  }
}
