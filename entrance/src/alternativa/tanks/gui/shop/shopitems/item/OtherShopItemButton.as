package alternativa.tanks.gui.shop.shopitems.item {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.shopitems.event.ShopItemChosen;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemSkins;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.LocaleServiceLangValues;
  import utils.preview.IImageResource;
  import utils.preview.ImageResourceLoadingWrapper;

  public class OtherShopItemButton extends ShopButton implements IImageResource {
    [Inject]
    public static var localeService:ILocaleService;

    protected static const PADDING:int = 17;

    private var nameLabel:LabelBase;

    protected var preview:Bitmap;

    private var text:String;
    private var previewResource:ImageResource;
    private var sendingObject:IGameObject;

    public function OtherShopItemButton(param1:IGameObject, param2:String, param3:ImageResource = null) {
      this.sendingObject = param1;
      addEventListener(MouseEvent.CLICK,this.onMouseClick);
      this.text = param2;
      this.previewResource = param3;
      super(ShopItemSkins.GREY);
    }

    override protected function init() : void {
      super.init();
      this.initImageResourceForPreview();
      this.initLabels();
      this.initPreview();
      this.align();
    }

    protected function initPreview() : void {
      if(this.preview != null) {
        this.setPreview();
      }
    }

    protected function setPreview() : void {
      addChildAt(this.preview,2);
    }

    private function initLabels() : void {
      this.nameLabel = new LabelBase();
      this.nameLabel.text = this.text;
      this.nameLabel.color = ColorConstants.SHOP_CRYSTALS_TEXT_LABEL_COLOR;
      this.nameLabel.size = localeService.language == LocaleServiceLangValues.CN ? 18 : 22;
      this.nameLabel.autoSize = TextFieldAutoSize.LEFT;
      this.nameLabel.bold = true;
      this.nameLabel.mouseEnabled = false;
      this.nameLabel.wordWrap = true;
      this.nameLabel.width = this.width / 2;
      addChild(this.nameLabel);
    }

    private function initImageResourceForPreview() : void {
      if(this.previewResource != null) {
        if(this.previewResource.isLazy && !this.previewResource.isLoaded) {
          this.previewResource.loadLazyResource(new ImageResourceLoadingWrapper(this));
        } else {
          this.preview = new Bitmap(this.previewResource.data);
        }
      }
    }

    protected function align() : void {
      this.nameLabel.y = this.height / 2 - this.nameLabel.height / 2;
      this.nameLabel.x = PADDING;
      if(this.preview != null) {
        this.preview.x = this.width - PADDING - 150;
        this.preview.y = 12;
      }
    }

    protected function onMouseClick(param1:MouseEvent) : void {
      dispatchEvent(new ShopItemChosen(this.sendingObject));
    }

    public function setPreviewResource(param1:ImageResource) : void {
      this.preview = new Bitmap(param1.data);
      this.updateLazyLoadedPreview();
    }

    protected function updateLazyLoadedPreview() : void {
      this.setPreview();
      this.align();
    }
  }
}
