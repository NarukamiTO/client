package _codec.projects.tanks.client.panel.model.bonus.showing.items {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.bonus.showing.items.BonusItemCC;

  public class CodecBonusItemCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_count:ICodec;
    private var codec_resource:ICodec;

    public function CodecBonusItemCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_count = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_resource = param1.getCodec(new TypeCodecInfo(ImageResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BonusItemCC = new BonusItemCC();
      local2.count = this.codec_count.decode(param1) as int;
      local2.resource = this.codec_resource.decode(param1) as ImageResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BonusItemCC = BonusItemCC(param2);
      this.codec_count.encode(param1,local3.count);
      this.codec_resource.encode(param1,local3.resource);
    }
  }
}
