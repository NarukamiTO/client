package projects.tanks.client.panel.model.personaldiscount {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;

  public class PersonalDiscountModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:PersonalDiscountModelServer;

    private var client:IPersonalDiscountModelBase = IPersonalDiscountModelBase(this);
    private var modelId:Long = Long.getLong(897429325,1733728636);
    private var _showPersonalDiscountId:Long = Long.getLong(552793109,-485726833);
    private var _showPersonalDiscount_itemInfoCodec:ICodec;
    private var _showPersonalDiscount_totalDiscountInPercentCodec:ICodec;
    private var _showPersonalDiscount_priceWithDiscountCodec:ICodec;
    private var _showPersonalDiscount_durationInSecCodec:ICodec;

    public function PersonalDiscountModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new PersonalDiscountModelServer(IModel(this));
      this._showPersonalDiscount_itemInfoCodec = this._protocol.getCodec(new TypeCodecInfo(GarageItemInfo,false));
      this._showPersonalDiscount_totalDiscountInPercentCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._showPersonalDiscount_priceWithDiscountCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._showPersonalDiscount_durationInSecCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showPersonalDiscountId:
          this.client.showPersonalDiscount(GarageItemInfo(this._showPersonalDiscount_itemInfoCodec.decode(param2)),int(this._showPersonalDiscount_totalDiscountInPercentCodec.decode(param2)),int(this._showPersonalDiscount_priceWithDiscountCodec.decode(param2)),int(this._showPersonalDiscount_durationInSecCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
