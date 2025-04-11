package projects.tanks.client.garage.models.garage.upgrade {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class UpgradeGarageItemModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:UpgradeGarageItemModelServer;

    private var client:IUpgradeGarageItemModelBase = IUpgradeGarageItemModelBase(this);
    private var modelId:Long = Long.getLong(293210276,-627719811);
    private var _itemAlreadyUpgradedId:Long = Long.getLong(2126423224,-768730341);
    private var _itemAlreadyUpgraded_expectedPriceCodec:ICodec;

    public function UpgradeGarageItemModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new UpgradeGarageItemModelServer(IModel(this));
      this._itemAlreadyUpgraded_expectedPriceCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._itemAlreadyUpgradedId:
          this.client.itemAlreadyUpgraded(int(this._itemAlreadyUpgraded_expectedPriceCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
