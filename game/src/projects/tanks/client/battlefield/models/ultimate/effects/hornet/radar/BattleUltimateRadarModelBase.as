package projects.tanks.client.battlefield.models.ultimate.effects.hornet.radar {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class BattleUltimateRadarModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleUltimateRadarModelServer;

    private var client:IBattleUltimateRadarModelBase = IBattleUltimateRadarModelBase(this);
    private var modelId:Long = Long.getLong(214258581,-1769245933);
    private var _updateDiscoveredTanksListId:Long = Long.getLong(157548406,1377428332);
    private var _updateDiscoveredTanksList_discoveredTanksCodec:ICodec;

    public function BattleUltimateRadarModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleUltimateRadarModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BattleUltimateRadarCC,false)));
      this._updateDiscoveredTanksList_discoveredTanksCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
    }

    protected function getInitParam() : BattleUltimateRadarCC {
      return BattleUltimateRadarCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._updateDiscoveredTanksListId:
          this.client.updateDiscoveredTanksList(this._updateDiscoveredTanksList_discoveredTanksCodec.decode(param2) as Vector.<Long>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
