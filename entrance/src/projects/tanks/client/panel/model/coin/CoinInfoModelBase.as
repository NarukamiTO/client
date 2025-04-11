package projects.tanks.client.panel.model.coin {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class CoinInfoModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:CoinInfoModelServer;

    private var client:ICoinInfoModelBase = ICoinInfoModelBase(this);
    private var modelId:Long = Long.getLong(462774872,33170034);
    private var _changeById:Long = Long.getLong(1574353768,-896343414);
    private var _changeBy_deltaCodec:ICodec;
    private var _setCoinsId:Long = Long.getLong(1574353870,-939206877);
    private var _setCoins_coinsCodec:ICodec;

    public function CoinInfoModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new CoinInfoModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(CoinInfoCC,false)));
      this._changeBy_deltaCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._setCoins_coinsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : CoinInfoCC {
      return CoinInfoCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._changeById:
          this.client.changeBy(int(this._changeBy_deltaCodec.decode(param2)));
          break;
        case this._setCoinsId:
          this.client.setCoins(int(this._setCoins_coinsCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
