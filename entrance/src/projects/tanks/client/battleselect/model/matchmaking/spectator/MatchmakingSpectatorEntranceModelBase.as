package projects.tanks.client.battleselect.model.matchmaking.spectator {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class MatchmakingSpectatorEntranceModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MatchmakingSpectatorEntranceModelServer;

    private var client:IMatchmakingSpectatorEntranceModelBase = IMatchmakingSpectatorEntranceModelBase(this);
    private var modelId:Long = Long.getLong(2143871783,-1643323062);
    private var _enterFailedNoSuitableBattlesId:Long = Long.getLong(57273342,86368579);

    public function MatchmakingSpectatorEntranceModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MatchmakingSpectatorEntranceModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._enterFailedNoSuitableBattlesId:
          this.client.enterFailedNoSuitableBattles();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
