package projects.tanks.client.battlefield.models.ultimate.effects.viking {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class VikingUltimateModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:VikingUltimateModelServer;

    private var client:IVikingUltimateModelBase = IVikingUltimateModelBase(this);
    private var modelId:Long = Long.getLong(1758244583,2134467693);
    private var _effectActivatedId:Long = Long.getLong(2075479607,-38975934);
    private var _effectDeactivatedId:Long = Long.getLong(1670496931,1822038243);

    public function VikingUltimateModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new VikingUltimateModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(VikingUltimateCC,false)));
    }

    protected function getInitParam() : VikingUltimateCC {
      return VikingUltimateCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._effectActivatedId:
          this.client.effectActivated();
          break;
        case this._effectDeactivatedId:
          this.client.effectDeactivated();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
