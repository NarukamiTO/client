package _codec.projects.tanks.client.battlefield.models.user.resistance {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import projects.tanks.client.battlefield.models.user.resistance.TankResistance;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class CodecTankResistance implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_resistanceInPercent:ICodec;
    private var codec_resistanceProperty:ICodec;

    public function CodecTankResistance() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_resistanceInPercent = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_resistanceProperty = param1.getCodec(new EnumCodecInfo(ItemProperty,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TankResistance = new TankResistance();
      local2.resistanceInPercent = this.codec_resistanceInPercent.decode(param1) as int;
      local2.resistanceProperty = this.codec_resistanceProperty.decode(param1) as ItemProperty;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TankResistance = TankResistance(param2);
      this.codec_resistanceInPercent.encode(param1,local3.resistanceInPercent);
      this.codec_resistanceProperty.encode(param1,local3.resistanceProperty);
    }
  }
}
