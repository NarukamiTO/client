package _codec.projects.tanks.client.battlefield.models.battle.battlefield {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.battlefield.BattlefieldCC;
  import projects.tanks.client.battlefield.models.battle.battlefield.types.BattlefieldSounds;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
  import projects.tanks.client.battleservice.Range;

  public class CodecBattlefieldCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_active:ICodec;
    private var codec_battleId:ICodec;
    private var codec_battlefieldSounds:ICodec;
    private var codec_colorTransformMultiplier:ICodec;
    private var codec_idleKickPeriodMsec:ICodec;
    private var codec_map:ICodec;
    private var codec_mineExplosionLighting:ICodec;
    private var codec_proBattle:ICodec;
    private var codec_range:ICodec;
    private var codec_reArmorEnabled:ICodec;
    private var codec_respawnDuration:ICodec;
    private var codec_shadowMapCorrectionFactor:ICodec;
    private var codec_showAddressLink:ICodec;
    private var codec_spectator:ICodec;
    private var codec_withoutBonuses:ICodec;
    private var codec_withoutDrones:ICodec;
    private var codec_withoutSupplies:ICodec;

    public function CodecBattlefieldCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_active = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_battleId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_battlefieldSounds = param1.getCodec(new TypeCodecInfo(BattlefieldSounds,false));
      this.codec_colorTransformMultiplier = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_idleKickPeriodMsec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_map = param1.getCodec(new TypeCodecInfo(IGameObject,false));
      this.codec_mineExplosionLighting = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_proBattle = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_range = param1.getCodec(new TypeCodecInfo(Range,false));
      this.codec_reArmorEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_respawnDuration = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_shadowMapCorrectionFactor = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_showAddressLink = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_spectator = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_withoutBonuses = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_withoutDrones = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_withoutSupplies = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattlefieldCC = new BattlefieldCC();
      local2.active = this.codec_active.decode(param1) as Boolean;
      local2.battleId = this.codec_battleId.decode(param1) as Long;
      local2.battlefieldSounds = this.codec_battlefieldSounds.decode(param1) as BattlefieldSounds;
      local2.colorTransformMultiplier = this.codec_colorTransformMultiplier.decode(param1) as Number;
      local2.idleKickPeriodMsec = this.codec_idleKickPeriodMsec.decode(param1) as int;
      local2.map = this.codec_map.decode(param1) as IGameObject;
      local2.mineExplosionLighting = this.codec_mineExplosionLighting.decode(param1) as LightingSFXEntity;
      local2.proBattle = this.codec_proBattle.decode(param1) as Boolean;
      local2.range = this.codec_range.decode(param1) as Range;
      local2.reArmorEnabled = this.codec_reArmorEnabled.decode(param1) as Boolean;
      local2.respawnDuration = this.codec_respawnDuration.decode(param1) as int;
      local2.shadowMapCorrectionFactor = this.codec_shadowMapCorrectionFactor.decode(param1) as Number;
      local2.showAddressLink = this.codec_showAddressLink.decode(param1) as Boolean;
      local2.spectator = this.codec_spectator.decode(param1) as Boolean;
      local2.withoutBonuses = this.codec_withoutBonuses.decode(param1) as Boolean;
      local2.withoutDrones = this.codec_withoutDrones.decode(param1) as Boolean;
      local2.withoutSupplies = this.codec_withoutSupplies.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattlefieldCC = BattlefieldCC(param2);
      this.codec_active.encode(param1,local3.active);
      this.codec_battleId.encode(param1,local3.battleId);
      this.codec_battlefieldSounds.encode(param1,local3.battlefieldSounds);
      this.codec_colorTransformMultiplier.encode(param1,local3.colorTransformMultiplier);
      this.codec_idleKickPeriodMsec.encode(param1,local3.idleKickPeriodMsec);
      this.codec_map.encode(param1,local3.map);
      this.codec_mineExplosionLighting.encode(param1,local3.mineExplosionLighting);
      this.codec_proBattle.encode(param1,local3.proBattle);
      this.codec_range.encode(param1,local3.range);
      this.codec_reArmorEnabled.encode(param1,local3.reArmorEnabled);
      this.codec_respawnDuration.encode(param1,local3.respawnDuration);
      this.codec_shadowMapCorrectionFactor.encode(param1,local3.shadowMapCorrectionFactor);
      this.codec_showAddressLink.encode(param1,local3.showAddressLink);
      this.codec_spectator.encode(param1,local3.spectator);
      this.codec_withoutBonuses.encode(param1,local3.withoutBonuses);
      this.codec_withoutDrones.encode(param1,local3.withoutDrones);
      this.codec_withoutSupplies.encode(param1,local3.withoutSupplies);
    }
  }
}
