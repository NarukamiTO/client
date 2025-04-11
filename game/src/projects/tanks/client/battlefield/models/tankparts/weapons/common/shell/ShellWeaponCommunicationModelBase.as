package projects.tanks.client.battlefield.models.tankparts.weapons.common.shell {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class ShellWeaponCommunicationModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ShellWeaponCommunicationModelServer;

    private var client:IShellWeaponCommunicationModelBase = IShellWeaponCommunicationModelBase(this);
    private var modelId:Long = Long.getLong(288784246,84754739);
    private var _shootId:Long = Long.getLong(272048587,295381737);
    private var _shoot_barrelIndexCodec:ICodec;
    private var _shoot_shotIdCodec:ICodec;
    private var _shoot_directionCodec:ICodec;
    private var _shootDummyId:Long = Long.getLong(614158399,-327996881);
    private var _shootDummy_barrelIndexCodec:ICodec;
    private var _shootWithTargetId:Long = Long.getLong(1963572121,467312018);
    private var _shootWithTarget_barrelIndexCodec:ICodec;
    private var _shootWithTarget_shotIdCodec:ICodec;
    private var _shootWithTarget_directionCodec:ICodec;
    private var _shootWithTarget_targetCodec:ICodec;
    private var _shootWithTarget_localTargetPointCodec:ICodec;

    public function ShellWeaponCommunicationModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ShellWeaponCommunicationModelServer(IModel(this));
      this._shoot_barrelIndexCodec = this._protocol.getCodec(new TypeCodecInfo(Byte,false));
      this._shoot_shotIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._shoot_directionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._shootDummy_barrelIndexCodec = this._protocol.getCodec(new TypeCodecInfo(Byte,false));
      this._shootWithTarget_barrelIndexCodec = this._protocol.getCodec(new TypeCodecInfo(Byte,false));
      this._shootWithTarget_shotIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._shootWithTarget_directionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._shootWithTarget_targetCodec = this._protocol.getCodec(new TypeCodecInfo(TargetPosition,false));
      this._shootWithTarget_localTargetPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._shootId:
          this.client.shoot(int(this._shoot_barrelIndexCodec.decode(param2)),int(this._shoot_shotIdCodec.decode(param2)),Vector3d(this._shoot_directionCodec.decode(param2)));
          break;
        case this._shootDummyId:
          this.client.shootDummy(int(this._shootDummy_barrelIndexCodec.decode(param2)));
          break;
        case this._shootWithTargetId:
          this.client.shootWithTarget(int(this._shootWithTarget_barrelIndexCodec.decode(param2)),int(this._shootWithTarget_shotIdCodec.decode(param2)),Vector3d(this._shootWithTarget_directionCodec.decode(param2)),TargetPosition(this._shootWithTarget_targetCodec.decode(param2)),Vector3d(this._shootWithTarget_localTargetPointCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
