package projects.tanks.client.garage.models.item.container.lootbox {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.garage.models.item.container.ContainerGivenItem;

  public class LootBoxModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:LootBoxModelServer;

    private var client:ILootBoxModelBase = ILootBoxModelBase(this);
    private var modelId:Long = Long.getLong(1980083488,639502934);
    private var _openSuccessfulId:Long = Long.getLong(910382979,820768829);
    private var _openSuccessful_rewardsCodec:ICodec;
    private var _updateCountId:Long = Long.getLong(447542744,65837337);
    private var _updateCount_countCodec:ICodec;

    public function LootBoxModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new LootBoxModelServer(IModel(this));
      this._openSuccessful_rewardsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ContainerGivenItem,false),false,1));
      this._updateCount_countCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._openSuccessfulId:
          this.client.openSuccessful(this._openSuccessful_rewardsCodec.decode(param2) as Vector.<ContainerGivenItem>);
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
