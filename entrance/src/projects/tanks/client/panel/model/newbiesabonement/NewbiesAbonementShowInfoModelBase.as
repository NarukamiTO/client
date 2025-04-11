package projects.tanks.client.panel.model.newbiesabonement {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class NewbiesAbonementShowInfoModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:NewbiesAbonementShowInfoModelServer;

    private var client:INewbiesAbonementShowInfoModelBase = INewbiesAbonementShowInfoModelBase(this);
    private var modelId:Long = Long.getLong(1118509469,-35521391);
    private var _showInfoWindowId:Long = Long.getLong(523922434,-1392224255);
    private var _showInfoWindow_lifeTimeInSecondsFromCurrentDateTimeCodec:ICodec;
    private var _showInfoWindow_crystalBonusInPersentCodec:ICodec;
    private var _showInfoWindow_scoreBonusInPercentCodec:ICodec;

    public function NewbiesAbonementShowInfoModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new NewbiesAbonementShowInfoModelServer(IModel(this));
      this._showInfoWindow_lifeTimeInSecondsFromCurrentDateTimeCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._showInfoWindow_crystalBonusInPersentCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._showInfoWindow_scoreBonusInPercentCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showInfoWindowId:
          this.client.showInfoWindow(int(this._showInfoWindow_lifeTimeInSecondsFromCurrentDateTimeCodec.decode(param2)),int(this._showInfoWindow_crystalBonusInPersentCodec.decode(param2)),int(this._showInfoWindow_scoreBonusInPercentCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
