package alternativa.tanks.model.item.container.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.garage.passtoshop.PassToShopService;
  import alternativa.tanks.model.item.container.ContainerPanelAction;
  import controls.buttons.h50px.GreyBigButton;
  import flash.display.DisplayObjectContainer;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ContainerPanel implements AutoClosable {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var passToShop:PassToShopService;

    private var buyButton:GreyBigButton = new GreyBigButton();
    private var openButton:GreyBigButton = new GreyBigButton();
    private var panelActions:ContainerPanelAction;
    private var openListener:Function;

    public function ContainerPanel(param1:ContainerPanelAction, param2:Function) {
      super();
      this.panelActions = param1;
      this.openListener = param2;
      this.buyButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_BUY_TEXT);
      this.buyButton.visible = Boolean(passToShop.isPassToShopEnabled()) && Boolean(param1.needBuyButton());
      this.buyButton.addEventListener(MouseEvent.CLICK,this.onBuyClick);
      this.openButton.label = localeService.getText(TanksLocale.TEXT_LOOT_OPEN_BUTTON);
      this.openButton.addEventListener(MouseEvent.CLICK,this.onOpenClick);
    }

    public function setOpenButtonEnabled(param1:Boolean) : void {
      this.openButton.enabled = param1;
    }

    private function onBuyClick(param1:MouseEvent) : void {
      this.panelActions.clickBuyButton();
    }

    private function onOpenClick(param1:MouseEvent) : void {
      this.openListener.call();
    }

    public function close() : void {
      this.buyButton.removeEventListener(MouseEvent.CLICK,this.onBuyClick);
      this.openButton.removeEventListener(MouseEvent.CLICK,this.onOpenClick);
      this.buyButton = null;
      this.openButton = null;
    }

    public function updateActionElements(param1:DisplayObjectContainer) : void {
      param1.addChild(this.buyButton);
      param1.addChild(this.openButton);
      this.buyButton.x = 11;
      if(this.buyButton.visible) {
        this.openButton.x = this.buyButton.x + (this.buyButton.width + 15) * 2;
      } else {
        this.openButton.x = 11;
      }
    }
  }
}
