package projects.tanks.client.panel.model.profile.rename {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class AndroidRenameModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AndroidRenameModelServer;

    private var client:IAndroidRenameModelBase = IAndroidRenameModelBase(this);
    private var modelId:Long = Long.getLong(1479505722,-162721658);
    private var _renameFailId:Long = Long.getLong(810003174,-1049558551);
    private var _renameSuccessfulId:Long = Long.getLong(825297695,-807400147);

    public function AndroidRenameModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AndroidRenameModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(AndroidRenameCC,false)));
    }

    protected function getInitParam() : AndroidRenameCC {
      return AndroidRenameCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._renameFailId:
          this.client.renameFail();
          break;
        case this._renameSuccessfulId:
          this.client.renameSuccessful();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
