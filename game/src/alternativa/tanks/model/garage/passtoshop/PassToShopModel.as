package alternativa.tanks.model.garage.passtoshop {
  import alternativa.osgi.OSGi;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.garage.models.garage.passtoshop.IPassToShopModelBase;
  import projects.tanks.client.garage.models.garage.passtoshop.PassToShopModelBase;

  [ModelInfo]
  public class PassToShopModel extends PassToShopModelBase implements IPassToShopModelBase, PassToShopService, ObjectLoadListener, ObjectUnloadListener {
    private var passToShopEnabled:Boolean;

    public function PassToShopModel() {
      super();
    }

    public function isPassToShopEnabled() : Boolean {
      return this.passToShopEnabled;
    }

    public function objectLoaded() : void {
      OSGi.getInstance().registerService(PassToShopService,this);
      this.passToShopEnabled = getInitParam().passToShopEnabled;
    }

    public function objectUnloaded() : void {
      OSGi.getInstance().unregisterService(PassToShopService);
    }
  }
}
