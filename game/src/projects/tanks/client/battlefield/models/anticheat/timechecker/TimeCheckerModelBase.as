package projects.tanks.client.battlefield.models.anticheat.timechecker {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class TimeCheckerModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TimeCheckerModelServer;

    private var client:ITimeCheckerModelBase = ITimeCheckerModelBase(this);
    private var modelId:Long = Long.getLong(747925004,799189270);
    private var _pingId:Long = Long.getLong(826158396,-1985123151);
    private var _ping_serverSessionTimeCodec:ICodec;
    private var _ping_clientPingCodec:ICodec;

    public function TimeCheckerModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TimeCheckerModelServer(IModel(this));
      this._ping_serverSessionTimeCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._ping_clientPingCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._pingId:
          this.client.ping(int(this._ping_serverSessionTimeCodec.decode(param2)),Number(this._ping_clientPingCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
