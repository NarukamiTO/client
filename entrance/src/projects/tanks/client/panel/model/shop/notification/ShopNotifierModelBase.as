package projects.tanks.client.panel.model.shop.notification {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class ShopNotifierModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ShopNotifierModelServer;

    private var client:IShopNotifierModelBase = IShopNotifierModelBase(this);
    private var modelId:Long = Long.getLong(1668161981,-943255745);
    private var _notifyDiscountsInShopId:Long = Long.getLong(240051811,-1135024818);
    private var _notifyNewItemsInShopId:Long = Long.getLong(864049549,260374042);

    public function ShopNotifierModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ShopNotifierModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._notifyDiscountsInShopId:
          this.client.notifyDiscountsInShop();
          break;
        case this._notifyNewItemsInShopId:
          this.client.notifyNewItemsInShop();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
