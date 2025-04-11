package projects.tanks.clients.fp10.models.tankspartnersmodel.guestform {
  import alternativa.startup.CacheLoader;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.system.LoaderContext;

  public class GuestForm extends Sprite {
    private static const ttfFont:Class = GuestForm_ttfFont;

    private var backgroundImageBitmap:Bitmap;
    private var normalBitmap:Bitmap;
    private var overBitmap:Bitmap;
    private var logoBitmap:BitmapData;
    private var logoAlphaBitmap:BitmapData;
    private var urls:Vector.<String> = new Vector.<String>();
    private var loader:CacheLoader;
    private var urlsCounter:int = -1;
    private var stageWidth:int;
    private var stageHeight:int;
    private var background:BackgroundImage;
    private var backgoundFill:BackgroundFill;
    private var logo:TankiLogo;
    private var buttonStart:Button;
    private var buttonHandler:Function;

    public function GuestForm(param1:Function) {
      super();
      this.urls.push("background.jpg");
      this.urls.push("button_normal.png");
      this.urls.push("button_over.png");
      this.urls.push("logo.jpg");
      this.urls.push("alpha.jpg");
      this.buttonHandler = param1;
      this.loadNextBMP();
    }

    private function loadNextBMP(param1:Event = null) : void {
      var local2:Bitmap = null;
      var local3:String = null;
      var local4:LoaderContext = null;
      if(this.urlsCounter >= 0 && !(param1 is ErrorEvent)) {
        local2 = this.loader.content as Bitmap;
        local3 = this.urls[this.urlsCounter];
        if(local3.indexOf("logo") >= 0) {
          this.logoBitmap = local2.bitmapData;
        } else if(local3.indexOf("alpha") >= 0) {
          this.logoAlphaBitmap = local2.bitmapData;
        } else if(local3.indexOf("background") >= 0) {
          this.backgroundImageBitmap = local2;
        } else if(local3.indexOf("normal") >= 0) {
          this.normalBitmap = local2;
        } else if(local3.indexOf("over") >= 0) {
          this.overBitmap = local2;
        }
      }
      if(++this.urlsCounter < this.urls.length) {
        this.loader = new CacheLoader();
        this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadNextBMP);
        this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadNextBMP);
        this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadNextBMP);
        local4 = new LoaderContext(true);
        if("imageDecodingPolicy" in local4) {
          local4["imageDecodingPolicy"] = "onLoad";
        }
        this.loader.load(new URLRequest(this.urls[this.urlsCounter]),local4);
      } else {
        this.init();
      }
    }

    private function init(param1:Event = null) : void {
      this.backgoundFill = new BackgroundFill();
      addChild(this.backgoundFill);
      this.background = new BackgroundImage(this.backgroundImageBitmap);
      addChild(this.background);
      this.logo = new TankiLogo(this.logoBitmap,this.logoAlphaBitmap);
      addChild(this.logo);
      this.buttonStart = new Button(this.normalBitmap,this.overBitmap,this.buttonHandler);
      addChild(this.buttonStart);
      if(stage != null) {
        stage.addEventListener(Event.RESIZE,this.onResize);
        stage.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
        this.resize(stage.stageWidth,stage.stageHeight);
      }
    }

    private function onRemovedFromStage(param1:Event) : void {
      stage.removeEventListener(Event.RESIZE,this.onResize);
      stage.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
    }

    private function onResize(param1:Event) : void {
      if(stage != null) {
        this.resize(stage.stageWidth,stage.stageHeight);
      }
    }

    public function resize(param1:int, param2:int) : void {
      if(this.backgoundFill != null) {
        this.backgoundFill.redraw(param1,param2);
        this.background.resposition(param1,param2);
        this.logo.reposition(param1,param2);
        this.buttonStart.reposition(param1,param2);
      }
      this.stageWidth = param1;
      this.stageHeight = param2;
    }
  }
}
