package projects.tanks.client.partners.impl.china.partner2144 {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class Partner2144ModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:Partner2144ModelServer;

    private var client:IPartner2144ModelBase = IPartner2144ModelBase(this);
    private var modelId:Long = Long.getLong(1460794337,-1064876227);

    public function Partner2144ModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new Partner2144ModelServer(IModel(this));
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
