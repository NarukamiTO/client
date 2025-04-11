package projects.tanks.client.clans.panel.notification {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ClanPanelNotificationModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ClanPanelNotificationModelServer;

    private var client:IClanPanelNotificationModelBase = IClanPanelNotificationModelBase(this);
    private var modelId:Long = Long.getLong(606942677,1590617894);
    private var _addedId:Long = Long.getLong(1587343137,-1916924187);
    private var _removedId:Long = Long.getLong(723365112,-1678221051);
    private var _updateRestrictionTimeJoinClanId:Long = Long.getLong(1322847239,424158635);
    private var _updateRestrictionTimeJoinClan_restrictionTimeJoinClanInSecCodec:ICodec;

    public function ClanPanelNotificationModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ClanPanelNotificationModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ClanPanelNotificationCC,false)));
      this._updateRestrictionTimeJoinClan_restrictionTimeJoinClanInSecCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : ClanPanelNotificationCC {
      return ClanPanelNotificationCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._addedId:
          this.client.added();
          break;
        case this._removedId:
          this.client.removed();
          break;
        case this._updateRestrictionTimeJoinClanId:
          this.client.updateRestrictionTimeJoinClan(int(this._updateRestrictionTimeJoinClan_restrictionTimeJoinClanInSecCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
