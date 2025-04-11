package _codec.projects.tanks.client.garage.models.item.upgradeable.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;
  import projects.tanks.client.garage.models.item.upgradeable.types.PropertyData;

  public class CodecGaragePropertyParams implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_precision:ICodec;
    private var codec_properties:ICodec;
    private var codec_property:ICodec;
    private var codec_visibleInInfo:ICodec;

    public function CodecGaragePropertyParams() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_precision = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_properties = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(PropertyData,false),false,1));
      this.codec_property = param1.getCodec(new EnumCodecInfo(ItemGarageProperty,false));
      this.codec_visibleInInfo = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GaragePropertyParams = new GaragePropertyParams();
      local2.precision = this.codec_precision.decode(param1) as int;
      local2.properties = this.codec_properties.decode(param1) as Vector.<PropertyData>;
      local2.property = this.codec_property.decode(param1) as ItemGarageProperty;
      local2.visibleInInfo = this.codec_visibleInInfo.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:GaragePropertyParams = GaragePropertyParams(param2);
      this.codec_precision.encode(param1,local3.precision);
      this.codec_properties.encode(param1,local3.properties);
      this.codec_property.encode(param1,local3.property);
      this.codec_visibleInInfo.encode(param1,local3.visibleInInfo);
    }
  }
}
