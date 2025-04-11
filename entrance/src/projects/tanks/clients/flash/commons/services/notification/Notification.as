package projects.tanks.clients.flash.commons.services.notification {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.types.Long;
  import controls.TankWindow;
  import controls.TankWindowInner;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import org.osflash.signals.Signal;
  import projects.tanks.clients.flash.commons.services.notification.sound.INotificationSoundService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
  import utils.tweener.TweenLite;
  import utils.tweener.easing.Linear;

  public class Notification extends Sprite implements INotification {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var notificationSoundService:INotificationSoundService;

    protected static const GAP:int = 11;

    private static const DEFAULT_WIDTH:int = 247;
    private static const DEFAULT_HEIGHT:int = 200;
    private static const START_POSITION_X:int = 100;
    private static const POSITION_Y:int = 34;
    private static const SHOW_TIME_IN_SEC:int = 10;
    private static const DURATION_SHOW:Number = 0.3;
    private static const DURATION_HIDE:Number = 0.3;

    protected var _background:TankWindow;
    protected var _inner:TankWindowInner;
    protected var _width:int;
    protected var _height:int;
    protected var _innerHeight:int;

    private var _closeSignal:Signal;
    private var _isShow:Boolean;
    private var _delayHideTimeOut:uint;
    private var _userId:Long;
    private var _message:String;
    private var _autoClosable:Boolean;

    public function Notification(param1:Long = null, param2:String = "", param3:Boolean = true) {
      super();
      this._userId = param1;
      this._message = param2;
      this._autoClosable = param3;
      this.init();
    }

    protected function init() : void {
      this._width = DEFAULT_WIDTH;
      this._height = DEFAULT_HEIGHT;
      this._innerHeight = this._height - GAP * 2;
      this.createBackGround();
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    private function onAddedToStage(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      display.stage.addEventListener(Event.RESIZE,this.onResize);
      this.setEvents();
    }

    protected function setEvents() : void {
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
      addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      this._background.addEventListener(MouseEvent.CLICK,this.onCloseNotification);
    }

    private function onRemoveFromStage(param1:Event) : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      display.stage.removeEventListener(Event.RESIZE,this.onResize);
    }

    private function onResize(param1:Event) : void {
      this.resize();
    }

    private function onRollOver(param1:MouseEvent) : void {
      clearTimeout(this._delayHideTimeOut);
    }

    private function onRollOut(param1:MouseEvent) : void {
      this.clearAndSetHideTimeOut();
    }

    private function onCloseNotification(param1:MouseEvent) : void {
      this.closeNotification();
    }

    protected function closeNotification() : void {
      this.hide();
    }

    protected function removeEvents() : void {
      removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
      removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      this._background.removeEventListener(MouseEvent.CLICK,this.onCloseNotification);
    }

    private function createBackGround() : void {
      this._background = new TankWindow();
      addChild(this._background);
      this._inner = new TankWindowInner(DEFAULT_WIDTH,DEFAULT_HEIGHT,TankWindowInner.GREEN);
      addChild(this._inner);
      this._inner.mouseChildren = false;
      this._inner.mouseEnabled = false;
      this._inner.x = this._inner.y = GAP;
      this._inner.showBlink = true;
    }

    public function show(param1:Signal) : void {
      this._closeSignal = param1;
      this.resize();
      this._isShow = true;
      display.noticesLayer.addChild(this);
      TweenLite.to(this,DURATION_SHOW,{
        "x":display.stage.stageWidth - this._width,
        "ease":Linear.easeNone,
        "onComplete":this.onCompleteShow
      });
      notificationSoundService.playNotificationSound();
    }

    private function onCompleteShow() : void {
      this.enable = true;
      this.setEvents();
      this.clearAndSetHideTimeOut();
    }

    private function clearAndSetHideTimeOut() : void {
      if(this._autoClosable) {
        clearTimeout(this._delayHideTimeOut);
        this._delayHideTimeOut = setTimeout(this.closeNotification,SHOW_TIME_IN_SEC * 1000);
      }
    }

    public function destroy() : void {
      this.removeEvents();
      clearTimeout(this._delayHideTimeOut);
      removeDisplayObject(this);
    }

    public function hide() : void {
      this._isShow = false;
      this.enable = false;
      this.removeEvents();
      clearTimeout(this._delayHideTimeOut);
      TweenLite.to(this,DURATION_HIDE,{
        "x":display.stage.stageWidth + START_POSITION_X,
        "ease":Linear.easeNone,
        "onComplete":this.onCompleteHide
      });
    }

    private function onCompleteHide() : void {
      removeDisplayObject(this);
      this._closeSignal.dispatch();
      this._closeSignal = null;
    }

    protected function resize() : void {
      this.resizeBackground();
      if(this._isShow) {
        this.x = display.stage.stageWidth - this._width;
      } else {
        this.x = display.stage.stageWidth + START_POSITION_X;
      }
      this.y = POSITION_Y;
    }

    private function resizeBackground() : void {
      this._background.width = this._width;
      this._background.height = this._height;
      this._inner.width = this._background.width - GAP * 2;
      this._inner.height = this._innerHeight;
    }

    public function set enable(param1:Boolean) : void {
      mouseChildren = param1;
      mouseEnabled = param1;
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function get message() : String {
      return this._message;
    }

    public function set autoClosable(param1:Boolean) : void {
      this._autoClosable = param1;
    }
  }
}
