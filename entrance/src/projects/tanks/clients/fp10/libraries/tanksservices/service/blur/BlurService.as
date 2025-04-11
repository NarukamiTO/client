package projects.tanks.clients.fp10.libraries.tanksservices.service.blur {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.utils.Dictionary;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;

  public class BlurService extends EventDispatcher implements IBlurService {
    [Inject]
    public static var helperService:IHelpService;

    private static const OVERLAY_COLOR:uint = 0;
    private static const OVERLAY_ALPHA:Number = 0.5;

    private var isBlurGameContent:Boolean;
    private var isBlurBattleContent:Boolean;
    private var isBlurDialogContent:Boolean;
    private var isBlurAllContent:Boolean;
    private var overlay:Sprite;
    private var mainContainerService:IDisplay;
    private var componentOverlays:Dictionary;
    private var blurredComponentsCount:uint = 0;

    public function BlurService() {
      super();
      this.mainContainerService = IDisplay(OSGi.getInstance().getService(IDisplay));
      this.overlay = new Sprite();
      this.overlay.mouseEnabled = true;
      this.componentOverlays = new Dictionary();
    }

    private static function lockHelpService() : void {
      helperService.pushState();
      helperService.hideAllHelpers();
      helperService.lock();
    }

    private static function unLockHelpService() : void {
      helperService.popState();
      helperService.unlock();
    }

    public function blurComponent(param1:DisplayObject) : void {
      if(param1 in this.componentOverlays) {
        return;
      }
      var local2:Sprite = this.createComponentOverlay(param1);
      this.componentOverlays[param1] = local2;
      ++this.blurredComponentsCount;
      if(this.blurredComponentsCount == 1) {
        this.mainContainerService.stage.addEventListener(Event.RESIZE,this.onStageResize);
      }
      this.mainContainerService.dialogsLayer.addChildAt(local2,0);
    }

    private function createComponentOverlay(param1:DisplayObject) : Sprite {
      var local2:Sprite = new Sprite();
      param1.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      this.redrawComponentOverlay(local2,param1);
      return local2;
    }

    public function blurBattleContent() : void {
      if(!this.isBlurBattleContent) {
        this.isBlurBattleContent = true;
        this.addOverlay();
      }
      this.mainContainerService.systemLayer.addChildAt(this.overlay,0);
    }

    public function blurGameContent() : void {
      if(!this.isBlurGameContent) {
        this.isBlurGameContent = true;
        this.addOverlay();
      }
      this.mainContainerService.dialogsLayer.addChildAt(this.overlay,0);
    }

    public function blurDialogContent() : void {
      if(!this.isBlurDialogContent) {
        this.isBlurDialogContent = true;
        this.addOverlay();
      }
      this.mainContainerService.noticesLayer.addChildAt(this.overlay,0);
    }

    public function blurAllContent() : void {
      if(!this.isBlurAllContent) {
        this.isBlurAllContent = true;
        this.addOverlay();
      }
      this.mainContainerService.stage.addChild(this.overlay);
    }

    public function unblurBattleContent() : void {
      if(this.isBlurBattleContent) {
        this.isBlurBattleContent = false;
        if(this.isBlurAllContent) {
          return;
        }
        if(this.isBlurDialogContent) {
          this.blurDialogContent();
          return;
        }
        if(this.isBlurGameContent) {
          this.blurGameContent();
          return;
        }
        this.removeOverlay();
      }
    }

    public function unblurGameContent() : void {
      if(this.isBlurGameContent) {
        this.isBlurGameContent = false;
        if(this.isBlurAllContent) {
          return;
        }
        if(this.isBlurDialogContent) {
          this.blurDialogContent();
          return;
        }
        if(this.isBlurBattleContent) {
          this.blurBattleContent();
          return;
        }
        this.removeOverlay();
      }
    }

    public function unblurDialogContent() : void {
      if(this.isBlurDialogContent) {
        this.isBlurDialogContent = false;
        if(this.isBlurAllContent) {
          return;
        }
        if(this.isBlurGameContent) {
          this.blurGameContent();
          return;
        }
        if(this.isBlurBattleContent) {
          this.blurBattleContent();
          return;
        }
        this.removeOverlay();
      }
    }

    public function unblurAllContent() : void {
      if(this.isBlurAllContent) {
        this.isBlurAllContent = false;
        if(this.isBlurDialogContent) {
          this.blurDialogContent();
          return;
        }
        if(this.isBlurGameContent) {
          this.blurGameContent();
          return;
        }
        if(this.isBlurBattleContent) {
          this.blurBattleContent();
          return;
        }
        this.removeOverlay();
      }
    }

    public function unblurAllComponents() : void {
      var local1:Object = null;
      for(local1 in this.componentOverlays) {
        this.unblurComponent(DisplayObject(local1));
      }
    }

    public function unblurComponent(param1:DisplayObject) : void {
      if(param1 in this.componentOverlays) {
        param1.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
        removeDisplayObject(this.componentOverlays[param1]);
        delete this.componentOverlays[param1];
        --this.blurredComponentsCount;
        if(this.blurredComponentsCount == 0) {
          this.mainContainerService.stage.removeEventListener(Event.RESIZE,this.onStageResize);
        }
      }
    }

    private function addOverlay() : void {
      if(this.overlay.parent == null) {
        this.mainContainerService.stage.addEventListener(Event.RESIZE,this.redrawOverlay);
        this.overlay.addEventListener(MouseEvent.CLICK,this.onClickOverlay);
        this.redrawOverlay();
        lockHelpService();
      }
    }

    private function redrawOverlay(param1:Event = null) : void {
      var local2:int = int(this.mainContainerService.stage.stageWidth);
      var local3:int = int(this.mainContainerService.stage.stageHeight);
      this.overlay.graphics.clear();
      this.overlay.graphics.beginFill(OVERLAY_COLOR,OVERLAY_ALPHA);
      this.overlay.graphics.drawRect(0,0,local2,local3);
    }

    private function onClickOverlay(param1:MouseEvent) : void {
      if(this.isClickOverlayBattleContent()) {
        dispatchEvent(new BlurServiceEvent(BlurServiceEvent.CLICK_OVERLAY_BATTLE_CONTENT));
      }
    }

    private function isClickOverlayBattleContent() : Boolean {
      return this.isBlurBattleContent && !this.isBlurGameContent && !this.isBlurDialogContent && !this.isBlurAllContent;
    }

    private function removeOverlay() : void {
      if(this.overlay.parent != null) {
        this.overlay.removeEventListener(MouseEvent.CLICK,this.onClickOverlay);
        removeDisplayObject(this.overlay);
        this.mainContainerService.stage.removeEventListener(Event.RESIZE,this.redrawOverlay);
        unLockHelpService();
      }
    }

    private function onStageResize(param1:Event) : void {
      var local2:Object = null;
      for(local2 in this.componentOverlays) {
        this.redrawComponentOverlay(this.componentOverlays[local2],DisplayObject(local2));
      }
    }

    private function redrawComponentOverlay(param1:Sprite, param2:DisplayObject) : void {
      var local3:Point = param2.localToGlobal(new Point(0,0));
      param1.graphics.clear();
      param1.graphics.beginFill(0,0);
      param1.graphics.drawRect(local3.x,local3.y,param2.width,param2.height);
      param1.graphics.endFill();
    }

    private function onRemovedFromStage(param1:Event) : void {
      var local2:DisplayObject = DisplayObject(param1.target);
      this.unblurComponent(local2);
    }
  }
}
