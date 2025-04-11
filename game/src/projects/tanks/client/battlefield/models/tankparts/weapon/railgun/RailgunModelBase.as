package projects.tanks.client.battlefield.models.tankparts.weapon.railgun {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class RailgunModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RailgunModelServer;

    private var client:IRailgunModelBase = IRailgunModelBase(this);
    private var modelId:Long = Long.getLong(387277533,1853292335);
    private var _fireId:Long = Long.getLong(87545380,-265767482);
    private var _fire_shooterCodec:ICodec;
    private var _fire_staticHitPointCodec:ICodec;
    private var _fire_targetsCodec:ICodec;
    private var _fire_targetHitPointsCodec:ICodec;
    private var _fireDummyId:Long = Long.getLong(289812713,334160242);
    private var _fireDummy_shooterCodec:ICodec;
    private var _immediateReloadId:Long = Long.getLong(1438252851,-2076139994);
    private var _reconfigureWeaponId:Long = Long.getLong(549412808,-630293643);
    private var _reconfigureWeapon_chargingTimeCodec:ICodec;
    private var _startChargingId:Long = Long.getLong(498560719,475399825);
    private var _startCharging_shooterCodec:ICodec;

    public function RailgunModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RailgunModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(RailgunCC,false)));
      this._fire_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._fire_staticHitPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._fire_targetsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),true,1));
      this._fire_targetHitPointsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),true,1));
      this._fireDummy_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._reconfigureWeapon_chargingTimeCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._startCharging_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    protected function getInitParam() : RailgunCC {
      return RailgunCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._fireId:
          this.client.fire(IGameObject(this._fire_shooterCodec.decode(param2)),Vector3d(this._fire_staticHitPointCodec.decode(param2)),this._fire_targetsCodec.decode(param2) as Vector.<IGameObject>,this._fire_targetHitPointsCodec.decode(param2) as Vector.<Vector3d>);
          break;
        case this._fireDummyId:
          this.client.fireDummy(IGameObject(this._fireDummy_shooterCodec.decode(param2)));
          break;
        case this._immediateReloadId:
          this.client.immediateReload();
          break;
        case this._reconfigureWeaponId:
          this.client.reconfigureWeapon(int(this._reconfigureWeapon_chargingTimeCodec.decode(param2)));
          break;
        case this._startChargingId:
          this.client.startCharging(IGameObject(this._startCharging_shooterCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
