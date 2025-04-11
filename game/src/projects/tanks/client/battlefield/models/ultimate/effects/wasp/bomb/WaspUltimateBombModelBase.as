package projects.tanks.client.battlefield.models.ultimate.effects.wasp.bomb {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class WaspUltimateBombModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:WaspUltimateBombModelServer;

    private var client:IWaspUltimateBombModelBase = IWaspUltimateBombModelBase(this);
    private var modelId:Long = Long.getLong(730448159,-745262215);
    private var _bangId:Long = Long.getLong(401765853,1762190228);

    public function WaspUltimateBombModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new WaspUltimateBombModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(WaspUltimateBombCC,false)));
    }

    protected function getInitParam() : WaspUltimateBombCC {
      return WaspUltimateBombCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._bangId:
          this.client.bang();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
