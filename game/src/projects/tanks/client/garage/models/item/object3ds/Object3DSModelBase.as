package projects.tanks.client.garage.models.item.object3ds {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class Object3DSModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:Object3DSModelServer;

    private var client:IObject3DSModelBase = IObject3DSModelBase(this);
    private var modelId:Long = Long.getLong(1497301838,-1092921347);

    public function Object3DSModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new Object3DSModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(Object3DSCC,false)));
    }

    protected function getInitParam() : Object3DSCC {
      return Object3DSCC(initParams[Model.object]);
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
