package projects.tanks.client.battleselect.model.battle.dm {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;

  public class BattleDMInfoModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleDMInfoModelServer;

    private var client:IBattleDMInfoModelBase = IBattleDMInfoModelBase(this);
    private var modelId:Long = Long.getLong(231608534,1754662850);
    private var _addUserId:Long = Long.getLong(1280686572,-165446809);
    private var _addUser_infoUserCodec:ICodec;
    private var _removeUserId:Long = Long.getLong(739099814,-1836001986);
    private var _removeUser_userIdCodec:ICodec;
    private var _updateUserScoreId:Long = Long.getLong(1545032099,1699072587);
    private var _updateUserScore_userIdCodec:ICodec;
    private var _updateUserScore_killsCodec:ICodec;

    public function BattleDMInfoModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleDMInfoModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BattleDMInfoCC,false)));
      this._addUser_infoUserCodec = this._protocol.getCodec(new TypeCodecInfo(BattleInfoUser,false));
      this._removeUser_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._updateUserScore_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._updateUserScore_killsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : BattleDMInfoCC {
      return BattleDMInfoCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._addUserId:
          this.client.addUser(BattleInfoUser(this._addUser_infoUserCodec.decode(param2)));
          break;
        case this._removeUserId:
          this.client.removeUser(Long(this._removeUser_userIdCodec.decode(param2)));
          break;
        case this._updateUserScoreId:
          this.client.updateUserScore(Long(this._updateUserScore_userIdCodec.decode(param2)),int(this._updateUserScore_killsCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
