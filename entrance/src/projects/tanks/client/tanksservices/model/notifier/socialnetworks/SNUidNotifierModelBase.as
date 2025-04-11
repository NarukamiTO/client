package projects.tanks.client.tanksservices.model.notifier.socialnetworks {
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

  public class SNUidNotifierModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:SNUidNotifierModelServer;

    private var client:ISNUidNotifierModelBase = ISNUidNotifierModelBase(this);
    private var modelId:Long = Long.getLong(1741772027,-10049568);
    private var _setSNUidId:Long = Long.getLong(1110422483,-372446840);
    private var _setSNUid_usersCodec:ICodec;

    public function SNUidNotifierModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new SNUidNotifierModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(SNUidNotifierData,false)));
      this._setSNUid_usersCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(SNUidNotifierData,false),false,1));
    }

    protected function getInitParam() : SNUidNotifierData {
      return SNUidNotifierData(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setSNUidId:
          this.client.setSNUid(this._setSNUid_usersCodec.decode(param2) as Vector.<SNUidNotifierData>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
