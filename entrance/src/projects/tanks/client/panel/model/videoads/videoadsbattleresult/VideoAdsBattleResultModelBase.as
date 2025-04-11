package projects.tanks.client.panel.model.videoads.videoadsbattleresult {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class VideoAdsBattleResultModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:VideoAdsBattleResultModelServer;

    private var client:IVideoAdsBattleResultModelBase = IVideoAdsBattleResultModelBase(this);
    private var modelId:Long = Long.getLong(549828790,1245365939);
    private var _availableIncreasedRewardsId:Long = Long.getLong(714027445,1471332669);
    private var _availableIncreasedRewards_rewardCodec:ICodec;
    private var _availableSimpleRewardsId:Long = Long.getLong(120761249,982718383);
    private var _availableSimpleRewards_rewardCodec:ICodec;
    private var _notAvailableRewardsId:Long = Long.getLong(1110576434,1477431942);

    public function VideoAdsBattleResultModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new VideoAdsBattleResultModelServer(IModel(this));
      this._availableIncreasedRewards_rewardCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._availableSimpleRewards_rewardCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._availableIncreasedRewardsId:
          this.client.availableIncreasedRewards(int(this._availableIncreasedRewards_rewardCodec.decode(param2)));
          break;
        case this._availableSimpleRewardsId:
          this.client.availableSimpleRewards(int(this._availableSimpleRewards_rewardCodec.decode(param2)));
          break;
        case this._notAvailableRewardsId:
          this.client.notAvailableRewards();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
