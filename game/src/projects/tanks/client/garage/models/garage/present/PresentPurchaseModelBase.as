package projects.tanks.client.garage.models.garage.present {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class PresentPurchaseModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:PresentPurchaseModelServer;

    private var client:IPresentPurchaseModelBase = IPresentPurchaseModelBase(this);
    private var modelId:Long = Long.getLong(888433053,2115284408);
    private var _setUidAvailableId:Long = Long.getLong(759000870,-1549014702);
    private var _setUidAvailable_availableCodec:ICodec;

    public function PresentPurchaseModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new PresentPurchaseModelServer(IModel(this));
      this._setUidAvailable_availableCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setUidAvailableId:
          this.client.setUidAvailable(Boolean(this._setUidAvailable_availableCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
