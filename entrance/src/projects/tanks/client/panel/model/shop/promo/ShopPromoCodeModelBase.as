package projects.tanks.client.panel.model.shop.promo {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.panel.model.donationalert.types.GoodInfoData;

  public class ShopPromoCodeModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ShopPromoCodeModelServer;

    private var client:IShopPromoCodeModelBase = IShopPromoCodeModelBase(this);
    private var modelId:Long = Long.getLong(441391263,1266773881);
    private var _codeActivatedId:Long = Long.getLong(127084649,413337814);
    private var _codeActivated_rewardCodec:ICodec;
    private var _codeActivationBlockedId:Long = Long.getLong(1650116493,253304315);
    private var _codeIsInvalidId:Long = Long.getLong(127086331,1588951154);

    public function ShopPromoCodeModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ShopPromoCodeModelServer(IModel(this));
      this._codeActivated_rewardCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(GoodInfoData,false),false,1));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._codeActivatedId:
          this.client.codeActivated(this._codeActivated_rewardCodec.decode(param2) as Vector.<GoodInfoData>);
          break;
        case this._codeActivationBlockedId:
          this.client.codeActivationBlocked();
          break;
        case this._codeIsInvalidId:
          this.client.codeIsInvalid();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
