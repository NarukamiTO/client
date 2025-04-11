package projects.tanks.client.panel.model.payment.loader {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class ShopItemLoaderForAndroidModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ShopItemLoaderForAndroidModelServer;

    private var client:IShopItemLoaderForAndroidModelBase = IShopItemLoaderForAndroidModelBase(this);
    private var modelId:Long = Long.getLong(1896396405,832327381);
    private var _specialOfferLoadedId:Long = Long.getLong(1261138148,-697586738);

    public function ShopItemLoaderForAndroidModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ShopItemLoaderForAndroidModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._specialOfferLoadedId:
          this.client.specialOfferLoaded();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
