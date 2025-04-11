package projects.tanks.client.commons.models.clienthalt {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class ServerHaltModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ServerHaltModelServer;

    private var client:IServerHaltModelBase = IServerHaltModelBase(this);
    private var modelId:Long = Long.getLong(1670604947,523994521);
    private var _haltServerId:Long = Long.getLong(617627221,751287008);
    private var _haltServer_timeLeftInSecCodec:ICodec;

    public function ServerHaltModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ServerHaltModelServer(IModel(this));
      this._haltServer_timeLeftInSecCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._haltServerId:
          this.client.haltServer(int(this._haltServer_timeLeftInSecCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
