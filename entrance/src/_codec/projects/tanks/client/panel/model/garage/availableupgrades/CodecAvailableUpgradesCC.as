package _codec.projects.tanks.client.panel.model.garage.availableupgrades {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.garage.availableupgrades.AvailableUpgradeItem;
  import projects.tanks.client.panel.model.garage.availableupgrades.AvailableUpgradesCC;

  public class CodecAvailableUpgradesCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_availableUpgradeItems:ICodec;

    public function CodecAvailableUpgradesCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_availableUpgradeItems = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(AvailableUpgradeItem,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:AvailableUpgradesCC = new AvailableUpgradesCC();
      local2.availableUpgradeItems = this.codec_availableUpgradeItems.decode(param1) as Vector.<AvailableUpgradeItem>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:AvailableUpgradesCC = AvailableUpgradesCC(param2);
      this.codec_availableUpgradeItems.encode(param1,local3.availableUpgradeItems);
    }
  }
}
