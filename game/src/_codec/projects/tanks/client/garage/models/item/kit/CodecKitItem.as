package _codec.projects.tanks.client.garage.models.item.kit {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.kit.KitItem;

  public class CodecKitItem implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_count:ICodec;
    private var codec_item:ICodec;
    private var codec_mount:ICodec;

    public function CodecKitItem() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_count = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_item = param1.getCodec(new TypeCodecInfo(IGameObject,false));
      this.codec_mount = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:KitItem = new KitItem();
      local2.count = this.codec_count.decode(param1) as int;
      local2.item = this.codec_item.decode(param1) as IGameObject;
      local2.mount = this.codec_mount.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:KitItem = KitItem(param2);
      this.codec_count.encode(param1,local3.count);
      this.codec_item.encode(param1,local3.item);
      this.codec_mount.encode(param1,local3.mount);
    }
  }
}
