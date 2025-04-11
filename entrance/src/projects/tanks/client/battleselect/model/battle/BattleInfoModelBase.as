package projects.tanks.client.battleselect.model.battle {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;

  public class BattleInfoModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleInfoModelServer;

    private var client:IBattleInfoModelBase = IBattleInfoModelBase(this);
    private var modelId:Long = Long.getLong(678248814,-1039722970);
    private var _resetBattleNameId:Long = Long.getLong(1723702817,-1559950205);
    private var _roundFinishedId:Long = Long.getLong(2079393446,1872275759);
    private var _roundStartedId:Long = Long.getLong(1595490780,1527833154);
    private var _roundStarted_timeLeftInSecCodec:ICodec;
    private var _setBattleNameId:Long = Long.getLong(1955622129,800057322);
    private var _setBattleName_nameCodec:ICodec;
    private var _updateSuspicionId:Long = Long.getLong(1794766139,-788021385);
    private var _updateSuspicion_suspicionLevelCodec:ICodec;
    private var _updateUserSuspiciousStateId:Long = Long.getLong(571437576,1704127087);
    private var _updateUserSuspiciousState_userIdCodec:ICodec;
    private var _updateUserSuspiciousState_suspiciousCodec:ICodec;

    public function BattleInfoModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleInfoModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BattleInfoCC,false)));
      this._roundStarted_timeLeftInSecCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._setBattleName_nameCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._updateSuspicion_suspicionLevelCodec = this._protocol.getCodec(new EnumCodecInfo(BattleSuspicionLevel,false));
      this._updateUserSuspiciousState_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._updateUserSuspiciousState_suspiciousCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    protected function getInitParam() : BattleInfoCC {
      return BattleInfoCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._resetBattleNameId:
          this.client.resetBattleName();
          break;
        case this._roundFinishedId:
          this.client.roundFinished();
          break;
        case this._roundStartedId:
          this.client.roundStarted(int(this._roundStarted_timeLeftInSecCodec.decode(param2)));
          break;
        case this._setBattleNameId:
          this.client.setBattleName(String(this._setBattleName_nameCodec.decode(param2)));
          break;
        case this._updateSuspicionId:
          this.client.updateSuspicion(BattleSuspicionLevel(this._updateSuspicion_suspicionLevelCodec.decode(param2)));
          break;
        case this._updateUserSuspiciousStateId:
          this.client.updateUserSuspiciousState(Long(this._updateUserSuspiciousState_userIdCodec.decode(param2)),Boolean(this._updateUserSuspiciousState_suspiciousCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
