package projects.tanks.client.panel.model.shop.androidspecialoffer.rank {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class AndroidOffersRankModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AndroidOffersRankModelServer;

    private var client:IAndroidOffersRankModelBase = IAndroidOffersRankModelBase(this);
    private var modelId:Long = Long.getLong(359824795,312311046);

    public function AndroidOffersRankModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AndroidOffersRankModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      var local3:* = param1;
      switch(false ? 0 : 0) {
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
