package projects.tanks.client.panel.model.payment.modes.android {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class AndroidPayModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AndroidPayModelServer;

    private var client:IAndroidPayModelBase = IAndroidPayModelBase(this);
    private var modelId:Long = Long.getLong(1588065385,-1735921226);
    private var _consumeId:Long = Long.getLong(1975169879,-182292227);
    private var _consume_tokenCodec:ICodec;

    public function AndroidPayModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AndroidPayModelServer(IModel(this));
      this._consume_tokenCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._consumeId:
          this.client.consume(String(this._consume_tokenCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
