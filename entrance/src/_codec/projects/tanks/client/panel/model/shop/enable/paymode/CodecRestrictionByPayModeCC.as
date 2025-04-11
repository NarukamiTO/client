package _codec.projects.tanks.client.panel.model.shop.enable.paymode {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.enable.paymode.RestrictionByPayModeCC;

  public class CodecRestrictionByPayModeCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_payMode:ICodec;

    public function CodecRestrictionByPayModeCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_payMode = param1.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RestrictionByPayModeCC = new RestrictionByPayModeCC();
      local2.payMode = this.codec_payMode.decode(param1) as IGameObject;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RestrictionByPayModeCC = RestrictionByPayModeCC(param2);
      this.codec_payMode.encode(param1,local3.payMode);
    }
  }
}
