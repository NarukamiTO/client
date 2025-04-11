package alternativa.types {
  import alternativa.ILauncherListener;
  import alternativa.osgi.service.launcherparams.ILauncherParams;

  public class DummyListener implements ILauncherListener {
    private var logOutput:LogOutput;

    public function DummyListener(param1:LogOutput) {
      super();
      this.logOutput = param1;
    }

    public function onConfigLoadingStart() : void {
      this.log("Config loading start");
    }

    public function onConfigLoadingComplete() : void {
      this.log("Config loading complete");
    }

    public function onConfigLoadingProgress(param1:uint, param2:uint) : void {
    }

    public function onLibrariesLoadingStart() : void {
      this.log("Libraries loading start");
    }

    public function onLibrariesLoadingComplete(param1:ILauncherParams, param2:Function) : void {
      this.log("Libraries loading complete");
      param2();
    }

    public function onLibraryLoadingError(param1:String) : void {
      this.log("Library loading error: " + param1);
    }

    public function onLibrariesLoadingProgress(param1:uint, param2:uint) : void {
    }

    public function onServerUnavailable() : void {
      this.log("Server is unavailable");
    }

    public function onServerOverloaded() : void {
      this.log("Server is overloaded");
    }

    public function onConfigLoadingError(param1:String) : void {
      this.log("Configuration loading error: " + param1);
    }

    public function onLibrariesInitialized() : void {
      this.log("Libraries have been initialized");
    }

    private function log(param1:String) : void {
      if(this.logOutput != null) {
        this.logOutput.addLine(param1);
      }
    }
  }
}
