package projects.tanks.client.battlefield.models.drone.demoman {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class DroneExplosionModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:DroneExplosionModelServer;

    private var client:IDroneExplosionModelBase = IDroneExplosionModelBase(this);
    private var modelId:Long = Long.getLong(327725701,-804290777);
    private var _addExplosionEffectId:Long = Long.getLong(1094361499,58760275);
    private var _addExplosionEffect_positionCodec:ICodec;
    private var _addExplosionEffect_radiusCodec:ICodec;

    public function DroneExplosionModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new DroneExplosionModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(DroneExplosionCC,false)));
      this._addExplosionEffect_positionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._addExplosionEffect_radiusCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
    }

    protected function getInitParam() : DroneExplosionCC {
      return DroneExplosionCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._addExplosionEffectId:
          this.client.addExplosionEffect(Vector3d(this._addExplosionEffect_positionCodec.decode(param2)),Number(this._addExplosionEffect_radiusCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
