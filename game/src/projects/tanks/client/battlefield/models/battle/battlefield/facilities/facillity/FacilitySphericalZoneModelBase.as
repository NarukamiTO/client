package projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class FacilitySphericalZoneModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:FacilitySphericalZoneModelServer;

    private var client:IFacilitySphericalZoneModelBase = IFacilitySphericalZoneModelBase(this);
    private var modelId:Long = Long.getLong(573858908,22312341);

    public function FacilitySphericalZoneModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new FacilitySphericalZoneModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(FacilitySphericalZoneCC,false)));
    }

    protected function getInitParam() : FacilitySphericalZoneCC {
      return FacilitySphericalZoneCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      var local3:* = param1;
      switch(false ? 0 : 0) {
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
