package projects.tanks.client.battlefield.bonus.randomgold.notification {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class RandomGoldBonusTakeModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RandomGoldBonusTakeModelServer;

    private var client:IRandomGoldBonusTakeModelBase = IRandomGoldBonusTakeModelBase(this);
    private var modelId:Long = Long.getLong(659324709,-1637199403);
    private var _showBonusNotificationId:Long = Long.getLong(1484124428,1709874221);
    private var _showBonusNotification_uidCodec:ICodec;
    private var _showBonusNotification_tankCodec:ICodec;
    private var _showBonusNotification_battleTopMessageCodec:ICodec;
    private var _showBonusNotification_battleLogMessageCodec:ICodec;

    public function RandomGoldBonusTakeModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RandomGoldBonusTakeModelServer(IModel(this));
      this._showBonusNotification_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._showBonusNotification_tankCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._showBonusNotification_battleTopMessageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._showBonusNotification_battleLogMessageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showBonusNotificationId:
          this.client.showBonusNotification(String(this._showBonusNotification_uidCodec.decode(param2)),IGameObject(this._showBonusNotification_tankCodec.decode(param2)),String(this._showBonusNotification_battleTopMessageCodec.decode(param2)),String(this._showBonusNotification_battleLogMessageCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
