package projects.tanks.client.garage.models.item.container.weekly {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.garage.models.item.container.ContainerGivenItem;

  public class WeeklyContainerModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:WeeklyContainerModelServer;

    private var client:IWeeklyContainerModelBase = IWeeklyContainerModelBase(this);
    private var modelId:Long = Long.getLong(895763411,-290717027);
    private var _openSuccessfulId:Long = Long.getLong(414752496,-1868458890);
    private var _openSuccessful_rewardsCodec:ICodec;
    private var _updateCountId:Long = Long.getLong(1978161324,62150420);
    private var _updateCount_countCodec:ICodec;

    public function WeeklyContainerModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new WeeklyContainerModelServer(IModel(this));
      this._openSuccessful_rewardsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ContainerGivenItem,false),false,1));
      this._updateCount_countCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._openSuccessfulId:
          this.client.openSuccessful(this._openSuccessful_rewardsCodec.decode(param2) as Vector.<ContainerGivenItem>);
          break;
        case this._updateCountId:
          this.client.updateCount(int(this._updateCount_countCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
