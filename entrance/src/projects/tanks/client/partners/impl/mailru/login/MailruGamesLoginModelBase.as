package projects.tanks.client.partners.impl.mailru.login {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class MailruGamesLoginModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MailruGamesLoginModelServer;

    private var client:IMailruGamesLoginModelBase = IMailruGamesLoginModelBase(this);
    private var modelId:Long = Long.getLong(552799900,1953964629);

    public function MailruGamesLoginModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MailruGamesLoginModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      var local3:* = param1;
      switch(false ? 0 : 0) {
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
