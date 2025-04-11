package projects.tanks.client.clans.user.acceptednotificator {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.clans.container.ContainerCC;

  public class ClanUserAcceptedNotificatorModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ClanUserAcceptedNotificatorModelServer;

    private var client:IClanUserAcceptedNotificatorModelBase = IClanUserAcceptedNotificatorModelBase(this);
    private var modelId:Long = Long.getLong(1233534043,-1972982554);
    private var _onAddingId:Long = Long.getLong(1928764250,-1868285925);
    private var _onAdding_clanIdCodec:ICodec;
    private var _onRemovedId:Long = Long.getLong(337850372,-157499174);
    private var _onRemoved_clanIdCodec:ICodec;

    public function ClanUserAcceptedNotificatorModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ClanUserAcceptedNotificatorModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ContainerCC,false)));
      this._onAdding_clanIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._onRemoved_clanIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    protected function getInitParam() : ContainerCC {
      return ContainerCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._onAddingId:
          this.client.onAdding(Long(this._onAdding_clanIdCodec.decode(param2)));
          break;
        case this._onRemovedId:
          this.client.onRemoved(Long(this._onRemoved_clanIdCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
