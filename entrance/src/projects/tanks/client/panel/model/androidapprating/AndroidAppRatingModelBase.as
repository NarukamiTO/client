package projects.tanks.client.panel.model.androidapprating {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class AndroidAppRatingModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AndroidAppRatingModelServer;

    private var client:IAndroidAppRatingModelBase = IAndroidAppRatingModelBase(this);
    private var modelId:Long = Long.getLong(1012815736,604595236);
    private var _showDialogAppRatingId:Long = Long.getLong(384306161,1146565800);

    public function AndroidAppRatingModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AndroidAppRatingModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showDialogAppRatingId:
          this.client.showDialogAppRating();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
