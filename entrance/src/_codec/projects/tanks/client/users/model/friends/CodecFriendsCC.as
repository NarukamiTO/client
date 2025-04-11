package _codec.projects.tanks.client.users.model.friends {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.users.model.friends.FriendsCC;

  public class CodecFriendsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_acceptedLimit:ICodec;
    private var codec_incomingLimit:ICodec;
    private var codec_local:ICodec;

    public function CodecFriendsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_acceptedLimit = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_incomingLimit = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_local = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:FriendsCC = new FriendsCC();
      local2.acceptedLimit = this.codec_acceptedLimit.decode(param1) as int;
      local2.incomingLimit = this.codec_incomingLimit.decode(param1) as int;
      local2.local = this.codec_local.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:FriendsCC = FriendsCC(param2);
      this.codec_acceptedLimit.encode(param1,local3.acceptedLimit);
      this.codec_incomingLimit.encode(param1,local3.incomingLimit);
      this.codec_local.encode(param1,local3.local);
    }
  }
}
