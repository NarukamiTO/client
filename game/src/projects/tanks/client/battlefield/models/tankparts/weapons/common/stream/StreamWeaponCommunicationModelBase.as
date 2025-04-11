package projects.tanks.client.battlefield.models.tankparts.weapons.common.stream {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class StreamWeaponCommunicationModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:StreamWeaponCommunicationModelServer;

    private var client:IStreamWeaponCommunicationModelBase = IStreamWeaponCommunicationModelBase(this);
    private var modelId:Long = Long.getLong(2040386917,729965137);
    private var _startFireId:Long = Long.getLong(1582297866,2028596660);
    private var _stopFireId:Long = Long.getLong(2129251848,-1338052132);
    private var _updateTargetsId:Long = Long.getLong(338478335,1466416629);
    private var _updateTargets_directionCodec:ICodec;
    private var _updateTargets_targetsCodec:ICodec;

    public function StreamWeaponCommunicationModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new StreamWeaponCommunicationModelServer(IModel(this));
      this._updateTargets_directionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._updateTargets_targetsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(TargetHit,false),false,1));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._startFireId:
          this.client.startFire();
          break;
        case this._stopFireId:
          this.client.stopFire();
          break;
        case this._updateTargetsId:
          this.client.updateTargets(Vector3d(this._updateTargets_directionCodec.decode(param2)),this._updateTargets_targetsCodec.decode(param2) as Vector.<TargetHit>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
