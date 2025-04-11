package projects.tanks.client.battleselect.model.matchmaking.view {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class MatchmakingLayoutModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MatchmakingLayoutModelServer;

    private var client:IMatchmakingLayoutModelBase = IMatchmakingLayoutModelBase(this);
    private var modelId:Long = Long.getLong(1381232317,979335603);
    private var _hideMatchmakingViewId:Long = Long.getLong(684570251,-10047503);
    private var _showMatchmakingViewId:Long = Long.getLong(741085905,-1689593046);

    public function MatchmakingLayoutModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MatchmakingLayoutModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(MatchmakingLayoutCC,false)));
    }

    protected function getInitParam() : MatchmakingLayoutCC {
      return MatchmakingLayoutCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._hideMatchmakingViewId:
          this.client.hideMatchmakingView();
          break;
        case this._showMatchmakingViewId:
          this.client.showMatchmakingView();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
