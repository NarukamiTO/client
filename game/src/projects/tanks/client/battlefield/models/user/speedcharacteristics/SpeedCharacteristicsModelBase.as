package projects.tanks.client.battlefield.models.user.speedcharacteristics {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class SpeedCharacteristicsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:SpeedCharacteristicsModelServer;

    private var client:ISpeedCharacteristicsModelBase = ISpeedCharacteristicsModelBase(this);
    private var modelId:Long = Long.getLong(1667805908,-902263720);
    private var _setSpecificationId:Long = Long.getLong(2130096710,1381807086);
    private var _setSpecification_maxSpeedCodec:ICodec;
    private var _setSpecification_maxTurnSpeedCodec:ICodec;
    private var _setSpecification_maxTurretRotationSpeedCodec:ICodec;
    private var _setSpecification_accelerationCodec:ICodec;
    private var _setSpecification_specificationIdCodec:ICodec;
    private var _setSpecification_immediatelyCodec:ICodec;

    public function SpeedCharacteristicsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new SpeedCharacteristicsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(SpeedCharacteristicsCC,false)));
      this._setSpecification_maxSpeedCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._setSpecification_maxTurnSpeedCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._setSpecification_maxTurretRotationSpeedCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._setSpecification_accelerationCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._setSpecification_specificationIdCodec = this._protocol.getCodec(new TypeCodecInfo(Short,false));
      this._setSpecification_immediatelyCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    protected function getInitParam() : SpeedCharacteristicsCC {
      return SpeedCharacteristicsCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setSpecificationId:
          this.client.setSpecification(Number(this._setSpecification_maxSpeedCodec.decode(param2)),Number(this._setSpecification_maxTurnSpeedCodec.decode(param2)),Number(this._setSpecification_maxTurretRotationSpeedCodec.decode(param2)),Number(this._setSpecification_accelerationCodec.decode(param2)),int(this._setSpecification_specificationIdCodec.decode(param2)),Boolean(this._setSpecification_immediatelyCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
