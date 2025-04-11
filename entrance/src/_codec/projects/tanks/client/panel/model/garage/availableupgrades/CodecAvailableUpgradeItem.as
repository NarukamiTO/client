package _codec.projects.tanks.client.panel.model.garage.availableupgrades {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.client.panel.model.garage.availableupgrades.AvailableUpgradeItem;

  public class CodecAvailableUpgradeItem implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_available:ICodec;
    private var codec_category:ICodec;
    private var codec_timeToEndUpgradeInSec:ICodec;

    public function CodecAvailableUpgradeItem() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_available = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_category = param1.getCodec(new EnumCodecInfo(ItemViewCategoryEnum,false));
      this.codec_timeToEndUpgradeInSec = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:AvailableUpgradeItem = new AvailableUpgradeItem();
      local2.available = this.codec_available.decode(param1) as Boolean;
      local2.category = this.codec_category.decode(param1) as ItemViewCategoryEnum;
      local2.timeToEndUpgradeInSec = this.codec_timeToEndUpgradeInSec.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:AvailableUpgradeItem = AvailableUpgradeItem(param2);
      this.codec_available.encode(param1,local3.available);
      this.codec_category.encode(param1,local3.category);
      this.codec_timeToEndUpgradeInSec.encode(param1,local3.timeToEndUpgradeInSec);
    }
  }
}
