package alternativa.tanks.gui.shop.components.itemscategory {
  import base.DiscreteSprite;
  import controls.base.LabelBase;

  public class ItemsCategoryViewHeader extends DiscreteSprite {
    private var headerText:String;
    private var descriptionText:String;
    private var headerLabel:LabelBase;
    private var descriptionLabel:LabelBase;

    public function ItemsCategoryViewHeader(param1:String, param2:String) {
      super();
      this.headerText = param1;
      this.descriptionText = param2;
      this.init();
    }

    private function init() : void {
      this.createHeaderLabel();
      this.createDescriptionLabel();
    }

    private function createHeaderLabel() : void {
      this.headerLabel = new LabelBase();
      this.headerLabel.size = 18;
      this.headerLabel.text = this.headerText;
      addChild(this.headerLabel);
    }

    private function createDescriptionLabel() : void {
      this.descriptionLabel = new LabelBase();
      this.descriptionLabel.htmlText = this.descriptionText;
      this.descriptionLabel.wordWrap = true;
      addChild(this.descriptionLabel);
    }

    public function render(param1:int) : void {
      this.headerLabel.width = param1;
      this.descriptionLabel.width = param1;
      this.descriptionLabel.y = this.headerLabel.y + this.headerLabel.height;
    }
  }
}
