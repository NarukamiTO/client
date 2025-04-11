package projects.tanks.client.battlefield.models.ultimate.common {
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

  public class UltimateModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:UltimateModelServer;

    private var client:IUltimateModelBase = IUltimateModelBase(this);
    private var modelId:Long = Long.getLong(1502954923,909786804);
    private var _resetChargeId:Long = Long.getLong(378718252,-2040079582);
    private var _showUltimateChargedId:Long = Long.getLong(353511605,16811297);
    private var _ultimateRejectedId:Long = Long.getLong(1391028187,669592304);
    private var _ultimateUsedId:Long = Long.getLong(1125545689,-631096655);
    private var _updateChargeId:Long = Long.getLong(1124882390,372674946);
    private var _updateCharge_chargeInPercentCodec:ICodec;
    private var _updateChargeAndRateId:Long = Long.getLong(1647981261,-1141176057);
    private var _updateChargeAndRate_chargeInPercentCodec:ICodec;
    private var _updateChargeAndRate_chargePercentPerSecondCodec:ICodec;

    public function UltimateModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new UltimateModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(UltimateCC,false)));
      this._updateCharge_chargeInPercentCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateChargeAndRate_chargeInPercentCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateChargeAndRate_chargePercentPerSecondCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
    }

    protected function getInitParam() : UltimateCC {
      return UltimateCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._resetChargeId:
          this.client.resetCharge();
          break;
        case this._showUltimateChargedId:
          this.client.showUltimateCharged();
          break;
        case this._ultimateRejectedId:
          this.client.ultimateRejected();
          break;
        case this._ultimateUsedId:
          this.client.ultimateUsed();
          break;
        case this._updateChargeId:
          this.client.updateCharge(int(this._updateCharge_chargeInPercentCodec.decode(param2)));
          break;
        case this._updateChargeAndRateId:
          this.client.updateChargeAndRate(int(this._updateChargeAndRate_chargeInPercentCodec.decode(param2)),Number(this._updateChargeAndRate_chargePercentPerSecondCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
