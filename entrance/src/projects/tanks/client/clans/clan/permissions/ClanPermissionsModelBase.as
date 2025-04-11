package projects.tanks.client.clans.clan.permissions {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ClanPermissionsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ClanPermissionsModelServer;

    private var client:IClanPermissionsModelBase = IClanPermissionsModelBase(this);
    private var modelId:Long = Long.getLong(1602467880,168781542);
    private var _updateActionsId:Long = Long.getLong(871743923,-1602562917);
    private var _updateActions_actionsCodec:ICodec;

    public function ClanPermissionsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ClanPermissionsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ClanPermissionsCC,false)));
      this._updateActions_actionsCodec = this._protocol.getCodec(new CollectionCodecInfo(new EnumCodecInfo(ClanAction,false),false,1));
    }

    protected function getInitParam() : ClanPermissionsCC {
      return ClanPermissionsCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._updateActionsId:
          this.client.updateActions(this._updateActions_actionsCodec.decode(param2) as Vector.<ClanAction>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
