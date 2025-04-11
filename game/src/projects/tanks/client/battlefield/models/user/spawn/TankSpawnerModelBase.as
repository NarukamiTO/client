package projects.tanks.client.battlefield.models.user.spawn {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class TankSpawnerModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TankSpawnerModelServer;

    private var client:ITankSpawnerModelBase = ITankSpawnerModelBase(this);
    private var modelId:Long = Long.getLong(490108405,-1605879749);
    private var _prepareToSpawnId:Long = Long.getLong(1841708554,1107932617);
    private var _prepareToSpawn_positionCodec:ICodec;
    private var _prepareToSpawn_orientationCodec:ICodec;
    private var _spawnId:Long = Long.getLong(937986364,-303760789);
    private var _spawn_teamCodec:ICodec;
    private var _spawn_positionCodec:ICodec;
    private var _spawn_orientationCodec:ICodec;
    private var _spawn_healthCodec:ICodec;
    private var _spawn_incarnationIdCodec:ICodec;

    public function TankSpawnerModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TankSpawnerModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(TankSpawnerCC,false)));
      this._prepareToSpawn_positionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._prepareToSpawn_orientationCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._spawn_teamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
      this._spawn_positionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._spawn_orientationCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._spawn_healthCodec = this._protocol.getCodec(new TypeCodecInfo(Short,false));
      this._spawn_incarnationIdCodec = this._protocol.getCodec(new TypeCodecInfo(Short,false));
    }

    protected function getInitParam() : TankSpawnerCC {
      return TankSpawnerCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._prepareToSpawnId:
          this.client.prepareToSpawn(Vector3d(this._prepareToSpawn_positionCodec.decode(param2)),Vector3d(this._prepareToSpawn_orientationCodec.decode(param2)));
          break;
        case this._spawnId:
          this.client.spawn(BattleTeam(this._spawn_teamCodec.decode(param2)),Vector3d(this._spawn_positionCodec.decode(param2)),Vector3d(this._spawn_orientationCodec.decode(param2)),int(this._spawn_healthCodec.decode(param2)),int(this._spawn_incarnationIdCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
