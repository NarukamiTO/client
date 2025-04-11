package projects.tanks.client.battlefield.models.tankparts.weapon.gauss {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class GaussModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:GaussModelServer;

    private var client:IGaussModelBase = IGaussModelBase(this);
    private var modelId:Long = Long.getLong(415126444,1630038805);
    private var _dummyShotId:Long = Long.getLong(16153141,-467637480);
    private var _primaryShotId:Long = Long.getLong(1654429078,-1789901298);
    private var _primaryShot_shotIdCodec:ICodec;
    private var _primaryShot_shotDirectionCodec:ICodec;
    private var _secondaryHitTargetCommandId:Long = Long.getLong(2066311556,139862161);
    private var _secondaryHitTargetCommand_targetCodec:ICodec;
    private var _secondaryHitTargetCommand_relativeHitPointCodec:ICodec;
    private var _startAimingId:Long = Long.getLong(1653845815,-265709909);
    private var _stopAimingId:Long = Long.getLong(500839552,1813251721);

    public function GaussModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new GaussModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(GaussCC,false)));
      this._primaryShot_shotIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryShot_shotDirectionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._secondaryHitTargetCommand_targetCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._secondaryHitTargetCommand_relativeHitPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    protected function getInitParam() : GaussCC {
      return GaussCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._dummyShotId:
          this.client.dummyShot();
          break;
        case this._primaryShotId:
          this.client.primaryShot(int(this._primaryShot_shotIdCodec.decode(param2)),Vector3d(this._primaryShot_shotDirectionCodec.decode(param2)));
          break;
        case this._secondaryHitTargetCommandId:
          this.client.secondaryHitTargetCommand(IGameObject(this._secondaryHitTargetCommand_targetCodec.decode(param2)),Vector3d(this._secondaryHitTargetCommand_relativeHitPointCodec.decode(param2)));
          break;
        case this._startAimingId:
          this.client.startAiming();
          break;
        case this._stopAimingId:
          this.client.stopAiming();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
