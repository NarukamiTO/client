package projects.tanks.client.panel.model.donationalert {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.panel.model.donationalert.types.DonationData;

  public class DonationAlertModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:DonationAlertModelServer;

    private var client:IDonationAlertModelBase = IDonationAlertModelBase(this);
    private var modelId:Long = Long.getLong(790638048,-212453148);
    private var _showDonationAlertId:Long = Long.getLong(1759230741,1008086188);
    private var _showDonationAlert_dataCodec:ICodec;
    private var _showDonationAlertWithEmailBlockId:Long = Long.getLong(268614093,535858133);
    private var _showDonationAlertWithEmailBlock_dataCodec:ICodec;
    private var _showEmailIsBusyId:Long = Long.getLong(1383818686,-1315591703);
    private var _showEmailIsBusy_emailCodec:ICodec;
    private var _showEmailIsForbiddenId:Long = Long.getLong(1589408480,-2143336969);
    private var _showEmailIsForbidden_emailCodec:ICodec;
    private var _showEmailIsFreeId:Long = Long.getLong(1383818686,-1315475876);
    private var _showEmailIsFree_emailCodec:ICodec;

    public function DonationAlertModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new DonationAlertModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(DonationAlertCC,false)));
      this._showDonationAlert_dataCodec = this._protocol.getCodec(new TypeCodecInfo(DonationData,false));
      this._showDonationAlertWithEmailBlock_dataCodec = this._protocol.getCodec(new TypeCodecInfo(DonationData,false));
      this._showEmailIsBusy_emailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._showEmailIsForbidden_emailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._showEmailIsFree_emailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    protected function getInitParam() : DonationAlertCC {
      return DonationAlertCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showDonationAlertId:
          this.client.showDonationAlert(DonationData(this._showDonationAlert_dataCodec.decode(param2)));
          break;
        case this._showDonationAlertWithEmailBlockId:
          this.client.showDonationAlertWithEmailBlock(DonationData(this._showDonationAlertWithEmailBlock_dataCodec.decode(param2)));
          break;
        case this._showEmailIsBusyId:
          this.client.showEmailIsBusy(String(this._showEmailIsBusy_emailCodec.decode(param2)));
          break;
        case this._showEmailIsForbiddenId:
          this.client.showEmailIsForbidden(String(this._showEmailIsForbidden_emailCodec.decode(param2)));
          break;
        case this._showEmailIsFreeId:
          this.client.showEmailIsFree(String(this._showEmailIsFree_emailCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
