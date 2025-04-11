package projects.tanks.client.battlefield.models.effects.description {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class EffectDescriptionModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:EffectDescriptionModelServer;

    private var client:IEffectDescriptionModelBase = IEffectDescriptionModelBase(this);
    private var modelId:Long = Long.getLong(1345545806,-1145690082);
    private var _activatedId:Long = Long.getLong(1368257163,-603415558);
    private var _activated_leftTimeInMsCodec:ICodec;
    private var _deactivatedId:Long = Long.getLong(635722896,-684971431);
    private var _mergedId:Long = Long.getLong(149694347,-1219794525);
    private var _merged_leftTimeInMsCodec:ICodec;

    public function EffectDescriptionModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new EffectDescriptionModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(EffectDescriptionCC,false)));
      this._activated_leftTimeInMsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._merged_leftTimeInMsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : EffectDescriptionCC {
      return EffectDescriptionCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._activatedId:
          this.client.activated(int(this._activated_leftTimeInMsCodec.decode(param2)));
          break;
        case this._deactivatedId:
          this.client.deactivated();
          break;
        case this._mergedId:
          this.client.merged(int(this._merged_leftTimeInMsCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
