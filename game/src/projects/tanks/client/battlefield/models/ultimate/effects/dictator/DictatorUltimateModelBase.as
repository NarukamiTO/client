package projects.tanks.client.battlefield.models.ultimate.effects.dictator {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;

  public class DictatorUltimateModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:DictatorUltimateModelServer;

    private var client:IDictatorUltimateModelBase = IDictatorUltimateModelBase(this);
    private var modelId:Long = Long.getLong(1534471818,-1953347155);
    private var _showUltimateUsedId:Long = Long.getLong(489471790,-1556831693);
    private var _showUltimateUsed_tanksInspiredCodec:ICodec;

    public function DictatorUltimateModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new DictatorUltimateModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(DictatorUltimateCC,false)));
      this._showUltimateUsed_tanksInspiredCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
    }

    protected function getInitParam() : DictatorUltimateCC {
      return DictatorUltimateCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showUltimateUsedId:
          this.client.showUltimateUsed(this._showUltimateUsed_tanksInspiredCodec.decode(param2) as Vector.<IGameObject>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
