package alternativa.tanks.battle {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.View;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.bg.IBackgroundService;
  import alternativa.tanks.display.AxisIndicator;
  import alternativa.tanks.models.battle.battlefield.ViewportBorder;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import alternativa.tanks.utils.MathUtils;
  import alternativa.utils.removeDisplayObject;
  import alternativa.utils.removeDisplayObjectChildren;
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.Rectangle;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class BattleView implements GameActionListener {
    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var backgroundService:IBackgroundService;

    public static const MAX_SCREEN_SIZE:int = 10;

    private static const SCREEN_SIZE_KEY:String = "screenSize";

    private var container:Sprite;
    private var view:View;
    private var overlay:Sprite;
    private var viewportBorderLayer:Shape;
    private var showAxisIndicator:Boolean;
    private var axisIndicator:AxisIndicator;
    private var screenSize:int = 10;

    public function BattleView() {
      super();
      this.container = this.createContainer();
      this.view = new View(1,1,GPUCapabilities.constrained);
      this.view.mouseEnabled = false;
      this.view.hideLogo();
      this.container.addChild(this.view);
      battleService.getBattleScene3D().setCameraView(this.view);
      this.overlay = new Sprite();
      this.overlay.mouseEnabled = false;
      this.container.addChild(this.overlay);
      this.viewportBorderLayer = new Shape();
      this.container.addChild(this.viewportBorderLayer);
      this.setSize(storageService.getStorage().data[SCREEN_SIZE_KEY]);
    }

    private function createContainer() : Sprite {
      var local1:Sprite = new Sprite();
      local1.mouseEnabled = false;
      local1.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      local1.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      return local1;
    }

    private function onAddedToStage(param1:Event) : void {
      this.container.stage.addEventListener(Event.RESIZE,this.onResize);
      battleInputService.addGameActionListener(this);
      this.setFocus();
      this.resize();
    }

    private function onRemovedFromStage(param1:Event) : void {
      this.container.stage.removeEventListener(Event.RESIZE,this.onResize);
      battleInputService.removeGameActionListener(this);
    }

    private function onResize(param1:Event) : void {
      this.resize();
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      if(param2) {
        switch(param1) {
          case GameActionEnum.BATTLE_VIEW_INCREASE:
            this.increaseViewSize();
            break;
          case GameActionEnum.BATTLE_VIEW_DECREASE:
            this.decreaseViewSize();
        }
      }
    }

    private function increaseViewSize() : void {
      this.incSize();
      storageService.getStorage().data[SCREEN_SIZE_KEY] = this.getScreenSize();
    }

    private function decreaseViewSize() : void {
      this.decSize();
      storageService.getStorage().data[SCREEN_SIZE_KEY] = this.getScreenSize();
    }

    public function destroy() : void {
      this.removeFromScreen();
      this.view.clear();
      this.view = null;
      removeDisplayObjectChildren(this.overlay);
      this.overlay = null;
      removeDisplayObjectChildren(this.container);
      this.container.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      this.container.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      this.container = null;
    }

    public function setShowAxisIndicator(param1:Boolean) : void {
      if(this.showAxisIndicator != param1) {
        this.showAxisIndicator = param1;
        if(param1) {
          this.axisIndicator = new AxisIndicator(100);
          this.container.addChild(this.axisIndicator);
          this.setAxisIndicatorPosition();
        } else {
          this.container.removeChild(this.axisIndicator);
          this.axisIndicator = null;
        }
      }
    }

    public function setShowFPSIndicator(param1:Boolean) : void {
      var local2:Camera3D = battleService.getBattleScene3D().getCamera();
      if(param1 != this.container.contains(local2.diagram)) {
        if(param1) {
          this.container.addChild(local2.diagram);
        } else {
          this.container.removeChild(local2.diagram);
        }
      }
    }

    private function resize() : void {
      if(this.container.stage == null) {
        return;
      }
      this.resizeView();
      this.updateContainerPosition();
      this.drawViewPortBorder();
      this.drawBackground();
      this.setAxisIndicatorPosition();
      battleService.getBattleScene3D().getCamera().updateFov();
    }

    private function resizeView() : void {
      var local1:Number = this.screenSize / MAX_SCREEN_SIZE;
      this.view.width = int(this.container.stage.stageWidth * local1);
      this.view.height = int(this.container.stage.stageHeight * local1);
    }

    private function updateContainerPosition() : void {
      this.container.x = this.container.stage.stageWidth - this.view.width >> 1;
      this.container.y = this.container.stage.stageHeight - this.view.height >> 1;
    }

    private function drawViewPortBorder() : void {
      this.viewportBorderLayer.graphics.clear();
      if(this.screenSize < MAX_SCREEN_SIZE) {
        ViewportBorder.draw(this.viewportBorderLayer.graphics,this.view.width,this.view.height);
      }
    }

    private function drawBackground() : void {
      var local1:int = 0.5 * (this.container.stage.stageWidth - this.view.width);
      var local2:int = 0.5 * (this.container.stage.stageHeight - this.view.height);
      backgroundService.drawBg(new Rectangle(local1,local2,this.view.width,this.view.height));
    }

    private function setAxisIndicatorPosition() : void {
      if(this.showAxisIndicator) {
        this.axisIndicator.y = this.view.height - this.axisIndicator.size - 50;
      }
    }

    public function incSize() : void {
      if(this.screenSize < MAX_SCREEN_SIZE) {
        ++this.screenSize;
        this.resize();
      }
    }

    public function decSize() : void {
      if(this.screenSize > 1) {
        --this.screenSize;
        this.resize();
      }
    }

    private function setSize(param1:int) : void {
      if(param1 == 0) {
        this.screenSize = MAX_SCREEN_SIZE;
      } else {
        this.screenSize = MathUtils.clamp(param1,1,MAX_SCREEN_SIZE);
      }
      this.resize();
    }

    public function getScreenSize() : int {
      return this.screenSize;
    }

    public function update() : void {
      if(this.showAxisIndicator) {
        this.axisIndicator.update(battleService.getBattleScene3D().getCamera());
      }
    }

    public function addOverlayObject(param1:DisplayObject) : void {
      this.overlay.addChild(param1);
    }

    public function removeOverlayObject(param1:DisplayObject) : void {
      this.overlay.removeChild(param1);
    }

    public function getWidth() : int {
      if(this.container.stage == null) {
        return 1;
      }
      return this.container.stage.stageWidth * this.screenSize / MAX_SCREEN_SIZE;
    }

    public function getHeight() : int {
      if(this.container.stage == null) {
        return 1;
      }
      return this.container.stage.stageHeight * this.screenSize / MAX_SCREEN_SIZE;
    }

    public function getDiagonalSquared() : Number {
      return this.getHeight() * this.getHeight() + this.getWidth() * this.getWidth();
    }

    public function getParentDisplayContainer() : DisplayObjectContainer {
      return this.container.parent;
    }

    public function getX() : int {
      return this.container.x;
    }

    public function getY() : int {
      return this.container.y;
    }

    public function addToScreen(param1:DisplayObjectContainer) : void {
      param1.addChild(this.container);
    }

    public function removeFromScreen() : void {
      removeDisplayObject(this.container);
    }

    public function setFocus() : void {
      display.stage.focus = this.container;
    }
  }
}
