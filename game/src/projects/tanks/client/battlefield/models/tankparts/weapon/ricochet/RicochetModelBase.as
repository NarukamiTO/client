package projects.tanks.client.battlefield.models.tankparts.weapon.ricochet {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;

  public class RicochetModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RicochetModelServer;

    private var client:IRicochetModelBase = IRicochetModelBase(this);
    private var modelId:Long = Long.getLong(592429654,1339096271);
    private var _addEnergyId:Long = Long.getLong(1470646161,908304539);
    private var _addEnergy_energyDeltaCodec:ICodec;
    private var _fireId:Long = Long.getLong(1979897371,-1124194266);
    private var _fire_shooterCodec:ICodec;
    private var _fire_shotDirectionXCodec:ICodec;
    private var _fire_shotDirectionYCodec:ICodec;
    private var _fire_shotDirectionZCodec:ICodec;
    private var _fireDummyId:Long = Long.getLong(1470645133,813558546);
    private var _fireDummy_shooterCodec:ICodec;
    private var _reconfigureWeaponId:Long = Long.getLong(619928272,961682155);
    private var _reconfigureWeapon_maxDistanceCodec:ICodec;
    private var _reconfigureWeapon_energyPerShootCodec:ICodec;

    public function RicochetModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RicochetModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(RicochetCC,false)));
      this._addEnergy_energyDeltaCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._fire_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._fire_shotDirectionXCodec = this._protocol.getCodec(new TypeCodecInfo(Short,false));
      this._fire_shotDirectionYCodec = this._protocol.getCodec(new TypeCodecInfo(Short,false));
      this._fire_shotDirectionZCodec = this._protocol.getCodec(new TypeCodecInfo(Short,false));
      this._fireDummy_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._reconfigureWeapon_maxDistanceCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._reconfigureWeapon_energyPerShootCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
    }

    protected function getInitParam() : RicochetCC {
      return RicochetCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._addEnergyId:
          this.client.addEnergy(int(this._addEnergy_energyDeltaCodec.decode(param2)));
          break;
        case this._fireId:
          this.client.fire(IGameObject(this._fire_shooterCodec.decode(param2)),int(this._fire_shotDirectionXCodec.decode(param2)),int(this._fire_shotDirectionYCodec.decode(param2)),int(this._fire_shotDirectionZCodec.decode(param2)));
          break;
        case this._fireDummyId:
          this.client.fireDummy(IGameObject(this._fireDummy_shooterCodec.decode(param2)));
          break;
        case this._reconfigureWeaponId:
          this.client.reconfigureWeapon(Number(this._reconfigureWeapon_maxDistanceCodec.decode(param2)),Number(this._reconfigureWeapon_energyPerShootCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
