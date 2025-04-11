package projects.tanks.client.chat.models.news.showing {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class NewsShowingModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:NewsShowingModelServer;

    private var client:INewsShowingModelBase = INewsShowingModelBase(this);
    private var modelId:Long = Long.getLong(202181824,-248161435);
    private var _removeNewsItemId:Long = Long.getLong(364381846,-771941222);
    private var _removeNewsItem_idCodec:ICodec;
    private var _sendNewsItemId:Long = Long.getLong(73337788,-905524322);
    private var _sendNewsItem_newsItemDataCodec:ICodec;

    public function NewsShowingModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new NewsShowingModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(NewsShowingCC,false)));
      this._removeNewsItem_idCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._sendNewsItem_newsItemDataCodec = this._protocol.getCodec(new TypeCodecInfo(NewsItemData,false));
    }

    protected function getInitParam() : NewsShowingCC {
      return NewsShowingCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._removeNewsItemId:
          this.client.removeNewsItem(Long(this._removeNewsItem_idCodec.decode(param2)));
          break;
        case this._sendNewsItemId:
          this.client.sendNewsItem(NewsItemData(this._sendNewsItem_newsItemDataCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
