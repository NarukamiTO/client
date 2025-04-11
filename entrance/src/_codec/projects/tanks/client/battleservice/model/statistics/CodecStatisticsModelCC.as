package _codec.projects.tanks.client.battleservice.model.statistics {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.createparams.BattleLimits;
  import projects.tanks.client.battleservice.model.statistics.StatisticsModelCC;

  public class CodecStatisticsModelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_battleName:ICodec;
    private var codec_equipmentConstraintsMode:ICodec;
    private var codec_fund:ICodec;
    private var codec_limits:ICodec;
    private var codec_mapName:ICodec;
    private var codec_matchBattle:ICodec;
    private var codec_maxPeopleCount:ICodec;
    private var codec_modeName:ICodec;
    private var codec_parkourMode:ICodec;
    private var codec_running:ICodec;
    private var codec_spectator:ICodec;
    private var codec_suspiciousUserIds:ICodec;
    private var codec_timeLeft:ICodec;
    private var codec_valuableRound:ICodec;

    public function CodecStatisticsModelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_battleName = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_equipmentConstraintsMode = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_fund = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_limits = param1.getCodec(new TypeCodecInfo(BattleLimits,false));
      this.codec_mapName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_matchBattle = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_maxPeopleCount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_modeName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_parkourMode = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_running = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_spectator = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_suspiciousUserIds = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
      this.codec_timeLeft = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_valuableRound = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:StatisticsModelCC = new StatisticsModelCC();
      local2.battleName = this.codec_battleName.decode(param1) as String;
      local2.equipmentConstraintsMode = this.codec_equipmentConstraintsMode.decode(param1) as String;
      local2.fund = this.codec_fund.decode(param1) as int;
      local2.limits = this.codec_limits.decode(param1) as BattleLimits;
      local2.mapName = this.codec_mapName.decode(param1) as String;
      local2.matchBattle = this.codec_matchBattle.decode(param1) as Boolean;
      local2.maxPeopleCount = this.codec_maxPeopleCount.decode(param1) as int;
      local2.modeName = this.codec_modeName.decode(param1) as String;
      local2.parkourMode = this.codec_parkourMode.decode(param1) as Boolean;
      local2.running = this.codec_running.decode(param1) as Boolean;
      local2.spectator = this.codec_spectator.decode(param1) as Boolean;
      local2.suspiciousUserIds = this.codec_suspiciousUserIds.decode(param1) as Vector.<Long>;
      local2.timeLeft = this.codec_timeLeft.decode(param1) as int;
      local2.valuableRound = this.codec_valuableRound.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:StatisticsModelCC = StatisticsModelCC(param2);
      this.codec_battleName.encode(param1,local3.battleName);
      this.codec_equipmentConstraintsMode.encode(param1,local3.equipmentConstraintsMode);
      this.codec_fund.encode(param1,local3.fund);
      this.codec_limits.encode(param1,local3.limits);
      this.codec_mapName.encode(param1,local3.mapName);
      this.codec_matchBattle.encode(param1,local3.matchBattle);
      this.codec_maxPeopleCount.encode(param1,local3.maxPeopleCount);
      this.codec_modeName.encode(param1,local3.modeName);
      this.codec_parkourMode.encode(param1,local3.parkourMode);
      this.codec_running.encode(param1,local3.running);
      this.codec_spectator.encode(param1,local3.spectator);
      this.codec_suspiciousUserIds.encode(param1,local3.suspiciousUserIds);
      this.codec_timeLeft.encode(param1,local3.timeLeft);
      this.codec_valuableRound.encode(param1,local3.valuableRound);
    }
  }
}
