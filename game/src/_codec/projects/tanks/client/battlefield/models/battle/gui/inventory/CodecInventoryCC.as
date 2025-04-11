package _codec.projects.tanks.client.battlefield.models.battle.gui.inventory {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.battle.gui.inventory.InventoryCC;

  public class CodecInventoryCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_ultimateEnabled:ICodec;

    public function CodecInventoryCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_ultimateEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:InventoryCC = new InventoryCC();
      local2.ultimateEnabled = this.codec_ultimateEnabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:InventoryCC = InventoryCC(param2);
      this.codec_ultimateEnabled.encode(param1,local3.ultimateEnabled);
    }
  }
}
