package projects.tanks.client.battlefield.models.tankparts.weapon.freeze {
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

  public class FreezeModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:FreezeModelServer;

    private var client:IFreezeModelBase = IFreezeModelBase(this);
    private var modelId:Long = Long.getLong(2120141642,699496177);
    private var _startFireId:Long = Long.getLong(1609604139,228512172);
    private var _startFire_shooterCodec:ICodec;
    private var _stopFireId:Long = Long.getLong(1853038031,-1082989884);
    private var _stopFire_shooterCodec:ICodec;

    public function FreezeModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new FreezeModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(FreezeCC,false)));
      this._startFire_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._stopFire_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    protected function getInitParam() : FreezeCC {
      return FreezeCC(initParams[Model.object]);
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
