package projects.tanks.client.panel.model.presents {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class NewPresentsShowingModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:NewPresentsShowingModelServer;

    private var client:INewPresentsShowingModelBase = INewPresentsShowingModelBase(this);
    private var modelId:Long = Long.getLong(1012007416,-1351622809);
    private var _showAlertId:Long = Long.getLong(1585320728,11519581);

    public function NewPresentsShowingModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new NewPresentsShowingModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showAlertId:
          this.client.showAlert();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
