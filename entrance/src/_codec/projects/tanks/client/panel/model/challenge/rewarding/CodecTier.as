package _codec.projects.tanks.client.panel.model.challenge.rewarding {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.challenge.rewarding.Tier;
  import projects.tanks.client.panel.model.challenge.rewarding.TierItem;

  public class CodecTier implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_battlePassItem:ICodec;
    private var codec_freeItem:ICodec;
    private var codec_needShowBattlePassItem:ICodec;
    private var codec_stars:ICodec;

    public function CodecTier() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_battlePassItem = param1.getCodec(new TypeCodecInfo(TierItem,true));
      this.codec_freeItem = param1.getCodec(new TypeCodecInfo(TierItem,true));
      this.codec_needShowBattlePassItem = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_stars = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:Tier = new Tier();
      local2.battlePassItem = this.codec_battlePassItem.decode(param1) as TierItem;
      local2.freeItem = this.codec_freeItem.decode(param1) as TierItem;
      local2.needShowBattlePassItem = this.codec_needShowBattlePassItem.decode(param1) as Boolean;
      local2.stars = this.codec_stars.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:Tier = Tier(param2);
      this.codec_battlePassItem.encode(param1,local3.battlePassItem);
      this.codec_freeItem.encode(param1,local3.freeItem);
      this.codec_needShowBattlePassItem.encode(param1,local3.needShowBattlePassItem);
      this.codec_stars.encode(param1,local3.stars);
    }
  }
}
