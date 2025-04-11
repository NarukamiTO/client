package projects.tanks.client.garage.models.item.drone {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class HasBatteriesNotifyModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:HasBatteriesNotifyModelServer;

    private var client:IHasBatteriesNotifyModelBase = IHasBatteriesNotifyModelBase(this);
    private var modelId:Long = Long.getLong(563557196,-1799629517);
    private var _setHasBatteriesId:Long = Long.getLong(1519071544,-862454895);
    private var _setHasBatteries_hasBatteriesCodec:ICodec;

    public function HasBatteriesNotifyModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new HasBatteriesNotifyModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(HasBatteriesNotifyCC,false)));
      this._setHasBatteries_hasBatteriesCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    protected function getInitParam() : HasBatteriesNotifyCC {
      return HasBatteriesNotifyCC(initParams[Model.object]);
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
