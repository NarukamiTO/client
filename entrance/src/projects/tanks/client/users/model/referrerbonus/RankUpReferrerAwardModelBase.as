package projects.tanks.client.users.model.referrerbonus {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class RankUpReferrerAwardModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RankUpReferrerAwardModelServer;

    private var client:IRankUpReferrerAwardModelBase = IRankUpReferrerAwardModelBase(this);
    private var modelId:Long = Long.getLong(2055575281,-1485567427);

    public function RankUpReferrerAwardModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RankUpReferrerAwardModelServer(IModel(this));
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
