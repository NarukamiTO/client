package fl.containers {
  import fl.controls.ScrollPolicy;
  import fl.core.InvalidationType;
  import fl.events.ScrollEvent;
  import fl.managers.IFocusManagerComponent;
  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.HTTPStatusEvent;
  import flash.events.IOErrorEvent;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import flash.ui.Keyboard;

  [Style(name="contentPadding",type="Number",format="Length")]
  [Style(name="upSkin",type="Class")]
  [Style(name="disabledSkin",type="Class")]
  [Event("progress",type="flash.events.ProgressEvent")]
  [Event("securityError",type="flash.events.SecurityErrorEvent")]
  [Event("open",type="flash.events.Event")]
  [Event("ioError",type="flash.events.IOErrorEvent")]
  [Event("init",type="flash.events.Event")]
  [Event(name="complete",type="flash.events.Event")]
  [Event(name="progress",type="flash.events.ProgressEvent")]
  [Event(name="scroll",type="fl.events.ScrollEvent")]
  [Embed(source="/_assets/assets.swf", symbol="symbol1016")]
  public class ScrollPane extends BaseScrollPane implements IFocusManagerComponent {
    private static var defaultStyles:Object = {
      "upSkin":"ScrollPane_upSkin",
      "disabledSkin":"ScrollPane_disabledSkin",
      "focusRectSkin":null,
      "focusRectPadding":null,
      "contentPadding":0
    };

    protected var scrollDragHPos:Number;
    protected var loader:Loader;
    protected var xOffset:Number;
    protected var _source:Object = "";
    protected var scrollDragVPos:Number;
    protected var _scrollDrag:Boolean = false;
    protected var currentContent:Object;
    protected var contentClip:Sprite;
    protected var yOffset:Number;

    public function ScrollPane() {
      super();
    }

    public static function getStyleDefinition() : Object {
      return mergeStyles(defaultStyles,BaseScrollPane.getStyleDefinition());
    }

    protected function clearContent() : void {
      if(contentClip.numChildren == 0) {
        return;
      }
      contentClip.removeChildAt(0);
      currentContent = null;
      if(loader != null) {
        try {
          loader.close();
        }
        catch(e:*) {
        }
        try {
          loader.unload();
        }
        catch(e:*) {
        }
        loader = null;
      }
    }

    protected function passEvent(param1:Event) : void {
      dispatchEvent(param1);
    }

    protected function calculateAvailableHeight() : Number {
      var local1:Number = Number(getStyleValue("contentPadding"));
      return height - local1 * 2 - (_horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && _maxHorizontalScrollPosition > 0 ? 15 : 0);
    }

    override protected function drawLayout() : void {
      super.drawLayout();
      contentScrollRect = contentClip.scrollRect;
      contentScrollRect.width = availableWidth;
      contentScrollRect.height = availableHeight;
      contentClip.cacheAsBitmap = useBitmapScrolling;
      contentClip.scrollRect = contentScrollRect;
      contentClip.x = contentClip.y = contentPadding;
    }

    public function get bytesTotal() : Number {
      return loader == null || loader.contentLoaderInfo == null ? 0 : loader.contentLoaderInfo.bytesTotal;
    }

    [Inspectable(type="String",defaultValue="")]
    public function get source() : Object {
      return _source;
    }

    override protected function handleScroll(param1:ScrollEvent) : void {
      passEvent(param1);
      super.handleScroll(param1);
    }

    protected function onContentLoad(param1:Event) : void {
      update();
      var local2:* = calculateAvailableHeight();
      calculateAvailableSize();
      horizontalScrollBar.setScrollProperties(availableWidth,0,useFixedHorizontalScrolling ? _maxHorizontalScrollPosition : contentWidth - availableWidth,availableWidth);
      verticalScrollBar.setScrollProperties(local2,0,contentHeight - local2,local2);
      passEvent(param1);
    }

    [Inspectable(type="Boolean",defaultValue="false")]
    public function get scrollDrag() : Boolean {
      return _scrollDrag;
    }

    protected function setScrollDrag() : void {
      if(_scrollDrag) {
        contentClip.addEventListener(MouseEvent.MOUSE_DOWN,doStartDrag,false,0,true);
        stage.addEventListener(MouseEvent.MOUSE_UP,endDrag,false,0,true);
      } else {
        contentClip.removeEventListener(MouseEvent.MOUSE_DOWN,doStartDrag);
        stage.removeEventListener(MouseEvent.MOUSE_UP,endDrag);
        removeEventListener(MouseEvent.MOUSE_MOVE,doDrag);
      }
      contentClip.buttonMode = _scrollDrag;
    }

    public function get percentLoaded() : Number {
      if(loader != null) {
        return Math.round(bytesLoaded / bytesTotal * 100);
      }
      return 0;
    }

    override protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void {
      var local3:* = contentClip.scrollRect;
      local3.y = param1;
      contentClip.scrollRect = local3;
    }

    protected function endDrag(param1:MouseEvent) : void {
      stage.removeEventListener(MouseEvent.MOUSE_MOVE,doDrag);
    }

    override protected function drawBackground() : void {
      var local1:DisplayObject = background;
      background = getDisplayObjectInstance(getStyleValue(enabled ? "upSkin" : "disabledSkin"));
      background.width = width;
      background.height = height;
      addChildAt(background,0);
      if(local1 != null && local1 != background) {
        removeChild(local1);
      }
    }

    public function set source(param1:Object) : void {
      var local2:* = undefined;
      clearContent();
      if(isLivePreview) {
        return;
      }
      _source = param1;
      if(_source == "" || _source == null) {
        return;
      }
      currentContent = getDisplayObjectInstance(param1);
      if(currentContent != null) {
        local2 = contentClip.addChild(currentContent as DisplayObject);
        dispatchEvent(new Event(Event.INIT));
        update();
      } else {
        load(new URLRequest(_source.toString()));
      }
    }

    public function set scrollDrag(param1:Boolean) : void {
      _scrollDrag = param1;
      invalidate(InvalidationType.STATE);
    }

    protected function initLoader() : void {
      loader = new Loader();
      loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,handleError,false,0,true);
      loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,handleError,false,0,true);
      loader.contentLoaderInfo.addEventListener(Event.OPEN,passEvent,false,0,true);
      loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,passEvent,false,0,true);
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onContentLoad,false,0,true);
      loader.contentLoaderInfo.addEventListener(Event.INIT,passEvent,false,0,true);
      loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,passEvent,false,0,true);
      contentClip.addChild(loader);
    }

    override protected function draw() : void {
      if(isInvalid(InvalidationType.STYLES)) {
        drawBackground();
      }
      if(isInvalid(InvalidationType.STATE)) {
        setScrollDrag();
      }
      super.draw();
    }

    protected function clearLoadEvents() : void {
      loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,handleError);
      loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,handleError);
      loader.contentLoaderInfo.removeEventListener(Event.OPEN,passEvent);
      loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,passEvent);
      loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS,passEvent);
      loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onContentLoad);
    }

    protected function handleError(param1:Event) : void {
      passEvent(param1);
      clearLoadEvents();
      loader.contentLoaderInfo.removeEventListener(Event.INIT,handleInit);
    }

    public function get bytesLoaded() : Number {
      return loader == null || loader.contentLoaderInfo == null ? 0 : loader.contentLoaderInfo.bytesLoaded;
    }

    override protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void {
      var local3:* = contentClip.scrollRect;
      local3.x = param1;
      contentClip.scrollRect = local3;
    }

    override protected function configUI() : void {
      super.configUI();
      contentClip = new Sprite();
      addChild(contentClip);
      contentClip.scrollRect = contentScrollRect;
      _horizontalScrollPolicy = ScrollPolicy.AUTO;
      _verticalScrollPolicy = ScrollPolicy.AUTO;
    }

    protected function handleInit(param1:Event) : void {
      loader.contentLoaderInfo.removeEventListener(Event.INIT,handleInit);
      passEvent(param1);
      invalidate(InvalidationType.SIZE);
    }

    public function update() : void {
      var local1:DisplayObject = contentClip.getChildAt(0);
      setContentSize(local1.width,local1.height);
    }

    public function refreshPane() : void {
      if(_source is URLRequest) {
        _source = _source.url;
      }
      source = _source;
    }

    public function load(param1:URLRequest, param2:LoaderContext = null) : void {
      if(param2 == null) {
        param2 = new LoaderContext(false,ApplicationDomain.currentDomain);
      }
      clearContent();
      initLoader();
      currentContent = _source = param1;
      loader.load(param1,param2);
    }

    protected function doStartDrag(param1:MouseEvent) : void {
      if(!enabled) {
        return;
      }
      xOffset = mouseX;
      yOffset = mouseY;
      scrollDragHPos = horizontalScrollPosition;
      scrollDragVPos = verticalScrollPosition;
      stage.addEventListener(MouseEvent.MOUSE_MOVE,doDrag,false,0,true);
    }

    protected function doDrag(param1:MouseEvent) : void {
      var local2:* = scrollDragVPos - (mouseY - yOffset);
      _verticalScrollBar.setScrollPosition(local2);
      setVerticalScrollPosition(_verticalScrollBar.scrollPosition,true);
      var local3:* = scrollDragHPos - (mouseX - xOffset);
      _horizontalScrollBar.setScrollPosition(local3);
      setHorizontalScrollPosition(_horizontalScrollBar.scrollPosition,true);
    }

    override protected function keyDownHandler(param1:KeyboardEvent) : void {
      var local2:int = calculateAvailableHeight();
      switch(param1.keyCode) {
        case Keyboard.DOWN:
          ++verticalScrollPosition;
          break;
        case Keyboard.UP:
          --verticalScrollPosition;
          break;
        case Keyboard.RIGHT:
          ++horizontalScrollPosition;
          break;
        case Keyboard.LEFT:
          --horizontalScrollPosition;
          break;
        case Keyboard.END:
          verticalScrollPosition = maxVerticalScrollPosition;
          break;
        case Keyboard.HOME:
          verticalScrollPosition = 0;
          break;
        case Keyboard.PAGE_UP:
          verticalScrollPosition -= local2;
          break;
        case Keyboard.PAGE_DOWN:
          verticalScrollPosition += local2;
      }
    }

    public function get content() : DisplayObject {
      var local1:Object = currentContent;
      if(local1 is URLRequest) {
        local1 = loader.content;
      }
      return local1 as DisplayObject;
    }
  }
}
