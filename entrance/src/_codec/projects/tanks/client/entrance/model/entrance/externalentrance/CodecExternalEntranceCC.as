package _codec.projects.tanks.client.entrance.model.entrance.externalentrance {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.entrance.model.entrance.externalentrance.ExternalEntranceCC;
  import projects.tanks.client.entrance.model.entrance.externalentrance.SocialNetworkEntranceParams;

  public class CodecExternalEntranceCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_socialNetworkParams:ICodec;

    public function CodecExternalEntranceCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_socialNetworkParams = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(SocialNetworkEntranceParams,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ExternalEntranceCC = new ExternalEntranceCC();
      local2.socialNetworkParams = this.codec_socialNetworkParams.decode(param1) as Vector.<SocialNetworkEntranceParams>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ExternalEntranceCC = ExternalEntranceCC(param2);
      this.codec_socialNetworkParams.encode(param1,local3.socialNetworkParams);
    }
  }
}
