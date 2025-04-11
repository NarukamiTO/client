package _codec.projects.tanks.client.battleselect.model.matchmaking.view {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.battleselect.model.matchmaking.modes.MatchmakingModeRank;
  import projects.tanks.client.battleselect.model.matchmaking.view.MatchmakingLayoutCC;

  public class CodecMatchmakingLayoutCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_holidayDescription:ICodec;
    private var codec_holidayEnabled:ICodec;
    private var codec_holidayIcon:ICodec;
    private var codec_holidayTitle:ICodec;
    private var codec_matchmakingModeRanks:ICodec;
    private var codec_minRankForProBattle:ICodec;

    public function CodecMatchmakingLayoutCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_holidayDescription = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_holidayEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_holidayIcon = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_holidayTitle = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_matchmakingModeRanks = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(MatchmakingModeRank,false),false,1));
      this.codec_minRankForProBattle = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MatchmakingLayoutCC = new MatchmakingLayoutCC();
      local2.holidayDescription = this.codec_holidayDescription.decode(param1) as String;
      local2.holidayEnabled = this.codec_holidayEnabled.decode(param1) as Boolean;
      local2.holidayIcon = this.codec_holidayIcon.decode(param1) as ImageResource;
      local2.holidayTitle = this.codec_holidayTitle.decode(param1) as String;
      local2.matchmakingModeRanks = this.codec_matchmakingModeRanks.decode(param1) as Vector.<MatchmakingModeRank>;
      local2.minRankForProBattle = this.codec_minRankForProBattle.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MatchmakingLayoutCC = MatchmakingLayoutCC(param2);
      this.codec_holidayDescription.encode(param1,local3.holidayDescription);
      this.codec_holidayEnabled.encode(param1,local3.holidayEnabled);
      this.codec_holidayIcon.encode(param1,local3.holidayIcon);
      this.codec_holidayTitle.encode(param1,local3.holidayTitle);
      this.codec_matchmakingModeRanks.encode(param1,local3.matchmakingModeRanks);
      this.codec_minRankForProBattle.encode(param1,local3.minRankForProBattle);
    }
  }
}
