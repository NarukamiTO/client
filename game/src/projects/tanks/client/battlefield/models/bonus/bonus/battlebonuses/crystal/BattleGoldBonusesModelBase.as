package projects.tanks.client.battlefield.models.bonus.bonus.battlebonuses.crystal {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleGoldBonusesModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleGoldBonusesModelServer;

    private var client:IBattleGoldBonusesModelBase = IBattleGoldBonusesModelBase(this);
    private var modelId:Long = Long.getLong(118876660,-1267889929);
    private var _goldTakenId:Long = Long.getLong(2126351838,-2114277847);
    private var _goldTaken_userCodec:ICodec;

    public function BattleGoldBonusesModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleGoldBonusesModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BattleGoldBonusCC,false)));
      this._goldTaken_userCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    protected function getInitParam() : BattleGoldBonusCC {
      return BattleGoldBonusCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._goldTakenId:
          this.client.goldTaken(IGameObject(this._goldTaken_userCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
