package projects.tanks.client.battlefield.models.tankparts.sfx.smoke {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class HullSmokeModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:HullSmokeModelServer;

    private var client:IHullSmokeModelBase = IHullSmokeModelBase(this);
    private var modelId:Long = Long.getLong(1546360680,1128943603);

    public function HullSmokeModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new HullSmokeModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(HullSmokeCC,false)));
    }

    protected function getInitParam() : HullSmokeCC {
      return HullSmokeCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      var local3:* = param1;
      switch(false ? 0 : 0) {
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
