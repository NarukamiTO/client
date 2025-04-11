package projects.tanks.client.commons.models.moveusertoclient {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class MoveUserToServerModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MoveUserToServerModelServer;

    private var client:IMoveUserToServerModelBase = IMoveUserToServerModelBase(this);
    private var modelId:Long = Long.getLong(1594319086,-307533593);
    private var _moveId:Long = Long.getLong(1584343746,-1931074163);
    private var _move_serverNumberCodec:ICodec;

    public function MoveUserToServerModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MoveUserToServerModelServer(IModel(this));
      this._move_serverNumberCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._moveId:
          this.client.move(int(this._move_serverNumberCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
