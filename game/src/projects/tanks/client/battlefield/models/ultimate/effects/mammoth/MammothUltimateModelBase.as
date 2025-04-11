package projects.tanks.client.battlefield.models.ultimate.effects.mammoth {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class MammothUltimateModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MammothUltimateModelServer;

    private var client:IMammothUltimateModelBase = IMammothUltimateModelBase(this);
    private var modelId:Long = Long.getLong(465096987,1359010901);
    private var _activateFieldId:Long = Long.getLong(1909637280,-1045975737);
    private var _damageByFieldId:Long = Long.getLong(1848373713,2048092684);
    private var _damageByField_enemyIdCodec:ICodec;
    private var _deactivateFieldId:Long = Long.getLong(908740500,1614240358);

    public function MammothUltimateModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MammothUltimateModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(MammothUltimateCC,false)));
      this._damageByField_enemyIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    protected function getInitParam() : MammothUltimateCC {
      return MammothUltimateCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._activateFieldId:
          this.client.activateField();
          break;
        case this._damageByFieldId:
          this.client.damageByField(Long(this._damageByField_enemyIdCodec.decode(param2)));
          break;
        case this._deactivateFieldId:
          this.client.deactivateField();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
