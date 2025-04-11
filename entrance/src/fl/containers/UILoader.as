package fl.containers {
  import fl.core.InvalidationType;
  import fl.core.UIComponent;
  import fl.events.ComponentEvent;
  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.HTTPStatusEvent;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import flash.utils.ByteArray;

  [Event("securityError",type="flash.events.SecurityErrorEvent")]
  [Event("resize",type="fl.events.ComponentEvent")]
  [Event("progress",type="flash.events.ProgressEvent")]
  [Event("open",type="flash.events.Event")]
  [Event("ioError",type="flash.events.IOErrorEvent")]
  [Event("init",type="flash.events.Event")]
  [Event("complete",type="flash.events.Event")]
  [Embed(source="/_assets/assets.swf", symbol="symbol636")]
  public class UILoader extends UIComponent {
    private static var defaultStyles:Object = {};

    protected var contentInited:Boolean = false;
    protected var _maintainAspectRatio:Boolean = true;
    protected var loader:Loader;
    protected var _autoLoad:Boolean = true;
    protected var contentClip:Sprite;
    protected var _scaleContent:Boolean = true;
    protected var _source:Object;

    public function UILoader() {
      super();
    }

    public static function getStyleDefinition() : Object {
      return defaultStyles;
    }

    protected function _unload(param1:Boolean = false) : void {
      var throwError:Boolean = param1;
      if(loader != null) {
        clearLoadEvents();
        contentClip.removeChild(loader);
        try {
          loader.close();
        }
        catch(e:Error) {
        }
        try {
          loader.unload();
        }
        catch(e:*) {
          if(throwError) {
            throw e;
          }
        }
        loader = null;
        return;
      }
      contentInited = false;
      if(Boolean(contentClip.numChildren)) {
        contentClip.removeChildAt(0);
      }
    }

    protected function handleComplete(param1:Event) : void {
      clearLoadEvents();
      passEvent(param1);
    }

    override public function setSize(param1:Number, param2:Number) : void {
      if(!_scaleContent && _width > 0) {
        return;
      }
      super.setSize(param1,param2);
    }

    override protected function draw() : void {
      if(isInvalid(InvalidationType.SIZE)) {
        drawLayout();
      }
      super.draw();
    }

    protected function handleError(param1:Event) : void {
      passEvent(param1);
      clearLoadEvents();
      loader.contentLoaderInfo.removeEventListener(Event.INIT,handleInit);
    }

    protected function initLoader() : void {
      loader = new Loader();
      contentClip.addChild(loader);
    }

    protected function clearLoadEvents() : void {
      loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,handleError);
      loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,handleError);
      loader.contentLoaderInfo.removeEventListener(Event.OPEN,passEvent);
      loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,passEvent);
      loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS,passEvent);
      loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,handleComplete);
    }

    protected function drawLayout() : void {
      var local2:Number = NaN;
      var local3:Number = NaN;
      var local6:LoaderInfo = null;
      if(!contentInited) {
        return;
      }
      var local1:Boolean = false;
      if(Boolean(loader)) {
        local6 = loader.contentLoaderInfo;
        local2 = local6.width;
        local3 = local6.height;
      } else {
        local2 = contentClip.width;
        local3 = contentClip.height;
      }
      var local4:Number = _width;
      var local5:Number = _height;
      if(!_scaleContent) {
        _width = contentClip.width;
        _height = contentClip.height;
      } else {
        sizeContent(contentClip,local2,local3,_width,_height);
      }
      if(local4 != _width || local5 != _height) {
        dispatchEvent(new ComponentEvent(ComponentEvent.RESIZE,true));
      }
    }

    [Inspectable(defaultValue="true")]
    public function get scaleContent() : Boolean {
      return _scaleContent;
    }

    override protected function configUI() : void {
      super.configUI();
      contentClip = new Sprite();
      addChild(contentClip);
    }

    [Inspectable(defaultValue="true")]
    public function get maintainAspectRatio() : Boolean {
      return _maintainAspectRatio;
    }

    protected function passEvent(param1:Event) : void {
      dispatchEvent(param1);
    }

    public function get bytesTotal() : uint {
      return loader == null || loader.contentLoaderInfo == null ? 0 : loader.contentLoaderInfo.bytesTotal;
    }

    protected function sizeContent(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number) : void {
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local6:Number = param4;
      var local7:Number = param5;
      if(_maintainAspectRatio) {
        local8 = param4 / param5;
        local9 = param2 / param3;
        if(local8 < local9) {
          local7 = local6 / local9;
        } else {
          local6 = local7 * local9;
        }
      }
      param1.width = local6;
      param1.height = local7;
      param1.x = param4 / 2 - local6 / 2;
      param1.y = param5 / 2 - local7 / 2;
    }

    [Inspectable(defaultValue="",type="String")]
    public function get source() : Object {
      return _source;
    }

    public function set scaleContent(param1:Boolean) : void {
      if(_scaleContent == param1) {
        return;
      }
      _scaleContent = param1;
      invalidate(InvalidationType.SIZE);
    }

    public function get bytesLoaded() : uint {
      return loader == null || loader.contentLoaderInfo == null ? 0 : loader.contentLoaderInfo.bytesLoaded;
    }

    public function loadBytes(param1:ByteArray, param2:LoaderContext = null) : void {
      var bytes:ByteArray = param1;
      var context:LoaderContext = param2;
      _unload();
      initLoader();
      try {
        loader.loadBytes(bytes,context);
      }
      catch(error:*) {
        throw error;
      }
    }

    protected function handleInit(param1:Event) : void {
      loader.contentLoaderInfo.removeEventListener(Event.INIT,handleInit);
      contentInited = true;
      passEvent(param1);
      invalidate(InvalidationType.SIZE);
    }

    public function set autoLoad(param1:Boolean) : void {
      _autoLoad = param1;
      if(_autoLoad && loader == null && _source != null && _source != "") {
        load();
      }
    }

    public function load(param1:URLRequest = null, param2:LoaderContext = null) : void {
      _unload();
      if((param1 == null || param1.url == null) && (_source == null || _source == "")) {
        return;
      }
      var local3:DisplayObject = getDisplayObjectInstance(source);
      if(local3 != null) {
        contentClip.addChild(local3);
        contentInited = true;
        invalidate(InvalidationType.SIZE);
        return;
      }
      param1 = param1;
      if(param1 == null) {
        param1 = new URLRequest(_source.toString());
      }
      if(param2 == null) {
        param2 = new LoaderContext(false,ApplicationDomain.currentDomain);
      }
      initLoader();
      loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,handleError,false,0,true);
      loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,handleError,false,0,true);
      loader.contentLoaderInfo.addEventListener(Event.OPEN,passEvent,false,0,true);
      loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,passEvent,false,0,true);
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE,handleComplete,false,0,true);
      loader.contentLoaderInfo.addEventListener(Event.INIT,handleInit,false,0,true);
      loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,passEvent,false,0,true);
      loader.load(param1,param2);
    }

    public function get percentLoaded() : Number {
      return bytesTotal <= 0 ? 0 : bytesLoaded / bytesTotal * 100;
    }

    public function set maintainAspectRatio(param1:Boolean) : void {
      _maintainAspectRatio = param1;
      invalidate(InvalidationType.SIZE);
    }

    [Inspectable(defaultValue="true")]
    public function get autoLoad() : Boolean {
      return _autoLoad;
    }

    public function set source(param1:Object) : void {
      if(param1 == "") {
        return;
      }
      _source = param1;
      _unload();
      if(_autoLoad && _source != null) {
        load();
      }
    }

    public function close() : void {
      try {
        loader.close();
      }
      catch(error:*) {
        throw error;
      }
    }

    public function get content() : DisplayObject {
      if(loader != null) {
        return loader.content;
      }
      if(Boolean(contentClip.numChildren)) {
        return contentClip.getChildAt(0);
      }
      return null;
    }

    public function unload() : void {
      _source = null;
      _unload(true);
    }
  }
}
