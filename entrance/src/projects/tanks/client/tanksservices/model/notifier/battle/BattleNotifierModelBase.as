package projects.tanks.client.tanksservices.model.notifier.battle {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class BattleNotifierModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleNotifierModelServer;

    private var client:IBattleNotifierModelBase = IBattleNotifierModelBase(this);
    private var modelId:Long = Long.getLong(904565121,-177943041);
    private var _leaveBattleId:Long = Long.getLong(1976915722,-215540987);
    private var _leaveBattle_userIdCodec:ICodec;
    private var _leaveGroupId:Long = Long.getLong(617960803,1927590436);
    private var _leaveGroup_userIdCodec:ICodec;
    private var _setBattleId:Long = Long.getLong(534256502,-1360731802);
    private var _setBattle_usersCodec:ICodec;

    public function BattleNotifierModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleNotifierModelServer(IModel(this));
      this._leaveBattle_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._leaveGroup_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._setBattle_usersCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BattleNotifierData,false),false,1));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._leaveBattleId:
          this.client.leaveBattle(Long(this._leaveBattle_userIdCodec.decode(param2)));
          break;
        case this._leaveGroupId:
          this.client.leaveGroup(Long(this._leaveGroup_userIdCodec.decode(param2)));
          break;
        case this._setBattleId:
          this.client.setBattle(this._setBattle_usersCodec.decode(param2) as Vector.<BattleNotifierData>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
