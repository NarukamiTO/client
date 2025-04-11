package projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class CommonFacilityModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:CommonFacilityModelServer;

    private var client:ICommonFacilityModelBase = ICommonFacilityModelBase(this);
    private var modelId:Long = Long.getLong(1779789989,953701943);
    private var _markAsDispelledId:Long = Long.getLong(1287147105,1273566171);

    public function CommonFacilityModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new CommonFacilityModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(CommonFacilityCC,false)));
    }

    protected function getInitParam() : CommonFacilityCC {
      return CommonFacilityCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._markAsDispelledId:
          this.client.markAsDispelled();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
