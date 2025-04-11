package projects.tanks.client.battlefield.models.tankparts.sfx.colortransform {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ColorTransformModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ColorTransformModelServer;

    private var client:IColorTransformModelBase = IColorTransformModelBase(this);
    private var modelId:Long = Long.getLong(1855402535,537941602);

    public function ColorTransformModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ColorTransformModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ColorTransformCC,false)));
    }

    protected function getInitParam() : ColorTransformCC {
      return ColorTransformCC(initParams[Model.object]);
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
