package _codec.platform.client.core.general.spaces.loading.dispatcher.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsDependencies;
  import platform.client.fp10.core.resource.Resource;

  public class CodecObjectsDependencies implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_callbackId:ICodec;
    private var codec_resources:ICodec;

    public function CodecObjectsDependencies() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_callbackId = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_resources = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Resource,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ObjectsDependencies = new ObjectsDependencies();
      local2.callbackId = this.codec_callbackId.decode(param1) as int;
      local2.resources = this.codec_resources.decode(param1) as Vector.<Resource>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ObjectsDependencies = ObjectsDependencies(param2);
      this.codec_callbackId.encode(param1,local3.callbackId);
      this.codec_resources.encode(param1,local3.resources);
    }
  }
}
