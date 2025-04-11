package projects.tanks.client.garage.models.item.kit {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class GarageKitModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:GarageKitModelServer;

    private var client:IGarageKitModelBase = IGarageKitModelBase(this);
    private var modelId:Long = Long.getLong(1215266592,-1320571870);

    public function GarageKitModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new GarageKitModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(GarageKitCC,false)));
    }

    protected function getInitParam() : GarageKitCC {
      return GarageKitCC(initParams[Model.object]);
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
