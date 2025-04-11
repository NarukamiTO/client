package projects.tanks.client.panel.model.profile.usersettings {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.chat.models.chat.users.personalmessagereceiver.PersonalMessageReceiveMode;

  public class SettingsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:SettingsModelServer;

    private var client:ISettingsModelBase = ISettingsModelBase(this);
    private var modelId:Long = Long.getLong(1428989873,1951780812);
    private var _openAntiAddictionSettingsId:Long = Long.getLong(810018451,-1328707173);
    private var _openAntiAddictionSettings_modeCodec:ICodec;
    private var _openAntiAddictionSettings_realNameCodec:ICodec;
    private var _openAntiAddictionSettings_idNumberCodec:ICodec;
    private var _openSettingsId:Long = Long.getLong(826886748,-1809986386);
    private var _openSettings_modeCodec:ICodec;

    public function SettingsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new SettingsModelServer(IModel(this));
      this._openAntiAddictionSettings_modeCodec = this._protocol.getCodec(new EnumCodecInfo(PersonalMessageReceiveMode,false));
      this._openAntiAddictionSettings_realNameCodec = this._protocol.getCodec(new TypeCodecInfo(String,true));
      this._openAntiAddictionSettings_idNumberCodec = this._protocol.getCodec(new TypeCodecInfo(String,true));
      this._openSettings_modeCodec = this._protocol.getCodec(new EnumCodecInfo(PersonalMessageReceiveMode,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._openAntiAddictionSettingsId:
          this.client.openAntiAddictionSettings(PersonalMessageReceiveMode(this._openAntiAddictionSettings_modeCodec.decode(param2)),String(this._openAntiAddictionSettings_realNameCodec.decode(param2)),String(this._openAntiAddictionSettings_idNumberCodec.decode(param2)));
          break;
        case this._openSettingsId:
          this.client.openSettings(PersonalMessageReceiveMode(this._openSettings_modeCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
