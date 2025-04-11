package projects.tanks.client.battlefield.models.tankparts.weapons.machinegun {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.cc.MachineGunCC;

  public class MachineGunModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MachineGunModelServer;

    private var client:IMachineGunModelBase = IMachineGunModelBase(this);
    private var modelId:Long = Long.getLong(1635158664,1411719504);
    private var _reconfigureWeaponId:Long = Long.getLong(458370105,-2041665930);
    private var _reconfigureWeapon_spinUpTimeCodec:ICodec;
    private var _reconfigureWeapon_spinDownTimeCodec:ICodec;
    private var _setSpunStateId:Long = Long.getLong(815911334,941718050);

    public function MachineGunModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MachineGunModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(MachineGunCC,false)));
      this._reconfigureWeapon_spinUpTimeCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._reconfigureWeapon_spinDownTimeCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : MachineGunCC {
      return MachineGunCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._reconfigureWeaponId:
          this.client.reconfigureWeapon(int(this._reconfigureWeapon_spinUpTimeCodec.decode(param2)),int(this._reconfigureWeapon_spinDownTimeCodec.decode(param2)));
          break;
        case this._setSpunStateId:
          this.client.setSpunState();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
