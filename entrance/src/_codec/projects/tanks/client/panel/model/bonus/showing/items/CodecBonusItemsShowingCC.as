package _codec.projects.tanks.client.panel.model.bonus.showing.items {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.bonus.showing.items.BonusItemsShowingCC;

  public class CodecBonusItemsShowingCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bonuses:ICodec;

    public function CodecBonusItemsShowingCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bonuses = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BonusItemsShowingCC = new BonusItemsShowingCC();
      local2.bonuses = this.codec_bonuses.decode(param1) as Vector.<IGameObject>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BonusItemsShowingCC = BonusItemsShowingCC(param2);
      this.codec_bonuses.encode(param1,local3.bonuses);
    }
  }
}
