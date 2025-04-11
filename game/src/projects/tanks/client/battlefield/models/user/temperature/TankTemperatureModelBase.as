package projects.tanks.client.battlefield.models.user.temperature {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class TankTemperatureModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TankTemperatureModelServer;

    private var client:ITankTemperatureModelBase = ITankTemperatureModelBase(this);
    private var modelId:Long = Long.getLong(1044732133,1674200214);
    private var _setTemperatureId:Long = Long.getLong(2076898112,-371208995);
    private var _setTemperature_valueCodec:ICodec;

    public function TankTemperatureModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TankTemperatureModelServer(IModel(this));
      this._setTemperature_valueCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setTemperatureId:
          this.client.setTemperature(Number(this._setTemperature_valueCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
