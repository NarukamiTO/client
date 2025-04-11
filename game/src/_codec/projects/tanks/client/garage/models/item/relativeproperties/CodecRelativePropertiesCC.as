package _codec.projects.tanks.client.garage.models.item.relativeproperties {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.relativeproperties.RelativePropertiesCC;
  import projects.tanks.client.garage.models.item.relativeproperties.RelativeProperty;

  public class CodecRelativePropertiesCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_properties:ICodec;

    public function CodecRelativePropertiesCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_properties = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(RelativeProperty,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RelativePropertiesCC = new RelativePropertiesCC();
      local2.properties = this.codec_properties.decode(param1) as Vector.<RelativeProperty>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RelativePropertiesCC = RelativePropertiesCC(param2);
      this.codec_properties.encode(param1,local3.properties);
    }
  }
}
