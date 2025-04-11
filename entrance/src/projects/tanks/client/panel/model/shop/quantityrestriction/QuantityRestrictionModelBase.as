package projects.tanks.client.panel.model.shop.quantityrestriction {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class QuantityRestrictionModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:QuantityRestrictionModelServer;

    private var client:IQuantityRestrictionModelBase = IQuantityRestrictionModelBase(this);
    private var modelId:Long = Long.getLong(1770193848,-618385804);
    private var _reservationAbortId:Long = Long.getLong(883847139,2092193755);

    public function QuantityRestrictionModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new QuantityRestrictionModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._reservationAbortId:
          this.client.reservationAbort();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
