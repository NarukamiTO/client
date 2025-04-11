package projects.tanks.client.partners.impl.china.partner4399 {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class Partner4399ModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:Partner4399ModelServer;

    private var client:IPartner4399ModelBase = IPartner4399ModelBase(this);
    private var modelId:Long = Long.getLong(15219793,-1921200771);

    public function Partner4399ModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new Partner4399ModelServer(IModel(this));
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
