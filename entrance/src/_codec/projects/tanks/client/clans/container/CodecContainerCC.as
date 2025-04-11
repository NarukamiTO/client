package _codec.projects.tanks.client.clans.container {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.clans.container.ContainerCC;

  public class CodecContainerCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_objects:ICodec;

    public function CodecContainerCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_objects = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),true,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ContainerCC = new ContainerCC();
      local2.objects = this.codec_objects.decode(param1) as Vector.<Long>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ContainerCC = ContainerCC(param2);
      this.codec_objects.encode(param1,local3.objects);
    }
  }
}
