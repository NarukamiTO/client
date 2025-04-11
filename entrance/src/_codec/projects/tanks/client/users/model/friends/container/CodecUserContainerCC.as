package _codec.projects.tanks.client.users.model.friends.container {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.users.model.friends.container.UserContainerCC;

  public class CodecUserContainerCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_users:ICodec;

    public function CodecUserContainerCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_users = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserContainerCC = new UserContainerCC();
      local2.users = this.codec_users.decode(param1) as Vector.<Long>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserContainerCC = UserContainerCC(param2);
      this.codec_users.encode(param1,local3.users);
    }
  }
}
