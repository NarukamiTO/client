package projects.tanks.client.garage.models.item.availabledevices {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class AvailableDevicesModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AvailableDevicesModelServer;

    private var client:IAvailableDevicesModelBase = IAvailableDevicesModelBase(this);
    private var modelId:Long = Long.getLong(104346758,-1948098183);
    private var _devicesLoadedId:Long = Long.getLong(1773038483,1761949850);
    private var _devicesLoaded_devicesCodec:ICodec;
    private var _devicesLoaded_mountedDeviceCodec:ICodec;

    public function AvailableDevicesModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AvailableDevicesModelServer(IModel(this));
      this._devicesLoaded_devicesCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
      this._devicesLoaded_mountedDeviceCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,true));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._devicesLoadedId:
          this.client.devicesLoaded(this._devicesLoaded_devicesCodec.decode(param2) as Vector.<IGameObject>,IGameObject(this._devicesLoaded_mountedDeviceCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
