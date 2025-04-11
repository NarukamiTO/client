package alternativa.tanks.model.payment.modes.description {
  import alternativa.osgi.service.clientlog.IClientLog;
  import platform.client.fp10.core.model.IObjectLoadListener;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.payment.modes.description.BottomDescriptionModelBase;
  import projects.tanks.client.panel.model.payment.modes.description.IBottomDescriptionModelBase;

  [ModelInfo]
  public class PayModeBottomDescriptionModel extends BottomDescriptionModelBase implements IBottomDescriptionModelBase, PayModeBottomDescription, PayModeBottomDescriptionInternal, IObjectLoadListener {
    [Inject]
    public static var clientLog:IClientLog;

    public function PayModeBottomDescriptionModel() {
      super();
    }

    public function getDescription() : String {
      if(getInitParam().description == null) {
        return "";
      }
      return getInitParam().description;
    }

    public function getImages() : Vector.<ImageResource> {
      return getInitParam().images;
    }

    public function enabled() : Boolean {
      return getData(Boolean);
    }

    public function setEnabled(param1:Boolean) : void {
      putData(Boolean,param1);
    }

    public function objectLoaded() : void {
      putData(Boolean,true);
    }

    public function objectLoadedPost() : void {
    }

    public function objectUnloaded() : void {
    }

    public function objectUnloadedPost() : void {
    }
  }
}
