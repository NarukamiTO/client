package projects.tanks.client.battlefield.models.tankparts.weapon.weakening {
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

  public class WeaponWeakeningModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:WeaponWeakeningModelServer;

    private var client:IWeaponWeakeningModelBase = IWeaponWeakeningModelBase(this);
    private var modelId:Long = Long.getLong(1486543535,-1939817925);
    private var _reconfigureWeaponId:Long = Long.getLong(215209601,1065005749);
    private var _reconfigureWeapon_maxDamageRadiusCodec:ICodec;
    private var _reconfigureWeapon_minDamageRadiusCodec:ICodec;

    public function WeaponWeakeningModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new WeaponWeakeningModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(WeaponWeakeningCC,false)));
      this._reconfigureWeapon_maxDamageRadiusCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._reconfigureWeapon_minDamageRadiusCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
    }

    protected function getInitParam() : WeaponWeakeningCC {
      return WeaponWeakeningCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._reconfigureWeaponId:
          this.client.reconfigureWeapon(Number(this._reconfigureWeapon_maxDamageRadiusCodec.decode(param2)),Number(this._reconfigureWeapon_minDamageRadiusCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
