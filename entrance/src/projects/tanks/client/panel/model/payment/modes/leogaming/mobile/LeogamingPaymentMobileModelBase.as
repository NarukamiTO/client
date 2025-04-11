package projects.tanks.client.panel.model.payment.modes.leogaming.mobile {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class LeogamingPaymentMobileModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:LeogamingPaymentMobileModelServer;

    private var client:ILeogamingPaymentMobileModelBase = ILeogamingPaymentMobileModelBase(this);
    private var modelId:Long = Long.getLong(952947688,-264256106);
    private var _errorId:Long = Long.getLong(510359375,-1812718807);
    private var _proceedId:Long = Long.getLong(829088188,-1391550065);

    public function LeogamingPaymentMobileModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new LeogamingPaymentMobileModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._errorId:
          this.client.error();
          break;
        case this._proceedId:
          this.client.proceed();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
