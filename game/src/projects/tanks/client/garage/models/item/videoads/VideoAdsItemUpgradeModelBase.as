package projects.tanks.client.garage.models.item.videoads {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class VideoAdsItemUpgradeModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:VideoAdsItemUpgradeModelServer;

    private var client:IVideoAdsItemUpgradeModelBase = IVideoAdsItemUpgradeModelBase(this);
    private var modelId:Long = Long.getLong(1632109435,-443674078);
    private var _maxAdsShowedId:Long = Long.getLong(1354999069,-1103449185);
    private var _maxAdsShowed_cooldwownTimeInSecCodec:ICodec;

    public function VideoAdsItemUpgradeModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new VideoAdsItemUpgradeModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(VideoAdsItemUpgradeCC,false)));
      this._maxAdsShowed_cooldwownTimeInSecCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : VideoAdsItemUpgradeCC {
      return VideoAdsItemUpgradeCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._maxAdsShowedId:
          this.client.maxAdsShowed(int(this._maxAdsShowed_cooldwownTimeInSecCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
