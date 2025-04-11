package _codec.projects.tanks.client.panel.model.shop.challenges.toclient {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.challenges.toclient.ChallengeShopItemsCC;

  public class CodecChallengeShopItemsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_shopBattlePass:ICodec;
    private var codec_shopBattlePassId:ICodec;
    private var codec_starsBundle:ICodec;
    private var codec_starsBundleId:ICodec;

    public function CodecChallengeShopItemsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_shopBattlePass = param1.getCodec(new TypeCodecInfo(IGameObject,false));
      this.codec_shopBattlePassId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_starsBundle = param1.getCodec(new TypeCodecInfo(IGameObject,false));
      this.codec_starsBundleId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ChallengeShopItemsCC = new ChallengeShopItemsCC();
      local2.shopBattlePass = this.codec_shopBattlePass.decode(param1) as IGameObject;
      local2.shopBattlePassId = this.codec_shopBattlePassId.decode(param1) as Long;
      local2.starsBundle = this.codec_starsBundle.decode(param1) as IGameObject;
      local2.starsBundleId = this.codec_starsBundleId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ChallengeShopItemsCC = ChallengeShopItemsCC(param2);
      this.codec_shopBattlePass.encode(param1,local3.shopBattlePass);
      this.codec_shopBattlePassId.encode(param1,local3.shopBattlePassId);
      this.codec_starsBundle.encode(param1,local3.starsBundle);
      this.codec_starsBundleId.encode(param1,local3.starsBundleId);
    }
  }
}
