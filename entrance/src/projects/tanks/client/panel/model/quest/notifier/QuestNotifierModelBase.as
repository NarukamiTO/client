package projects.tanks.client.panel.model.quest.notifier {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class QuestNotifierModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:QuestNotifierModelServer;

    private var client:IQuestNotifierModelBase = IQuestNotifierModelBase(this);
    private var modelId:Long = Long.getLong(2083723058,-1617932508);
    private var _completedDailyQuestId:Long = Long.getLong(1649960148,-282513245);
    private var _completedWeeklyQuestsId:Long = Long.getLong(881910911,183376780);
    private var _newInDailyQuestsId:Long = Long.getLong(68721805,897135658);
    private var _newInWeeklyQuestsId:Long = Long.getLong(2017235952,945739610);

    public function QuestNotifierModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new QuestNotifierModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(QuestNotifierCC,false)));
    }

    protected function getInitParam() : QuestNotifierCC {
      return QuestNotifierCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._completedDailyQuestId:
          this.client.completedDailyQuest();
          break;
        case this._completedWeeklyQuestsId:
          this.client.completedWeeklyQuests();
          break;
        case this._newInDailyQuestsId:
          this.client.newInDailyQuests();
          break;
        case this._newInWeeklyQuestsId:
          this.client.newInWeeklyQuests();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
