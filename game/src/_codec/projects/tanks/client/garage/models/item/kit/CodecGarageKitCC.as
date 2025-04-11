package _codec.projects.tanks.client.garage.models.item.kit {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.garage.models.item.kit.GarageKitCC;
  import projects.tanks.client.garage.models.item.kit.KitItem;

  public class CodecGarageKitCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_discountInPercent:ICodec;
    private var codec_image:ICodec;
    private var codec_kitItems:ICodec;

    public function CodecGarageKitCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_discountInPercent = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_image = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_kitItems = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(KitItem,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GarageKitCC = new GarageKitCC();
      local2.discountInPercent = this.codec_discountInPercent.decode(param1) as int;
      local2.image = this.codec_image.decode(param1) as ImageResource;
      local2.kitItems = this.codec_kitItems.decode(param1) as Vector.<KitItem>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:GarageKitCC = GarageKitCC(param2);
      this.codec_discountInPercent.encode(param1,local3.discountInPercent);
      this.codec_image.encode(param1,local3.image);
      this.codec_kitItems.encode(param1,local3.kitItems);
    }
  }
}
