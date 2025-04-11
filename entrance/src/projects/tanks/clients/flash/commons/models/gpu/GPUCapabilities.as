package projects.tanks.clients.flash.commons.models.gpu {
  import flash.display.Stage;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.utils.setTimeout;

  public class GPUCapabilities extends EventDispatcher {
    private static var _gpuEnabled:Boolean;
    private static var _constrained:Boolean;

    private var stage:Stage;

    public function GPUCapabilities(param1:Stage) {
      super();
      this.stage = param1;
    }

    public static function get gpuEnabled() : Boolean {
      return _gpuEnabled;
    }

    public static function get constrained() : Boolean {
      return _constrained;
    }

    public function detect() : void {
      if(this.stage3DExists()) {
        this.getContext3D();
      } else {
        this.dispatchCompleteEventWithDelay();
      }
    }

    private function stage3DExists() : Boolean {
      return this.stage.hasOwnProperty("stage3Ds");
    }

    private function getContext3D() : void {
      var local1:Object = this.getStage3D();
      local1.addEventListener("context3DCreate",this.onContext3DCreate);
      local1.addEventListener(ErrorEvent.ERROR,this.onContext3DCreateError);
      local1.requestContext3D("auto");
    }

    private function onContext3DCreate(param1:Event) : void {
      this.removeListeners();
      this.detectGPUAcceleration();
      if(!_gpuEnabled && this.isConstrainedAvaible()) {
        this.getContext3DConstrained();
      } else {
        this.dispatchCompleteEvent();
      }
    }

    private function isConstrainedAvaible() : Boolean {
      var local1:Object = this.getStage3D();
      return local1.requestContext3D.length > 1;
    }

    private function getContext3DConstrained() : void {
      _constrained = true;
      var local1:Object = this.getStage3D();
      local1.addEventListener("context3DCreate",this.onContext3DCreateConstrained);
      local1.addEventListener(ErrorEvent.ERROR,this.onContext3DCreateError);
      local1.requestContext3D("auto","baselineConstrained");
    }

    private function onContext3DCreateConstrained(param1:Event) : void {
      this.removeListeners();
      this.detectGPUAcceleration();
      this.dispatchCompleteEvent();
    }

    private function detectGPUAcceleration() : void {
      var local1:Object = this.getStage3D();
      var local2:Object = local1.context3D;
      var local3:String = local2.driverInfo;
      _gpuEnabled = local3.toLowerCase().indexOf("software") == -1;
      local2.dispose();
    }

    private function onContext3DCreateError(param1:ErrorEvent) : void {
      this.removeListeners();
      this.dispatchCompleteEvent();
    }

    private function getStage3D() : Object {
      return this.stage["stage3Ds"][0];
    }

    private function removeListeners() : void {
      var local1:Object = this.getStage3D();
      local1.removeEventListener("context3DCreate",this.onContext3DCreate);
      local1.removeEventListener("context3DCreate",this.onContext3DCreateConstrained);
      local1.removeEventListener(ErrorEvent.ERROR,this.onContext3DCreateError);
    }

    private function dispatchCompleteEventWithDelay() : void {
      setTimeout(this.dispatchCompleteEvent,0);
    }

    private function dispatchCompleteEvent() : void {
      dispatchEvent(new Event(Event.COMPLETE));
    }
  }
}
