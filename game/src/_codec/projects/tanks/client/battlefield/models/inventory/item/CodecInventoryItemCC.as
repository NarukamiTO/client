package _codec.projects.tanks.client.battlefield.models.inventory.item {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.inventory.item.InventoryItemCC;

  public class CodecInventoryItemCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_alternativeSlotItem:ICodec;
    private var codec_count:ICodec;
    private var codec_itemIndex:ICodec;

    public function CodecInventoryItemCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_alternativeSlotItem = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_count = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_itemIndex = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:InventoryItemCC = new InventoryItemCC();
      local2.alternativeSlotItem = this.codec_alternativeSlotItem.decode(param1) as Boolean;
      local2.count = this.codec_count.decode(param1) as int;
      local2.itemIndex = this.codec_itemIndex.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:InventoryItemCC = InventoryItemCC(param2);
      this.codec_alternativeSlotItem.encode(param1,local3.alternativeSlotItem);
      this.codec_count.encode(param1,local3.count);
      this.codec_itemIndex.encode(param1,local3.itemIndex);
    }
  }
}
