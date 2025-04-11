package projects.tanks.client.garage.models.item.upgradeable {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class UpgradeableParamsConstructorModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:UpgradeableParamsConstructorModelServer;

    private var client:IUpgradeableParamsConstructorModelBase = IUpgradeableParamsConstructorModelBase(this);
    private var modelId:Long = Long.getLong(1104447849,1721128071);

    public function UpgradeableParamsConstructorModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new UpgradeableParamsConstructorModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(UpgradeParamsCC,false)));
    }

    protected function getInitParam() : UpgradeParamsCC {
      return UpgradeParamsCC(initParams[Model.object]);
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
