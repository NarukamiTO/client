package projects.tanks.client.battleservice.model.latency {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class LatencyModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:LatencyModelServer;

    private var client:ILatencyModelBase = ILatencyModelBase(this);
    private var modelId:Long = Long.getLong(121770418,618912707);
    private var _pingId:Long = Long.getLong(335434599,-27161610);

    public function LatencyModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new LatencyModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._pingId:
          this.client.ping();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
