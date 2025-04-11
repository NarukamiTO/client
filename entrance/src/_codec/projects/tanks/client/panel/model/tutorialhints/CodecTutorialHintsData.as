package _codec.projects.tanks.client.panel.model.tutorialhints {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.panel.model.tutorialhints.TutorialHintsData;

  public class CodecTutorialHintsData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_canBuyTargetItem:ICodec;
    private var codec_canUpgrageCurrentTurret:ICodec;
    private var codec_hasUntakenQuestPrize:ICodec;
    private var codec_mountedTurretId:ICodec;
    private var codec_neverBoughtTurretOrWeapon:ICodec;
    private var codec_neverUpgradeTurretOrWeapon:ICodec;
    private var codec_targetToBuyItemId:ICodec;

    public function CodecTutorialHintsData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_canBuyTargetItem = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_canUpgrageCurrentTurret = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_hasUntakenQuestPrize = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_mountedTurretId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_neverBoughtTurretOrWeapon = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_neverUpgradeTurretOrWeapon = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_targetToBuyItemId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TutorialHintsData = new TutorialHintsData();
      local2.canBuyTargetItem = this.codec_canBuyTargetItem.decode(param1) as Boolean;
      local2.canUpgrageCurrentTurret = this.codec_canUpgrageCurrentTurret.decode(param1) as Boolean;
      local2.hasUntakenQuestPrize = this.codec_hasUntakenQuestPrize.decode(param1) as Boolean;
      local2.mountedTurretId = this.codec_mountedTurretId.decode(param1) as Long;
      local2.neverBoughtTurretOrWeapon = this.codec_neverBoughtTurretOrWeapon.decode(param1) as Boolean;
      local2.neverUpgradeTurretOrWeapon = this.codec_neverUpgradeTurretOrWeapon.decode(param1) as Boolean;
      local2.targetToBuyItemId = this.codec_targetToBuyItemId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TutorialHintsData = TutorialHintsData(param2);
      this.codec_canBuyTargetItem.encode(param1,local3.canBuyTargetItem);
      this.codec_canUpgrageCurrentTurret.encode(param1,local3.canUpgrageCurrentTurret);
      this.codec_hasUntakenQuestPrize.encode(param1,local3.hasUntakenQuestPrize);
      this.codec_mountedTurretId.encode(param1,local3.mountedTurretId);
      this.codec_neverBoughtTurretOrWeapon.encode(param1,local3.neverBoughtTurretOrWeapon);
      this.codec_neverUpgradeTurretOrWeapon.encode(param1,local3.neverUpgradeTurretOrWeapon);
      this.codec_targetToBuyItemId.encode(param1,local3.targetToBuyItemId);
    }
  }
}
