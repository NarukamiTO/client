package _codec.projects.tanks.client.battlefield.models.user.bossstate {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
  import projects.tanks.client.battlefield.models.user.bossstate.BossStateCC;

  public class CodecBossStateCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_enabled:ICodec;
    private var codec_hullId:ICodec;
    private var codec_local:ICodec;
    private var codec_role:ICodec;
    private var codec_weaponId:ICodec;

    public function CodecBossStateCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_enabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_hullId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_local = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_role = param1.getCodec(new EnumCodecInfo(BossRelationRole,false));
      this.codec_weaponId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BossStateCC = new BossStateCC();
      local2.enabled = this.codec_enabled.decode(param1) as Boolean;
      local2.hullId = this.codec_hullId.decode(param1) as Long;
      local2.local = this.codec_local.decode(param1) as Boolean;
      local2.role = this.codec_role.decode(param1) as BossRelationRole;
      local2.weaponId = this.codec_weaponId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BossStateCC = BossStateCC(param2);
      this.codec_enabled.encode(param1,local3.enabled);
      this.codec_hullId.encode(param1,local3.hullId);
      this.codec_local.encode(param1,local3.local);
      this.codec_role.encode(param1,local3.role);
      this.codec_weaponId.encode(param1,local3.weaponId);
    }
  }
}
