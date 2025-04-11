package alternativa.tanks.gui.payment.forms.commons {
  import alternativa.tanks.gui.payment.forms.TemplateDescription;
  import alternativa.tanks.gui.shop.windows.ShopWindow;
  import alternativa.tanks.model.payment.category.PayFullDescription;
  import alternativa.tanks.model.payment.modes.PayMode;
  import alternativa.tanks.model.payment.modes.description.PayModeBottomDescription;
  import base.DiscreteSprite;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import fl.containers.ScrollPane;
  import fl.controls.ScrollPolicy;
  import flash.display.Sprite;
  import platform.client.fp10.core.type.IGameObject;
  import utils.ScrollStyleUtils;

  public class DescriptionBlock extends DiscreteSprite {
    private var payMode:IGameObject;
    private var headerLabel:LabelBase;
    private var descriptionControl:TemplateDescription;
    private var scrollPane:ScrollPane;
    private var innerWindowDescription:TankWindowInner;
    private var innerWindowHeight:int;

    public function DescriptionBlock(param1:IGameObject, param2:int) {
      super();
      this.payMode = param1;
      this.innerWindowHeight = param2;
      this.addHeader();
      this.addDescriptionBlock();
    }

    public function updateHeight(param1:int) : void {
      this.innerWindowHeight = param1;
      this.innerWindowDescription.height = this.innerWindowHeight;
      this.scrollPane.setSize(this.innerWindowDescription.width,this.innerWindowHeight - 2 * ShopWindow.WINDOW_PADDING);
    }

    public function getInnerWindowHeight() : int {
      return this.innerWindowHeight;
    }

    private function addHeader() : void {
      this.headerLabel = new LabelBase();
      this.headerLabel.wordWrap = true;
      this.headerLabel.text = PayMode(this.payMode.adapt(PayMode)).getName();
      this.headerLabel.size = 18;
      this.headerLabel.width = 200;
      addChild(this.headerLabel);
    }

    private function addDescriptionBlock() : void {
      this.innerWindowDescription = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.innerWindowDescription.showBlink = true;
      this.innerWindowDescription.y = this.headerLabel.y + this.headerLabel.height;
      this.innerWindowDescription.width = ShopWindow.WINDOW_WIDTH - ShopWindow.WINDOW_PADDING * 2;
      this.innerWindowDescription.height = this.innerWindowHeight;
      addChild(this.innerWindowDescription);
      var local1:Sprite = new Sprite();
      this.scrollPane = new ScrollPane();
      ScrollStyleUtils.setGreenStyle(this.scrollPane);
      this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
      this.scrollPane.verticalScrollPolicy = ScrollPolicy.AUTO;
      this.scrollPane.source = local1;
      this.scrollPane.update();
      this.scrollPane.focusEnabled = false;
      this.scrollPane.y = this.innerWindowDescription.y + ShopWindow.WINDOW_PADDING;
      addChild(this.scrollPane);
      this.descriptionControl = new TemplateDescription();
      this.descriptionControl.x = ShopWindow.WINDOW_PADDING;
      this.descriptionControl.width = this.innerWindowDescription.width - 2 * ShopWindow.WINDOW_PADDING;
      local1.addChild(this.descriptionControl);
      this.scrollPane.setSize(this.innerWindowDescription.width,this.innerWindowHeight - 2 * ShopWindow.WINDOW_PADDING);
      this.updateDescription();
    }

    public function updateDescription() : void {
      var local1:PayModeBottomDescription = null;
      this.descriptionControl.description.htmlText = PayFullDescription(this.payMode.adapt(PayFullDescription)).getFullDescription();
      if(this.payMode.hasModel(PayModeBottomDescription)) {
        local1 = PayModeBottomDescription(this.payMode.adapt(PayModeBottomDescription));
        if(local1.enabled()) {
          this.descriptionControl.setBottomDescription(local1.getDescription(),local1.getImages());
        } else {
          this.descriptionControl.hideBottomDescription();
        }
      } else {
        this.descriptionControl.hideBottomDescription();
      }
      this.scrollPane.update();
    }

    public function getHeight() : Number {
      return this.innerWindowHeight + this.headerLabel.height + ShopWindow.WINDOW_PADDING;
    }
  }
}
