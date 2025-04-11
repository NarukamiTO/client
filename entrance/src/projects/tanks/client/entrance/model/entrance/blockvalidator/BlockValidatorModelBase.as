package projects.tanks.client.entrance.model.entrance.blockvalidator {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class BlockValidatorModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BlockValidatorModelServer;

    private var client:IBlockValidatorModelBase = IBlockValidatorModelBase(this);
    private var modelId:Long = Long.getLong(928862932,-197944152);
    private var _youAreBlockedId:Long = Long.getLong(418541502,1347122970);
    private var _youAreBlocked_reasonForUserCodec:ICodec;
    private var _youWereKickedId:Long = Long.getLong(418674442,275149928);
    private var _youWereKicked_reasonForUserCodec:ICodec;
    private var _youWereKicked_minutesCodec:ICodec;
    private var _youWereKicked_hoursCodec:ICodec;
    private var _youWereKicked_daysCodec:ICodec;

    public function BlockValidatorModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BlockValidatorModelServer(IModel(this));
      this._youAreBlocked_reasonForUserCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._youWereKicked_reasonForUserCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._youWereKicked_minutesCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._youWereKicked_hoursCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._youWereKicked_daysCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._youAreBlockedId:
          this.client.youAreBlocked(String(this._youAreBlocked_reasonForUserCodec.decode(param2)));
          break;
        case this._youWereKickedId:
          this.client.youWereKicked(String(this._youWereKicked_reasonForUserCodec.decode(param2)),int(this._youWereKicked_minutesCodec.decode(param2)),int(this._youWereKicked_hoursCodec.decode(param2)),int(this._youWereKicked_daysCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
