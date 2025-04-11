package projects.tanks.client.commons.models.linkactivator {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class LinkActivatorModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:LinkActivatorModelServer;

    private var client:ILinkActivatorModelBase = ILinkActivatorModelBase(this);
    private var modelId:Long = Long.getLong(650947056,1487530419);
    private var _aliveId:Long = Long.getLong(14163504,1184321813);
    private var _alive_battleIdCodec:ICodec;
    private var _battleNotFoundId:Long = Long.getLong(2016074577,529714967);
    private var _deadId:Long = Long.getLong(969374437,-1423594874);
    private var _dead_battleIdCodec:ICodec;

    public function LinkActivatorModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new LinkActivatorModelServer(IModel(this));
      this._alive_battleIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._dead_battleIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._aliveId:
          this.client.alive(Long(this._alive_battleIdCodec.decode(param2)));
          break;
        case this._battleNotFoundId:
          this.client.battleNotFound();
          break;
        case this._deadId:
          this.client.dead(Long(this._dead_battleIdCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
