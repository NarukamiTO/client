package projects.tanks.client.battlefield.models.tankparts.weapon.thunder {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class ThunderModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ThunderModelServer;

    private var client:IThunderModelBase = IThunderModelBase(this);
    private var modelId:Long = Long.getLong(254322684,-956504003);
    private var _shootId:Long = Long.getLong(1180507715,64759943);
    private var _shoot_shooterCodec:ICodec;
    private var _shootStaticId:Long = Long.getLong(547115248,565846485);
    private var _shootStatic_shooterCodec:ICodec;
    private var _shootStatic_hitPointCodec:ICodec;
    private var _shootTargetId:Long = Long.getLong(547115248,577422584);
    private var _shootTarget_shooterCodec:ICodec;
    private var _shootTarget_targetCodec:ICodec;
    private var _shootTarget_relativeHitPointCodec:ICodec;

    public function ThunderModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ThunderModelServer(IModel(this));
      this._shoot_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._shootStatic_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._shootStatic_hitPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._shootTarget_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._shootTarget_targetCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._shootTarget_relativeHitPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._shootId:
          this.client.shoot(IGameObject(this._shoot_shooterCodec.decode(param2)));
          break;
        case this._shootStaticId:
          this.client.shootStatic(IGameObject(this._shootStatic_shooterCodec.decode(param2)),Vector3d(this._shootStatic_hitPointCodec.decode(param2)));
          break;
        case this._shootTargetId:
          this.client.shootTarget(IGameObject(this._shootTarget_shooterCodec.decode(param2)),IGameObject(this._shootTarget_targetCodec.decode(param2)),Vector3d(this._shootTarget_relativeHitPointCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
