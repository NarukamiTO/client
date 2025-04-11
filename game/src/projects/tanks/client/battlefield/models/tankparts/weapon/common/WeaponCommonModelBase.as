package projects.tanks.client.battlefield.models.tankparts.weapon.common {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class WeaponCommonModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:WeaponCommonModelServer;

    private var client:IWeaponCommonModelBase = IWeaponCommonModelBase(this);
    private var modelId:Long = Long.getLong(288238981,44520685);
    private var _setBuffedId:Long = Long.getLong(222121220,-2013237836);
    private var _setBuffed_buffedCodec:ICodec;
    private var _setBuffed_kickbackCodec:ICodec;

    public function WeaponCommonModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new WeaponCommonModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(WeaponCommonCC,false)));
      this._setBuffed_buffedCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._setBuffed_kickbackCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
    }

    protected function getInitParam() : WeaponCommonCC {
      return WeaponCommonCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setBuffedId:
          this.client.setBuffed(Boolean(this._setBuffed_buffedCodec.decode(param2)),Number(this._setBuffed_kickbackCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
