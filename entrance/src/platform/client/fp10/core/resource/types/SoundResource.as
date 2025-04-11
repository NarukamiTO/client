package platform.client.fp10.core.resource.types {
  import alternativa.startup.SoundCacheLoader;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.media.Sound;
  import flash.media.SoundLoaderContext;
  import flash.net.URLRequest;
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.ResourceFlags;
  import platform.client.fp10.core.resource.ResourceInfo;
  import platform.client.fp10.core.resource.ResourceStatus;

  public class SoundResource extends Resource {
    private var _sound:Sound;

    public function SoundResource(param1:ResourceInfo) {
      super(param1);
    }

    public function get sound() : Sound {
      return this._sound;
    }

    override public function toString() : String {
      return "[SoundResource id=" + id + "]";
    }

    override public function load(param1:String, param2:IResourceLoadingListener) : void {
      super.load(param1,param2);
      this.doLoad();
    }

    override protected function doReload() : void {
      if(isLoading) {
        clearFlags(ResourceFlags.IS_LOADING);
        this._sound.close();
      }
      this.doLoad();
    }

    private function doLoad() : void {
      this._sound = new SoundCacheLoader();
      this._sound.addEventListener(Event.OPEN,this.onLoadingOpen);
      this._sound.addEventListener(Event.COMPLETE,this.onLoadComplete);
      this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError);
      this._sound.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadError);
      this._sound.addEventListener(ProgressEvent.PROGRESS,this.onLoadProgress);
      this._sound.load(new URLRequest(baseUrl + this.getFileName()),new SoundLoaderContext());
      startTimeoutTracking();
      status = ResourceStatus.REQUESTED;
    }

    private function onLoadingOpen(param1:Event) : void {
      setFlags(ResourceFlags.IS_LOADING);
      updateLastActivityTime();
      listener.onResourceLoadingStart(this);
    }

    private function onLoadComplete(param1:Event) : void {
      clearFlags(ResourceFlags.IS_LOADING);
      this._sound.removeEventListener(Event.OPEN,this.onLoadingOpen);
      this._sound.removeEventListener(Event.COMPLETE,this.onLoadComplete);
      this._sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadError);
      this._sound.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadError);
      this._sound.removeEventListener(ProgressEvent.PROGRESS,this.onLoadProgress);
      completeLoading();
    }

    private function onLoadProgress(param1:ProgressEvent) : void {
      updateLastActivityTime();
    }

    private function onLoadError(param1:ErrorEvent) : void {
      clearFlags(ResourceFlags.IS_LOADING);
      this._sound = new SoundEmptyWrapper();
      completeLoading();
    }

    private function getFileName() : String {
      return "sound.swf";
    }
  }
}
