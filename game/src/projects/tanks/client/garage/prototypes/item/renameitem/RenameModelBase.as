package projects.tanks.client.garage.prototypes.item.renameitem {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class RenameModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RenameModelServer;

    private var client:IRenameModelBase = IRenameModelBase(this);
    private var modelId:Long = Long.getLong(841189855,-1268110049);
    private var _renameFailId:Long = Long.getLong(1282635693,192675762);
    private var _renameSuccessfullId:Long = Long.getLong(2064863564,657165826);
    private var _renameSuccessfull_oldNameCodec:ICodec;
    private var _renameSuccessfull_newNameCodec:ICodec;

    public function RenameModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RenameModelServer(IModel(this));
      this._renameSuccessfull_oldNameCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._renameSuccessfull_newNameCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._renameFailId:
          this.client.renameFail();
          break;
        case this._renameSuccessfullId:
          this.client.renameSuccessfull(String(this._renameSuccessfull_oldNameCodec.decode(param2)),String(this._renameSuccessfull_newNameCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
