package _codec.projects.tanks.client.battleselect.model.map {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.battleselect.model.map.MapInfoCC;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;

  public class CodecMapInfoCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_defaultTheme:ICodec;
    private var codec_enabled:ICodec;
    private var codec_mapId:ICodec;
    private var codec_mapName:ICodec;
    private var codec_matchmakingMark:ICodec;
    private var codec_maxPeople:ICodec;
    private var codec_preview:ICodec;
    private var codec_rankLimit:ICodec;
    private var codec_supportedModes:ICodec;
    private var codec_theme:ICodec;

    public function CodecMapInfoCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_defaultTheme = param1.getCodec(new EnumCodecInfo(MapTheme,false));
      this.codec_enabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_mapId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_mapName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_matchmakingMark = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_maxPeople = param1.getCodec(new TypeCodecInfo(Short,false));
      this.codec_preview = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_rankLimit = param1.getCodec(new TypeCodecInfo(Range,false));
      this.codec_supportedModes = param1.getCodec(new CollectionCodecInfo(new EnumCodecInfo(BattleMode,false),false,1));
      this.codec_theme = param1.getCodec(new EnumCodecInfo(MapTheme,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MapInfoCC = new MapInfoCC();
      local2.defaultTheme = this.codec_defaultTheme.decode(param1) as MapTheme;
      local2.enabled = this.codec_enabled.decode(param1) as Boolean;
      local2.mapId = this.codec_mapId.decode(param1) as Long;
      local2.mapName = this.codec_mapName.decode(param1) as String;
      local2.matchmakingMark = this.codec_matchmakingMark.decode(param1) as Boolean;
      local2.maxPeople = this.codec_maxPeople.decode(param1) as int;
      local2.preview = this.codec_preview.decode(param1) as ImageResource;
      local2.rankLimit = this.codec_rankLimit.decode(param1) as Range;
      local2.supportedModes = this.codec_supportedModes.decode(param1) as Vector.<BattleMode>;
      local2.theme = this.codec_theme.decode(param1) as MapTheme;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MapInfoCC = MapInfoCC(param2);
      this.codec_defaultTheme.encode(param1,local3.defaultTheme);
      this.codec_enabled.encode(param1,local3.enabled);
      this.codec_mapId.encode(param1,local3.mapId);
      this.codec_mapName.encode(param1,local3.mapName);
      this.codec_matchmakingMark.encode(param1,local3.matchmakingMark);
      this.codec_maxPeople.encode(param1,local3.maxPeople);
      this.codec_preview.encode(param1,local3.preview);
      this.codec_rankLimit.encode(param1,local3.rankLimit);
      this.codec_supportedModes.encode(param1,local3.supportedModes);
      this.codec_theme.encode(param1,local3.theme);
    }
  }
}
