package projects.tanks.client.panel.model.videoads {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class VideoAdsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:VideoAdsModelServer;

    private var client:IVideoAdsModelBase = IVideoAdsModelBase(this);
    private var modelId:Long = Long.getLong(1726595253,-1440123844);
    private var _disableId:Long = Long.getLong(1455720671,844804169);
    private var _enableId:Long = Long.getLong(601148059,-698196692);

    public function VideoAdsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new VideoAdsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(VideoAdsModelCC,false)));
    }

    protected function getInitParam() : VideoAdsModelCC {
      return VideoAdsModelCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._disableId:
          this.client.disable();
          break;
        case this._enableId:
          this.client.enable();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
