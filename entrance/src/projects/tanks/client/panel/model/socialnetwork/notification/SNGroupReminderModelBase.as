package projects.tanks.client.panel.model.socialnetwork.notification {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class SNGroupReminderModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:SNGroupReminderModelServer;

    private var client:ISNGroupReminderModelBase = ISNGroupReminderModelBase(this);
    private var modelId:Long = Long.getLong(490510137,-613242056);
    private var _checkIsInGroupId:Long = Long.getLong(427740815,-932994949);
    private var _checkIsInGroup_uidCodec:ICodec;
    private var _checkIsInGroup_snIdCodec:ICodec;
    private var _showCongratulationsWindowId:Long = Long.getLong(191744022,-2101440939);

    public function SNGroupReminderModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new SNGroupReminderModelServer(IModel(this));
      this._checkIsInGroup_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._checkIsInGroup_snIdCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._checkIsInGroupId:
          this.client.checkIsInGroup(String(this._checkIsInGroup_uidCodec.decode(param2)),String(this._checkIsInGroup_snIdCodec.decode(param2)));
          break;
        case this._showCongratulationsWindowId:
          this.client.showCongratulationsWindow();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
