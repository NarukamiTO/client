package _codec.projects.tanks.client.garage.models.item.upgradeable.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;
  import projects.tanks.client.garage.models.item.upgradeable.types.PropertyData;

  public class CodecPropertyData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_finalValue:ICodec;
    private var codec_initialValue:ICodec;
    private var codec_property:ICodec;

    public function CodecPropertyData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_finalValue = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_initialValue = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_property = param1.getCodec(new EnumCodecInfo(ItemProperty,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PropertyData = new PropertyData();
      local2.finalValue = this.codec_finalValue.decode(param1) as Number;
      local2.initialValue = this.codec_initialValue.decode(param1) as Number;
      local2.property = this.codec_property.decode(param1) as ItemProperty;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PropertyData = PropertyData(param2);
      this.codec_finalValue.encode(param1,local3.finalValue);
      this.codec_initialValue.encode(param1,local3.initialValue);
      this.codec_property.encode(param1,local3.property);
    }
  }
}
