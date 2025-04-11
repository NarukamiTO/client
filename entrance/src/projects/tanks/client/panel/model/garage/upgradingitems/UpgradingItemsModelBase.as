package projects.tanks.client.panel.model.garage.upgradingitems {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;

  public class UpgradingItemsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:UpgradingItemsModelServer;

    private var client:IUpgradingItemsModelBase = IUpgradingItemsModelBase(this);
    private var modelId:Long = Long.getLong(1118995569,-1424498497);
    private var _initId:Long = Long.getLong(349570982,87011802);
    private var _init_upgradedItemsCodec:ICodec;
    private var _init_upgradingItemsCodec:ICodec;

    public function UpgradingItemsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new UpgradingItemsModelServer(IModel(this));
      this._init_upgradedItemsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(GarageItemInfo,false),false,1));
      this._init_upgradingItemsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(GarageItemInfo,false),false,1));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._initId:
          this.client.init(this._init_upgradedItemsCodec.decode(param2) as Vector.<GarageItemInfo>,this._init_upgradingItemsCodec.decode(param2) as Vector.<GarageItemInfo>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
