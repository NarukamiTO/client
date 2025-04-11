package projects.tanks.client.battlefield.models.ultimate.effects.hornet {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class HornetUltimateModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:HornetUltimateModelServer;

    private var client:IHornetUltimateModelBase = IHornetUltimateModelBase(this);
    private var modelId:Long = Long.getLong(1679670805,-112284013);
    private var _showUltimateRadarIsTurnedOffId:Long = Long.getLong(1886084416,1962413779);
    private var _showUltimateRadarIsTurnedOnId:Long = Long.getLong(770442559,-63303675);

    public function HornetUltimateModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new HornetUltimateModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(HornetUltimateCC,false)));
    }

    protected function getInitParam() : HornetUltimateCC {
      return HornetUltimateCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showUltimateRadarIsTurnedOffId:
          this.client.showUltimateRadarIsTurnedOff();
          break;
        case this._showUltimateRadarIsTurnedOnId:
          this.client.showUltimateRadarIsTurnedOn();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
