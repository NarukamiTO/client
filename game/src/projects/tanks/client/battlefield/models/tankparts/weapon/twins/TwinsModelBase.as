package projects.tanks.client.battlefield.models.tankparts.weapon.twins {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class TwinsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TwinsModelServer;

    private var client:ITwinsModelBase = ITwinsModelBase(this);
    private var modelId:Long = Long.getLong(1952266263,-1912192267);
    private var _fireId:Long = Long.getLong(823399156,351343872);
    private var _fire_shooterCodec:ICodec;
    private var _fire_barrelCodec:ICodec;
    private var _fire_shotIdCodec:ICodec;
    private var _fire_shotDirectionCodec:ICodec;
    private var _fireDummyId:Long = Long.getLong(1289133603,-862527368);
    private var _fireDummy_shooterCodec:ICodec;
    private var _fireDummy_barrelCodec:ICodec;

    public function TwinsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TwinsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(TwinsCC,false)));
      this._fire_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._fire_barrelCodec = this._protocol.getCodec(new TypeCodecInfo(Byte,false));
      this._fire_shotIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._fire_shotDirectionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._fireDummy_shooterCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._fireDummy_barrelCodec = this._protocol.getCodec(new TypeCodecInfo(Byte,false));
    }

    protected function getInitParam() : TwinsCC {
      return TwinsCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._fireId:
          this.client.fire(IGameObject(this._fire_shooterCodec.decode(param2)),int(this._fire_barrelCodec.decode(param2)),int(this._fire_shotIdCodec.decode(param2)),Vector3d(this._fire_shotDirectionCodec.decode(param2)));
          break;
        case this._fireDummyId:
          this.client.fireDummy(IGameObject(this._fireDummy_shooterCodec.decode(param2)),int(this._fireDummy_barrelCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
