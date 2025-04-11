package alternativa.tanks.gui.item.actionpanel {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.buttons.h50px.GreyBigButton;
  import flash.display.DisplayObjectContainer;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.AutoClosable;

  public class SingleActionPanel implements AutoClosable {
    [Inject]
    public static var localeService:ILocaleService;

    protected var actionButton:GreyBigButton = new GreyBigButton();

    private var action:Function;

    public function SingleActionPanel(param1:String, param2:Function) {
      super();
      this.action = param2;
      this.actionButton.label = localeService.getText(param1);
      this.actionButton.visible = param2 != null;
      this.actionButton.addEventListener(MouseEvent.CLICK,this.onClick);
      this.actionButton.x = 11;
    }

    private function onClick(param1:MouseEvent) : void {
      this.action();
    }

    public function set enabled(param1:Boolean) : void {
      this.actionButton.enabled = param1;
    }

    public function get enabled() : Boolean {
      return this.actionButton.enabled;
    }

    public function updateActionElements(param1:DisplayObjectContainer) : void {
      param1.addChild(this.actionButton);
    }

    public function close() : void {
      this.actionButton.removeEventListener(MouseEvent.CLICK,this.onClick);
    }
  }
}
