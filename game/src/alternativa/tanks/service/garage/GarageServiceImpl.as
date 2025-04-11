package alternativa.tanks.service.garage {
  import alternativa.tanks.gui.IGarageWindow;

  public class GarageServiceImpl implements GarageService {
    private var view:IGarageWindow;
    private var cameraPitch:Number;
    private var cameraAltitude:Number;
    private var cameraDistance:Number;
    private var cameraFov:Number;

    public function GarageServiceImpl() {
      super();
    }

    public function getView() : IGarageWindow {
      return this.view;
    }

    public function registerView(param1:IGarageWindow) : void {
      this.view = param1;
    }

    public function unregisterView() : void {
      this.view = null;
    }

    public function init(param1:Number, param2:Number, param3:Number, param4:Number) : void {
      this.cameraPitch = param1;
      this.cameraAltitude = param2;
      this.cameraDistance = param3;
      this.cameraFov = param4;
    }

    public function getCameraPitch() : Number {
      return this.cameraPitch;
    }

    public function getCameraAltitude() : Number {
      return this.cameraAltitude;
    }

    public function getCameraDistance() : Number {
      return this.cameraDistance;
    }

    public function getCameraFieldOfView() : Number {
      return this.cameraFov;
    }
  }
}
