package projects.tanks.clients.fp10.TanksLauncher {
  import alternativa.startup.StartupSettings;
  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.events.TextEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import projects.tanks.clients.fp10.TanksLauncher.service.LocaleService;

  public class SmartErrorHandler extends Sprite {
    public static const OVERLOADED_ERROR:String = "overloaded";
    public static const NOTAVAILABLE_ERROR:String = "notavailable";

    private var errorMessage:String;
    private var errorCode:String;
    private var tanksErrorMessage:*;

    public function SmartErrorHandler(param1:String, param2:String) {
      super();
      this.errorMessage = param1;
      this.errorCode = param2;
    }

    private function showSimpleMessage(param1:String) : void {
      var local2:TextField = new TextField();
      local2.wordWrap = true;
      local2.multiline = true;
      local2.width = 600;
      local2.autoSize = TextFieldAutoSize.LEFT;
      local2.defaultTextFormat = new TextFormat("Tahoma",16,16777215);
      local2.text = param1;
      stage.addChild(local2);
      local2.x = stage.stageWidth - local2.width >> 1;
      local2.y = stage.stageHeight - local2.height >> 1;
    }

    public function handleLoadingError() : void {
      var local1:URLRequest = null;
      var local2:Loader = null;
      var local3:LoaderInfo = null;
      if(this.forceShowDetailedError || this.isDebugMode || StartupSettings.isDesktop) {
        this.showSimpleMessage(this.errorMessage);
      } else {
        local1 = new URLRequest("TanksErrorScreen.swf");
        local2 = new Loader();
        local3 = local2.contentLoaderInfo;
        local3.addEventListener(Event.COMPLETE,this.onLoadingErrorMessageComplete);
        local3.addEventListener(IOErrorEvent.IO_ERROR,this.onFailedLoadingTanksErrorMessageClass);
        local3.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFailedLoadingTanksErrorMessageClass);
        local2.load(local1);
      }
    }

    private function onFailedLoadingTanksErrorMessageClass(param1:Event) : void {
      this.showSimpleMessage(this.errorMessage);
    }

    private function onLoadingErrorMessageComplete(param1:Event) : void {
      this.tanksErrorMessage = param1.currentTarget.content;
      this.tanksErrorMessage.init(this.errorCode,this.isTestServer,LocaleService.anotherGameServerUrl,LocaleService.currentLocale);
      this.tanksErrorMessage.addEventListener("LINK_CLICKED",this.onLinkClicked);
      stage.addChild(this.tanksErrorMessage);
      this.tanksErrorMessage.redraw(stage.stageWidth,stage.stageHeight);
      stage.addEventListener(Event.RESIZE,this.draw);
    }

    private function onLinkClicked(param1:TextEvent) : void {
      var event:TextEvent = param1;
      try {
        navigateToURL(new URLRequest(event.text),"_top");
      }
      catch(e:Error) {
      }
    }

    private function draw(param1:Event) : void {
      this.tanksErrorMessage.redraw(stage.stageWidth,stage.stageHeight);
    }

    private function get isDebugMode() : Boolean {
      return Boolean(loaderInfo.parameters["debug"]);
    }

    private function get isTestServer() : Boolean {
      return Boolean(loaderInfo.parameters["test_server"]);
    }

    private function get forceShowDetailedError() : Boolean {
      return Boolean(loaderInfo.parameters["show_detailed_error"]);
    }
  }
}
