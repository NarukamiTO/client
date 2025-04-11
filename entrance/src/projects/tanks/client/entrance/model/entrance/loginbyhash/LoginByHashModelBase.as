package projects.tanks.client.entrance.model.entrance.loginbyhash {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class LoginByHashModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:LoginByHashModelServer;

    private var client:ILoginByHashModelBase = ILoginByHashModelBase(this);
    private var modelId:Long = Long.getLong(1662174151,-1895153624);
    private var _loginByHashFailedId:Long = Long.getLong(2026019693,504774578);
    private var _loginBySingleUseHashFailedId:Long = Long.getLong(1347129984,911924633);
    private var _rememberAccountId:Long = Long.getLong(1836812020,986666173);
    private var _rememberAccount_hashCodec:ICodec;
    private var _rememberUsersHashId:Long = Long.getLong(55211289,-1109675316);
    private var _rememberUsersHash_hashCodec:ICodec;

    public function LoginByHashModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new LoginByHashModelServer(IModel(this));
      this._rememberAccount_hashCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._rememberUsersHash_hashCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._loginByHashFailedId:
          this.client.loginByHashFailed();
          break;
        case this._loginBySingleUseHashFailedId:
          this.client.loginBySingleUseHashFailed();
          break;
        case this._rememberAccountId:
          this.client.rememberAccount(String(this._rememberAccount_hashCodec.decode(param2)));
          break;
        case this._rememberUsersHashId:
          this.client.rememberUsersHash(String(this._rememberUsersHash_hashCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
