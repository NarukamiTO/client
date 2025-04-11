package _codec.projects.tanks.client.garage.models.item.device {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.garage.models.item.device.ItemDevicesCC;

  public class CodecItemDevicesCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_devicesAvailable:ICodec;
    private var codec_preview:ICodec;
    private var codec_sale:ICodec;

    public function CodecItemDevicesCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_devicesAvailable = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_preview = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_sale = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ItemDevicesCC = new ItemDevicesCC();
      local2.devicesAvailable = this.codec_devicesAvailable.decode(param1) as Boolean;
      local2.preview = this.codec_preview.decode(param1) as ImageResource;
      local2.sale = this.codec_sale.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ItemDevicesCC = ItemDevicesCC(param2);
      this.codec_devicesAvailable.encode(param1,local3.devicesAvailable);
      this.codec_preview.encode(param1,local3.preview);
      this.codec_sale.encode(param1,local3.sale);
    }
  }
}
