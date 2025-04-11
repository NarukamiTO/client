package projects.tanks.client.panel.model.tutorialhints {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class TutorialHintsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TutorialHintsModelServer;

    private var client:ITutorialHintsModelBase = ITutorialHintsModelBase(this);
    private var modelId:Long = Long.getLong(1524013763,797788828);
    private var _updateId:Long = Long.getLong(1971461217,-1044767866);
    private var _update_tutorialHintsDataCodec:ICodec;

    public function TutorialHintsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TutorialHintsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(TutorialHintsCC,false)));
      this._update_tutorialHintsDataCodec = this._protocol.getCodec(new TypeCodecInfo(TutorialHintsData,false));
    }

    protected function getInitParam() : TutorialHintsCC {
      return TutorialHintsCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._updateId:
          this.client.update(TutorialHintsData(this._update_tutorialHintsDataCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
