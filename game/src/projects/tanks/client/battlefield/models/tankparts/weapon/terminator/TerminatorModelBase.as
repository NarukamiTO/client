package projects.tanks.client.battlefield.models.tankparts.weapon.terminator {
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

  public class TerminatorModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TerminatorModelServer;

    private var client:ITerminatorModelBase = ITerminatorModelBase(this);
    private var modelId:Long = Long.getLong(1596182265,-1705134735);
    private var _primaryRemoteChargeId:Long = Long.getLong(1223833855,-1906776616);
    private var _primaryRemoteCharge_shooterCodec:ICodec;
    private var _primaryRemoteCharge_barrelIndexCodec:ICodec;
    private var _primaryRemoteDummyId:Long = Long.getLong(653258149,752923388);
    private var _primaryRemoteDummy_shooterCodec:ICodec;
    private var _primaryRemoteDummy_barrelIndexCodec:ICodec;
    private var _primaryRemoteShotId:Long = Long.getLong(1641495142,114693918);
    private var _primaryRemoteShot_shooterCodec:ICodec;
    private var _primaryRemoteShot_staticHitPointCodec:ICodec;
    private var _primaryRemoteShot_targetsCodec:ICodec;
    private var _primaryRemoteShot_targetHitPointsCodec:ICodec;
    private var _primaryRemoteShot_barrelIndexCodec:ICodec;
    private var _secondaryRemoteHideId:Long = Long.getLong(1755383946,-1270349656);
    private var _secondaryRemoteHide_shootersCodec:ICodec;
    private var _secondaryRemoteOpenId:Long = Long.getLong(1755383946,-1270564960);
    private var _secondaryRemoteOpen_shooterCodec:ICodec;

    public function TerminatorModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TerminatorModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(TerminatorCC,false)));
      this._primaryRemoteCharge_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._primaryRemoteCharge_barrelIndexCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryRemoteDummy_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._primaryRemoteDummy_barrelIndexCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryRemoteShot_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._primaryRemoteShot_staticHitPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._primaryRemoteShot_targetsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),true,1));
      this._primaryRemoteShot_targetHitPointsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),true,1));
      this._primaryRemoteShot_barrelIndexCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._secondaryRemoteHide_shootersCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._secondaryRemoteOpen_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    protected function getInitParam() : TerminatorCC {
      return TerminatorCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._primaryRemoteChargeId:
          this.client.primaryRemoteCharge(IGameObject(this._primaryRemoteCharge_shooterCodec.decode(param2)),int(this._primaryRemoteCharge_barrelIndexCodec.decode(param2)));
          break;
        case this._primaryRemoteDummyId:
          this.client.primaryRemoteDummy(IGameObject(this._primaryRemoteDummy_shooterCodec.decode(param2)),int(this._primaryRemoteDummy_barrelIndexCodec.decode(param2)));
          break;
        case this._primaryRemoteShotId:
          this.client.primaryRemoteShot(IGameObject(this._primaryRemoteShot_shooterCodec.decode(param2)),Vector3d(this._primaryRemoteShot_staticHitPointCodec.decode(param2)),this._primaryRemoteShot_targetsCodec.decode(param2) as Vector.<IGameObject>,this._primaryRemoteShot_targetHitPointsCodec.decode(param2) as Vector.<Vector3d>,int(this._primaryRemoteShot_barrelIndexCodec.decode(param2)));
          break;
        case this._secondaryRemoteHideId:
          this.client.secondaryRemoteHide(IGameObject(this._secondaryRemoteHide_shootersCodec.decode(param2)));
          break;
        case this._secondaryRemoteOpenId:
          this.client.secondaryRemoteOpen(IGameObject(this._secondaryRemoteOpen_shooterCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
