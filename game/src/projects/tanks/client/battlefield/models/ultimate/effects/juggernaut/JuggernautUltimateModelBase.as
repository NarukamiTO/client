package projects.tanks.client.battlefield.models.ultimate.effects.juggernaut {
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

  public class JuggernautUltimateModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:JuggernautUltimateModelServer;

    private var client:IJuggernautUltimateModelBase = IJuggernautUltimateModelBase(this);
    private var modelId:Long = Long.getLong(206621166,86427501);
    private var _showUltimateUsedId:Long = Long.getLong(967672650,-338860941);
    private var _showUltimateUsed_tanksPushedCodec:ICodec;

    public function JuggernautUltimateModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new JuggernautUltimateModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(JuggernautUltimateCC,false)));
      this._showUltimateUsed_tanksPushedCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
    }

    protected function getInitParam() : JuggernautUltimateCC {
      return JuggernautUltimateCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showUltimateUsedId:
          this.client.showUltimateUsed(this._showUltimateUsed_tanksPushedCodec.decode(param2) as Vector.<IGameObject>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
