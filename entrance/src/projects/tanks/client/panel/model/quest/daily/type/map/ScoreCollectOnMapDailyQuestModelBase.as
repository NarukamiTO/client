package projects.tanks.client.panel.model.quest.daily.type.map {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class ScoreCollectOnMapDailyQuestModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ScoreCollectOnMapDailyQuestModelServer;

    private var client:IScoreCollectOnMapDailyQuestModelBase = IScoreCollectOnMapDailyQuestModelBase(this);
    private var modelId:Long = Long.getLong(2038809803,-77133727);

    public function ScoreCollectOnMapDailyQuestModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ScoreCollectOnMapDailyQuestModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      var local3:* = param1;
      switch(false ? 0 : 0) {
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
