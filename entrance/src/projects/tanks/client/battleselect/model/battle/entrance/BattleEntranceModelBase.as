package projects.tanks.client.battleselect.model.battle.entrance {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class BattleEntranceModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleEntranceModelServer;

    private var client:IBattleEntranceModelBase = IBattleEntranceModelBase(this);
    private var modelId:Long = Long.getLong(124040719,-2122162804);
    private var _enterToBattleFailedId:Long = Long.getLong(1427344653,-225635033);
    private var _equipmentNotMatchConstraintsId:Long = Long.getLong(1971172597,1526425495);
    private var _fightFailedServerIsHaltingId:Long = Long.getLong(1465029547,1591202968);

    public function BattleEntranceModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleEntranceModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._enterToBattleFailedId:
          this.client.enterToBattleFailed();
          break;
        case this._equipmentNotMatchConstraintsId:
          this.client.equipmentNotMatchConstraints();
          break;
        case this._fightFailedServerIsHaltingId:
          this.client.fightFailedServerIsHalting();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
