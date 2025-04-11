package projects.tanks.client.panel.model.garage.rankupsupplybonus {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class RankUpSupplyBonusModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RankUpSupplyBonusModelServer;

    private var client:IRankUpSupplyBonusModelBase = IRankUpSupplyBonusModelBase(this);
    private var modelId:Long = Long.getLong(1175442844,-1652512683);
    private var _showRankUpSupplyBonusAlertsId:Long = Long.getLong(1864278356,1633403965);
    private var _showRankUpSupplyBonusAlerts_bonusesCodec:ICodec;

    public function RankUpSupplyBonusModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RankUpSupplyBonusModelServer(IModel(this));
      this._showRankUpSupplyBonusAlerts_bonusesCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(RankUpSupplyBonusInfo,false),false,1));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showRankUpSupplyBonusAlertsId:
          this.client.showRankUpSupplyBonusAlerts(this._showRankUpSupplyBonusAlerts_bonusesCodec.decode(param2) as Vector.<RankUpSupplyBonusInfo>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
