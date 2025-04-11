package projects.tanks.client.partners.impl.china.partner360platform {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class Partner360PlatformModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:Partner360PlatformModelServer;

    private var client:IPartner360PlatformModelBase = IPartner360PlatformModelBase(this);
    private var modelId:Long = Long.getLong(601165383,1506017039);

    public function Partner360PlatformModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new Partner360PlatformModelServer(IModel(this));
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
