package projects.tanks.client.garage.models.item.mobilelootbox.lootbox {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class MobileLootBoxModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MobileLootBoxModelServer;

    private var client:IMobileLootBoxModelBase = IMobileLootBoxModelBase(this);
    private var modelId:Long = Long.getLong(793986940,265050196);
    private var _openSuccessfulId:Long = Long.getLong(812687689,208178107);
    private var _openSuccessful_rewardsCodec:ICodec;
    private var _openingFailedId:Long = Long.getLong(857495400,624501804);
    private var _updateCountId:Long = Long.getLong(1398628694,-1349788069);
    private var _updateCount_countCodec:ICodec;

    public function MobileLootBoxModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MobileLootBoxModelServer(IModel(this));
      this._openSuccessful_rewardsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(MobileLoot,false),false,1));
      this._updateCount_countCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._openSuccessfulId:
          this.client.openSuccessful(this._openSuccessful_rewardsCodec.decode(param2) as Vector.<MobileLoot>);
          break;
        case this._openingFailedId:
          this.client.openingFailed();
          break;
        case this._updateCountId:
          this.client.updateCount(int(this._updateCount_countCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
