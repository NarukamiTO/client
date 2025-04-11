package projects.tanks.client.partners.impl.china.china3rdplatform.auth {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class China3rdPlatformLoginModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:China3rdPlatformLoginModelServer;

    private var client:IChina3rdPlatformLoginModelBase = IChina3rdPlatformLoginModelBase(this);
    private var modelId:Long = Long.getLong(2066561654,-605405330);

    public function China3rdPlatformLoginModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new China3rdPlatformLoginModelServer(IModel(this));
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
