package projects.tanks.client.panel.model.alerts.entrancealert {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.LocalizedImageResource;

  public class EntranceAlertModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:EntranceAlertModelServer;

    private var client:IEntranceAlertModelBase = IEntranceAlertModelBase(this);
    private var modelId:Long = Long.getLong(1825522664,-327255425);
    private var _showAlertId:Long = Long.getLong(1680328157,1362081079);
    private var _showAlert_imageCodec:ICodec;
    private var _showAlert_headerCodec:ICodec;
    private var _showAlert_textCodec:ICodec;

    public function EntranceAlertModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new EntranceAlertModelServer(IModel(this));
      this._showAlert_imageCodec = this._protocol.getCodec(new TypeCodecInfo(LocalizedImageResource,false));
      this._showAlert_headerCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._showAlert_textCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showAlertId:
          this.client.showAlert(LocalizedImageResource(this._showAlert_imageCodec.decode(param2)),String(this._showAlert_headerCodec.decode(param2)),String(this._showAlert_textCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
