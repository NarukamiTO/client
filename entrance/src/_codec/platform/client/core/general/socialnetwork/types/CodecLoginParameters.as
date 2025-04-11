package _codec.platform.client.core.general.socialnetwork.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.MapCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;

  public class CodecLoginParameters implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_parameters:ICodec;

    public function CodecLoginParameters() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_parameters = param1.getCodec(new MapCodecInfo(new TypeCodecInfo(String,false),new TypeCodecInfo(String,false),false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:LoginParameters = new LoginParameters();
      local2.parameters = this.codec_parameters.decode(param1) as Dictionary;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:LoginParameters = LoginParameters(param2);
      this.codec_parameters.encode(param1,local3.parameters);
    }
  }
}
