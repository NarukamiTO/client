package projects.tanks.client.battlefield.models.battle.jgr.killstreak {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class KillStreakModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:KillStreakModelServer;

    private var client:IKillStreakModelBase = IKillStreakModelBase(this);
    private var modelId:Long = Long.getLong(1192985770,445553764);
    private var _killStreakAchivedId:Long = Long.getLong(966829750,1086968099);
    private var _killStreakAchived_indexCodec:ICodec;

    public function KillStreakModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new KillStreakModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(KillStreakCC,false)));
      this._killStreakAchived_indexCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : KillStreakCC {
      return KillStreakCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._killStreakAchivedId:
          this.client.killStreakAchived(int(this._killStreakAchived_indexCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
