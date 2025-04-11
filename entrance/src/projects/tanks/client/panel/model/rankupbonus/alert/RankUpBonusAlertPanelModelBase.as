package projects.tanks.client.panel.model.rankupbonus.alert {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class RankUpBonusAlertPanelModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RankUpBonusAlertPanelModelServer;

    private var client:IRankUpBonusAlertPanelModelBase = IRankUpBonusAlertPanelModelBase(this);
    private var modelId:Long = Long.getLong(1984500447,-1883224146);
    private var _showAlertId:Long = Long.getLong(653153520,-1625951208);
    private var _showAlert_itemCodec:ICodec;

    public function RankUpBonusAlertPanelModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RankUpBonusAlertPanelModelServer(IModel(this));
      this._showAlert_itemCodec = this._protocol.getCodec(new TypeCodecInfo(RankUpBonusAlertItem,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showAlertId:
          this.client.showAlert(RankUpBonusAlertItem(this._showAlert_itemCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
