package projects.tanks.client.garage.models.item.countable {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class CountableItemModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:CountableItemModelServer;

    private var client:ICountableItemModelBase = ICountableItemModelBase(this);
    private var modelId:Long = Long.getLong(28163628,1959753058);

    public function CountableItemModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new CountableItemModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(CountableItemCC,false)));
    }

    protected function getInitParam() : CountableItemCC {
      return CountableItemCC(initParams[Model.object]);
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
