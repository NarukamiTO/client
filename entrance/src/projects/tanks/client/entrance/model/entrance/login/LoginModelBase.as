package projects.tanks.client.entrance.model.entrance.login {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class LoginModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:LoginModelServer;

    private var client:ILoginModelBase = ILoginModelBase(this);
    private var modelId:Long = Long.getLong(1719449474,-786961358);
    private var _wrongPasswordId:Long = Long.getLong(1434450286,802939585);

    public function LoginModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new LoginModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._wrongPasswordId:
          this.client.wrongPassword();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
