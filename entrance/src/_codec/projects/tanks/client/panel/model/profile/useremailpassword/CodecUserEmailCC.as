package _codec.projects.tanks.client.panel.model.profile.useremailpassword {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.profile.useremailpassword.UserEmailCC;

  public class CodecUserEmailCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_email:ICodec;
    private var codec_emailConfirmed:ICodec;

    public function CodecUserEmailCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_email = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_emailConfirmed = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserEmailCC = new UserEmailCC();
      local2.email = this.codec_email.decode(param1) as String;
      local2.emailConfirmed = this.codec_emailConfirmed.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserEmailCC = UserEmailCC(param2);
      this.codec_email.encode(param1,local3.email);
      this.codec_emailConfirmed.encode(param1,local3.emailConfirmed);
    }
  }
}
