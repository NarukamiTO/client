package _codec.projects.tanks.client.panel.model.garage {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;

  public class CodecGarageItemInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_category:ICodec;
    private var codec_garageItemId:ICodec;
    private var codec_item:ICodec;
    private var codec_itemViewCategory:ICodec;
    private var codec_modificationIndex:ICodec;
    private var codec_mounted:ICodec;
    private var codec_name:ICodec;
    private var codec_position:ICodec;
    private var codec_premiumItem:ICodec;
    private var codec_preview:ICodec;
    private var codec_remaingTimeInMS:ICodec;

    public function CodecGarageItemInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_category = param1.getCodec(new EnumCodecInfo(ItemCategoryEnum,false));
      this.codec_garageItemId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_item = param1.getCodec(new TypeCodecInfo(IGameObject,false));
      this.codec_itemViewCategory = param1.getCodec(new EnumCodecInfo(ItemViewCategoryEnum,false));
      this.codec_modificationIndex = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_mounted = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_position = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_premiumItem = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_preview = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_remaingTimeInMS = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GarageItemInfo = new GarageItemInfo();
      local2.category = this.codec_category.decode(param1) as ItemCategoryEnum;
      local2.garageItemId = this.codec_garageItemId.decode(param1) as Long;
      local2.item = this.codec_item.decode(param1) as IGameObject;
      local2.itemViewCategory = this.codec_itemViewCategory.decode(param1) as ItemViewCategoryEnum;
      local2.modificationIndex = this.codec_modificationIndex.decode(param1) as int;
      local2.mounted = this.codec_mounted.decode(param1) as Boolean;
      local2.name = this.codec_name.decode(param1) as String;
      local2.position = this.codec_position.decode(param1) as int;
      local2.premiumItem = this.codec_premiumItem.decode(param1) as Boolean;
      local2.preview = this.codec_preview.decode(param1) as ImageResource;
      local2.remaingTimeInMS = this.codec_remaingTimeInMS.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:GarageItemInfo = GarageItemInfo(param2);
      this.codec_category.encode(param1,local3.category);
      this.codec_garageItemId.encode(param1,local3.garageItemId);
      this.codec_item.encode(param1,local3.item);
      this.codec_itemViewCategory.encode(param1,local3.itemViewCategory);
      this.codec_modificationIndex.encode(param1,local3.modificationIndex);
      this.codec_mounted.encode(param1,local3.mounted);
      this.codec_name.encode(param1,local3.name);
      this.codec_position.encode(param1,local3.position);
      this.codec_premiumItem.encode(param1,local3.premiumItem);
      this.codec_preview.encode(param1,local3.preview);
      this.codec_remaingTimeInMS.encode(param1,local3.remaingTimeInMS);
    }
  }
}
