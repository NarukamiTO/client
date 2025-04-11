package projects.tanks.client.commons.models.alert {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class AlertModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AlertModelServer;

    private var client:IAlertModelBase = IAlertModelBase(this);
    private var modelId:Long = Long.getLong(2058573415,-746879275);
    private var _showId:Long = Long.getLong(888592950,-646476035);
    private var _show_textCodec:ICodec;

    public function AlertModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AlertModelServer(IModel(this));
      this._show_textCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showId:
          this.client.show(String(this._show_textCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
