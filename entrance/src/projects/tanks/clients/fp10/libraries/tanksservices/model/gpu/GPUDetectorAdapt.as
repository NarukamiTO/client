package projects.tanks.clients.fp10.libraries.tanksservices.model.gpu {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GPUDetectorAdapt implements GPUDetector {
    private var object:IGameObject;
    private var impl:GPUDetector;

    public function GPUDetectorAdapt(param1:IGameObject, param2:GPUDetector) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function detectGPUCapabilities() : void {
      try {
        Model.object = this.object;
        this.impl.detectGPUCapabilities();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
