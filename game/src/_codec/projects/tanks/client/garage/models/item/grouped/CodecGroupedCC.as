package _codec.projects.tanks.client.garage.models.item.grouped {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.grouped.GroupedCC;

  public class CodecGroupedCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_group:ICodec;
    private var codec_grouped:ICodec;

    public function CodecGroupedCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_group = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_grouped = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GroupedCC = new GroupedCC();
      local2.group = this.codec_group.decode(param1) as int;
      local2.grouped = this.codec_grouped.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:GroupedCC = GroupedCC(param2);
      this.codec_group.encode(param1,local3.group);
      this.codec_grouped.encode(param1,local3.grouped);
    }
  }
}
