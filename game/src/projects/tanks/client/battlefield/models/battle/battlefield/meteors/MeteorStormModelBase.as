package projects.tanks.client.battlefield.models.battle.battlefield.meteors {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class MeteorStormModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MeteorStormModelServer;

    private var client:IMeteorStormModelBase = IMeteorStormModelBase(this);
    private var modelId:Long = Long.getLong(2135606158,-499224081);
    private var _meteorNotificationId:Long = Long.getLong(1749127255,695205765);
    private var _spawnMeteorId:Long = Long.getLong(674368666,1928778179);
    private var _spawnMeteor_upperPointCodec:ICodec;
    private var _spawnMeteor_spawnPositionCodec:ICodec;
    private var _spawnMeteor_timeToFlyMsCodec:ICodec;

    public function MeteorStormModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MeteorStormModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(MeteorStormCC,false)));
      this._spawnMeteor_upperPointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._spawnMeteor_spawnPositionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._spawnMeteor_timeToFlyMsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : MeteorStormCC {
      return MeteorStormCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._meteorNotificationId:
          this.client.meteorNotification();
          break;
        case this._spawnMeteorId:
          this.client.spawnMeteor(Vector3d(this._spawnMeteor_upperPointCodec.decode(param2)),Vector3d(this._spawnMeteor_spawnPositionCodec.decode(param2)),int(this._spawnMeteor_timeToFlyMsCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
