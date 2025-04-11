package projects.tanks.client.battlefield.models.tankparts.weapon.turret {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretStateCommand;

  public class RotatingTurretModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RotatingTurretModelServer;

    private var client:IRotatingTurretModelBase = IRotatingTurretModelBase(this);
    private var modelId:Long = Long.getLong(652662967,-1245415753);
    private var _updateId:Long = Long.getLong(1536305300,1218725205);
    private var _update_turretStateCommandCodec:ICodec;

    public function RotatingTurretModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RotatingTurretModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(RotatingTurretCC,false)));
      this._update_turretStateCommandCodec = this._protocol.getCodec(new TypeCodecInfo(TurretStateCommand,false));
    }

    protected function getInitParam() : RotatingTurretCC {
      return RotatingTurretCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._updateId:
          this.client.update(TurretStateCommand(this._update_turretStateCommandCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
