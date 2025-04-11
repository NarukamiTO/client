package projects.tanks.client.battlefield.models.user.bossstate {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class BossStateModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BossStateModelServer;

    private var client:IBossStateModelBase = IBossStateModelBase(this);
    private var modelId:Long = Long.getLong(1177132817,1695744884);
    private var _changeRoleId:Long = Long.getLong(1216877919,-1226060135);
    private var _changeRole_newRoleCodec:ICodec;

    public function BossStateModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BossStateModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BossStateCC,false)));
      this._changeRole_newRoleCodec = this._protocol.getCodec(new EnumCodecInfo(BossRelationRole,false));
    }

    protected function getInitParam() : BossStateCC {
      return BossStateCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._changeRoleId:
          this.client.changeRole(BossRelationRole(this._changeRole_newRoleCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
