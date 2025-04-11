package projects.tanks.client.panel.model.referrals {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ReferralsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ReferralsModelServer;

    private var client:IReferralsModelBase = IReferralsModelBase(this);
    private var modelId:Long = Long.getLong(1896158207,-814003948);
    private var _updateDataId:Long = Long.getLong(1620265453,-1623297132);
    private var _updateData_dataCodec:ICodec;

    public function ReferralsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ReferralsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ReferralsModelCC,false)));
      this._updateData_dataCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ReferralIncomeData,false),false,1));
    }

    protected function getInitParam() : ReferralsModelCC {
      return ReferralsModelCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._updateDataId:
          this.client.updateData(this._updateData_dataCodec.decode(param2) as Vector.<ReferralIncomeData>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
