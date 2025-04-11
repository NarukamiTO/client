package projects.tanks.client.entrance.model.entrance.trackingshower {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class TrackingPixelShowingModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TrackingPixelShowingModelServer;

    private var client:ITrackingPixelShowingModelBase = ITrackingPixelShowingModelBase(this);
    private var modelId:Long = Long.getLong(1856211401,2131898451);
    private var _loadPixelId:Long = Long.getLong(1935743445,1171486952);
    private var _loadPixel_pixelUrlCodec:ICodec;

    public function TrackingPixelShowingModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TrackingPixelShowingModelServer(IModel(this));
      this._loadPixel_pixelUrlCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._loadPixelId:
          this.client.loadPixel(String(this._loadPixel_pixelUrlCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
