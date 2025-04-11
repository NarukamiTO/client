package projects.tanks.client.clans.notifier {
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

  public class ClanNotifierModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ClanNotifierModelServer;

    private var client:IClanNotifierModelBase = IClanNotifierModelBase(this);
    private var modelId:Long = Long.getLong(1850785827,-2022019480);
    private var _sendDataId:Long = Long.getLong(2052398186,-511753871);
    private var _sendData_userDataCodec:ICodec;

    public function ClanNotifierModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ClanNotifierModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ClanNotifierData,false)));
      this._sendData_userDataCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ClanNotifierData,false),false,1));
    }

    protected function getInitParam() : ClanNotifierData {
      return ClanNotifierData(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._sendDataId:
          this.client.sendData(this._sendData_userDataCodec.decode(param2) as Vector.<ClanNotifierData>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
