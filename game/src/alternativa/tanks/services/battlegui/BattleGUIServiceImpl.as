package alternativa.tanks.services.battlegui {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.utils.removeDisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.events.EventDispatcher;

  public class BattleGUIServiceImpl extends EventDispatcher implements BattleGUIService {
    [Inject]
    public static var display:IDisplay;

    private var viewportContainer:Sprite = new Sprite();
    private var guiContainer:Sprite = new Sprite();
    private var tabContainer:Sprite = new Sprite();
    private var _positionXDefaultLayout:int;
    private var _positionXInventory:int;

    public function BattleGUIServiceImpl() {
      super();
      this.viewportContainer.mouseEnabled = false;
      this.guiContainer.mouseEnabled = false;
      this.tabContainer.mouseEnabled = false;
    }

    public function getViewportContainer() : DisplayObjectContainer {
      return this.viewportContainer;
    }

    public function getGuiContainer() : DisplayObjectContainer {
      return this.guiContainer;
    }

    public function getTabContainer() : DisplayObjectContainer {
      return this.tabContainer;
    }

    public function hide() : void {
      removeDisplayObject(this.viewportContainer);
      removeDisplayObject(this.guiContainer);
      removeDisplayObject(this.tabContainer);
    }

    public function show() : void {
      display.contentLayer.addChild(this.viewportContainer);
      display.contentUILayer.addChild(this.guiContainer);
      display.contentUILayer.addChild(this.tabContainer);
    }

    public function setPositionXDefaultLayout(param1:int) : void {
      this._positionXDefaultLayout = param1;
      dispatchEvent(new BattleGUIServiceEvent(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT));
    }

    public function getPositionXDefaultLayout() : int {
      return this._positionXDefaultLayout;
    }

    public function setPositionXInventory(param1:int) : void {
      this._positionXInventory = param1;
      dispatchEvent(new InventoryChangePositionEvent());
    }

    public function getPositionXInventory() : int {
      return this._positionXInventory;
    }

    public function resetPositionXInventory() : void {
      this._positionXInventory = 0;
    }
  }
}
