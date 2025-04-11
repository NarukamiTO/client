package projects.tanks.client.entrance.model.entrance.redirect {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class WarRedirectModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:WarRedirectModelServer;

    private var client:IWarRedirectModelBase = IWarRedirectModelBase(this);
    private var modelId:Long = Long.getLong(1401901648,1562179062);
    private var _receiveUrlId:Long = Long.getLong(1756438771,337037653);
    private var _receiveUrl_urlCodec:ICodec;

    public function WarRedirectModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new WarRedirectModelServer(IModel(this));
      this._receiveUrl_urlCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._receiveUrlId:
          this.client.receiveUrl(String(this._receiveUrl_urlCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
