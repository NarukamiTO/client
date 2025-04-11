package projects.tanks.client.battlefield.models.ultimate.effects.hunter {
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
  import projects.tanks.client.battlefield.types.Vector3d;

  public class HunterUltimateModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:HunterUltimateModelServer;

    private var client:IHunterUltimateModelBase = IHunterUltimateModelBase(this);
    private var modelId:Long = Long.getLong(1026046526,1304951507);
    private var _cancelId:Long = Long.getLong(1265329489,6570748);
    private var _dispelId:Long = Long.getLong(1265329489,42749515);
    private var _dispel_lightingPointsCodec:ICodec;
    private var _startChargingId:Long = Long.getLong(2095147553,-1205681713);
    private var _stopChargingId:Long = Long.getLong(1733615392,-1549805675);

    public function HunterUltimateModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new HunterUltimateModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(HunterUltimateCC,false)));
      this._dispel_lightingPointsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),false,1));
    }

    protected function getInitParam() : HunterUltimateCC {
      return HunterUltimateCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._cancelId:
          this.client.cancel();
          break;
        case this._dispelId:
          this.client.dispel(this._dispel_lightingPointsCodec.decode(param2) as Vector.<Vector3d>);
          break;
        case this._startChargingId:
          this.client.startCharging();
          break;
        case this._stopChargingId:
          this.client.stopCharging();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
