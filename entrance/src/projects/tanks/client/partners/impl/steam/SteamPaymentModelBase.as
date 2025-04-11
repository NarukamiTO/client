package projects.tanks.client.partners.impl.steam {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class SteamPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:SteamPaymentModelServer;

    private var client:ISteamPaymentModelBase = ISteamPaymentModelBase(this);
    private var modelId:Long = Long.getLong(1657527226,-1527425512);

    public function SteamPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new SteamPaymentModelServer(IModel(this));
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
