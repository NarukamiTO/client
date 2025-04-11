package _codec.projects.tanks.client.tanksservices.types.battle {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;

  public class CodecBattleInfoData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_battleId:ICodec;
    private var codec_inGroup:ICodec;
    private var codec_mapName:ICodec;
    private var codec_mode:ICodec;
    private var codec_privateBattle:ICodec;
    private var codec_proBattle:ICodec;
    private var codec_range:ICodec;

    public function CodecBattleInfoData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_battleId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_inGroup = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_mapName = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_mode = param1.getCodec(new EnumCodecInfo(BattleMode,true));
      this.codec_privateBattle = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_proBattle = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_range = param1.getCodec(new TypeCodecInfo(Range,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleInfoData = new BattleInfoData();
      local2.battleId = this.codec_battleId.decode(param1) as Long;
      local2.inGroup = this.codec_inGroup.decode(param1) as Boolean;
      local2.mapName = this.codec_mapName.decode(param1) as String;
      local2.mode = this.codec_mode.decode(param1) as BattleMode;
      local2.privateBattle = this.codec_privateBattle.decode(param1) as Boolean;
      local2.proBattle = this.codec_proBattle.decode(param1) as Boolean;
      local2.range = this.codec_range.decode(param1) as Range;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleInfoData = BattleInfoData(param2);
      this.codec_battleId.encode(param1,local3.battleId);
      this.codec_inGroup.encode(param1,local3.inGroup);
      this.codec_mapName.encode(param1,local3.mapName);
      this.codec_mode.encode(param1,local3.mode);
      this.codec_privateBattle.encode(param1,local3.privateBattle);
      this.codec_proBattle.encode(param1,local3.proBattle);
      this.codec_range.encode(param1,local3.range);
    }
  }
}
