package projects.tanks.client.clans.license.user {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class LicenseClanUserModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:LicenseClanUserModelServer;

    private var client:ILicenseClanUserModelBase = ILicenseClanUserModelBase(this);
    private var modelId:Long = Long.getLong(1978103354,1644120870);
    private var _addClanLicenseId:Long = Long.getLong(742414901,491655143);
    private var _removeClanLicenseId:Long = Long.getLong(521749674,-1882127080);

    public function LicenseClanUserModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new LicenseClanUserModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(LicenseClanUserCC,false)));
    }

    protected function getInitParam() : LicenseClanUserCC {
      return LicenseClanUserCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._addClanLicenseId:
          this.client.addClanLicense();
          break;
        case this._removeClanLicenseId:
          this.client.removeClanLicense();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
