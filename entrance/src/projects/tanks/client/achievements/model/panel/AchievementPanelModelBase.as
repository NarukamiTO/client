package projects.tanks.client.achievements.model.panel {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.achievements.model.Achievement;

  public class AchievementPanelModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AchievementPanelModelServer;

    private var client:IAchievementPanelModelBase = IAchievementPanelModelBase(this);
    private var modelId:Long = Long.getLong(1524513374,287342893);
    private var _activateAchievementId:Long = Long.getLong(623988280,-1549577978);
    private var _activateAchievement_achievementCodec:ICodec;
    private var _completeAchievementId:Long = Long.getLong(392903733,700779252);
    private var _completeAchievement_achievementCodec:ICodec;
    private var _completeAchievement_messageCodec:ICodec;
    private var _completeAchievement_prizeCodec:ICodec;

    public function AchievementPanelModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AchievementPanelModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(AchievementCC,false)));
      this._activateAchievement_achievementCodec = this._protocol.getCodec(new EnumCodecInfo(Achievement,false));
      this._completeAchievement_achievementCodec = this._protocol.getCodec(new EnumCodecInfo(Achievement,false));
      this._completeAchievement_messageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._completeAchievement_prizeCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : AchievementCC {
      return AchievementCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._activateAchievementId:
          this.client.activateAchievement(Achievement(this._activateAchievement_achievementCodec.decode(param2)));
          break;
        case this._completeAchievementId:
          this.client.completeAchievement(Achievement(this._completeAchievement_achievementCodec.decode(param2)),String(this._completeAchievement_messageCodec.decode(param2)),int(this._completeAchievement_prizeCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
