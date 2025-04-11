package projects.tanks.client.battlefield.models.tankparts.weapon.healing {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;

  public class IsisModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:IsisModelServer;

    private var client:IIsisModelBase = IIsisModelBase(this);
    private var modelId:Long = Long.getLong(1645686167,1474428435);
    private var _addEnergyId:Long = Long.getLong(387345259,-1471314439);
    private var _addEnergy_energyDeltaCodec:ICodec;
    private var _reconfigureWeaponId:Long = Long.getLong(2020897529,-1471968141);
    private var _reconfigureWeapon_dischargeDamageSpeedCodec:ICodec;
    private var _reconfigureWeapon_dischargeHealingSpeedCodec:ICodec;
    private var _reconfigureWeapon_dischargeIdleSpeedCodec:ICodec;
    private var _reconfigureWeapon_radiusCodec:ICodec;
    private var _resetTargetId:Long = Long.getLong(1426613749,-669664322);
    private var _setTargetId:Long = Long.getLong(387341675,1817286639);
    private var _setTarget_stateCodec:ICodec;
    private var _setTarget_hitCodec:ICodec;
    private var _stopWeaponId:Long = Long.getLong(877312902,1109359872);

    public function IsisModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new IsisModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(IsisCC,false)));
      this._addEnergy_energyDeltaCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._reconfigureWeapon_dischargeDamageSpeedCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._reconfigureWeapon_dischargeHealingSpeedCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._reconfigureWeapon_dischargeIdleSpeedCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._reconfigureWeapon_radiusCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._setTarget_stateCodec = this._protocol.getCodec(new EnumCodecInfo(IsisState,false));
      this._setTarget_hitCodec = this._protocol.getCodec(new TypeCodecInfo(TargetHit,false));
    }

    protected function getInitParam() : IsisCC {
      return IsisCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._addEnergyId:
          this.client.addEnergy(int(this._addEnergy_energyDeltaCodec.decode(param2)));
          break;
        case this._reconfigureWeaponId:
          this.client.reconfigureWeapon(Number(this._reconfigureWeapon_dischargeDamageSpeedCodec.decode(param2)),Number(this._reconfigureWeapon_dischargeHealingSpeedCodec.decode(param2)),Number(this._reconfigureWeapon_dischargeIdleSpeedCodec.decode(param2)),Number(this._reconfigureWeapon_radiusCodec.decode(param2)));
          break;
        case this._resetTargetId:
          this.client.resetTarget();
          break;
        case this._setTargetId:
          this.client.setTarget(IsisState(this._setTarget_stateCodec.decode(param2)),TargetHit(this._setTarget_hitCodec.decode(param2)));
          break;
        case this._stopWeaponId:
          this.client.stopWeapon();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
