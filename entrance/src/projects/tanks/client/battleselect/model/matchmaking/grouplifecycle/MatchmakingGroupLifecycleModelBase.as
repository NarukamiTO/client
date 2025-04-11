package projects.tanks.client.battleselect.model.matchmaking.grouplifecycle {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class MatchmakingGroupLifecycleModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MatchmakingGroupLifecycleModelServer;

    private var client:IMatchmakingGroupLifecycleModelBase = IMatchmakingGroupLifecycleModelBase(this);
    private var modelId:Long = Long.getLong(413804305,1147765830);

    public function MatchmakingGroupLifecycleModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MatchmakingGroupLifecycleModelServer(IModel(this));
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
