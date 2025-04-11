package projects.tanks.client.commons.models.detach {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class DetachModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:DetachModelServer;

    private var client:IDetachModelBase = IDetachModelBase(this);
    private var modelId:Long = Long.getLong(1666840941,1681304473);

    public function DetachModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new DetachModelServer(IModel(this));
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
