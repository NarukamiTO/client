package projects.tanks.client.panel.model.kitoffer {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class KitOfferModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:KitOfferModelServer;

    private var client:IKitOfferModelBase = IKitOfferModelBase(this);
    private var modelId:Long = Long.getLong(648458850,1480220388);
    private var _showOfferId:Long = Long.getLong(1005239660,318507406);
    private var _showOffer_infoCodec:ICodec;

    public function KitOfferModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new KitOfferModelServer(IModel(this));
      this._showOffer_infoCodec = this._protocol.getCodec(new TypeCodecInfo(KitOfferInfo,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showOfferId:
          this.client.showOffer(KitOfferInfo(this._showOffer_infoCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
