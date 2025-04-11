package projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class DiscreteWeaponCommunicationModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:DiscreteWeaponCommunicationModelServer;

    private var client:IDiscreteWeaponCommunicationModelBase = IDiscreteWeaponCommunicationModelBase(this);
    private var modelId:Long = Long.getLong(486222912,-663069007);
    private var _shootId:Long = Long.getLong(1666638426,-1858765435);
    private var _shoot_shooterCodec:ICodec;
    private var _shoot_directionCodec:ICodec;
    private var _shoot_targetsCodec:ICodec;

    public function DiscreteWeaponCommunicationModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new DiscreteWeaponCommunicationModelServer(IModel(this));
      this._shoot_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._shoot_directionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._shoot_targetsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(TargetHit,false),false,1));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._shootId:
          this.client.shoot(IGameObject(this._shoot_shooterCodec.decode(param2)),Vector3d(this._shoot_directionCodec.decode(param2)),this._shoot_targetsCodec.decode(param2) as Vector.<TargetHit>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
