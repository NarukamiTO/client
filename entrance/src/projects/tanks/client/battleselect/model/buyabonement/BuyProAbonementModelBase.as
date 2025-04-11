package projects.tanks.client.battleselect.model.buyabonement {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class BuyProAbonementModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BuyProAbonementModelServer;

    private var client:IBuyProAbonementModelBase = IBuyProAbonementModelBase(this);
    private var modelId:Long = Long.getLong(1781362325,1040106191);

    public function BuyProAbonementModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BuyProAbonementModelServer(IModel(this));
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
