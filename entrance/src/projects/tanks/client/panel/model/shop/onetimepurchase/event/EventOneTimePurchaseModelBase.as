package projects.tanks.client.panel.model.shop.onetimepurchase.event {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.panel.model.shop.onetimepurchase.ShopItemOneTimePurchaseCC;

  public class EventOneTimePurchaseModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:EventOneTimePurchaseModelServer;

    private var client:IEventOneTimePurchaseModelBase = IEventOneTimePurchaseModelBase(this);
    private var modelId:Long = Long.getLong(1592905426,190628822);

    public function EventOneTimePurchaseModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new EventOneTimePurchaseModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ShopItemOneTimePurchaseCC,false)));
    }

    protected function getInitParam() : ShopItemOneTimePurchaseCC {
      return ShopItemOneTimePurchaseCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      var local3:* = param1;
      switch(false ? 0 : 0) {
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
