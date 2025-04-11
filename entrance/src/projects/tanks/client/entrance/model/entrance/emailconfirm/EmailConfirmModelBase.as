package projects.tanks.client.entrance.model.entrance.emailconfirm {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class EmailConfirmModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:EmailConfirmModelServer;

    private var client:IEmailConfirmModelBase = IEmailConfirmModelBase(this);
    private var modelId:Long = Long.getLong(284901932,-278416008);
    private var _confirmEmailStatusId:Long = Long.getLong(1693893879,-709904107);
    private var _confirmEmailStatus_statusCodec:ICodec;

    public function EmailConfirmModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new EmailConfirmModelServer(IModel(this));
      this._confirmEmailStatus_statusCodec = this._protocol.getCodec(new EnumCodecInfo(ConfirmEmailStatus,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._confirmEmailStatusId:
          this.client.confirmEmailStatus(ConfirmEmailStatus(this._confirmEmailStatus_statusCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
