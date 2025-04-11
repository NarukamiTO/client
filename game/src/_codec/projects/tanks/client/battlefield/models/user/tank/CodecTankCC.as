package _codec.projects.tanks.client.battlefield.models.user.tank {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Short;
  import projects.tanks.client.battlefield.models.user.tank.TankCC;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;
  import projects.tanks.client.battlefield.types.TankState;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class CodecTankCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_health:ICodec;
    private var codec_local:ICodec;
    private var codec_logicState:ICodec;
    private var codec_movementDistanceBorderUntilTankCorrection:ICodec;
    private var codec_movementTimeoutUntilTankCorrection:ICodec;
    private var codec_tankState:ICodec;
    private var codec_team:ICodec;

    public function CodecTankCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_health = param1.getCodec(new TypeCodecInfo(Short,false));
      this.codec_local = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_logicState = param1.getCodec(new EnumCodecInfo(TankLogicState,false));
      this.codec_movementDistanceBorderUntilTankCorrection = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_movementTimeoutUntilTankCorrection = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_tankState = param1.getCodec(new TypeCodecInfo(TankState,true));
      this.codec_team = param1.getCodec(new EnumCodecInfo(BattleTeam,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TankCC = new TankCC();
      local2.health = this.codec_health.decode(param1) as int;
      local2.local = this.codec_local.decode(param1) as Boolean;
      local2.logicState = this.codec_logicState.decode(param1) as TankLogicState;
      local2.movementDistanceBorderUntilTankCorrection = this.codec_movementDistanceBorderUntilTankCorrection.decode(param1) as int;
      local2.movementTimeoutUntilTankCorrection = this.codec_movementTimeoutUntilTankCorrection.decode(param1) as int;
      local2.tankState = this.codec_tankState.decode(param1) as TankState;
      local2.team = this.codec_team.decode(param1) as BattleTeam;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TankCC = TankCC(param2);
      this.codec_health.encode(param1,local3.health);
      this.codec_local.encode(param1,local3.local);
      this.codec_logicState.encode(param1,local3.logicState);
      this.codec_movementDistanceBorderUntilTankCorrection.encode(param1,local3.movementDistanceBorderUntilTankCorrection);
      this.codec_movementTimeoutUntilTankCorrection.encode(param1,local3.movementTimeoutUntilTankCorrection);
      this.codec_tankState.encode(param1,local3.tankState);
      this.codec_team.encode(param1,local3.team);
    }
  }
}
