package projects.tanks.clients.fp10.libraries.tanksservices.model.gpu {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GPUDetectorEvents implements GPUDetector {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function GPUDetectorEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function detectGPUCapabilities() : void {
      var i:int = 0;
      var m:GPUDetector = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GPUDetector(this.impl[i]);
          m.detectGPUCapabilities();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
