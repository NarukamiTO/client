package projects.tanks.client.battlefield.models.tankparts.weapon.shot {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class DiscreteShotModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:DiscreteShotModelServer;

    private var client:IDiscreteShotModelBase = IDiscreteShotModelBase(this);
    private var modelId:Long = Long.getLong(968114218,-1703577718);
    private var _reconfigureWeaponId:Long = Long.getLong(1553277326,-178268452);
    private var _reconfigureWeapon_reloadTimeCodec:ICodec;

    public function DiscreteShotModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new DiscreteShotModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ShotCC,false)));
      this._reconfigureWeapon_reloadTimeCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : ShotCC {
      return ShotCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._reconfigureWeaponId:
          this.client.reconfigureWeapon(int(this._reconfigureWeapon_reloadTimeCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
