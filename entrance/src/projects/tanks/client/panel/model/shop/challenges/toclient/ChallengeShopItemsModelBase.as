package projects.tanks.client.panel.model.shop.challenges.toclient {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ChallengeShopItemsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ChallengeShopItemsModelServer;

    private var client:IChallengeShopItemsModelBase = IChallengeShopItemsModelBase(this);
    private var modelId:Long = Long.getLong(1498317426,618512353);
    private var _itemsLoadedId:Long = Long.getLong(1756878835,-70934895);

    public function ChallengeShopItemsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ChallengeShopItemsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ChallengeShopItemsCC,false)));
    }

    protected function getInitParam() : ChallengeShopItemsCC {
      return ChallengeShopItemsCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._itemsLoadedId:
          this.client.itemsLoaded();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
