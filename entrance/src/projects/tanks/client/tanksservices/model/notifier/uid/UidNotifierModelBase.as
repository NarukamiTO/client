package projects.tanks.client.tanksservices.model.notifier.uid {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class UidNotifierModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:UidNotifierModelServer;

    private var client:IUidNotifierModelBase = IUidNotifierModelBase(this);
    private var modelId:Long = Long.getLong(990863444,376077627);
    private var _setUidId:Long = Long.getLong(290132373,74250398);
    private var _setUid_usersCodec:ICodec;

    public function UidNotifierModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new UidNotifierModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(UidNotifierData,false)));
      this._setUid_usersCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UidNotifierData,false),false,1));
    }

    protected function getInitParam() : UidNotifierData {
      return UidNotifierData(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setUidId:
          this.client.setUid(this._setUid_usersCodec.decode(param2) as Vector.<UidNotifierData>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
