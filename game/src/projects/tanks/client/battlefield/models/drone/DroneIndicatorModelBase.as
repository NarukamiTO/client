package projects.tanks.client.battlefield.models.drone {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class DroneIndicatorModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:DroneIndicatorModelServer;

    private var client:IDroneIndicatorModelBase = IDroneIndicatorModelBase(this);
    private var modelId:Long = Long.getLong(1936258281,-1608612342);
    private var _notReadyId:Long = Long.getLong(1675079766,1720830299);
    private var _readyId:Long = Long.getLong(1926631125,-1544324792);
    private var _reloadId:Long = Long.getLong(403977249,629765924);
    private var _reload_durationMsCodec:ICodec;
    private var _setBatteriesAmountId:Long = Long.getLong(1248011373,2011342868);
    private var _setBatteriesAmount_amountCodec:ICodec;

    public function DroneIndicatorModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new DroneIndicatorModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(DroneIndicatorCC,false)));
      this._reload_durationMsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._setBatteriesAmount_amountCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : DroneIndicatorCC {
      return DroneIndicatorCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._notReadyId:
          this.client.notReady();
          break;
        case this._readyId:
          this.client.ready();
          break;
        case this._reloadId:
          this.client.reload(int(this._reload_durationMsCodec.decode(param2)));
          break;
        case this._setBatteriesAmountId:
          this.client.setBatteriesAmount(int(this._setBatteriesAmount_amountCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
