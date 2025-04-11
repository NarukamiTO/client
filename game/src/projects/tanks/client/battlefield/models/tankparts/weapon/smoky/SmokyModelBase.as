package projects.tanks.client.battlefield.models.tankparts.weapon.smoky {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class SmokyModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:SmokyModelServer;

    private var client:ISmokyModelBase = ISmokyModelBase(this);
    private var modelId:Long = Long.getLong(505740619,208573179);
    private var _localCriticalHitId:Long = Long.getLong(1314377165,-137514211);
    private var _localCriticalHit_targetCodec:ICodec;
    private var _shootId:Long = Long.getLong(1283643622,1059974789);
    private var _shoot_shooterCodec:ICodec;
    private var _shootStaticId:Long = Long.getLong(954743485,-2074939053);
    private var _shootStatic_shooterCodec:ICodec;
    private var _shootStatic_hitPointCodec:ICodec;
    private var _shootTargetId:Long = Long.getLong(954743485,-2063362954);
    private var _shootTarget_shooterCodec:ICodec;
    private var _shootTarget_targetCodec:ICodec;
    private var _shootTarget_hitPointCodec:ICodec;
    private var _shootTarget_weakeningCoeffCodec:ICodec;
    private var _shootTarget_isCriticalCodec:ICodec;

    public function SmokyModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new SmokyModelServer(IModel(this));
      this._localCriticalHit_targetCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._shoot_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._shootStatic_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._shootStatic_hitPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._shootTarget_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._shootTarget_targetCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._shootTarget_hitPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._shootTarget_weakeningCoeffCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._shootTarget_isCriticalCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._localCriticalHitId:
          this.client.localCriticalHit(IGameObject(this._localCriticalHit_targetCodec.decode(param2)));
          break;
        case this._shootId:
          this.client.shoot(IGameObject(this._shoot_shooterCodec.decode(param2)));
          break;
        case this._shootStaticId:
          this.client.shootStatic(IGameObject(this._shootStatic_shooterCodec.decode(param2)),Vector3d(this._shootStatic_hitPointCodec.decode(param2)));
          break;
        case this._shootTargetId:
          this.client.shootTarget(IGameObject(this._shootTarget_shooterCodec.decode(param2)),IGameObject(this._shootTarget_targetCodec.decode(param2)),Vector3d(this._shootTarget_hitPointCodec.decode(param2)),Number(this._shootTarget_weakeningCoeffCodec.decode(param2)),Boolean(this._shootTarget_isCriticalCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
