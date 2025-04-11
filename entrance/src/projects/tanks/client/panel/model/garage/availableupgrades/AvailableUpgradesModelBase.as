package projects.tanks.client.panel.model.garage.availableupgrades {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class AvailableUpgradesModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AvailableUpgradesModelServer;

    private var client:IAvailableUpgradesModelBase = IAvailableUpgradesModelBase(this);
    private var modelId:Long = Long.getLong(1703176691,-2087679293);
    private var _updateAvailableUpgradeId:Long = Long.getLong(60052310,1634022030);
    private var _updateAvailableUpgrade_isAvailableItemsCodec:ICodec;

    public function AvailableUpgradesModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AvailableUpgradesModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(AvailableUpgradesCC,false)));
      this._updateAvailableUpgrade_isAvailableItemsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(AvailableUpgradeItem,false),false,1));
    }

    protected function getInitParam() : AvailableUpgradesCC {
      return AvailableUpgradesCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._updateAvailableUpgradeId:
          this.client.updateAvailableUpgrade(this._updateAvailableUpgrade_isAvailableItemsCodec.decode(param2) as Vector.<AvailableUpgradeItem>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
