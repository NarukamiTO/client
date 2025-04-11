package projects.tanks.client.panel.model.mobilequest.profile {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class MobileQuestProfileModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MobileQuestProfileModelServer;

    private var client:IMobileQuestProfileModelBase = IMobileQuestProfileModelBase(this);
    private var modelId:Long = Long.getLong(1240219703,-1345063692);
    private var _changeProgressId:Long = Long.getLong(45741248,-1496530658);
    private var _changeProgress_currentStepCodec:ICodec;

    public function MobileQuestProfileModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MobileQuestProfileModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(MobileQuestProfileCC,false)));
      this._changeProgress_currentStepCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : MobileQuestProfileCC {
      return MobileQuestProfileCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._changeProgressId:
          this.client.changeProgress(int(this._changeProgress_currentStepCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
