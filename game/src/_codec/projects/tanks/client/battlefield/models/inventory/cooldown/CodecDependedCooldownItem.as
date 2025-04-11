package _codec.projects.tanks.client.battlefield.models.inventory.cooldown {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.models.inventory.cooldown.DependedCooldownItem;

  public class CodecDependedCooldownItem implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_duration:ICodec;
    private var codec_id:ICodec;

    public function CodecDependedCooldownItem() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_duration = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_id = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DependedCooldownItem = new DependedCooldownItem();
      local2.duration = this.codec_duration.decode(param1) as int;
      local2.id = this.codec_id.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DependedCooldownItem = DependedCooldownItem(param2);
      this.codec_duration.encode(param1,local3.duration);
      this.codec_id.encode(param1,local3.id);
    }
  }
}
