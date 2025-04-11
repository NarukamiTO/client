package projects.tanks.client.battleselect.model.matchmaking.notify {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;

  public class MatchmakingNotifyModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MatchmakingNotifyModelServer;

    private var client:IMatchmakingNotifyModelBase = IMatchmakingNotifyModelBase(this);
    private var modelId:Long = Long.getLong(1668041838,-577067222);
    private var _registrationCancelledId:Long = Long.getLong(1292268413,1208036615);
    private var _registrationTimeoutId:Long = Long.getLong(930952614,-2058633481);
    private var _userRegistrationSuccessfulId:Long = Long.getLong(1706073111,946529251);
    private var _userRegistrationSuccessful_avgWaitTimeInSecondsCodec:ICodec;
    private var _userRegistrationSuccessful_modeCodec:ICodec;

    public function MatchmakingNotifyModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MatchmakingNotifyModelServer(IModel(this));
      this._userRegistrationSuccessful_avgWaitTimeInSecondsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._userRegistrationSuccessful_modeCodec = this._protocol.getCodec(new EnumCodecInfo(MatchmakingMode,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._registrationCancelledId:
          this.client.registrationCancelled();
          break;
        case this._registrationTimeoutId:
          this.client.registrationTimeout();
          break;
        case this._userRegistrationSuccessfulId:
          this.client.userRegistrationSuccessful(int(this._userRegistrationSuccessful_avgWaitTimeInSecondsCodec.decode(param2)),MatchmakingMode(this._userRegistrationSuccessful_modeCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
