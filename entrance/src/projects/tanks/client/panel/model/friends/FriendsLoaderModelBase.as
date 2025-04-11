package projects.tanks.client.panel.model.friends {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class FriendsLoaderModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:FriendsLoaderModelServer;

    private var client:IFriendsLoaderModelBase = IFriendsLoaderModelBase(this);
    private var modelId:Long = Long.getLong(1511905518,2017080539);
    private var _onUsersLoadedId:Long = Long.getLong(1043577002,1221905182);

    public function FriendsLoaderModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new FriendsLoaderModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._onUsersLoadedId:
          this.client.onUsersLoaded();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
