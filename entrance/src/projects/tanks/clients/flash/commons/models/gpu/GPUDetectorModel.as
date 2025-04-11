package projects.tanks.clients.flash.commons.models.gpu {
  import alternativa.Launcher;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import flash.events.Event;
  import projects.tanks.client.commons.models.gpu.GPUDetectorModelBase;
  import projects.tanks.client.commons.models.gpu.IGPUDetectorModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.gpu.GPUDetector;

  [ModelInfo]
  public class GPUDetectorModel extends GPUDetectorModelBase implements IGPUDetectorModelBase, GPUDetector {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var launcherParams:ILauncherParams;

    private var gpuCapabilities:GPUCapabilities;

    public function GPUDetectorModel() {
      super();
    }

    public function detectGPUCapabilities() : void {
      if(this.gpuCapabilities != null) {
        server.detectionGPUcompleted(this.isGpuEnabled());
        return;
      }
      this.gpuCapabilities = new GPUCapabilities(display.stage);
      this.gpuCapabilities.addEventListener(Event.COMPLETE,getFunctionWrapper(this.onGPUCapabilitiesReady));
      this.gpuCapabilities.detect();
    }

    private function onGPUCapabilitiesReady(param1:Event) : void {
      this.gpuCapabilities.removeEventListener(Event.COMPLETE,this.onGPUCapabilitiesReady);
      this.loadAlternativa3D();
    }

    private function isGpuEnabled() : Boolean {
      return Boolean(launcherParams.getParameter("force_gpu")) || GPUCapabilities.gpuEnabled;
    }

    private function loadAlternativa3D() : void {
      var gpuEnabled:Boolean = false;
      var launcher:Launcher = null;
      gpuEnabled = this.isGpuEnabled();
      var libraryName:String = gpuEnabled ? "hardware.swf" : "software.swf";
      launcher = OSGi.getInstance().getService(Launcher);
      var notifyServer:Function = getFunctionWrapper(function():void {
        server.detectionGPUcompleted(gpuEnabled);
      });
      if(launcherParams.getParameter("develop") == null) {
        launcher.loadLibrary(libraryName,function():void {
          launcher.loadLibrary("game.swf",function():void {
            launcher.initLibrary("GameActivator");
            notifyServer();
          });
        });
      } else {
        notifyServer();
      }
    }
  }
}
