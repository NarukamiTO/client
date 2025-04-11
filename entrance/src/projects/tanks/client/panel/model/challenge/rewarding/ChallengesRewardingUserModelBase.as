package projects.tanks.client.panel.model.challenge.rewarding {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class ChallengesRewardingUserModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ChallengesRewardingUserModelServer;

    private var client:IChallengesRewardingUserModelBase = IChallengesRewardingUserModelBase(this);
    private var modelId:Long = Long.getLong(142490486,-1012948578);
    private var _rewardNotifyId:Long = Long.getLong(1979487962,1574221041);
    private var _rewardNotify_tierStarsCodec:ICodec;

    public function ChallengesRewardingUserModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ChallengesRewardingUserModelServer(IModel(this));
      this._rewardNotify_tierStarsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._rewardNotifyId:
          this.client.rewardNotify(int(this._rewardNotify_tierStarsCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
