package projects.tanks.client.battlefield.models.user.tank {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
  import projects.tanks.client.battlefield.types.DamageType;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class TankModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TankModelServer;

    private var client:ITankModelBase = ITankModelBase(this);
    private var modelId:Long = Long.getLong(500772743,-1275562344);
    private var _activateTankId:Long = Long.getLong(1132148565,-1228176022);
    private var _deathConfirmedId:Long = Long.getLong(1500025148,-1072265992);
    private var _killId:Long = Long.getLong(815803475,677498549);
    private var _kill_killerTankIdCodec:ICodec;
    private var _kill_respawnDelayCodec:ICodec;
    private var _kill_damageTypeCodec:ICodec;
    private var _moveId:Long = Long.getLong(815803475,677432898);
    private var _move_moveCommandCodec:ICodec;
    private var _movementControlId:Long = Long.getLong(1056545941,1597681057);
    private var _movementControl_controlCodec:ICodec;
    private var _movementControl_turnSpeedNumberCodec:ICodec;
    private var _pushId:Long = Long.getLong(815803475,677337849);
    private var _push_hitPointCodec:ICodec;
    private var _push_forceCodec:ICodec;
    private var _resetConfigurationId:Long = Long.getLong(1453923431,-1281454868);
    private var _resetConfiguration_hullIdCodec:ICodec;
    private var _resetConfiguration_weaponIdCodec:ICodec;
    private var _resetConfiguration_droneIdCodec:ICodec;
    private var _resetConfiguration_fullHealthHitsCodec:ICodec;
    private var _setHealthId:Long = Long.getLong(696094159,-894234735);
    private var _setHealth_newHealthCodec:ICodec;

    public function TankModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TankModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(TankCC,false)));
      this._kill_killerTankIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._kill_respawnDelayCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._kill_damageTypeCodec = this._protocol.getCodec(new EnumCodecInfo(DamageType,false));
      this._move_moveCommandCodec = this._protocol.getCodec(new TypeCodecInfo(MoveCommand,false));
      this._movementControl_controlCodec = this._protocol.getCodec(new TypeCodecInfo(Byte,false));
      this._movementControl_turnSpeedNumberCodec = this._protocol.getCodec(new TypeCodecInfo(Byte,false));
      this._push_hitPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._push_forceCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._resetConfiguration_hullIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._resetConfiguration_weaponIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._resetConfiguration_droneIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._resetConfiguration_fullHealthHitsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._setHealth_newHealthCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
    }

    protected function getInitParam() : TankCC {
      return TankCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._activateTankId:
          this.client.activateTank();
          break;
        case this._deathConfirmedId:
          this.client.deathConfirmed();
          break;
        case this._killId:
          this.client.kill(Long(this._kill_killerTankIdCodec.decode(param2)),int(this._kill_respawnDelayCodec.decode(param2)),DamageType(this._kill_damageTypeCodec.decode(param2)));
          break;
        case this._moveId:
          this.client.move(MoveCommand(this._move_moveCommandCodec.decode(param2)));
          break;
        case this._movementControlId:
          this.client.movementControl(int(this._movementControl_controlCodec.decode(param2)),int(this._movementControl_turnSpeedNumberCodec.decode(param2)));
          break;
        case this._pushId:
          this.client.push(Vector3d(this._push_hitPointCodec.decode(param2)),Vector3d(this._push_forceCodec.decode(param2)));
          break;
        case this._resetConfigurationId:
          this.client.resetConfiguration(Long(this._resetConfiguration_hullIdCodec.decode(param2)),Long(this._resetConfiguration_weaponIdCodec.decode(param2)),Long(this._resetConfiguration_droneIdCodec.decode(param2)),int(this._resetConfiguration_fullHealthHitsCodec.decode(param2)));
          break;
        case this._setHealthId:
          this.client.setHealth(Number(this._setHealth_newHealthCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
