package projects.tanks.client.battlefield.models.tankparts.weapon.laser {
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

  public class LaserPointerModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:LaserPointerModelServer;

    private var client:ILaserPointerModelBase = ILaserPointerModelBase(this);
    private var modelId:Long = Long.getLong(1691794381,-1794202080);
    private var _aimRemoteAtTankId:Long = Long.getLong(2087187664,-1594727181);
    private var _aimRemoteAtTank_targetTankCodec:ICodec;
    private var _aimRemoteAtTank_localSpotPositionCodec:ICodec;
    private var _hideRemoteId:Long = Long.getLong(1056602643,1332983261);
    private var _updateRemoteDirectionId:Long = Long.getLong(1740337189,-128463099);
    private var _updateRemoteDirection_projectionOnVerticalAxisCodec:ICodec;

    public function LaserPointerModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new LaserPointerModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(LaserPointerCC,false)));
      this._aimRemoteAtTank_targetTankCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._aimRemoteAtTank_localSpotPositionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._updateRemoteDirection_projectionOnVerticalAxisCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
    }

    protected function getInitParam() : LaserPointerCC {
      return LaserPointerCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._aimRemoteAtTankId:
          this.client.aimRemoteAtTank(IGameObject(this._aimRemoteAtTank_targetTankCodec.decode(param2)),Vector3d(this._aimRemoteAtTank_localSpotPositionCodec.decode(param2)));
          break;
        case this._hideRemoteId:
          this.client.hideRemote();
          break;
        case this._updateRemoteDirectionId:
          this.client.updateRemoteDirection(Number(this._updateRemoteDirection_projectionOnVerticalAxisCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
