package projects.tanks.client.garage.models.garagepreview {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class GaragePreviewModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:GaragePreviewModelServer;

    private var client:IGaragePreviewModelBase = IGaragePreviewModelBase(this);
    private var modelId:Long = Long.getLong(868501559,1837500388);
    private var _setHasBatteriesId:Long = Long.getLong(1619306003,844016486);
    private var _setHasBatteries_hasBatteriesCodec:ICodec;

    public function GaragePreviewModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new GaragePreviewModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(GaragePreviewModelCC,false)));
      this._setHasBatteries_hasBatteriesCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    protected function getInitParam() : GaragePreviewModelCC {
      return GaragePreviewModelCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setHasBatteriesId:
          this.client.setHasBatteries(Boolean(this._setHasBatteries_hasBatteriesCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
