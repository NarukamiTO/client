package _codec.projects.tanks.client.garage.models.item.mobilelootbox.lootbox {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.garage.models.item.mobilelootbox.lootbox.MobileLoot;

  public class CodecMobileLoot implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_count:ICodec;
    private var codec_image:ICodec;
    private var codec_name:ICodec;

    public function CodecMobileLoot() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_count = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_image = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MobileLoot = new MobileLoot();
      local2.count = this.codec_count.decode(param1) as int;
      local2.image = this.codec_image.decode(param1) as ImageResource;
      local2.name = this.codec_name.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MobileLoot = MobileLoot(param2);
      this.codec_count.encode(param1,local3.count);
      this.codec_image.encode(param1,local3.image);
      this.codec_name.encode(param1,local3.name);
    }
  }
}
