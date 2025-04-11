package _codec.projects.tanks.client.panel.model.challenge.rewarding {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.challenge.rewarding.TierItem;

  public class CodecTierItem implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_amount:ICodec;
    private var codec_name:ICodec;
    private var codec_preview:ICodec;
    private var codec_received:ICodec;

    public function CodecTierItem() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_amount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_preview = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_received = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TierItem = new TierItem();
      local2.amount = this.codec_amount.decode(param1) as int;
      local2.name = this.codec_name.decode(param1) as String;
      local2.preview = this.codec_preview.decode(param1) as ImageResource;
      local2.received = this.codec_received.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TierItem = TierItem(param2);
      this.codec_amount.encode(param1,local3.amount);
      this.codec_name.encode(param1,local3.name);
      this.codec_preview.encode(param1,local3.preview);
      this.codec_received.encode(param1,local3.received);
    }
  }
}
