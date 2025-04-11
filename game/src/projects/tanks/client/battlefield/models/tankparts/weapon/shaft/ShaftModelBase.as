package projects.tanks.client.battlefield.models.tankparts.weapon.shaft {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class ShaftModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ShaftModelServer;

    private var client:IShaftModelBase = IShaftModelBase(this);
    private var modelId:Long = Long.getLong(170467452,-1685189911);
    private var _activateManualTargetingId:Long = Long.getLong(741262612,-1895966548);
    private var _activateManualTargeting_shooterCodec:ICodec;
    private var _fireId:Long = Long.getLong(1921998262,-1791534114);
    private var _fire_shooterCodec:ICodec;
    private var _fire_staticHitPointCodec:ICodec;
    private var _fire_targetCodec:ICodec;
    private var _fire_targetHitPointCodec:ICodec;
    private var _fire_impactForceCodec:ICodec;
    private var _reconfigureWeaponId:Long = Long.getLong(1204032744,-1504214109);
    private var _reconfigureWeapon_dischargeRateCodec:ICodec;
    private var _reconfigureWeapon_fastShotEnergyCodec:ICodec;
    private var _reconfigureWeapon_sniperModeLockedCodec:ICodec;
    private var _stopManulaTargetingId:Long = Long.getLong(247034803,-90734157);
    private var _stopManulaTargeting_shooterCodec:ICodec;

    public function ShaftModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ShaftModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ShaftCC,false)));
      this._activateManualTargeting_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._fire_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._fire_staticHitPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._fire_targetCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,true));
      this._fire_targetHitPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._fire_impactForceCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._reconfigureWeapon_dischargeRateCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._reconfigureWeapon_fastShotEnergyCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._reconfigureWeapon_sniperModeLockedCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._stopManulaTargeting_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    protected function getInitParam() : ShaftCC {
      return ShaftCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._activateManualTargetingId:
          this.client.activateManualTargeting(IGameObject(this._activateManualTargeting_shooterCodec.decode(param2)));
          break;
        case this._fireId:
          this.client.fire(IGameObject(this._fire_shooterCodec.decode(param2)),Vector3d(this._fire_staticHitPointCodec.decode(param2)),IGameObject(this._fire_targetCodec.decode(param2)),Vector3d(this._fire_targetHitPointCodec.decode(param2)),Number(this._fire_impactForceCodec.decode(param2)));
          break;
        case this._reconfigureWeaponId:
          this.client.reconfigureWeapon(Number(this._reconfigureWeapon_dischargeRateCodec.decode(param2)),Number(this._reconfigureWeapon_fastShotEnergyCodec.decode(param2)),Boolean(this._reconfigureWeapon_sniperModeLockedCodec.decode(param2)));
          break;
        case this._stopManulaTargetingId:
          this.client.stopManulaTargeting(IGameObject(this._stopManulaTargeting_shooterCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
