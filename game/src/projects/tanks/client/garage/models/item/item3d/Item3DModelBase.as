package projects.tanks.client.garage.models.item.item3d {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class Item3DModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:Item3DModelServer;

    private var client:IItem3DModelBase = IItem3DModelBase(this);
    private var modelId:Long = Long.getLong(1739715120,-17857031);

    public function Item3DModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new Item3DModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(Item3DCC,false)));
    }

    protected function getInitParam() : Item3DCC {
      return Item3DCC(initParams[Model.object]);
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
