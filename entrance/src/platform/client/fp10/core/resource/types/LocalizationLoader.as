package platform.client.fp10.core.resource.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.locale.LocaleService;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.protocol.IProtocol;
  import alternativa.startup.CacheURLLoader;
  import alternativa.types.URL;
  import flash.display.BitmapData;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.utils.ByteArray;
  import platform.client.core.general.resourcelocale.format.ImagePair;
  import platform.client.core.general.resourcelocale.format.LocalizedFileFormat;
  import platform.client.core.general.resourcelocale.format.StringPair;
  import platform.client.fp10.core.resource.BatchImageConstructor;

  public class LocalizationLoader {
    private var localeService:ILocaleService;
    private var localeStruct:LocalizedFileFormat;
    private var batchImageConstructor:BatchImageConstructor;
    private var localizationLogger:Logger;

    protected var loadCompleteHandler:Function;

    private var urlParams:ILauncherParams;

    public function LocalizationLoader(param1:ILauncherParams) {
      super();
      var local2:OSGi = OSGi.getInstance();
      this.urlParams = param1;
      var local3:String = param1.getParameter("lang","en");
      this.localeService = new LocaleService(local3,"en");
      local2.registerService(ILocaleService,this.localeService);
      this.localizationLogger = local2.getService(LogService).getLogger("localization");
    }

    public function load(param1:Function) : void {
      this.loadCompleteHandler = param1;
      this.loadMeta();
    }

    private function loadMeta() : void {
      var local1:String = this.getLocalizationRootUrl() + "meta.json?rand=" + Math.random();
      var local2:URLLoader = new URLLoader();
      local2.dataFormat = URLLoaderDataFormat.BINARY;
      local2.addEventListener(Event.COMPLETE,this.onLoadMetaComplete);
      local2.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      local2.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
      local2.load(new URLRequest(local1));
    }

    private function getLocalizationRootUrl() : String {
      var local4:String = null;
      var local1:String = this.urlParams.getParameter("resources");
      var local2:int = int(local1.indexOf("resources/"));
      var local3:String = local2 == -1 ? local1 : local1.substr(0,local2);
      if(local3.indexOf("://") == -1) {
        local4 = new URL(this.urlParams.urlLoader,this.urlParams.isStrictUseHttp()).scheme;
        local3 = local4 + "://" + local3;
      }
      if(local3.lastIndexOf("/") != local3.length - 1) {
        local3 += "/";
      }
      return local3 + "localization/";
    }

    private function onLoadMetaComplete(param1:Event) : void {
      var local2:Object = JSON.parse(unescape(param1.target.data));
      var local3:String = local2[this.localeService.language.toUpperCase() + ".l18n"];
      this.loadData(this.getLocalizationRootUrl() + local3);
    }

    private function loadData(param1:String) : void {
      var local2:CacheURLLoader = new CacheURLLoader();
      local2.dataFormat = URLLoaderDataFormat.BINARY;
      local2.addEventListener(Event.COMPLETE,this.onLoadingComplete);
      local2.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      local2.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
      local2.load(new URLRequest(param1));
    }

    protected function onLoadingComplete(param1:Event) : void {
      var local2:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.localeStruct = local2.decode(LocalizedFileFormat,URLLoader(param1.target).data);
      this.registerValues();
    }

    private function onLoadingError(param1:ErrorEvent) : void {
      this.localizationLogger.error("Localization not loaded: " + param1.errorID + ", " + param1.text);
    }

    private function registerValues() : void {
      var local1:StringPair = null;
      if(this.localeStruct.strings != null) {
        for each(local1 in this.localeStruct.strings) {
          this.localeService.setText(local1.key,local1.value);
        }
      }
      if(this.localeStruct.images != null && this.localeStruct.images.length > 0) {
        this.createImages();
      }
      this.loadCompleteHandler();
    }

    private function createImages() : void {
      var local2:ImagePair = null;
      var local1:Vector.<ByteArray> = new Vector.<ByteArray>();
      for each(local2 in this.localeStruct.images) {
        local1.push(local2.value);
      }
      this.batchImageConstructor = new BatchImageConstructor();
      this.batchImageConstructor.addEventListener(Event.COMPLETE,this.onImagesComplete);
      this.batchImageConstructor.buildImages(local1,5);
    }

    private function onImagesComplete(param1:Event) : void {
      var local2:Vector.<BitmapData> = this.batchImageConstructor.images;
      this.batchImageConstructor = null;
      var local3:Vector.<ImagePair> = this.localeStruct.images;
      var local4:int = 0;
      while(local4 < local2.length) {
        this.localeService.setImage(local3[local4].key,local2[local4]);
        local4++;
      }
    }
  }
}
