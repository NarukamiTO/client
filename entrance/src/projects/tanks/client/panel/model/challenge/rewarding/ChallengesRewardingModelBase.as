package projects.tanks.client.panel.model.challenge.rewarding {
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

  public class ChallengesRewardingModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ChallengesRewardingModelServer;

    private var client:IChallengesRewardingModelBase = IChallengesRewardingModelBase(this);
    private var modelId:Long = Long.getLong(1504901702,408311149);
    private var _sendTiersInfoId:Long = Long.getLong(139084535,228510069);
    private var _sendTiersInfo_tiersCodec:ICodec;

    public function ChallengesRewardingModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ChallengesRewardingModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ChallengeRewardsCC,false)));
      this._sendTiersInfo_tiersCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Tier,false),false,1));
    }

    protected function getInitParam() : ChallengeRewardsCC {
      return ChallengeRewardsCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._sendTiersInfoId:
          this.client.sendTiersInfo(this._sendTiersInfo_tiersCodec.decode(param2) as Vector.<Tier>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
