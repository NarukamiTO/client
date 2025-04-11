package _codec.projects.tanks.client.garage.models.item.properties {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.garage.models.item.properties.ItemGaragePropertyData;

  public class CodecItemGaragePropertyData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_property:ICodec;
    private var codec_value:ICodec;

    public function CodecItemGaragePropertyData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_property = param1.getCodec(new EnumCodecInfo(ItemGarageProperty,false));
      this.codec_value = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ItemGaragePropertyData = new ItemGaragePropertyData();
      local2.property = this.codec_property.decode(param1) as ItemGarageProperty;
      local2.value = this.codec_value.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ItemGaragePropertyData = ItemGaragePropertyData(param2);
      this.codec_property.encode(param1,local3.property);
      this.codec_value.encode(param1,local3.value);
    }
  }
}
