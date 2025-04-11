package _codec.projects.tanks.client.battlefield.models.battle.battlefield.billboard {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.battle.battlefield.billboard.BillboardCC;

  public class CodecBillboardCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_defaultBillboardImage:ICodec;

    public function CodecBillboardCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_defaultBillboardImage = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BillboardCC = new BillboardCC();
      local2.defaultBillboardImage = this.codec_defaultBillboardImage.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BillboardCC = BillboardCC(param2);
      this.codec_defaultBillboardImage.encode(param1,local3.defaultBillboardImage);
    }
  }
}
