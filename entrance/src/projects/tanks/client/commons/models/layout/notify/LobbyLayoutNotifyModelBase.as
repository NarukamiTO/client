package projects.tanks.client.commons.models.layout.notify {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.commons.models.layout.LayoutState;

  public class LobbyLayoutNotifyModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:LobbyLayoutNotifyModelServer;

    private var client:ILobbyLayoutNotifyModelBase = ILobbyLayoutNotifyModelBase(this);
    private var modelId:Long = Long.getLong(1481647778,-291699533);
    private var _beginLayoutSwitchId:Long = Long.getLong(1809738995,677658011);
    private var _beginLayoutSwitch_stateCodec:ICodec;
    private var _cancelPredictedLayoutSwitchId:Long = Long.getLong(527428095,-1647091354);
    private var _endLayoutSwitchId:Long = Long.getLong(2122248367,-1459259159);
    private var _endLayoutSwitch_originCodec:ICodec;
    private var _endLayoutSwitch_stateCodec:ICodec;

    public function LobbyLayoutNotifyModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new LobbyLayoutNotifyModelServer(IModel(this));
      this._beginLayoutSwitch_stateCodec = this._protocol.getCodec(new EnumCodecInfo(LayoutState,false));
      this._endLayoutSwitch_originCodec = this._protocol.getCodec(new EnumCodecInfo(LayoutState,false));
      this._endLayoutSwitch_stateCodec = this._protocol.getCodec(new EnumCodecInfo(LayoutState,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._beginLayoutSwitchId:
          this.client.beginLayoutSwitch(LayoutState(this._beginLayoutSwitch_stateCodec.decode(param2)));
          break;
        case this._cancelPredictedLayoutSwitchId:
          this.client.cancelPredictedLayoutSwitch();
          break;
        case this._endLayoutSwitchId:
          this.client.endLayoutSwitch(LayoutState(this._endLayoutSwitch_originCodec.decode(param2)),LayoutState(this._endLayoutSwitch_stateCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
