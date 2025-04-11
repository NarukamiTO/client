package projects.tanks.client.panel.model.shop.androidspecialoffer.offers.purchaseofupgrades {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class AndroidPurchaseOfUpgradesUserModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AndroidPurchaseOfUpgradesUserModelServer;

    private var client:IAndroidPurchaseOfUpgradesUserModelBase = IAndroidPurchaseOfUpgradesUserModelBase(this);
    private var modelId:Long = Long.getLong(856727384,-557476859);
    private var _changeLevelId:Long = Long.getLong(2065306189,-1463079708);
    private var _changeLevel_itemIdCodec:ICodec;
    private var _changeLevel_newLevelCodec:ICodec;

    public function AndroidPurchaseOfUpgradesUserModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AndroidPurchaseOfUpgradesUserModelServer(IModel(this));
      this._changeLevel_itemIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._changeLevel_newLevelCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._changeLevelId:
          this.client.changeLevel(Long(this._changeLevel_itemIdCodec.decode(param2)),int(this._changeLevel_newLevelCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
