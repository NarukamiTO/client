package _codec.projects.tanks.client.battleselect.model.matchmaking.group.notify {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MountItemsUserData;
  import projects.tanks.client.commons.types.ItemCategoryEnum;

  public class CodecMountItemsUserData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_id:ICodec;
    private var codec_itemCategory:ICodec;
    private var codec_modification:ICodec;
    private var codec_name:ICodec;
    private var codec_upgradeLevel:ICodec;

    public function CodecMountItemsUserData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_id = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_itemCategory = param1.getCodec(new EnumCodecInfo(ItemCategoryEnum,false));
      this.codec_modification = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_upgradeLevel = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MountItemsUserData = new MountItemsUserData();
      local2.id = this.codec_id.decode(param1) as Long;
      local2.itemCategory = this.codec_itemCategory.decode(param1) as ItemCategoryEnum;
      local2.modification = this.codec_modification.decode(param1) as int;
      local2.name = this.codec_name.decode(param1) as String;
      local2.upgradeLevel = this.codec_upgradeLevel.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MountItemsUserData = MountItemsUserData(param2);
      this.codec_id.encode(param1,local3.id);
      this.codec_itemCategory.encode(param1,local3.itemCategory);
      this.codec_modification.encode(param1,local3.modification);
      this.codec_name.encode(param1,local3.name);
      this.codec_upgradeLevel.encode(param1,local3.upgradeLevel);
    }
  }
}
