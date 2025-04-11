package projects.tanks.client.panel.model.payment.modes.errors {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class ErrorsDescriptionModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ErrorsDescriptionModelServer;

    private var client:IErrorsDescriptionModelBase = IErrorsDescriptionModelBase(this);
    private var modelId:Long = Long.getLong(1456185857,-299115092);
    private var _showErrorId:Long = Long.getLong(1139481512,922626302);
    private var _showError_msgCodec:ICodec;

    public function ErrorsDescriptionModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ErrorsDescriptionModelServer(IModel(this));
      this._showError_msgCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showErrorId:
          this.client.showError(String(this._showError_msgCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
