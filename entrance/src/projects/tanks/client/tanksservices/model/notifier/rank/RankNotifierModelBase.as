package projects.tanks.client.tanksservices.model.notifier.rank {
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

  public class RankNotifierModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RankNotifierModelServer;

    private var client:IRankNotifierModelBase = IRankNotifierModelBase(this);
    private var modelId:Long = Long.getLong(60229216,350352129);
    private var _setRankId:Long = Long.getLong(1290751540,-2034560678);
    private var _setRank_usersCodec:ICodec;

    public function RankNotifierModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RankNotifierModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(RankNotifierData,false)));
      this._setRank_usersCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(RankNotifierData,false),false,1));
    }

    protected function getInitParam() : RankNotifierData {
      return RankNotifierData(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setRankId:
          this.client.setRank(this._setRank_usersCodec.decode(param2) as Vector.<RankNotifierData>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
