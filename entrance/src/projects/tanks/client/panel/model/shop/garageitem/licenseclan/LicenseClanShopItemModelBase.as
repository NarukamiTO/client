package projects.tanks.client.panel.model.shop.garageitem.licenseclan {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class LicenseClanShopItemModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:LicenseClanShopItemModelServer;

    private var client:ILicenseClanShopItemModelBase = ILicenseClanShopItemModelBase(this);
    private var modelId:Long = Long.getLong(342831337,-415928029);

    public function LicenseClanShopItemModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new LicenseClanShopItemModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      var local3:* = param1;
      switch(false ? 0 : 0) {
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
