package _codec.projects.tanks.client.panel.model.shop.renameshopitem {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.renameshopitem.RenameShopItemCC;

  public class CodecRenameShopItemCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_name:ICodec;

    public function CodecRenameShopItemCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RenameShopItemCC = new RenameShopItemCC();
      local2.name = this.codec_name.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RenameShopItemCC = RenameShopItemCC(param2);
      this.codec_name.encode(param1,local3.name);
    }
  }
}
