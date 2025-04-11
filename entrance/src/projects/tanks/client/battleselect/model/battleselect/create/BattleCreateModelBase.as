package projects.tanks.client.battleselect.model.battleselect.create {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class BattleCreateModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleCreateModelServer;

    private var client:IBattleCreateModelBase = IBattleCreateModelBase(this);
    private var modelId:Long = Long.getLong(2006601986,1009878384);
    private var _createFailedBattleCreateDisabledId:Long = Long.getLong(197885668,-2032708814);
    private var _createFailedServerIsHaltingId:Long = Long.getLong(1756028652,-1657837994);
    private var _createFailedTooManyBattlesFromYouId:Long = Long.getLong(872763403,679070993);
    private var _createFailedYouAreBannedId:Long = Long.getLong(1102481331,-1022378385);
    private var _setFilteredBattleNameId:Long = Long.getLong(1263225061,56978839);
    private var _setFilteredBattleName_filteredNameCodec:ICodec;

    public function BattleCreateModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleCreateModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BattleCreateCC,false)));
      this._setFilteredBattleName_filteredNameCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    protected function getInitParam() : BattleCreateCC {
      return BattleCreateCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._createFailedBattleCreateDisabledId:
          this.client.createFailedBattleCreateDisabled();
          break;
        case this._createFailedServerIsHaltingId:
          this.client.createFailedServerIsHalting();
          break;
        case this._createFailedTooManyBattlesFromYouId:
          this.client.createFailedTooManyBattlesFromYou();
          break;
        case this._createFailedYouAreBannedId:
          this.client.createFailedYouAreBanned();
          break;
        case this._setFilteredBattleNameId:
          this.client.setFilteredBattleName(String(this._setFilteredBattleName_filteredNameCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
