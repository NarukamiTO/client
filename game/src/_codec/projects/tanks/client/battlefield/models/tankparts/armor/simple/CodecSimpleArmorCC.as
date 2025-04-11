package _codec.projects.tanks.client.battlefield.models.tankparts.armor.simple {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.tankparts.armor.simple.SimpleArmorCC;

  public class CodecSimpleArmorCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_maxHealth:ICodec;

    public function CodecSimpleArmorCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_maxHealth = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SimpleArmorCC = new SimpleArmorCC();
      local2.maxHealth = this.codec_maxHealth.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SimpleArmorCC = SimpleArmorCC(param2);
      this.codec_maxHealth.encode(param1,local3.maxHealth);
    }
  }
}
