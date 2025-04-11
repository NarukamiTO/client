package projects.tanks.client.clans.user {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class ClanUserLoaderModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ClanUserLoaderModelServer;

    private var client:IClanUserLoaderModelBase = IClanUserLoaderModelBase(this);
    private var modelId:Long = Long.getLong(1420566941,-260091189);
    private var _showWindowId:Long = Long.getLong(511635594,2072865495);

    public function ClanUserLoaderModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ClanUserLoaderModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showWindowId:
          this.client.showWindow();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
