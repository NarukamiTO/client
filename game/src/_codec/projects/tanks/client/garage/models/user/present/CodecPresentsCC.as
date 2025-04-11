package _codec.projects.tanks.client.garage.models.user.present {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.user.present.PresentItem;
  import projects.tanks.client.garage.models.user.present.PresentsCC;

  public class CodecPresentsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_presents:ICodec;

    public function CodecPresentsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_presents = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(PresentItem,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PresentsCC = new PresentsCC();
      local2.presents = this.codec_presents.decode(param1) as Vector.<PresentItem>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PresentsCC = PresentsCC(param2);
      this.codec_presents.encode(param1,local3.presents);
    }
  }
}
