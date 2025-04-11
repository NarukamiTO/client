package projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.autoaiming {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.VerticalAnglesCC;

  public class WeaponVerticalAnglesModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:WeaponVerticalAnglesModelServer;

    private var client:IWeaponVerticalAnglesModelBase = IWeaponVerticalAnglesModelBase(this);
    private var modelId:Long = Long.getLong(1835454872,-194543840);

    public function WeaponVerticalAnglesModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new WeaponVerticalAnglesModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(VerticalAnglesCC,false)));
    }

    protected function getInitParam() : VerticalAnglesCC {
      return VerticalAnglesCC(initParams[Model.object]);
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
