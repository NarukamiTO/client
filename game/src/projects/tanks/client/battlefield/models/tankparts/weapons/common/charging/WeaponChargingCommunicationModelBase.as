package projects.tanks.client.battlefield.models.tankparts.weapons.common.charging {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class WeaponChargingCommunicationModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:WeaponChargingCommunicationModelServer;

    private var client:IWeaponChargingCommunicationModelBase = IWeaponChargingCommunicationModelBase(this);
    private var modelId:Long = Long.getLong(1249124405,67678961);
    private var _handleChargingFinishId:Long = Long.getLong(1333946959,1231462256);
    private var _handleChargingFinish_durationMsCodec:ICodec;
    private var _handleChargingStartId:Long = Long.getLong(95516785,249691333);

    public function WeaponChargingCommunicationModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new WeaponChargingCommunicationModelServer(IModel(this));
      this._handleChargingFinish_durationMsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._handleChargingFinishId:
          this.client.handleChargingFinish(int(this._handleChargingFinish_durationMsCodec.decode(param2)));
          break;
        case this._handleChargingStartId:
          this.client.handleChargingStart();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
