package projects.tanks.client.garage.models.item.discount.proabonement {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ProAbonementRankDiscountModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ProAbonementRankDiscountModelServer;

    private var client:IProAbonementRankDiscountModelBase = IProAbonementRankDiscountModelBase(this);
    private var modelId:Long = Long.getLong(1092583570,-2129915601);

    public function ProAbonementRankDiscountModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ProAbonementRankDiscountModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ProAbonementRankDiscountCC,false)));
    }

    protected function getInitParam() : ProAbonementRankDiscountCC {
      return ProAbonementRankDiscountCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      var local3:* = param1;
      switch(false ? 0 : 0) {
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
