package _codec.projects.tanks.client.tanksservices.model.reconnect {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.tanksservices.model.reconnect.RemoteEndpointData;

  public class CodecRemoteEndpointData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_host:ICodec;
    private var codec_ports:ICodec;

    public function CodecRemoteEndpointData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_host = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_ports = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RemoteEndpointData = new RemoteEndpointData();
      local2.host = this.codec_host.decode(param1) as String;
      local2.ports = this.codec_ports.decode(param1) as Vector.<int>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RemoteEndpointData = RemoteEndpointData(param2);
      this.codec_host.encode(param1,local3.host);
      this.codec_ports.encode(param1,local3.ports);
    }
  }
}
