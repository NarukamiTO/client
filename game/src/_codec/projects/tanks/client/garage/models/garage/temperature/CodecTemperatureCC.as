package _codec.projects.tanks.client.garage.models.garage.temperature {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.garage.models.garage.temperature.TemperatureCC;

  public class CodecTemperatureCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_temperatureAutoDecrement:ICodec;

    public function CodecTemperatureCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_temperatureAutoDecrement = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TemperatureCC = new TemperatureCC();
      local2.temperatureAutoDecrement = this.codec_temperatureAutoDecrement.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TemperatureCC = TemperatureCC(param2);
      this.codec_temperatureAutoDecrement.encode(param1,local3.temperatureAutoDecrement);
    }
  }
}
