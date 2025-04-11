package projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower {
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

  public class FlameThrowerModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:FlameThrowerModelServer;

    private var client:IFlameThrowerModelBase = IFlameThrowerModelBase(this);
    private var modelId:Long = Long.getLong(1034700989,1212373553);
    private var _startFireId:Long = Long.getLong(597053943,1126684268);
    private var _startFire_shooterCodec:ICodec;
    private var _stopFireId:Long = Long.getLong(119287527,-1716930052);
    private var _stopFire_shooterCodec:ICodec;

    public function FlameThrowerModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new FlameThrowerModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(FlameThrowerCC,false)));
      this._startFire_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._stopFire_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    protected function getInitParam() : FlameThrowerCC {
      return FlameThrowerCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._startFireId:
          this.client.startFire(IGameObject(this._startFire_shooterCodec.decode(param2)));
          break;
        case this._stopFireId:
          this.client.stopFire(IGameObject(this._stopFire_shooterCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
