package _codec.projects.tanks.client.battleservice {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.BattleCreateParameters;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.client.battleservice.model.createparams.BattleLimits;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;

  public class CodecBattleCreateParameters implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_autoBalance:ICodec;
    private var codec_battleMode:ICodec;
    private var codec_clanBattle:ICodec;
    private var codec_dependentCooldownEnabled:ICodec;
    private var codec_equipmentConstraintsMode:ICodec;
    private var codec_friendlyFire:ICodec;
    private var codec_goldBoxesEnabled:ICodec;
    private var codec_limits:ICodec;
    private var codec_mapId:ICodec;
    private var codec_maxPeopleCount:ICodec;
    private var codec_name:ICodec;
    private var codec_parkourMode:ICodec;
    private var codec_privateBattle:ICodec;
    private var codec_proBattle:ICodec;
    private var codec_rankRange:ICodec;
    private var codec_reArmorEnabled:ICodec;
    private var codec_theme:ICodec;
    private var codec_ultimatesEnabled:ICodec;
    private var codec_uniqueUsersBattle:ICodec;
    private var codec_withoutBonuses:ICodec;
    private var codec_withoutDevices:ICodec;
    private var codec_withoutDrones:ICodec;
    private var codec_withoutSupplies:ICodec;
    private var codec_withoutUpgrades:ICodec;

    public function CodecBattleCreateParameters() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_autoBalance = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_battleMode = param1.getCodec(new EnumCodecInfo(BattleMode,false));
      this.codec_clanBattle = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_dependentCooldownEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_equipmentConstraintsMode = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_friendlyFire = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_goldBoxesEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_limits = param1.getCodec(new TypeCodecInfo(BattleLimits,false));
      this.codec_mapId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_maxPeopleCount = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_parkourMode = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_privateBattle = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_proBattle = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_rankRange = param1.getCodec(new TypeCodecInfo(Range,false));
      this.codec_reArmorEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_theme = param1.getCodec(new EnumCodecInfo(MapTheme,false));
      this.codec_ultimatesEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_uniqueUsersBattle = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_withoutBonuses = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_withoutDevices = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_withoutDrones = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_withoutSupplies = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_withoutUpgrades = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleCreateParameters = new BattleCreateParameters();
      local2.autoBalance = this.codec_autoBalance.decode(param1) as Boolean;
      local2.battleMode = this.codec_battleMode.decode(param1) as BattleMode;
      local2.clanBattle = this.codec_clanBattle.decode(param1) as Boolean;
      local2.dependentCooldownEnabled = this.codec_dependentCooldownEnabled.decode(param1) as Boolean;
      local2.equipmentConstraintsMode = this.codec_equipmentConstraintsMode.decode(param1) as String;
      local2.friendlyFire = this.codec_friendlyFire.decode(param1) as Boolean;
      local2.goldBoxesEnabled = this.codec_goldBoxesEnabled.decode(param1) as Boolean;
      local2.limits = this.codec_limits.decode(param1) as BattleLimits;
      local2.mapId = this.codec_mapId.decode(param1) as Long;
      local2.maxPeopleCount = this.codec_maxPeopleCount.decode(param1) as int;
      local2.name = this.codec_name.decode(param1) as String;
      local2.parkourMode = this.codec_parkourMode.decode(param1) as Boolean;
      local2.privateBattle = this.codec_privateBattle.decode(param1) as Boolean;
      local2.proBattle = this.codec_proBattle.decode(param1) as Boolean;
      local2.rankRange = this.codec_rankRange.decode(param1) as Range;
      local2.reArmorEnabled = this.codec_reArmorEnabled.decode(param1) as Boolean;
      local2.theme = this.codec_theme.decode(param1) as MapTheme;
      local2.ultimatesEnabled = this.codec_ultimatesEnabled.decode(param1) as Boolean;
      local2.uniqueUsersBattle = this.codec_uniqueUsersBattle.decode(param1) as Boolean;
      local2.withoutBonuses = this.codec_withoutBonuses.decode(param1) as Boolean;
      local2.withoutDevices = this.codec_withoutDevices.decode(param1) as Boolean;
      local2.withoutDrones = this.codec_withoutDrones.decode(param1) as Boolean;
      local2.withoutSupplies = this.codec_withoutSupplies.decode(param1) as Boolean;
      local2.withoutUpgrades = this.codec_withoutUpgrades.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleCreateParameters = BattleCreateParameters(param2);
      this.codec_autoBalance.encode(param1,local3.autoBalance);
      this.codec_battleMode.encode(param1,local3.battleMode);
      this.codec_clanBattle.encode(param1,local3.clanBattle);
      this.codec_dependentCooldownEnabled.encode(param1,local3.dependentCooldownEnabled);
      this.codec_equipmentConstraintsMode.encode(param1,local3.equipmentConstraintsMode);
      this.codec_friendlyFire.encode(param1,local3.friendlyFire);
      this.codec_goldBoxesEnabled.encode(param1,local3.goldBoxesEnabled);
      this.codec_limits.encode(param1,local3.limits);
      this.codec_mapId.encode(param1,local3.mapId);
      this.codec_maxPeopleCount.encode(param1,local3.maxPeopleCount);
      this.codec_name.encode(param1,local3.name);
      this.codec_parkourMode.encode(param1,local3.parkourMode);
      this.codec_privateBattle.encode(param1,local3.privateBattle);
      this.codec_proBattle.encode(param1,local3.proBattle);
      this.codec_rankRange.encode(param1,local3.rankRange);
      this.codec_reArmorEnabled.encode(param1,local3.reArmorEnabled);
      this.codec_theme.encode(param1,local3.theme);
      this.codec_ultimatesEnabled.encode(param1,local3.ultimatesEnabled);
      this.codec_uniqueUsersBattle.encode(param1,local3.uniqueUsersBattle);
      this.codec_withoutBonuses.encode(param1,local3.withoutBonuses);
      this.codec_withoutDevices.encode(param1,local3.withoutDevices);
      this.codec_withoutDrones.encode(param1,local3.withoutDrones);
      this.codec_withoutSupplies.encode(param1,local3.withoutSupplies);
      this.codec_withoutUpgrades.encode(param1,local3.withoutUpgrades);
    }
  }
}
