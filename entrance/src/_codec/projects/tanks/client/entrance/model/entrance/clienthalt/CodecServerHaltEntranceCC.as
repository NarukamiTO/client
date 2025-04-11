package _codec.projects.tanks.client.entrance.model.entrance.clienthalt {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.entrance.model.entrance.clienthalt.ServerHaltEntranceCC;

  public class CodecServerHaltEntranceCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_serverHalt:ICodec;

    public function CodecServerHaltEntranceCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_serverHalt = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ServerHaltEntranceCC = new ServerHaltEntranceCC();
      local2.serverHalt = this.codec_serverHalt.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ServerHaltEntranceCC = ServerHaltEntranceCC(param2);
      this.codec_serverHalt.encode(param1,local3.serverHalt);
    }
  }
}
