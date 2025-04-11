package projects.tanks.client.panel.model.abonements {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class UserAbonementsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:UserAbonementsModelServer;

    private var client:IUserAbonementsModelBase = IUserAbonementsModelBase(this);
    private var modelId:Long = Long.getLong(13210116,-2135305231);
    private var _updateAbonementId:Long = Long.getLong(1596742393,-1924740812);
    private var _updateAbonement_abonementCodec:ICodec;

    public function UserAbonementsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new UserAbonementsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(UserAbonementsCC,false)));
      this._updateAbonement_abonementCodec = this._protocol.getCodec(new TypeCodecInfo(ShopAbonementData,false));
    }

    protected function getInitParam() : UserAbonementsCC {
      return UserAbonementsCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._updateAbonementId:
          this.client.updateAbonement(ShopAbonementData(this._updateAbonement_abonementCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
