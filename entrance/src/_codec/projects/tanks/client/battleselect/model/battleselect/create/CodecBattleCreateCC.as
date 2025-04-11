package _codec.projects.tanks.client.battleselect.model.battleselect.create {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battleselect.model.battleselect.create.BattleCreateCC;
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.client.battleservice.model.createparams.BattleLimits;

  public class CodecBattleCreateCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_battleCreationDisabled:ICodec;
    private var codec_battlesLimits:ICodec;
    private var codec_defaultRange:ICodec;
    private var codec_maxRange:ICodec;
    private var codec_maxRangeLength:ICodec;
    private var codec_ultimatesEnabled:ICodec;

    public function CodecBattleCreateCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_battleCreationDisabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_battlesLimits = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BattleLimits,false),false,1));
      this.codec_defaultRange = param1.getCodec(new TypeCodecInfo(Range,false));
      this.codec_maxRange = param1.getCodec(new TypeCodecInfo(Range,false));
      this.codec_maxRangeLength = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_ultimatesEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleCreateCC = new BattleCreateCC();
      local2.battleCreationDisabled = this.codec_battleCreationDisabled.decode(param1) as Boolean;
      local2.battlesLimits = this.codec_battlesLimits.decode(param1) as Vector.<BattleLimits>;
      local2.defaultRange = this.codec_defaultRange.decode(param1) as Range;
      local2.maxRange = this.codec_maxRange.decode(param1) as Range;
      local2.maxRangeLength = this.codec_maxRangeLength.decode(param1) as int;
      local2.ultimatesEnabled = this.codec_ultimatesEnabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleCreateCC = BattleCreateCC(param2);
      this.codec_battleCreationDisabled.encode(param1,local3.battleCreationDisabled);
      this.codec_battlesLimits.encode(param1,local3.battlesLimits);
      this.codec_defaultRange.encode(param1,local3.defaultRange);
      this.codec_maxRange.encode(param1,local3.maxRange);
      this.codec_maxRangeLength.encode(param1,local3.maxRangeLength);
      this.codec_ultimatesEnabled.encode(param1,local3.ultimatesEnabled);
    }
  }
}
