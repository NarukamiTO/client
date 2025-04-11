package projects.tanks.client.panel.model.shop.specialkit.view {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class PayPalKitViewModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:PayPalKitViewModelServer;

    private var client:IPayPalKitViewModelBase = IPayPalKitViewModelBase(this);
    private var modelId:Long = Long.getLong(356896316,-88712144);

    public function PayPalKitViewModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new PayPalKitViewModelServer(IModel(this));
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
